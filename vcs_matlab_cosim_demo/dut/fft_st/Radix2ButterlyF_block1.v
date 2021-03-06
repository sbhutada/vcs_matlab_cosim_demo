// -------------------------------------------------------------
// 
// File Name: hdlsrc\fft_st\Radix2ButterlyF_block1.v
// Created: 2014-11-25 15:16:14
// 
// Generated by MATLAB 8.5 and HDL Coder 3.6
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: Radix2ButterlyF_block1
// Source Path: fft_st/fft_st/FFT HDL Optimized/RADIX2FFT_KernelF_3/Radix2ButterlyF
// Hierarchy Level: 3
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module Radix2ButterlyF_block1
          (
           clk,
           reset,
           enb,
           x_re_0,
           in2_re,
           x_im_0,
           in2_im,
           procEnb,
           softReset,
           x_out,
           u_out,
           y_out,
           v_out,
           doutVld
          );


  input   clk;
  input   reset;
  input   enb;
  input   signed [15:0] x_re_0;  // sfix16
  input   signed [32:0] in2_re;  // sfix33_En14
  input   signed [15:0] x_im_0;  // sfix16
  input   signed [32:0] in2_im;  // sfix33_En14
  input   procEnb;
  input   softReset;
  output  signed [15:0] x_out;  // sfix16
  output  signed [15:0] u_out;  // sfix16
  output  signed [15:0] y_out;  // sfix16
  output  signed [15:0] v_out;  // sfix16
  output  doutVld;


  reg signed [32:0] Radix2ButterflyF_din1_re_reg1;  // sfix33
  reg signed [32:0] Radix2ButterflyF_din1_im_reg1;  // sfix33
  reg signed [15:0] Radix2ButterflyF_dout1_re_reg;  // sfix16
  reg signed [15:0] Radix2ButterflyF_dout2_re_reg;  // sfix16
  reg signed [15:0] Radix2ButterflyF_dout1_im_reg;  // sfix16
  reg signed [15:0] Radix2ButterflyF_dout2_im_reg;  // sfix16
  reg  Radix2ButterflyF_dinVld_reg1;
  reg  Radix2ButterflyF_dinVld_reg2;
  reg  Radix2ButterflyF_dinVld_reg3;
  reg signed [33:0] Radix2ButterflyF_sum1_re_reg;  // sfix34
  reg signed [33:0] Radix2ButterflyF_sum2_re_reg;  // sfix34
  reg signed [33:0] Radix2ButterflyF_sum1_im_reg;  // sfix34
  reg signed [33:0] Radix2ButterflyF_sum2_im_reg;  // sfix34
  reg signed [15:0] Radix2ButterflyF_din1_re_pipe1;  // sfix16
  reg signed [15:0] Radix2ButterflyF_din1_im_pipe1;  // sfix16
  reg signed [15:0] Radix2ButterflyF_din1_re_pipe2;  // sfix16
  reg signed [15:0] Radix2ButterflyF_din1_im_pipe2;  // sfix16
  reg signed [15:0] Radix2ButterflyF_din1_re_pipe3;  // sfix16
  reg signed [15:0] Radix2ButterflyF_din1_im_pipe3;  // sfix16
  reg  Radix2ButterflyF_dinVld_pipe1;
  reg  Radix2ButterflyF_dinVld_pipe2;
  reg  Radix2ButterflyF_dinVld_pipe3;
  reg signed [32:0] Radix2ButterflyF_din1_re_reg1_next;  // sfix33_En14
  reg signed [32:0] Radix2ButterflyF_din1_im_reg1_next;  // sfix33_En14
  reg signed [15:0] Radix2ButterflyF_dout1_re_reg_next;  // sfix16
  reg signed [15:0] Radix2ButterflyF_dout2_re_reg_next;  // sfix16
  reg signed [15:0] Radix2ButterflyF_dout1_im_reg_next;  // sfix16
  reg signed [15:0] Radix2ButterflyF_dout2_im_reg_next;  // sfix16
  reg  Radix2ButterflyF_dinVld_reg1_next;
  reg  Radix2ButterflyF_dinVld_reg2_next;
  reg  Radix2ButterflyF_dinVld_reg3_next;
  reg signed [33:0] Radix2ButterflyF_sum1_re_reg_next;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_sum2_re_reg_next;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_sum1_im_reg_next;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_sum2_im_reg_next;  // sfix34_En14
  reg signed [15:0] Radix2ButterflyF_din1_re_pipe1_next;  // sfix16
  reg signed [15:0] Radix2ButterflyF_din1_im_pipe1_next;  // sfix16
  reg signed [15:0] Radix2ButterflyF_din1_re_pipe2_next;  // sfix16
  reg signed [15:0] Radix2ButterflyF_din1_im_pipe2_next;  // sfix16
  reg signed [15:0] Radix2ButterflyF_din1_re_pipe3_next;  // sfix16
  reg signed [15:0] Radix2ButterflyF_din1_im_pipe3_next;  // sfix16
  reg  Radix2ButterflyF_dinVld_pipe1_next;
  reg  Radix2ButterflyF_dinVld_pipe2_next;
  reg  Radix2ButterflyF_dinVld_pipe3_next;
  reg signed [15:0] x_out_1;  // sfix16
  reg signed [15:0] y_out_1;  // sfix16
  reg signed [15:0] u_out_1;  // sfix16
  reg signed [15:0] v_out_1;  // sfix16
  reg  doutVld_1;
  reg signed [33:0] Radix2ButterflyF_sra_temp;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_add_cast;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_add_cast_0;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_sra_temp_0;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_sub_cast;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_sub_cast_0;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_sra_temp_1;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_add_cast_1;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_add_cast_2;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_sra_temp_2;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_sub_cast_1;  // sfix34_En14
  reg signed [33:0] Radix2ButterflyF_sub_cast_2;  // sfix34_En14


  // Radix2ButterflyF
  always @(posedge clk)
    begin : Radix2ButterflyF_process
      if (reset == 1'b1) begin
        Radix2ButterflyF_dout1_re_reg <= 16'sb0000000000000000;
        Radix2ButterflyF_dout2_re_reg <= 16'sb0000000000000000;
        Radix2ButterflyF_dout1_im_reg <= 16'sb0000000000000000;
        Radix2ButterflyF_dout2_im_reg <= 16'sb0000000000000000;
        Radix2ButterflyF_sum1_re_reg <= 34'sh000000000;
        Radix2ButterflyF_sum2_re_reg <= 34'sh000000000;
        Radix2ButterflyF_sum1_im_reg <= 34'sh000000000;
        Radix2ButterflyF_sum2_im_reg <= 34'sh000000000;
        Radix2ButterflyF_din1_re_reg1 <= 33'sh000000000;
        Radix2ButterflyF_din1_im_reg1 <= 33'sh000000000;
        Radix2ButterflyF_din1_re_pipe1 <= 16'sb0000000000000000;
        Radix2ButterflyF_din1_im_pipe1 <= 16'sb0000000000000000;
        Radix2ButterflyF_din1_re_pipe2 <= 16'sb0000000000000000;
        Radix2ButterflyF_din1_im_pipe2 <= 16'sb0000000000000000;
        Radix2ButterflyF_din1_re_pipe3 <= 16'sb0000000000000000;
        Radix2ButterflyF_din1_im_pipe3 <= 16'sb0000000000000000;
        Radix2ButterflyF_dinVld_reg3 <= 1'b0;
        Radix2ButterflyF_dinVld_reg2 <= 1'b0;
        Radix2ButterflyF_dinVld_reg1 <= 1'b0;
        Radix2ButterflyF_dinVld_pipe1 <= 1'b0;
        Radix2ButterflyF_dinVld_pipe2 <= 1'b0;
        Radix2ButterflyF_dinVld_pipe3 <= 1'b0;
      end
      else begin
        if (enb) begin
          Radix2ButterflyF_din1_re_reg1 <= Radix2ButterflyF_din1_re_reg1_next;
          Radix2ButterflyF_din1_im_reg1 <= Radix2ButterflyF_din1_im_reg1_next;
          Radix2ButterflyF_dout1_re_reg <= Radix2ButterflyF_dout1_re_reg_next;
          Radix2ButterflyF_dout2_re_reg <= Radix2ButterflyF_dout2_re_reg_next;
          Radix2ButterflyF_dout1_im_reg <= Radix2ButterflyF_dout1_im_reg_next;
          Radix2ButterflyF_dout2_im_reg <= Radix2ButterflyF_dout2_im_reg_next;
          Radix2ButterflyF_dinVld_reg1 <= Radix2ButterflyF_dinVld_reg1_next;
          Radix2ButterflyF_dinVld_reg2 <= Radix2ButterflyF_dinVld_reg2_next;
          Radix2ButterflyF_dinVld_reg3 <= Radix2ButterflyF_dinVld_reg3_next;
          Radix2ButterflyF_sum1_re_reg <= Radix2ButterflyF_sum1_re_reg_next;
          Radix2ButterflyF_sum2_re_reg <= Radix2ButterflyF_sum2_re_reg_next;
          Radix2ButterflyF_sum1_im_reg <= Radix2ButterflyF_sum1_im_reg_next;
          Radix2ButterflyF_sum2_im_reg <= Radix2ButterflyF_sum2_im_reg_next;
          Radix2ButterflyF_din1_re_pipe1 <= Radix2ButterflyF_din1_re_pipe1_next;
          Radix2ButterflyF_din1_im_pipe1 <= Radix2ButterflyF_din1_im_pipe1_next;
          Radix2ButterflyF_din1_re_pipe2 <= Radix2ButterflyF_din1_re_pipe2_next;
          Radix2ButterflyF_din1_im_pipe2 <= Radix2ButterflyF_din1_im_pipe2_next;
          Radix2ButterflyF_din1_re_pipe3 <= Radix2ButterflyF_din1_re_pipe3_next;
          Radix2ButterflyF_din1_im_pipe3 <= Radix2ButterflyF_din1_im_pipe3_next;
          Radix2ButterflyF_dinVld_pipe1 <= Radix2ButterflyF_dinVld_pipe1_next;
          Radix2ButterflyF_dinVld_pipe2 <= Radix2ButterflyF_dinVld_pipe2_next;
          Radix2ButterflyF_dinVld_pipe3 <= Radix2ButterflyF_dinVld_pipe3_next;
        end
      end
    end

  always @(Radix2ButterflyF_din1_re_reg1, Radix2ButterflyF_din1_im_reg1,
       Radix2ButterflyF_dout1_re_reg, Radix2ButterflyF_dout2_re_reg,
       Radix2ButterflyF_dout1_im_reg, Radix2ButterflyF_dout2_im_reg,
       Radix2ButterflyF_dinVld_reg1, Radix2ButterflyF_dinVld_reg2,
       Radix2ButterflyF_dinVld_reg3, Radix2ButterflyF_sum1_re_reg,
       Radix2ButterflyF_sum2_re_reg, Radix2ButterflyF_sum1_im_reg,
       Radix2ButterflyF_sum2_im_reg, Radix2ButterflyF_din1_re_pipe1,
       Radix2ButterflyF_din1_im_pipe1, Radix2ButterflyF_din1_re_pipe2,
       Radix2ButterflyF_din1_im_pipe2, Radix2ButterflyF_din1_re_pipe3,
       Radix2ButterflyF_din1_im_pipe3, Radix2ButterflyF_dinVld_pipe1,
       Radix2ButterflyF_dinVld_pipe2, Radix2ButterflyF_dinVld_pipe3, x_re_0,
       in2_re, x_im_0, in2_im, procEnb) begin
    Radix2ButterflyF_dout1_re_reg_next = Radix2ButterflyF_dout1_re_reg;
    Radix2ButterflyF_dout2_re_reg_next = Radix2ButterflyF_dout2_re_reg;
    Radix2ButterflyF_dout1_im_reg_next = Radix2ButterflyF_dout1_im_reg;
    Radix2ButterflyF_dout2_im_reg_next = Radix2ButterflyF_dout2_im_reg;
    Radix2ButterflyF_din1_re_pipe1_next = Radix2ButterflyF_din1_re_pipe1;
    Radix2ButterflyF_din1_im_pipe1_next = Radix2ButterflyF_din1_im_pipe1;
    if (Radix2ButterflyF_dinVld_reg2) begin
      Radix2ButterflyF_sra_temp = Radix2ButterflyF_sum1_re_reg >>> 8'd1;
      Radix2ButterflyF_dout1_re_reg_next = Radix2ButterflyF_sra_temp[29:14];
      Radix2ButterflyF_sra_temp_0 = Radix2ButterflyF_sum2_re_reg >>> 8'd1;
      Radix2ButterflyF_dout2_re_reg_next = Radix2ButterflyF_sra_temp_0[29:14];
      Radix2ButterflyF_sra_temp_1 = Radix2ButterflyF_sum1_im_reg >>> 8'd1;
      Radix2ButterflyF_dout1_im_reg_next = Radix2ButterflyF_sra_temp_1[29:14];
      Radix2ButterflyF_sra_temp_2 = Radix2ButterflyF_sum2_im_reg >>> 8'd1;
      Radix2ButterflyF_dout2_im_reg_next = Radix2ButterflyF_sra_temp_2[29:14];
    end
    Radix2ButterflyF_add_cast = {Radix2ButterflyF_din1_re_reg1[32], Radix2ButterflyF_din1_re_reg1};
    Radix2ButterflyF_add_cast_0 = {in2_re[32], in2_re};
    Radix2ButterflyF_sum1_re_reg_next = Radix2ButterflyF_add_cast + Radix2ButterflyF_add_cast_0;
    Radix2ButterflyF_sub_cast = {Radix2ButterflyF_din1_re_reg1[32], Radix2ButterflyF_din1_re_reg1};
    Radix2ButterflyF_sub_cast_0 = {in2_re[32], in2_re};
    Radix2ButterflyF_sum2_re_reg_next = Radix2ButterflyF_sub_cast - Radix2ButterflyF_sub_cast_0;
    Radix2ButterflyF_add_cast_1 = {Radix2ButterflyF_din1_im_reg1[32], Radix2ButterflyF_din1_im_reg1};
    Radix2ButterflyF_add_cast_2 = {in2_im[32], in2_im};
    Radix2ButterflyF_sum1_im_reg_next = Radix2ButterflyF_add_cast_1 + Radix2ButterflyF_add_cast_2;
    Radix2ButterflyF_sub_cast_1 = {Radix2ButterflyF_din1_im_reg1[32], Radix2ButterflyF_din1_im_reg1};
    Radix2ButterflyF_sub_cast_2 = {in2_im[32], in2_im};
    Radix2ButterflyF_sum2_im_reg_next = Radix2ButterflyF_sub_cast_1 - Radix2ButterflyF_sub_cast_2;
    Radix2ButterflyF_din1_re_reg1_next = {{3{Radix2ButterflyF_din1_re_pipe3[15]}}, {Radix2ButterflyF_din1_re_pipe3, 14'b00000000000000}};
    Radix2ButterflyF_din1_im_reg1_next = {{3{Radix2ButterflyF_din1_im_pipe3[15]}}, {Radix2ButterflyF_din1_im_pipe3, 14'b00000000000000}};
    Radix2ButterflyF_dinVld_reg3_next = Radix2ButterflyF_dinVld_reg2;
    Radix2ButterflyF_dinVld_reg2_next = Radix2ButterflyF_dinVld_reg1;
    Radix2ButterflyF_dinVld_reg1_next = Radix2ButterflyF_dinVld_pipe3;
    Radix2ButterflyF_dinVld_pipe3_next = Radix2ButterflyF_dinVld_pipe2;
    Radix2ButterflyF_dinVld_pipe2_next = Radix2ButterflyF_dinVld_pipe1;
    Radix2ButterflyF_dinVld_pipe1_next = procEnb;
    Radix2ButterflyF_din1_re_pipe3_next = Radix2ButterflyF_din1_re_pipe2;
    Radix2ButterflyF_din1_im_pipe3_next = Radix2ButterflyF_din1_im_pipe2;
    Radix2ButterflyF_din1_re_pipe2_next = Radix2ButterflyF_din1_re_pipe1;
    Radix2ButterflyF_din1_im_pipe2_next = Radix2ButterflyF_din1_im_pipe1;
    if (procEnb) begin
      Radix2ButterflyF_din1_re_pipe1_next = x_re_0;
      Radix2ButterflyF_din1_im_pipe1_next = x_im_0;
    end
    x_out_1 = Radix2ButterflyF_dout1_re_reg;
    y_out_1 = Radix2ButterflyF_dout2_re_reg;
    u_out_1 = Radix2ButterflyF_dout1_im_reg;
    v_out_1 = Radix2ButterflyF_dout2_im_reg;
    doutVld_1 = Radix2ButterflyF_dinVld_reg3;
  end



  assign x_out = x_out_1;

  assign u_out = u_out_1;

  assign y_out = y_out_1;

  assign v_out = v_out_1;

  assign doutVld = doutVld_1;

endmodule  // Radix2ButterlyF_block1

