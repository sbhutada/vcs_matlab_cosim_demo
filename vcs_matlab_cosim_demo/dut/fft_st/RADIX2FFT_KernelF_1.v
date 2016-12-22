// -------------------------------------------------------------
// 
// File Name: hdlsrc\fft_st\RADIX2FFT_KernelF_1.v
// Created: 2014-11-25 15:16:14
// 
// Generated by MATLAB 8.5 and HDL Coder 3.6
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: RADIX2FFT_KernelF_1
// Source Path: fft_st/fft_st/FFT HDL Optimized/RADIX2FFT_KernelF_1
// Hierarchy Level: 2
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module RADIX2FFT_KernelF_1
          (
           clk,
           reset,
           enb,
           din_re,
           din_im,
           validIn,
           softReset,
           dout_re1,
           dout_im1,
           dout_vld1
          );


  input   clk;
  input   reset;
  input   enb;
  input   signed [15:0] din_re;  // sfix16
  input   signed [15:0] din_im;  // sfix16
  input   validIn;
  input   softReset;
  output  signed [15:0] dout_re1;  // sfix16
  output  signed [15:0] dout_im1;  // sfix16
  output  dout_vld1;


  wire signed [15:0] CONST0;  // sfix16_En14
  reg signed [15:0] wrData_im_1;  // sfix16
  reg [2:0] wrAddr_1;  // ufix3
  reg  WrEnb_1;
  reg [2:0] rdAddr_1;  // ufix3
  wire signed [15:0] x_im_1;  // sfix16
  reg signed [15:0] wrData_re_1;  // sfix16
  wire signed [15:0] x_re_1;  // sfix16
  reg signed [15:0] wrData_im_0;  // sfix16
  reg [4:0] wrAddr_0;  // ufix5
  reg  WrEnb_0;
  reg [4:0] rdAddr_0;  // ufix5
  wire signed [15:0] x_im_0;  // sfix16
  reg  procEnb;
  reg signed [15:0] in2_re;  // sfix16
  reg signed [15:0] in2_im;  // sfix16
  wire doutVld;
  reg  txEOF;
  reg [2:0] rdStateMachineF_rdState;  // ufix3
  reg [4:0] rdStateMachineF_curRdAddr_0;  // ufix5
  reg [2:0] rdStateMachineF_curRdAddr_1;  // ufix3
  reg  rdStateMachineF_curRdEnb_0;
  reg  rdStateMachineF_curRdEnb_1;
  reg  rdStateMachineF_procEnbReg;
  reg  rdStateMachineF_dVldOut2O_Reg0;
  reg  rdStateMachineF_dVldOut_Reg1;
  reg [1:0] rdStateMachineF_xMemState;  // ufix2
  reg [5:0] rdStateMachineF_waitCnt;  // ufix6
  reg [4:0] rdStateMachineF_waitCnt4Rd;  // ufix5
  reg  rdStateMachineF_procState;  // ufix1
  reg [2:0] rdStateMachineF_rdState_next;  // ufix3
  reg [4:0] rdStateMachineF_curRdAddr_0_next;  // ufix5
  reg [2:0] rdStateMachineF_curRdAddr_1_next;  // ufix3
  reg  rdStateMachineF_curRdEnb_0_next;
  reg  rdStateMachineF_curRdEnb_1_next;
  reg  rdStateMachineF_procEnbReg_next;
  reg  rdStateMachineF_dVldOut2O_Reg0_next;
  reg  rdStateMachineF_dVldOut_Reg1_next;
  reg [1:0] rdStateMachineF_xMemState_next;  // ufix2
  reg [5:0] rdStateMachineF_waitCnt_next;  // ufix6
  reg [4:0] rdStateMachineF_waitCnt4Rd_next;  // ufix5
  reg  rdStateMachineF_procState_next;  // ufix1
  reg  dOutVld2O;
  reg  dOutVld_1;
  wire signed [15:0] y_out;  // sfix16
  wire signed [15:0] v_out;  // sfix16
  reg [1:0] wrStateMachineF_wrState;  // ufix2
  reg [4:0] wrStateMachineF_curWrAddr_0;  // ufix5
  reg  wrStateMachineF_wrEnbReg_0;
  reg signed [15:0] wrStateMachineF_wrDataReg_re_0;  // sfix16
  reg signed [15:0] wrStateMachineF_wrDataReg_im_0;  // sfix16
  reg  wrStateMachineF_wrXState;  // ufix1
  reg [2:0] wrStateMachineF_curWrAddr_1;  // ufix3
  reg  wrStateMachineF_wrEnbReg_1;
  reg signed [15:0] wrStateMachineF_wrDataReg_re_1;  // sfix16
  reg signed [15:0] wrStateMachineF_wrDataReg_im_1;  // sfix16
  reg [4:0] wrStateMachineF_dinCnt;  // ufix5
  reg  wrStateMachineF_contigous;
  reg  wrStateMachineF_EOF;
  reg [5:0] wrStateMachineF_sampleCnt;  // ufix6
  reg [1:0] wrStateMachineF_wrState_next;  // ufix2
  reg [4:0] wrStateMachineF_curWrAddr_0_next;  // ufix5
  reg  wrStateMachineF_wrEnbReg_0_next;
  reg signed [15:0] wrStateMachineF_wrDataReg_re_0_next;  // sfix16
  reg signed [15:0] wrStateMachineF_wrDataReg_im_0_next;  // sfix16
  reg  wrStateMachineF_wrXState_next;  // ufix1
  reg [2:0] wrStateMachineF_curWrAddr_1_next;  // ufix3
  reg  wrStateMachineF_wrEnbReg_1_next;
  reg signed [15:0] wrStateMachineF_wrDataReg_re_1_next;  // sfix16
  reg signed [15:0] wrStateMachineF_wrDataReg_im_1_next;  // sfix16
  reg [4:0] wrStateMachineF_dinCnt_next;  // ufix5
  reg  wrStateMachineF_contigous_next;
  reg  wrStateMachineF_EOF_next;
  reg [5:0] wrStateMachineF_sampleCnt_next;  // ufix6
  reg signed [15:0] wrData_re_0;  // sfix16
  wire signed [15:0] x_re_0;  // sfix16
  wire signed [15:0] x_out;  // sfix16
  wire signed [15:0] u_out;  // sfix16
  reg signed [15:0] outputMuxF_dout_re_reg;  // sfix16
  reg signed [15:0] outputMuxF_dout_im_reg;  // sfix16
  reg [1:0] outputMuxF_state;  // ufix2
  reg  outputMuxF_doutVld_reg;
  reg signed [15:0] outputMuxF_y0_out_dly1;  // sfix16
  reg signed [15:0] outputMuxF_v0_out_dly1;  // sfix16
  reg signed [15:0] outputMuxF_y0_out_dly2;  // sfix16
  reg signed [15:0] outputMuxF_v0_out_dly2;  // sfix16
  reg signed [15:0] outputMuxF_y0_out_dly3;  // sfix16
  reg signed [15:0] outputMuxF_v0_out_dly3;  // sfix16
  reg  outputMuxF_dvld_0_reg1;
  reg  outputMuxF_dvld_0_reg2;
  reg  outputMuxF_dvld_0_reg3;
  reg  outputMuxF_EOF;
  reg signed [15:0] outputMuxF_dout_re_reg_next;  // sfix16
  reg signed [15:0] outputMuxF_dout_im_reg_next;  // sfix16
  reg [1:0] outputMuxF_state_next;  // ufix2
  reg  outputMuxF_doutVld_reg_next;
  reg signed [15:0] outputMuxF_y0_out_dly1_next;  // sfix16
  reg signed [15:0] outputMuxF_v0_out_dly1_next;  // sfix16
  reg signed [15:0] outputMuxF_y0_out_dly2_next;  // sfix16
  reg signed [15:0] outputMuxF_v0_out_dly2_next;  // sfix16
  reg signed [15:0] outputMuxF_y0_out_dly3_next;  // sfix16
  reg signed [15:0] outputMuxF_v0_out_dly3_next;  // sfix16
  reg  outputMuxF_dvld_0_reg1_next;
  reg  outputMuxF_dvld_0_reg2_next;
  reg  outputMuxF_dvld_0_reg3_next;
  reg  outputMuxF_EOF_next;
  reg signed [15:0] dout_re1_1;  // sfix16
  reg signed [15:0] dout_im1_1;  // sfix16
  reg  dout_vld1_1;


  assign CONST0 = 16'sb0000000000000000;



  dataXMEM_re_1_1_8x16b   u_dataXMEM_im_1_1   (.clk(clk),
                                               .enb(enb),
                                               .wr_din(wrData_im_1),  // sfix16
                                               .wr_addr(wrAddr_1),  // ufix3
                                               .wr_en(WrEnb_1),
                                               .rd_addr(rdAddr_1),  // ufix3
                                               .rd_dout(x_im_1)  // sfix16
                                               );

  dataXMEM_re_1_1_8x16b   u_dataXMEM_re_1_1_8x16b   (.clk(clk),
                                                     .enb(enb),
                                                     .wr_din(wrData_re_1),  // sfix16
                                                     .wr_addr(wrAddr_1),  // ufix3
                                                     .wr_en(WrEnb_1),
                                                     .rd_addr(rdAddr_1),  // ufix3
                                                     .rd_dout(x_re_1)  // sfix16
                                                     );

  dataMEM_re_0_1_32x16b   u_dataMEM_im_0_1   (.clk(clk),
                                              .enb(enb),
                                              .wr_din(wrData_im_0),  // sfix16
                                              .wr_addr(wrAddr_0),  // ufix5
                                              .wr_en(WrEnb_0),
                                              .rd_addr(rdAddr_0),  // ufix5
                                              .rd_dout(x_im_0)  // sfix16
                                              );

  // twdlXsample
  always @(posedge clk)
    begin : twdlXsample_process
      if (reset == 1'b1) begin
        in2_re <= 16'sb0000000000000000;
        in2_im <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          in2_re <= din_re;
          in2_im <= din_im;
        end
      end
    end



  // rdStateMachineF
  always @(posedge clk)
    begin : rdStateMachineF_process
      if (reset == 1'b1) begin
        rdStateMachineF_rdState <= 3'b000;
        rdStateMachineF_procState <= 1'b0;
        rdStateMachineF_curRdAddr_0 <= 5'b00000;
        rdStateMachineF_curRdAddr_1 <= 3'b000;
        rdStateMachineF_waitCnt <= 6'b000000;
        rdStateMachineF_waitCnt4Rd <= 5'b00000;
        rdStateMachineF_curRdEnb_0 <= 1'b0;
        rdStateMachineF_curRdEnb_1 <= 1'b0;
        rdStateMachineF_dVldOut2O_Reg0 <= 1'b0;
        rdStateMachineF_dVldOut_Reg1 <= 1'b0;
        rdStateMachineF_procEnbReg <= 1'b0;
        rdStateMachineF_xMemState <= 2'b00;
      end
      else begin
        if (enb) begin
          rdStateMachineF_rdState <= rdStateMachineF_rdState_next;
          rdStateMachineF_curRdAddr_0 <= rdStateMachineF_curRdAddr_0_next;
          rdStateMachineF_curRdAddr_1 <= rdStateMachineF_curRdAddr_1_next;
          rdStateMachineF_curRdEnb_0 <= rdStateMachineF_curRdEnb_0_next;
          rdStateMachineF_curRdEnb_1 <= rdStateMachineF_curRdEnb_1_next;
          rdStateMachineF_procEnbReg <= rdStateMachineF_procEnbReg_next;
          rdStateMachineF_dVldOut2O_Reg0 <= rdStateMachineF_dVldOut2O_Reg0_next;
          rdStateMachineF_dVldOut_Reg1 <= rdStateMachineF_dVldOut_Reg1_next;
          rdStateMachineF_xMemState <= rdStateMachineF_xMemState_next;
          rdStateMachineF_waitCnt <= rdStateMachineF_waitCnt_next;
          rdStateMachineF_waitCnt4Rd <= rdStateMachineF_waitCnt4Rd_next;
          rdStateMachineF_procState <= rdStateMachineF_procState_next;
        end
      end
    end

  always @(rdStateMachineF_rdState, rdStateMachineF_curRdAddr_0,
       rdStateMachineF_curRdAddr_1, rdStateMachineF_curRdEnb_0,
       rdStateMachineF_curRdEnb_1, rdStateMachineF_procEnbReg,
       rdStateMachineF_dVldOut2O_Reg0, rdStateMachineF_dVldOut_Reg1,
       rdStateMachineF_xMemState, rdStateMachineF_waitCnt,
       rdStateMachineF_waitCnt4Rd, rdStateMachineF_procState, validIn) begin
    rdStateMachineF_rdState_next = rdStateMachineF_rdState;
    rdStateMachineF_curRdAddr_0_next = rdStateMachineF_curRdAddr_0;
    rdStateMachineF_curRdAddr_1_next = rdStateMachineF_curRdAddr_1;
    rdStateMachineF_curRdEnb_0_next = rdStateMachineF_curRdEnb_0;
    rdStateMachineF_curRdEnb_1_next = rdStateMachineF_curRdEnb_1;
    rdStateMachineF_procEnbReg_next = rdStateMachineF_procEnbReg;
    rdStateMachineF_dVldOut2O_Reg0_next = rdStateMachineF_dVldOut2O_Reg0;
    rdStateMachineF_xMemState_next = rdStateMachineF_xMemState;
    rdStateMachineF_waitCnt_next = rdStateMachineF_waitCnt;
    rdStateMachineF_waitCnt4Rd_next = rdStateMachineF_waitCnt4Rd;
    rdStateMachineF_procState_next = rdStateMachineF_procState;
    case ( rdStateMachineF_procState)
      1'b0 :
        begin
          rdStateMachineF_procState_next = 1'b0;
          rdStateMachineF_procEnbReg_next = 1'b0;
          if ((rdStateMachineF_rdState == 3'b001) && rdStateMachineF_curRdEnb_0) begin
            if (validIn) begin
              rdStateMachineF_procEnbReg_next = 1'b1;
            end
            else begin
              rdStateMachineF_procState_next = 1'b1;
            end
          end
        end
      1'b1 :
        begin
          if (validIn) begin
            rdStateMachineF_procEnbReg_next = 1'b1;
            rdStateMachineF_procState_next = 1'b0;
          end
        end
      default :
        begin
          rdStateMachineF_procState_next = 1'b0;
          rdStateMachineF_procEnbReg_next = 1'b0;
        end
    endcase
    rdStateMachineF_dVldOut_Reg1_next = rdStateMachineF_curRdEnb_1;
    case ( rdStateMachineF_xMemState)
      2'b00 :
        begin
          rdStateMachineF_xMemState_next = 2'b00;
          rdStateMachineF_curRdAddr_1_next = 3'b000;
          rdStateMachineF_curRdEnb_1_next = 1'b0;
          rdStateMachineF_waitCnt_next = 6'b000000;
          if (rdStateMachineF_dVldOut2O_Reg0) begin
            rdStateMachineF_xMemState_next = 2'b01;
          end
        end
      2'b01 :
        begin
          if (rdStateMachineF_waitCnt == 6'b011100) begin
            rdStateMachineF_waitCnt_next = 6'b000000;
            rdStateMachineF_xMemState_next = 2'b10;
            rdStateMachineF_curRdEnb_1_next = 1'b1;
          end
          else begin
            rdStateMachineF_waitCnt_next = rdStateMachineF_waitCnt + 6'b000001;
          end
        end
      2'b10 :
        begin
          if (rdStateMachineF_curRdAddr_1 < 3'b011) begin
            rdStateMachineF_curRdAddr_1_next = rdStateMachineF_curRdAddr_1 + 3'b001;
            rdStateMachineF_curRdEnb_1_next = 1'b1;
          end
          else begin
            rdStateMachineF_curRdAddr_1_next = 3'b000;
            rdStateMachineF_curRdEnb_1_next = 1'b0;
            rdStateMachineF_xMemState_next = 2'b00;
          end
        end
      default :
        begin
          rdStateMachineF_xMemState_next = 2'b00;
          rdStateMachineF_curRdAddr_1_next = 3'b000;
          rdStateMachineF_curRdEnb_1_next = 1'b0;
          rdStateMachineF_waitCnt_next = 6'b000000;
        end
    endcase
    case ( rdStateMachineF_rdState)
      3'b000 :
        begin
          rdStateMachineF_curRdEnb_0_next = 1'b0;
          rdStateMachineF_dVldOut2O_Reg0_next = 1'b0;
          if (validIn) begin
            if (rdStateMachineF_waitCnt4Rd < 5'b11111) begin
              rdStateMachineF_rdState_next = 3'b000;
              rdStateMachineF_waitCnt4Rd_next = rdStateMachineF_waitCnt4Rd + 5'b00001;
              rdStateMachineF_curRdEnb_0_next = 1'b0;
            end
            else begin
              rdStateMachineF_rdState_next = 3'b001;
              rdStateMachineF_waitCnt4Rd_next = 5'b00000;
              rdStateMachineF_curRdEnb_0_next = 1'b1;
            end
          end
        end
      3'b001 :
        begin
          rdStateMachineF_dVldOut2O_Reg0_next = 1'b0;
          if (validIn) begin
            if (rdStateMachineF_curRdAddr_0 < 5'b11111) begin
              rdStateMachineF_curRdAddr_0_next = rdStateMachineF_curRdAddr_0 + 5'b00001;
              rdStateMachineF_curRdEnb_0_next = 1'b1;
              rdStateMachineF_rdState_next = 3'b001;
            end
            else begin
              rdStateMachineF_curRdEnb_0_next = 1'b1;
              rdStateMachineF_dVldOut2O_Reg0_next = 1'b0;
              rdStateMachineF_curRdAddr_0_next = 5'b00000;
              rdStateMachineF_rdState_next = 3'b010;
            end
          end
          else if (rdStateMachineF_curRdAddr_0 < 5'b11111) begin
            rdStateMachineF_curRdEnb_0_next = 1'b0;
            rdStateMachineF_rdState_next = 3'b001;
          end
          else begin
            rdStateMachineF_rdState_next = 3'b001;
          end
        end
      3'b010 :
        begin
          rdStateMachineF_dVldOut2O_Reg0_next = 1'b1;
          if ((rdStateMachineF_curRdAddr_0 < 5'b11011) || (rdStateMachineF_curRdAddr_0 == 5'b11111)) begin
            rdStateMachineF_curRdAddr_0_next = rdStateMachineF_curRdAddr_0 + 5'b00001;
            rdStateMachineF_curRdEnb_0_next = 1'b1;
          end
          else begin
            rdStateMachineF_curRdEnb_0_next = 1'b0;
            rdStateMachineF_rdState_next = 3'b011;
          end
          if (validIn) begin
            rdStateMachineF_waitCnt4Rd_next = rdStateMachineF_waitCnt4Rd + 5'b00001;
          end
        end
      3'b011 :
        begin
          rdStateMachineF_curRdEnb_0_next = 1'b0;
          rdStateMachineF_dVldOut2O_Reg0_next = 1'b0;
          if (validIn) begin
            if (rdStateMachineF_waitCnt4Rd < 5'b11111) begin
              rdStateMachineF_waitCnt4Rd_next = rdStateMachineF_waitCnt4Rd + 5'b00001;
            end
            else begin
              rdStateMachineF_waitCnt4Rd_next = 5'b00000;
              rdStateMachineF_curRdAddr_0_next = 5'b00000;
              rdStateMachineF_rdState_next = 3'b001;
              rdStateMachineF_curRdEnb_0_next = 1'b1;
            end
          end
          else begin
            rdStateMachineF_curRdEnb_0_next = 1'b0;
          end
        end
      default :
        begin
          rdStateMachineF_rdState_next = 3'b000;
          rdStateMachineF_curRdAddr_0_next = 5'b00000;
          rdStateMachineF_curRdEnb_0_next = 1'b0;
          rdStateMachineF_dVldOut2O_Reg0_next = 1'b0;
        end
    endcase
    rdAddr_0 = rdStateMachineF_curRdAddr_0;
    rdAddr_1 = rdStateMachineF_curRdAddr_1;
    dOutVld2O = rdStateMachineF_dVldOut2O_Reg0;
    dOutVld_1 = rdStateMachineF_dVldOut_Reg1;
    procEnb = rdStateMachineF_procEnbReg;
  end



  // wrStateMachineF
  always @(posedge clk)
    begin : wrStateMachineF_process
      if (reset == 1'b1) begin
        wrStateMachineF_wrState <= 2'b00;
        wrStateMachineF_wrXState <= 1'b0;
        wrStateMachineF_wrEnbReg_0 <= 1'b0;
        wrStateMachineF_wrEnbReg_1 <= 1'b0;
        wrStateMachineF_wrDataReg_re_0 <= 16'sb0000000000000000;
        wrStateMachineF_wrDataReg_im_0 <= 16'sb0000000000000000;
        wrStateMachineF_wrDataReg_re_1 <= 16'sb0000000000000000;
        wrStateMachineF_wrDataReg_im_1 <= 16'sb0000000000000000;
        wrStateMachineF_curWrAddr_0 <= 5'b00000;
        wrStateMachineF_curWrAddr_1 <= 3'b000;
        wrStateMachineF_dinCnt <= 5'b00000;
        wrStateMachineF_contigous <= 1'b1;
        wrStateMachineF_EOF <= 1'b0;
        wrStateMachineF_sampleCnt <= 6'b000000;
      end
      else begin
        if (enb) begin
          wrStateMachineF_wrState <= wrStateMachineF_wrState_next;
          wrStateMachineF_curWrAddr_0 <= wrStateMachineF_curWrAddr_0_next;
          wrStateMachineF_wrEnbReg_0 <= wrStateMachineF_wrEnbReg_0_next;
          wrStateMachineF_wrDataReg_re_0 <= wrStateMachineF_wrDataReg_re_0_next;
          wrStateMachineF_wrDataReg_im_0 <= wrStateMachineF_wrDataReg_im_0_next;
          wrStateMachineF_wrXState <= wrStateMachineF_wrXState_next;
          wrStateMachineF_curWrAddr_1 <= wrStateMachineF_curWrAddr_1_next;
          wrStateMachineF_wrEnbReg_1 <= wrStateMachineF_wrEnbReg_1_next;
          wrStateMachineF_wrDataReg_re_1 <= wrStateMachineF_wrDataReg_re_1_next;
          wrStateMachineF_wrDataReg_im_1 <= wrStateMachineF_wrDataReg_im_1_next;
          wrStateMachineF_dinCnt <= wrStateMachineF_dinCnt_next;
          wrStateMachineF_contigous <= wrStateMachineF_contigous_next;
          wrStateMachineF_EOF <= wrStateMachineF_EOF_next;
          wrStateMachineF_sampleCnt <= wrStateMachineF_sampleCnt_next;
        end
      end
    end

  always @(wrStateMachineF_wrState, wrStateMachineF_curWrAddr_0,
       wrStateMachineF_wrEnbReg_0, wrStateMachineF_wrDataReg_re_0,
       wrStateMachineF_wrDataReg_im_0, wrStateMachineF_wrXState,
       wrStateMachineF_curWrAddr_1, wrStateMachineF_wrEnbReg_1,
       wrStateMachineF_wrDataReg_re_1, wrStateMachineF_wrDataReg_im_1,
       wrStateMachineF_dinCnt, wrStateMachineF_contigous, wrStateMachineF_EOF,
       wrStateMachineF_sampleCnt, din_re, din_im, validIn, y_out, v_out,
       doutVld) begin
    wrStateMachineF_wrState_next = wrStateMachineF_wrState;
    wrStateMachineF_curWrAddr_0_next = wrStateMachineF_curWrAddr_0;
    wrStateMachineF_wrEnbReg_0_next = wrStateMachineF_wrEnbReg_0;
    wrStateMachineF_wrDataReg_re_0_next = wrStateMachineF_wrDataReg_re_0;
    wrStateMachineF_wrDataReg_im_0_next = wrStateMachineF_wrDataReg_im_0;
    wrStateMachineF_wrXState_next = wrStateMachineF_wrXState;
    wrStateMachineF_curWrAddr_1_next = wrStateMachineF_curWrAddr_1;
    wrStateMachineF_wrEnbReg_1_next = wrStateMachineF_wrEnbReg_1;
    wrStateMachineF_wrDataReg_re_1_next = wrStateMachineF_wrDataReg_re_1;
    wrStateMachineF_wrDataReg_im_1_next = wrStateMachineF_wrDataReg_im_1;
    wrStateMachineF_dinCnt_next = wrStateMachineF_dinCnt;
    wrStateMachineF_contigous_next = wrStateMachineF_contigous;
    wrStateMachineF_sampleCnt_next = wrStateMachineF_sampleCnt;
    case ( wrStateMachineF_wrXState)
      1'b0 :
        begin
          wrStateMachineF_wrDataReg_re_1_next = y_out;
          wrStateMachineF_wrDataReg_im_1_next = v_out;
          wrStateMachineF_curWrAddr_1_next = 3'b000;
          wrStateMachineF_wrEnbReg_1_next = 1'b0;
          wrStateMachineF_wrXState_next = 1'b0;
          if (((wrStateMachineF_wrState == 2'b10) && (wrStateMachineF_curWrAddr_0 == 5'b11011)) && doutVld) begin
            wrStateMachineF_wrEnbReg_1_next = 1'b1;
            wrStateMachineF_wrXState_next = 1'b1;
          end
        end
      1'b1 :
        begin
          wrStateMachineF_wrDataReg_re_1_next = y_out;
          wrStateMachineF_wrDataReg_im_1_next = v_out;
          wrStateMachineF_wrXState_next = 1'b1;
          if (wrStateMachineF_curWrAddr_1 < 3'b011) begin
            if (doutVld) begin
              wrStateMachineF_wrEnbReg_1_next = 1'b1;
              wrStateMachineF_curWrAddr_1_next = wrStateMachineF_curWrAddr_1 + 3'b001;
            end
            else begin
              wrStateMachineF_wrEnbReg_1_next = 1'b0;
            end
          end
          else begin
            wrStateMachineF_wrXState_next = 1'b0;
            wrStateMachineF_curWrAddr_1_next = 3'b000;
            wrStateMachineF_wrEnbReg_1_next = 1'b0;
          end
        end
      default :
        begin
          wrStateMachineF_wrDataReg_re_1_next = y_out;
          wrStateMachineF_wrDataReg_im_1_next = v_out;
          wrStateMachineF_curWrAddr_1_next = 3'b000;
          wrStateMachineF_wrEnbReg_1_next = 1'b0;
          wrStateMachineF_wrXState_next = 1'b0;
        end
    endcase
    case ( wrStateMachineF_wrState)
      2'b00 :
        begin
          wrStateMachineF_wrState_next = 2'b00;
          wrStateMachineF_curWrAddr_0_next = 5'b00000;
          wrStateMachineF_wrEnbReg_0_next = 1'b0;
          wrStateMachineF_dinCnt_next = 5'b00000;
          if (validIn) begin
            wrStateMachineF_wrState_next = 2'b01;
            wrStateMachineF_wrEnbReg_0_next = 1'b1;
            wrStateMachineF_wrDataReg_re_0_next = din_re;
            wrStateMachineF_wrDataReg_im_0_next = din_im;
            wrStateMachineF_curWrAddr_0_next = 5'b00000;
          end
        end
      2'b01 :
        begin
          wrStateMachineF_wrEnbReg_0_next = 1'b0;
          wrStateMachineF_dinCnt_next = 5'b00000;
          if (validIn) begin
            wrStateMachineF_wrEnbReg_0_next = 1'b1;
            wrStateMachineF_wrDataReg_re_0_next = din_re;
            wrStateMachineF_wrDataReg_im_0_next = din_im;
            if (wrStateMachineF_curWrAddr_0 < 5'b11111) begin
              wrStateMachineF_curWrAddr_0_next = wrStateMachineF_curWrAddr_0 + 5'b00001;
            end
            else begin
              wrStateMachineF_wrEnbReg_0_next = 1'b0;
              wrStateMachineF_wrState_next = 2'b10;
              wrStateMachineF_curWrAddr_0_next = 5'b11111;
              wrStateMachineF_dinCnt_next = 5'b00000;
            end
          end
          else begin
            if (wrStateMachineF_curWrAddr_0 == 5'b11111) begin
              wrStateMachineF_wrEnbReg_0_next = 1'b0;
              wrStateMachineF_wrState_next = 2'b10;
              wrStateMachineF_curWrAddr_0_next = 5'b11111;
              wrStateMachineF_dinCnt_next = 5'b11111;
            end
            wrStateMachineF_contigous_next = 1'b0;
          end
        end
      2'b10 :
        begin
          wrStateMachineF_wrEnbReg_0_next = 1'b0;
          wrStateMachineF_wrState_next = 2'b10;
          if ((wrStateMachineF_curWrAddr_0 < 5'b11011) || (wrStateMachineF_curWrAddr_0 == 5'b11111)) begin
            if (doutVld) begin
              wrStateMachineF_curWrAddr_0_next = wrStateMachineF_curWrAddr_0 + 5'b00001;
              wrStateMachineF_wrEnbReg_0_next = 1'b1;
              wrStateMachineF_wrDataReg_re_0_next = y_out;
              wrStateMachineF_wrDataReg_im_0_next = v_out;
            end
          end
          else if (wrStateMachineF_dinCnt == 5'b11111) begin
            if (wrStateMachineF_contigous) begin
              if (validIn) begin
                wrStateMachineF_wrState_next = 2'b01;
                wrStateMachineF_wrEnbReg_0_next = 1'b1;
              end
              else begin
                wrStateMachineF_wrState_next = 2'b00;
                wrStateMachineF_wrEnbReg_0_next = 1'b0;
              end
              wrStateMachineF_wrDataReg_re_0_next = din_re;
              wrStateMachineF_wrDataReg_im_0_next = din_im;
              wrStateMachineF_curWrAddr_0_next = 5'b00000;
            end
            else begin
              wrStateMachineF_wrDataReg_re_0_next = din_re;
              wrStateMachineF_wrDataReg_im_0_next = din_im;
              if (wrStateMachineF_EOF) begin
                wrStateMachineF_curWrAddr_0_next = 5'b00000;
                if (validIn) begin
                  wrStateMachineF_wrState_next = 2'b01;
                  wrStateMachineF_wrEnbReg_0_next = 1'b1;
                end
                else begin
                  wrStateMachineF_wrState_next = 2'b00;
                  wrStateMachineF_wrEnbReg_0_next = 1'b0;
                end
              end
              else begin
                wrStateMachineF_curWrAddr_0_next = 5'b00000;
                wrStateMachineF_wrState_next = 2'b01;
                wrStateMachineF_wrEnbReg_0_next = 1'b1;
              end
            end
          end
          if (validIn) begin
            wrStateMachineF_dinCnt_next = wrStateMachineF_dinCnt + 5'b00001;
          end
          else begin
            wrStateMachineF_contigous_next = 1'b0;
          end
        end
      default :
        begin
          wrStateMachineF_wrState_next = 2'b00;
          wrStateMachineF_wrEnbReg_0_next = 1'b0;
          wrStateMachineF_wrDataReg_re_0_next = 16'sb0000000000000000;
          wrStateMachineF_wrDataReg_im_0_next = 16'sb0000000000000000;
          wrStateMachineF_curWrAddr_0_next = 5'b00000;
          wrStateMachineF_dinCnt_next = 5'b00000;
          wrStateMachineF_contigous_next = 1'b1;
        end
    endcase
    wrStateMachineF_EOF_next = 1'b0;
    if (validIn && (wrStateMachineF_sampleCnt == 6'b111111)) begin
      wrStateMachineF_EOF_next = 1'b1;
    end
    if (validIn) begin
      wrStateMachineF_sampleCnt_next = wrStateMachineF_sampleCnt + 6'b000001;
    end
    wrData_re_0 = wrStateMachineF_wrDataReg_re_0;
    wrData_im_0 = wrStateMachineF_wrDataReg_im_0;
    WrEnb_0 = wrStateMachineF_wrEnbReg_0;
    wrAddr_0 = wrStateMachineF_curWrAddr_0;
    wrData_re_1 = wrStateMachineF_wrDataReg_re_1;
    wrData_im_1 = wrStateMachineF_wrDataReg_im_1;
    WrEnb_1 = wrStateMachineF_wrEnbReg_1;
    wrAddr_1 = wrStateMachineF_curWrAddr_1;
  end



  dataMEM_re_0_1_32x16b   u_dataMEM_re_0_1_32x16b   (.clk(clk),
                                                     .enb(enb),
                                                     .wr_din(wrData_re_0),  // sfix16
                                                     .wr_addr(wrAddr_0),  // ufix5
                                                     .wr_en(WrEnb_0),
                                                     .rd_addr(rdAddr_0),  // ufix5
                                                     .rd_dout(x_re_0)  // sfix16
                                                     );

  Radix2ButterlyF   u_ButterflyF   (.clk(clk),
                                    .reset(reset),
                                    .enb(enb),
                                    .x_re_0(x_re_0),  // sfix16
                                    .in2_re(in2_re),  // sfix16
                                    .x_im_0(x_im_0),  // sfix16
                                    .in2_im(in2_im),  // sfix16
                                    .procEnb(procEnb),
                                    .softReset(softReset),
                                    .x_out(x_out),  // sfix16
                                    .u_out(u_out),  // sfix16
                                    .y_out(y_out),  // sfix16
                                    .v_out(v_out),  // sfix16
                                    .doutVld(doutVld)
                                    );

  // outputMuxF
  always @(posedge clk)
    begin : outputMuxF_process
      if (reset == 1'b1) begin
        outputMuxF_dout_re_reg <= 16'sb0000000000000000;
        outputMuxF_dout_im_reg <= 16'sb0000000000000000;
        outputMuxF_y0_out_dly1 <= 16'sb0000000000000000;
        outputMuxF_v0_out_dly1 <= 16'sb0000000000000000;
        outputMuxF_y0_out_dly2 <= 16'sb0000000000000000;
        outputMuxF_v0_out_dly2 <= 16'sb0000000000000000;
        outputMuxF_y0_out_dly3 <= 16'sb0000000000000000;
        outputMuxF_v0_out_dly3 <= 16'sb0000000000000000;
        outputMuxF_dvld_0_reg1 <= 1'b0;
        outputMuxF_dvld_0_reg2 <= 1'b0;
        outputMuxF_dvld_0_reg3 <= 1'b0;
        outputMuxF_doutVld_reg <= 1'b0;
        outputMuxF_state <= 2'b00;
        outputMuxF_EOF <= 1'b0;
      end
      else begin
        if (enb) begin
          outputMuxF_dout_re_reg <= outputMuxF_dout_re_reg_next;
          outputMuxF_dout_im_reg <= outputMuxF_dout_im_reg_next;
          outputMuxF_state <= outputMuxF_state_next;
          outputMuxF_doutVld_reg <= outputMuxF_doutVld_reg_next;
          outputMuxF_y0_out_dly1 <= outputMuxF_y0_out_dly1_next;
          outputMuxF_v0_out_dly1 <= outputMuxF_v0_out_dly1_next;
          outputMuxF_y0_out_dly2 <= outputMuxF_y0_out_dly2_next;
          outputMuxF_v0_out_dly2 <= outputMuxF_v0_out_dly2_next;
          outputMuxF_y0_out_dly3 <= outputMuxF_y0_out_dly3_next;
          outputMuxF_v0_out_dly3 <= outputMuxF_v0_out_dly3_next;
          outputMuxF_dvld_0_reg1 <= outputMuxF_dvld_0_reg1_next;
          outputMuxF_dvld_0_reg2 <= outputMuxF_dvld_0_reg2_next;
          outputMuxF_dvld_0_reg3 <= outputMuxF_dvld_0_reg3_next;
          outputMuxF_EOF <= outputMuxF_EOF_next;
        end
      end
    end

  always @(outputMuxF_dout_re_reg, outputMuxF_dout_im_reg, outputMuxF_state,
       outputMuxF_doutVld_reg, outputMuxF_y0_out_dly1, outputMuxF_v0_out_dly1,
       outputMuxF_y0_out_dly2, outputMuxF_v0_out_dly2, outputMuxF_y0_out_dly3,
       outputMuxF_v0_out_dly3, outputMuxF_dvld_0_reg1, outputMuxF_dvld_0_reg2,
       outputMuxF_dvld_0_reg3, outputMuxF_EOF, doutVld, x_out, u_out, dOutVld2O,
       x_re_0, x_im_0, dOutVld_1, x_re_1, x_im_1) begin
    outputMuxF_dout_re_reg_next = outputMuxF_dout_re_reg;
    outputMuxF_dout_im_reg_next = outputMuxF_dout_im_reg;
    outputMuxF_state_next = outputMuxF_state;
    outputMuxF_doutVld_reg_next = outputMuxF_doutVld_reg;
    outputMuxF_EOF_next = outputMuxF_EOF;
    case ( outputMuxF_state)
      2'b00 :
        begin
          outputMuxF_EOF_next = 1'b0;
          if (doutVld) begin
            outputMuxF_state_next = 2'b01;
            outputMuxF_dout_re_reg_next = x_out;
            outputMuxF_dout_im_reg_next = u_out;
            outputMuxF_doutVld_reg_next = 1'b1;
          end
          else begin
            outputMuxF_state_next = 2'b00;
            outputMuxF_doutVld_reg_next = 1'b0;
            outputMuxF_dout_re_reg_next = 16'sb0000000000000000;
            outputMuxF_dout_im_reg_next = 16'sb0000000000000000;
          end
        end
      2'b01 :
        begin
          if (doutVld) begin
            outputMuxF_state_next = 2'b01;
            outputMuxF_dout_re_reg_next = x_out;
            outputMuxF_dout_im_reg_next = u_out;
            outputMuxF_doutVld_reg_next = 1'b1;
          end
          else if (outputMuxF_dvld_0_reg3) begin
            outputMuxF_state_next = 2'b10;
            outputMuxF_dout_re_reg_next = outputMuxF_y0_out_dly3;
            outputMuxF_dout_im_reg_next = outputMuxF_v0_out_dly3;
            outputMuxF_doutVld_reg_next = outputMuxF_dvld_0_reg3;
          end
          else begin
            outputMuxF_state_next = 2'b01;
            outputMuxF_dout_re_reg_next = x_out;
            outputMuxF_dout_im_reg_next = u_out;
            outputMuxF_doutVld_reg_next = 1'b0;
          end
        end
      2'b10 :
        begin
          if (outputMuxF_dvld_0_reg3) begin
            outputMuxF_state_next = 2'b10;
            outputMuxF_dout_re_reg_next = outputMuxF_y0_out_dly3;
            outputMuxF_dout_im_reg_next = outputMuxF_v0_out_dly3;
            outputMuxF_doutVld_reg_next = outputMuxF_dvld_0_reg3;
          end
          else if (dOutVld_1) begin
            outputMuxF_state_next = 2'b11;
            outputMuxF_dout_re_reg_next = x_re_1;
            outputMuxF_dout_im_reg_next = x_im_1;
            outputMuxF_doutVld_reg_next = 1'b1;
          end
          else begin
            outputMuxF_state_next = 2'b10;
            outputMuxF_dout_re_reg_next = outputMuxF_y0_out_dly3;
            outputMuxF_dout_im_reg_next = outputMuxF_v0_out_dly3;
            outputMuxF_doutVld_reg_next = 1'b0;
          end
        end
      2'b11 :
        begin
          if (dOutVld_1) begin
            outputMuxF_state_next = 2'b11;
            outputMuxF_dout_re_reg_next = x_re_1;
            outputMuxF_dout_im_reg_next = x_im_1;
            outputMuxF_doutVld_reg_next = 1'b1;
          end
          else if (doutVld) begin
            outputMuxF_state_next = 2'b01;
            outputMuxF_dout_re_reg_next = x_out;
            outputMuxF_dout_im_reg_next = u_out;
            outputMuxF_doutVld_reg_next = 1'b1;
          end
          else begin
            outputMuxF_state_next = 2'b00;
            outputMuxF_dout_re_reg_next = 16'sb0000000000000000;
            outputMuxF_dout_im_reg_next = 16'sb0000000000000000;
            outputMuxF_doutVld_reg_next = 1'b0;
            outputMuxF_EOF_next = 1'b1;
          end
        end
      default :
        begin
          outputMuxF_state_next = 2'b00;
          outputMuxF_EOF_next = 1'b0;
          outputMuxF_doutVld_reg_next = 1'b0;
          outputMuxF_dout_re_reg_next = 16'sb0000000000000000;
          outputMuxF_dout_im_reg_next = 16'sb0000000000000000;
        end
    endcase
    outputMuxF_y0_out_dly3_next = outputMuxF_y0_out_dly2;
    outputMuxF_v0_out_dly3_next = outputMuxF_v0_out_dly2;
    outputMuxF_y0_out_dly2_next = outputMuxF_y0_out_dly1;
    outputMuxF_v0_out_dly2_next = outputMuxF_v0_out_dly1;
    outputMuxF_y0_out_dly1_next = x_re_0;
    outputMuxF_v0_out_dly1_next = x_im_0;
    outputMuxF_dvld_0_reg3_next = outputMuxF_dvld_0_reg2;
    outputMuxF_dvld_0_reg2_next = outputMuxF_dvld_0_reg1;
    outputMuxF_dvld_0_reg1_next = dOutVld2O;
    dout_re1_1 = outputMuxF_dout_re_reg;
    dout_im1_1 = outputMuxF_dout_im_reg;
    dout_vld1_1 = outputMuxF_doutVld_reg;
    txEOF = outputMuxF_EOF;
  end



  assign dout_re1 = dout_re1_1;

  assign dout_im1 = dout_im1_1;

  assign dout_vld1 = dout_vld1_1;

endmodule  // RADIX2FFT_KernelF_1

