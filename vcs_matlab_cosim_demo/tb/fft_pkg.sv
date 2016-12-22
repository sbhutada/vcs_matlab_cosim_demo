/*
 * Copyright 2016 The MathWorks, Inc.
 */

import uvm_pkg::*;
`include "uvm_macros.svh"

class fft_transaction extends uvm_sequence_item;
	shortint data_re [0:63];
	shortint data_im [0:63];

	`uvm_object_utils_begin(fft_transaction)	
          `uvm_field_sarray_int      (data_re,           UVM_DEFAULT)
          `uvm_field_sarray_int      (data_im,           UVM_DEFAULT)
        `uvm_object_utils_end
	
  // new - constructor
  function new (string name = "ubus_transfer_inst");
    super.new(name);
  endfunction : new



endclass: fft_transaction


typedef uvm_sequencer #(fft_transaction) fft_sequencer;

class fft_st_driver extends uvm_driver #(fft_transaction);
	`uvm_component_utils(fft_st_driver)
	
	uvm_analysis_port #(fft_transaction) aport;
	virtual axi_st_if driver_if;
								
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		aport = new("aport", this);
	endfunction: build_phase
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		// Wait for the reset to finish
		@(negedge driver_if.areset);
		
		forever begin
			int count = 0;
			fft_transaction tx;
			
			phase.drop_objection(this);
			seq_item_port.get_next_item(tx);
			phase.raise_objection(this);
			aport.write(tx);
			
			while( count < 64 ) begin
				@(posedge driver_if.aclk);
				driver_if.tdata = {tx.data_im[count], tx.data_re[count]};
				if(driver_if.tready == 1'b1) begin
					count = count + 1;
					driver_if.tvalid = 1;					
				end
				else begin
					driver_if.tvalid = 0;
				end				
			end	
			
			@(posedge driver_if.aclk);
			driver_if.tvalid = 0;
			// We are done with this item;
			@(posedge driver_if.aclk);
			seq_item_port.item_done();				
		end
	endtask
endclass: fft_st_driver
	
class fft_st_monitor extends uvm_monitor;
	`uvm_component_utils(fft_st_monitor)
	uvm_analysis_port #(fft_transaction) aport;
	virtual axi_st_if monitor_if;

	covergroup cov;
		coverpoint monitor_if.tdata[15:0];
		coverpoint monitor_if.tdata[31:16];
	endgroup		
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
		cov = new();
	endfunction: new	
	
	function void build_phase(uvm_phase phase);
		aport = new("aport", this);		
	endfunction: build_phase
	
	task run_phase(uvm_phase phase);		
		forever begin
			int count = 0;
			fft_transaction rx;
			
			while( count < 64 ) begin
				@(posedge monitor_if.aclk);
				if(monitor_if.tvalid == 1'b1) begin
					if(count == 0) begin
						// Raise objection when there is a pending transaction
						phase.raise_objection(this);
						rx = fft_transaction::type_id::create("rx");
 						void'(this.begin_tr(rx));

					end
					rx.data_re[count] = signed'(monitor_if.tdata[15:0]);
					rx.data_im[count] = signed'(monitor_if.tdata[31:16]);
					++count;
					cov.sample();
				end				
			end				
			// Now we have received a full transaction
			if(count==64) begin
				aport.write(rx);
				count = 0;
				// Drop objection when we finished the pending transaction
				phase.drop_objection(this);				
 				void'(this.end_tr(rx));
			end
		end
	endtask: run_phase
	
endclass: fft_st_monitor

// Declare imported C functions generated by MATLAB and Simulink

import "DPI-C" function chandle DPI_fft_checker_initialize(
	chandle existhandle);

import "DPI-C" function void DPI_fft_checker(
	input chandle objhandle,
	input shortint fftin_re [64],
	input shortint fftin_im [64],
	input shortint fftout_re [64],
	input shortint fftout_im [64],
	output real result);


`uvm_analysis_imp_decl(_fftin)
`uvm_analysis_imp_decl(_fftout)
class fft_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(fft_scoreboard)
	
	uvm_analysis_imp_fftin  #(fft_transaction, fft_scoreboard) port_fftin;
	uvm_analysis_imp_fftout #(fft_transaction, fft_scoreboard) port_fftout;

	fft_transaction queue_fftin[$];
	chandle dpic_h;

	function new(string name, uvm_component parent);
		super.new(name,parent);
		port_fftin 	= new("port_fftin", this);
		port_fftout = new("port_fftout", this);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		dpic_h = DPI_fft_checker_initialize(null);
	endfunction: build_phase
	
	function void write_fftin(fft_transaction t);
		queue_fftin.push_back(t);		
		uvm_test_done.raise_objection(this);
	endfunction: write_fftin
	
	function void write_fftout(fft_transaction t);
		fft_transaction fftin;
		real nrms; 
		real threshold = 0.002;
		string msg;
		
        // Pop out an input transaction
		fftin = queue_fftin.pop_front();
        // Calculate normalized rms of fixed point design
		DPI_fft_checker(dpic_h, fftin.data_re, fftin.data_im, t.data_re, t.data_im, nrms);
        
		$sformat(msg, "Normalized rms value of fixed-point FFT is %f", nrms);
		`uvm_info("SCORE", msg, UVM_NONE);
        
		if ( nrms > threshold ) begin
			`uvm_error("FAIL", "The normalized rms value is higher than specified threshold.");
        end
		else begin 
			`uvm_info("PASS", "The normalized rms value is lower than threshold. Test passed.", UVM_NONE);
        end
		
		if( queue_fftin.size() == 0 ) begin
			uvm_test_done.drop_objection(this);
		end
	endfunction: write_fftout
		
endclass


class fft_sequence extends uvm_sequence #(fft_transaction);
	`uvm_object_utils(fft_sequence)
	
	function new(string name = "");
		super.new(name);
	endfunction: new	
endclass: fft_sequence


class fft_env extends uvm_env;
	`uvm_component_utils(fft_env)
	
	fft_sequencer 	m_sequencer;
	fft_st_driver 	m_driver;
	fft_st_monitor 	m_monitor;
	fft_scoreboard  m_scoreboard;
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		m_sequencer = fft_sequencer::type_id::create("m_sequencer", this);
		m_driver    = fft_st_driver::type_id::create("m_driver", this);	
		m_monitor   = fft_st_monitor::type_id::create("m_monitor", this);
		m_scoreboard= fft_scoreboard::type_id::create("m_scoreboard", this);		
	endfunction

	function void connect_phase(uvm_phase phase);
		m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
		
		// Connect scoreboard ports
		m_driver.aport.connect( m_scoreboard.port_fftin);
		m_monitor.aport.connect( m_scoreboard.port_fftout);
	endfunction
	
	task run_phase(uvm_phase phase);
		fft_sequence seq;
		seq = fft_sequence::type_id::create("seq");
		seq.start(m_sequencer);
	endtask	
	
endclass: fft_env
	
class fft_test_base extends uvm_test;
	`uvm_component_utils(fft_test_base)
	
	virtual axi_st_if driver_if;
	virtual axi_st_if monitor_if;
	fft_env m_env;
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);

		m_env = fft_env::type_id::create("m_env", this);				
		if(!uvm_config_db #(virtual axi_st_if)::get(this, "", "dut_driver", driver_if))
			`uvm_fatal("fft_test", "Could not get driver interface");		
		if(!uvm_config_db #(virtual axi_st_if)::get(this, "", "dut_monitor", monitor_if))
			`uvm_fatal("fft_test", "Could not get driver interface");		
		
	endfunction
	
	function void connect_phase(uvm_phase phase);
		m_env.m_driver.driver_if = driver_if;
		m_env.m_monitor.monitor_if = monitor_if;
	endfunction: connect_phase	
	
endclass: fft_test_base



class fft_sequence_basic extends fft_sequence;
	`uvm_object_utils(fft_sequence_basic)
	
	function new(string name = "");
		super.new(name);
	endfunction: new	
	
	task body;
		uvm_test_done.raise_objection(this);
		begin
			fft_transaction constant;
			constant = fft_transaction::type_id::create("constant");
			start_item(constant);
			for(int i=0;i<64;i=i+1) begin
				constant.data_re[i] = 32;
				constant.data_im[i] = 0;
			end
			finish_item(constant);
		end
		uvm_test_done.drop_objection(this);
	endtask: body
endclass: fft_sequence_basic


class fft_test_basic extends fft_test_base;
	`uvm_component_utils(fft_test_basic)	
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		fft_sequence::type_id::set_type_override(fft_sequence_basic::get_type());		
	endfunction

endclass: fft_test_basic

import "DPI-C" function chandle DPI_gen_wave_initialize(chandle existhandle);
import "DPI-C" function void DPI_gen_wave(input chandle objhandle,output shortint re [64],output shortint im [64]);

class fft_sequence_wave extends fft_sequence;
	`uvm_object_utils(fft_sequence_wave)
	
	chandle dpic_h;
	
	function new(string name = "");
		super.new(name);
		dpic_h = DPI_gen_wave_initialize(null);
	endfunction: new	
	
	task body;
		uvm_test_done.raise_objection(this);
		begin
			fft_transaction t;
			t = fft_transaction::type_id::create("sine");
			start_item(t);
			DPI_gen_wave(dpic_h, t.data_re, t.data_im);
			finish_item(t);
		end
		uvm_test_done.drop_objection(this);
	endtask: body
endclass: fft_sequence_wave


class fft_test_wave extends fft_test_base;
	`uvm_component_utils(fft_test_wave)	
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		fft_sequence::type_id::set_type_override(fft_sequence_wave::get_type());		
	endfunction

endclass: fft_test_wave
