// -------------------------------------------------------------
// 
// File Name: hdlsrc\fft_st\HDL_FIFO_ram_128x32b.v
// Created: 2014-11-25 15:16:15
// 
// Generated by MATLAB 8.5 and HDL Coder 3.6
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: HDL_FIFO_ram_128x32b
// Source Path: fft_st/fft_st/HDL FIFO/HDL FIFO_ram_128x32b
// Hierarchy Level: 2
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module HDL_FIFO_ram_128x32b
          (
           clk,
           enb,
           wr_din_re,
           wr_din_im,
           wr_addr,
           wr_en,
           rd_addr,
           rd_dout_re,
           rd_dout_im
          );


  input   clk;
  input   enb;
  input   signed [15:0] wr_din_re;  // int16
  input   signed [15:0] wr_din_im;  // int16
  input   [6:0] wr_addr;  // ufix7
  input   wr_en;  // ufix1
  input   [6:0] rd_addr;  // ufix7
  output  signed [15:0] rd_dout_re;  // int16
  output  signed [15:0] rd_dout_im;  // int16




  SimpleDualPortRAM_128x32b   u_SimpleDualPortRAM_128x32b   (.clk(clk),
                                                             .enb(enb),
                                                             .wr_din_re(wr_din_re),  // int16
                                                             .wr_din_im(wr_din_im),  // int16
                                                             .wr_addr(wr_addr),  // ufix7
                                                             .wr_en(wr_en),  // ufix1
                                                             .rd_addr(rd_addr),  // ufix7
                                                             .rd_dout_re(rd_dout_re),  // int16
                                                             .rd_dout_im(rd_dout_im)  // int16
                                                             );

endmodule  // HDL_FIFO_ram_128x32b

