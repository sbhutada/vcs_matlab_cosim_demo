// -------------------------------------------------------------
// 
// File Name: hdlsrc\fft_st\dataXMEM_re_1_1_8x16b.v
// Created: 2014-11-25 15:16:14
// 
// Generated by MATLAB 8.5 and HDL Coder 3.6
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dataXMEM_re_1_1_8x16b
// Source Path: fft_st/fft_st/FFT HDL Optimized/RADIX2FFT_KernelF_1/dataXMEM_re_1_1_8x16b
// Hierarchy Level: 3
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dataXMEM_re_1_1_8x16b
          (
           clk,
           enb,
           wr_din,
           wr_addr,
           wr_en,
           rd_addr,
           rd_dout
          );


  input   clk;
  input   enb;
  input   signed [15:0] wr_din;  // sfix16
  input   [2:0] wr_addr;  // ufix3
  input   wr_en;  // ufix1
  input   [2:0] rd_addr;  // ufix3
  output  signed [15:0] rd_dout;  // sfix16




  SimpleDualPortRAM_8x16b   u_SimpleDualPortRAM_8x16b   (.clk(clk),
                                                         .enb(enb),
                                                         .wr_din(wr_din),  // sfix16
                                                         .wr_addr(wr_addr),  // ufix3
                                                         .wr_en(wr_en),  // ufix1
                                                         .rd_addr(rd_addr),  // ufix3
                                                         .rd_dout(rd_dout)  // sfix16
                                                         );

endmodule  // dataXMEM_re_1_1_8x16b

