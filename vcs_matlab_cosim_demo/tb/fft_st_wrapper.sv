/*
 * Copyright 2016 The MathWorks, Inc.
 */

module fft_st_wrapper(
    input           aclk,
    input           areset,
    input [31:0]    slave_tdata,
    input           slave_tvalid,
    output          slave_tready,
    output [31:0]   master_tdata,
    output          master_tvalid,
    input           master_tready);

    fft_st u_fft_st(
           .clk(aclk),
           .reset(areset),
           .clk_enable(1'b1),
           .slave_data_re(slave_tdata[15:0]),
           .slave_data_im(slave_tdata[31:16]),
           .slave_tvalid(slave_tvalid),
           .master_tready(master_tready),
           .ce_out(),
           .master_data_re(master_tdata[15:0]),
           .master_data_im(master_tdata[31:16]),
           .master_tvalid(master_tvalid),
           .slave_tready(slave_tready));
    
endmodule
    