/*
 * Copyright 2016 The MathWorks, Inc.
 */

`timescale 1ns/1ns

import uvm_pkg::*;

module top;
    bit clk;
    bit reset;
    
    axi_st_if dut_driver(clk,reset);
    axi_st_if dut_monitor(clk,reset);
	
    initial begin
    	clk = 0;
    	reset = 0;
    	#10
    	reset = 1;
    	#10 
    	reset = 0;
    end
    always #5 clk = !clk;
    
    fft_st_wrapper dut(
        .aclk(clk),
        .areset(reset),
        .slave_tdata(dut_driver.tdata),
        .slave_tvalid(dut_driver.tvalid),
        .slave_tready(dut_driver.tready),
        .master_tdata(dut_monitor.tdata),
        .master_tvalid(dut_monitor.tvalid),
        .master_tready(1'b1));
    
    initial begin
    	uvm_config_db #(virtual axi_st_if)::set(null, "uvm_test_top", "dut_driver", dut_driver);   
    	uvm_config_db #(virtual axi_st_if)::set(null, "uvm_test_top", "dut_monitor", dut_monitor);   
    	run_test();
    end
endmodule
