// -------------------------------------------------------------
// 
// File Name: hdlsrc\fft_st\ComplexMultiply_block2.v
// Created: 2014-11-25 15:16:15
// 
// Generated by MATLAB 8.5 and HDL Coder 3.6
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: ComplexMultiply_block2
// Source Path: fft_st/fft_st/FFT HDL Optimized/RADIX2FFT_KernelL/Radix2ButterflyG/ComplexMultiply
// Hierarchy Level: 4
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module ComplexMultiply_block2
          (
           clk,
           enb,
           y_v_in,
           v_y_in,
           twdl_re_dly,
           twdl_im_dly,
           multRes1,
           multRes2
          );


  input   clk;
  input   enb;
  input   signed [15:0] y_v_in;  // sfix16
  input   signed [15:0] v_y_in;  // sfix16
  input   signed [15:0] twdl_re_dly;  // sfix16_En14
  input   signed [15:0] twdl_im_dly;  // sfix16_En14
  output  signed [31:0] multRes1;  // sfix32_En14
  output  signed [31:0] multRes2;  // sfix32_En14


  reg signed [15:0] ComplexMultiply_din1_pipe1;  // sfix16
  reg signed [15:0] ComplexMultiply_din2_pipe1;  // sfix16
  reg signed [31:0] ComplexMultiply_mult1_pipe1;  // sfix32
  reg signed [31:0] ComplexMultiply_mult2_pipe1;  // sfix32
  reg signed [15:0] ComplexMultiply_twiddle_re_pipe1;  // sfix16
  reg signed [15:0] ComplexMultiply_twiddle_im_pipe1;  // sfix16
  reg signed [31:0] multRes1_1;  // sfix32_En14
  reg signed [31:0] multRes2_1;  // sfix32_En14


  // ComplexMultiply
  always @(posedge clk)
    begin : ComplexMultiply_process
      if (enb) begin
        multRes1_1 <= ComplexMultiply_mult1_pipe1;
        multRes2_1 <= ComplexMultiply_mult2_pipe1;
        ComplexMultiply_twiddle_re_pipe1 <= twdl_re_dly;
        ComplexMultiply_twiddle_im_pipe1 <= twdl_im_dly;
        ComplexMultiply_din1_pipe1 <= y_v_in;
        ComplexMultiply_din2_pipe1 <= v_y_in;
        ComplexMultiply_mult1_pipe1 <= ComplexMultiply_din1_pipe1 * ComplexMultiply_twiddle_re_pipe1;
        ComplexMultiply_mult2_pipe1 <= ComplexMultiply_din2_pipe1 * ComplexMultiply_twiddle_im_pipe1;
      end
    end



  assign multRes1 = multRes1_1;

  assign multRes2 = multRes2_1;

endmodule  // ComplexMultiply_block2

