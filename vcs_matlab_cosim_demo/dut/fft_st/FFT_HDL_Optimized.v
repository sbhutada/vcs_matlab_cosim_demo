// -------------------------------------------------------------
// 
// File Name: hdlsrc\fft_st\FFT_HDL_Optimized.v
// Created: 2014-11-25 15:16:15
// 
// Generated by MATLAB 8.5 and HDL Coder 3.6
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: FFT_HDL_Optimized
// Source Path: fft_st/fft_st/FFT HDL Optimized
// Hierarchy Level: 1
// 
// FFT HDL Optimized
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module FFT_HDL_Optimized
          (
           clk,
           reset,
           enb,
           dataIn_re,
           dataIn_im,
           validIn,
           dataOut_re,
           dataOut_im,
           validOut
          );


  input   clk;
  input   reset;
  input   enb;
  input   signed [15:0] dataIn_re;  // int16
  input   signed [15:0] dataIn_im;  // int16
  input   validIn;
  output  signed [15:0] dataOut_re;  // int16
  output  signed [15:0] dataOut_im;  // int16
  output  validOut;

  parameter signed [15:0] table_data_0 = 0;  // sfix16
  parameter signed [15:0] table_data_1 = -6270;  // sfix16
  parameter signed [15:0] table_data_2 = -11585;  // sfix16
  parameter signed [15:0] table_data_0_2 = 16384;  // sfix16
  parameter signed [15:0] table_data_1_2 = 15137;  // sfix16
  parameter signed [15:0] table_data_2_2 = 11585;  // sfix16
  parameter signed [15:0] table_data_0_4 = 0;  // sfix16
  parameter signed [15:0] table_data_1_4 = -3196;  // sfix16
  parameter signed [15:0] table_data_2_4 = -6270;  // sfix16
  parameter signed [15:0] table_data_3 = -9102;  // sfix16
  parameter signed [15:0] table_data_4 = -11585;  // sfix16
  parameter signed [15:0] table_data_0_6 = 16384;  // sfix16
  parameter signed [15:0] table_data_1_6 = 16069;  // sfix16
  parameter signed [15:0] table_data_2_6 = 15137;  // sfix16
  parameter signed [15:0] table_data_3_2 = 13623;  // sfix16
  parameter signed [15:0] table_data_4_2 = 11585;  // sfix16
  parameter signed [15:0] table_data_0_8 = 0;  // sfix16
  parameter signed [15:0] table_data_1_8 = -1606;  // sfix16
  parameter signed [15:0] table_data_2_8 = -3196;  // sfix16
  parameter signed [15:0] table_data_3_4 = -4756;  // sfix16
  parameter signed [15:0] table_data_4_4 = -6270;  // sfix16
  parameter signed [15:0] table_data_5 = -7723;  // sfix16
  parameter signed [15:0] table_data_6 = -9102;  // sfix16
  parameter signed [15:0] table_data_7 = -10394;  // sfix16
  parameter signed [15:0] table_data_8 = -11585;  // sfix16
  parameter signed [15:0] table_data_0_10 = 16384;  // sfix16
  parameter signed [15:0] table_data_1_10 = 16305;  // sfix16
  parameter signed [15:0] table_data_2_10 = 16069;  // sfix16
  parameter signed [15:0] table_data_3_6 = 15679;  // sfix16
  parameter signed [15:0] table_data_4_6 = 15137;  // sfix16
  parameter signed [15:0] table_data_5_2 = 14449;  // sfix16
  parameter signed [15:0] table_data_6_2 = 13623;  // sfix16
  parameter signed [15:0] table_data_7_2 = 12665;  // sfix16
  parameter signed [15:0] table_data_8_2 = 11585;  // sfix16

  wire signed [15:0] dataIn_cast_re;  // sfix16
  wire signed [15:0] dataIn_cast_im;  // sfix16
  wire softReset;
  wire signed [15:0] dout_re1;  // sfix16
  wire signed [15:0] dout_im1;  // sfix16
  wire dout_vld1;
  wire signed [15:0] dout_re2;  // sfix16
  wire signed [15:0] dout_im2;  // sfix16
  wire dout_vld2;
  wire signed [15:0] dout_re3;  // sfix16
  wire signed [15:0] dout_im3;  // sfix16
  wire dout_vld3;
  wire twiddleAddr_4;  // ufix1
  wire signed [15:0] Twiddle_im_table_data [0:2];  // sfix16_En14 [3]
  wire signed [15:0] twiddleS_im;  // sfix16_En14
  reg signed [15:0] twiddle_im_4;  // sfix16_En14
  wire signed [15:0] Twiddle_re_table_data [0:2];  // sfix16_En14 [3]
  wire signed [15:0] twiddleS_re;  // sfix16_En14
  reg signed [15:0] twiddle_re_4;  // sfix16_En14
  wire [2:0] stageOut_3;  // ufix3
  wire [2:0] stageOut_4;  // ufix3
  wire signed [15:0] dout_re4;  // sfix16
  wire signed [15:0] dout_im4;  // sfix16
  wire dout_vld4;
  wire [1:0] twiddleAddr_5;  // ufix2
  wire signed [15:0] Twiddle_im_table_data_1 [0:4];  // sfix16_En14 [5]
  wire signed [15:0] twiddleS_im_1;  // sfix16_En14
  reg signed [15:0] twiddle_im_5;  // sfix16_En14
  wire signed [15:0] Twiddle_re_table_data_1 [0:4];  // sfix16_En14 [5]
  wire signed [15:0] twiddleS_re_1;  // sfix16_En14
  reg signed [15:0] twiddle_re_5;  // sfix16_En14
  wire [2:0] stageOut_5;  // ufix3
  wire signed [15:0] dout_re5;  // sfix16
  wire signed [15:0] dout_im5;  // sfix16
  wire dout_vld5;
  wire [2:0] twiddleAddr_6;  // ufix3
  wire signed [15:0] Twiddle_im_table_data_2 [0:8];  // sfix16_En14 [9]
  wire signed [15:0] twiddleS_im_2;  // sfix16_En14
  reg signed [15:0] twiddle_im_6;  // sfix16_En14
  wire signed [15:0] Twiddle_re_table_data_2 [0:8];  // sfix16_En14 [9]
  wire signed [15:0] twiddleS_re_2;  // sfix16_En14
  reg signed [15:0] twiddle_re_6;  // sfix16_En14
  wire [2:0] stageOut_6;  // ufix3
  wire signed [15:0] dout_re6;  // sfix16
  wire signed [15:0] dout_im6;  // sfix16
  wire dout_vld6;
  wire signed [15:0] dout_re7;  // sfix16
  wire signed [15:0] dout_im7;  // sfix16
  wire dout_vld7;


  assign dataIn_cast_re = dataIn_re;
  assign dataIn_cast_im = dataIn_im;



  assign softReset = 1'b0;



  RADIX2FFT_KernelF_1   u_First_Stage   (.clk(clk),
                                         .reset(reset),
                                         .enb(enb),
                                         .din_re(dataIn_cast_re),  // sfix16
                                         .din_im(dataIn_cast_im),  // sfix16
                                         .validIn(validIn),
                                         .softReset(softReset),
                                         .dout_re1(dout_re1),  // sfix16
                                         .dout_im1(dout_im1),  // sfix16
                                         .dout_vld1(dout_vld1)
                                         );

  RADIX2FFT_KernelF_2   u_Second_Stage   (.clk(clk),
                                          .reset(reset),
                                          .enb(enb),
                                          .dout_re1(dout_re1),  // sfix16
                                          .dout_im1(dout_im1),  // sfix16
                                          .dout_vld1(dout_vld1),
                                          .softReset(softReset),
                                          .dout_re2(dout_re2),  // sfix16
                                          .dout_im2(dout_im2),  // sfix16
                                          .dout_vld2(dout_vld2)
                                          );

  RADIX2FFT_KernelF_3   u_Third_Stage   (.clk(clk),
                                         .reset(reset),
                                         .enb(enb),
                                         .dout_re2(dout_re2),  // sfix16
                                         .dout_im2(dout_im2),  // sfix16
                                         .dout_vld2(dout_vld2),
                                         .softReset(softReset),
                                         .dout_re3(dout_re3),  // sfix16
                                         .dout_im3(dout_im3),  // sfix16
                                         .dout_vld3(dout_vld3)
                                         );

  // Twiddle ROM2
  assign Twiddle_im_table_data[0] = table_data_0;
  assign Twiddle_im_table_data[1] = table_data_1;
  assign Twiddle_im_table_data[2] = table_data_2;
  assign twiddleS_im = Twiddle_im_table_data[twiddleAddr_4];



  always @(posedge clk)
    begin : TWIDDLEROM_IM_process
      if (reset == 1'b1) begin
        twiddle_im_4 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          twiddle_im_4 <= twiddleS_im;
        end
      end
    end



  // Twiddle ROM1
  assign Twiddle_re_table_data[0] = table_data_0_2;
  assign Twiddle_re_table_data[1] = table_data_1_2;
  assign Twiddle_re_table_data[2] = table_data_2_2;
  assign twiddleS_re = Twiddle_re_table_data[twiddleAddr_4];



  always @(posedge clk)
    begin : TWIDDLEROM_RE_process
      if (reset == 1'b1) begin
        twiddle_re_4 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          twiddle_re_4 <= twiddleS_re;
        end
      end
    end



  RADIX2FFT_KernelG   u_Middle_Stage   (.clk(clk),
                                        .reset(reset),
                                        .enb(enb),
                                        .stageIn_4(stageOut_3),  // ufix3
                                        .twiddle_re_4(twiddle_re_4),  // sfix16_En14
                                        .twiddle_im_4(twiddle_im_4),  // sfix16_En14
                                        .dout_re3(dout_re3),  // sfix16
                                        .dout_im3(dout_im3),  // sfix16
                                        .dout_vld3(dout_vld3),
                                        .softReset(softReset),
                                        .stageOut_4(stageOut_4),  // ufix3
                                        .twiddleAddr_4(twiddleAddr_4),  // ufix1
                                        .dout_re4(dout_re4),  // sfix16
                                        .dout_im4(dout_im4),  // sfix16
                                        .dout_vld4(dout_vld4)
                                        );

  // Twiddle ROM2
  assign Twiddle_im_table_data_1[0] = table_data_0_4;
  assign Twiddle_im_table_data_1[1] = table_data_1_4;
  assign Twiddle_im_table_data_1[2] = table_data_2_4;
  assign Twiddle_im_table_data_1[3] = table_data_3;
  assign Twiddle_im_table_data_1[4] = table_data_4;
  assign twiddleS_im_1 = Twiddle_im_table_data_1[twiddleAddr_5];



  always @(posedge clk)
    begin : TWIDDLEROM_IM_1_process
      if (reset == 1'b1) begin
        twiddle_im_5 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          twiddle_im_5 <= twiddleS_im_1;
        end
      end
    end



  // Twiddle ROM1
  assign Twiddle_re_table_data_1[0] = table_data_0_6;
  assign Twiddle_re_table_data_1[1] = table_data_1_6;
  assign Twiddle_re_table_data_1[2] = table_data_2_6;
  assign Twiddle_re_table_data_1[3] = table_data_3_2;
  assign Twiddle_re_table_data_1[4] = table_data_4_2;
  assign twiddleS_re_1 = Twiddle_re_table_data_1[twiddleAddr_5];



  always @(posedge clk)
    begin : TWIDDLEROM_RE_1_process
      if (reset == 1'b1) begin
        twiddle_re_5 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          twiddle_re_5 <= twiddleS_re_1;
        end
      end
    end



  RADIX2FFT_KernelG_block   u_Middle_Stage_1   (.clk(clk),
                                                .reset(reset),
                                                .enb(enb),
                                                .stageIn_5(stageOut_4),  // ufix3
                                                .twiddle_re_5(twiddle_re_5),  // sfix16_En14
                                                .twiddle_im_5(twiddle_im_5),  // sfix16_En14
                                                .dout_re4(dout_re4),  // sfix16
                                                .dout_im4(dout_im4),  // sfix16
                                                .dout_vld4(dout_vld4),
                                                .softReset(softReset),
                                                .stageOut_5(stageOut_5),  // ufix3
                                                .twiddleAddr_5(twiddleAddr_5),  // ufix2
                                                .dout_re5(dout_re5),  // sfix16
                                                .dout_im5(dout_im5),  // sfix16
                                                .dout_vld5(dout_vld5)
                                                );

  // Twiddle ROM2
  assign Twiddle_im_table_data_2[0] = table_data_0_8;
  assign Twiddle_im_table_data_2[1] = table_data_1_8;
  assign Twiddle_im_table_data_2[2] = table_data_2_8;
  assign Twiddle_im_table_data_2[3] = table_data_3_4;
  assign Twiddle_im_table_data_2[4] = table_data_4_4;
  assign Twiddle_im_table_data_2[5] = table_data_5;
  assign Twiddle_im_table_data_2[6] = table_data_6;
  assign Twiddle_im_table_data_2[7] = table_data_7;
  assign Twiddle_im_table_data_2[8] = table_data_8;
  assign twiddleS_im_2 = Twiddle_im_table_data_2[twiddleAddr_6];



  always @(posedge clk)
    begin : TWIDDLEROM_IM_2_process
      if (reset == 1'b1) begin
        twiddle_im_6 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          twiddle_im_6 <= twiddleS_im_2;
        end
      end
    end



  // Twiddle ROM1
  assign Twiddle_re_table_data_2[0] = table_data_0_10;
  assign Twiddle_re_table_data_2[1] = table_data_1_10;
  assign Twiddle_re_table_data_2[2] = table_data_2_10;
  assign Twiddle_re_table_data_2[3] = table_data_3_6;
  assign Twiddle_re_table_data_2[4] = table_data_4_6;
  assign Twiddle_re_table_data_2[5] = table_data_5_2;
  assign Twiddle_re_table_data_2[6] = table_data_6_2;
  assign Twiddle_re_table_data_2[7] = table_data_7_2;
  assign Twiddle_re_table_data_2[8] = table_data_8_2;
  assign twiddleS_re_2 = Twiddle_re_table_data_2[twiddleAddr_6];



  always @(posedge clk)
    begin : TWIDDLEROM_RE_2_process
      if (reset == 1'b1) begin
        twiddle_re_6 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          twiddle_re_6 <= twiddleS_re_2;
        end
      end
    end



  RADIX2FFT_KernelL   u_Last_Stage   (.clk(clk),
                                      .reset(reset),
                                      .enb(enb),
                                      .stageIn_6(stageOut_5),  // ufix3
                                      .twiddle_re_6(twiddle_re_6),  // sfix16_En14
                                      .twiddle_im_6(twiddle_im_6),  // sfix16_En14
                                      .dout_re5(dout_re5),  // sfix16
                                      .dout_im5(dout_im5),  // sfix16
                                      .dout_vld5(dout_vld5),
                                      .softReset(softReset),
                                      .stageOut_6(stageOut_6),  // ufix3
                                      .twiddleAddr_6(twiddleAddr_6),  // ufix3
                                      .dout_re6(dout_re6),  // sfix16
                                      .dout_im6(dout_im6),  // sfix16
                                      .dout_vld6(dout_vld6)
                                      );

  RADIX2FFT_bitNatural   u_NaturalOrder_Stage   (.clk(clk),
                                                 .reset(reset),
                                                 .enb(enb),
                                                 .dout_re6(dout_re6),  // sfix16
                                                 .dout_im6(dout_im6),  // sfix16
                                                 .dout_vld6(dout_vld6),
                                                 .softReset(softReset),
                                                 .dout_re7(dout_re7),  // sfix16
                                                 .dout_im7(dout_im7),  // sfix16
                                                 .dout_vld7(dout_vld7)
                                                 );

  assign dataOut_re = dout_re7;

  assign dataOut_im = dout_im7;

  assign validOut = dout_vld7;

endmodule  // FFT_HDL_Optimized

