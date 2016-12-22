// -------------------------------------------------------------
// 
// File Name: hdlsrc\fft_st\RADIX2FFT_bitNatural.v
// Created: 2014-11-25 15:16:15
// 
// Generated by MATLAB 8.5 and HDL Coder 3.6
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: RADIX2FFT_bitNatural
// Source Path: fft_st/fft_st/FFT HDL Optimized/RADIX2FFT_bitNatural
// Hierarchy Level: 2
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module RADIX2FFT_bitNatural
          (
           clk,
           reset,
           enb,
           dout_re6,
           dout_im6,
           dout_vld6,
           softReset,
           dout_re7,
           dout_im7,
           dout_vld7
          );


  input   clk;
  input   reset;
  input   enb;
  input   signed [15:0] dout_re6;  // sfix16
  input   signed [15:0] dout_im6;  // sfix16
  input   dout_vld6;
  input   softReset;
  output  signed [15:0] dout_re7;  // sfix16
  output  signed [15:0] dout_im7;  // sfix16
  output  dout_vld7;


  reg [1:0] wrStateMachineBitNatural_wrState;  // ufix2
  reg [5:0] wrStateMachineBitNatural_wrAddrCnt;  // ufix6
  reg [1:0] wrStateMachineBitNatural_wrState_next;  // ufix2
  reg [5:0] wrStateMachineBitNatural_wrAddrCnt_next;  // ufix6
  reg  WrEnb;
  reg [5:0] wrAddr;  // ufix6
  reg [5:0] sampleIdx;  // ufix6
  reg [5:0] rdAddr;  // ufix6
  wire signed [15:0] memOut_im;  // sfix16
  wire signed [15:0] memOut_re;  // sfix16
  reg [1:0] rdStateMachineBitNatural_rdState;  // ufix2
  reg [5:0] rdStateMachineBitNatural_rdAddrCnt;  // ufix6
  reg  rdStateMachineBitNatural_doutVldReg1;
  reg  rdStateMachineBitNatural_doutVldReg2;
  reg signed [15:0] rdStateMachineBitNatural_doutReReg;  // sfix16
  reg signed [15:0] rdStateMachineBitNatural_doutImReg;  // sfix16
  reg [1:0] rdStateMachineBitNatural_rdState_next;  // ufix2
  reg [5:0] rdStateMachineBitNatural_rdAddrCnt_next;  // ufix6
  reg  rdStateMachineBitNatural_doutVldReg1_next;
  reg  rdStateMachineBitNatural_doutVldReg2_next;
  reg signed [15:0] rdStateMachineBitNatural_doutReReg_next;  // sfix16
  reg signed [15:0] rdStateMachineBitNatural_doutImReg_next;  // sfix16
  reg signed [15:0] dout_re7_1;  // sfix16
  reg signed [15:0] dout_im7_1;  // sfix16
  reg  dout_vld7_1;


  // wrStateMachineBitNatural
  always @(posedge clk)
    begin : wrStateMachineBitNatural_process
      if (reset == 1'b1) begin
        wrStateMachineBitNatural_wrState <= 2'b00;
        wrStateMachineBitNatural_wrAddrCnt <= 6'b000000;
      end
      else begin
        if (enb) begin
          wrStateMachineBitNatural_wrState <= wrStateMachineBitNatural_wrState_next;
          wrStateMachineBitNatural_wrAddrCnt <= wrStateMachineBitNatural_wrAddrCnt_next;
        end
      end
    end

  always @(wrStateMachineBitNatural_wrState, wrStateMachineBitNatural_wrAddrCnt,
       dout_vld6) begin
    wrStateMachineBitNatural_wrState_next = wrStateMachineBitNatural_wrState;
    wrStateMachineBitNatural_wrAddrCnt_next = wrStateMachineBitNatural_wrAddrCnt;
    if (wrStateMachineBitNatural_wrState == 2'b10) begin
      wrAddr = {wrStateMachineBitNatural_wrAddrCnt[0], wrStateMachineBitNatural_wrAddrCnt[1], wrStateMachineBitNatural_wrAddrCnt[2], wrStateMachineBitNatural_wrAddrCnt[3], wrStateMachineBitNatural_wrAddrCnt[4], wrStateMachineBitNatural_wrAddrCnt[5]};
    end
    else begin
      wrAddr = wrStateMachineBitNatural_wrAddrCnt;
    end
    case ( wrStateMachineBitNatural_wrState)
      2'b00 :
        begin
          if (dout_vld6) begin
            wrStateMachineBitNatural_wrState_next = 2'b01;
            wrStateMachineBitNatural_wrAddrCnt_next = 6'b000001;
          end
          else begin
            wrStateMachineBitNatural_wrState_next = 2'b00;
            wrStateMachineBitNatural_wrAddrCnt_next = 6'b000000;
          end
        end
      2'b01 :
        begin
          if (dout_vld6) begin
            if (wrStateMachineBitNatural_wrAddrCnt == 6'b111111) begin
              wrStateMachineBitNatural_wrAddrCnt_next = 6'b000000;
              wrStateMachineBitNatural_wrState_next = 2'b10;
            end
            else begin
              wrStateMachineBitNatural_wrAddrCnt_next = wrStateMachineBitNatural_wrAddrCnt + 6'b000001;
              wrStateMachineBitNatural_wrState_next = 2'b01;
            end
          end
        end
      2'b10 :
        begin
          if (dout_vld6) begin
            if (wrStateMachineBitNatural_wrAddrCnt == 6'b111111) begin
              wrStateMachineBitNatural_wrAddrCnt_next = 6'b000000;
              wrStateMachineBitNatural_wrState_next = 2'b01;
            end
            else begin
              wrStateMachineBitNatural_wrAddrCnt_next = wrStateMachineBitNatural_wrAddrCnt + 6'b000001;
              wrStateMachineBitNatural_wrState_next = 2'b10;
            end
          end
        end
      default :
        begin
          wrStateMachineBitNatural_wrState_next = 2'b00;
          wrStateMachineBitNatural_wrAddrCnt_next = 6'b000000;
        end
    endcase
    WrEnb = dout_vld6;
    sampleIdx = wrStateMachineBitNatural_wrAddrCnt;
  end



  dataMEM_re_1_64x16b   u_dataMEM_im_1   (.clk(clk),
                                          .enb(enb),
                                          .wr_din(dout_im6),  // sfix16
                                          .wr_addr(wrAddr),  // ufix6
                                          .wr_en(WrEnb),
                                          .rd_addr(rdAddr),  // ufix6
                                          .rd_dout(memOut_im)  // sfix16
                                          );

  dataMEM_re_1_64x16b   u_dataMEM_re_1_64x16b   (.clk(clk),
                                                 .enb(enb),
                                                 .wr_din(dout_re6),  // sfix16
                                                 .wr_addr(wrAddr),  // ufix6
                                                 .wr_en(WrEnb),
                                                 .rd_addr(rdAddr),  // ufix6
                                                 .rd_dout(memOut_re)  // sfix16
                                                 );

  // rdStateMachineBitNatural
  always @(posedge clk)
    begin : rdStateMachineBitNatural_process
      if (reset == 1'b1) begin
        rdStateMachineBitNatural_rdState <= 2'b00;
        rdStateMachineBitNatural_rdAddrCnt <= 6'b000000;
        rdStateMachineBitNatural_doutVldReg1 <= 1'b0;
        rdStateMachineBitNatural_doutVldReg2 <= 1'b0;
        rdStateMachineBitNatural_doutReReg <= 16'sb0000000000000000;
        rdStateMachineBitNatural_doutImReg <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          rdStateMachineBitNatural_rdState <= rdStateMachineBitNatural_rdState_next;
          rdStateMachineBitNatural_rdAddrCnt <= rdStateMachineBitNatural_rdAddrCnt_next;
          rdStateMachineBitNatural_doutVldReg1 <= rdStateMachineBitNatural_doutVldReg1_next;
          rdStateMachineBitNatural_doutVldReg2 <= rdStateMachineBitNatural_doutVldReg2_next;
          rdStateMachineBitNatural_doutReReg <= rdStateMachineBitNatural_doutReReg_next;
          rdStateMachineBitNatural_doutImReg <= rdStateMachineBitNatural_doutImReg_next;
        end
      end
    end

  always @(rdStateMachineBitNatural_rdState, rdStateMachineBitNatural_rdAddrCnt,
       rdStateMachineBitNatural_doutVldReg1,
       rdStateMachineBitNatural_doutVldReg2, rdStateMachineBitNatural_doutReReg,
       rdStateMachineBitNatural_doutImReg, sampleIdx, memOut_re, memOut_im) begin
    rdStateMachineBitNatural_rdState_next = rdStateMachineBitNatural_rdState;
    rdStateMachineBitNatural_rdAddrCnt_next = rdStateMachineBitNatural_rdAddrCnt;
    rdStateMachineBitNatural_doutReReg_next = rdStateMachineBitNatural_doutReReg;
    rdStateMachineBitNatural_doutImReg_next = rdStateMachineBitNatural_doutImReg;
    if (rdStateMachineBitNatural_rdState == 2'b01) begin
      rdAddr = {rdStateMachineBitNatural_rdAddrCnt[0], rdStateMachineBitNatural_rdAddrCnt[1], rdStateMachineBitNatural_rdAddrCnt[2], rdStateMachineBitNatural_rdAddrCnt[3], rdStateMachineBitNatural_rdAddrCnt[4], rdStateMachineBitNatural_rdAddrCnt[5]};
    end
    else begin
      rdAddr = rdStateMachineBitNatural_rdAddrCnt;
    end
    case ( rdStateMachineBitNatural_rdState)
      2'b00 :
        begin
          rdStateMachineBitNatural_doutVldReg1_next = 1'b0;
          if (sampleIdx >= 6'b110101) begin
            rdStateMachineBitNatural_rdAddrCnt_next = 6'b000001;
            rdStateMachineBitNatural_doutVldReg1_next = 1'b1;
            rdStateMachineBitNatural_rdState_next = 2'b01;
          end
          else begin
            rdStateMachineBitNatural_rdAddrCnt_next = 6'b000000;
            rdStateMachineBitNatural_rdState_next = 2'b00;
          end
        end
      2'b01 :
        begin
          rdStateMachineBitNatural_doutVldReg1_next = 1'b1;
          if (rdStateMachineBitNatural_rdAddrCnt == 6'b111111) begin
            rdStateMachineBitNatural_rdAddrCnt_next = 6'b000000;
            rdStateMachineBitNatural_rdState_next = 2'b10;
          end
          else begin
            rdStateMachineBitNatural_rdAddrCnt_next = rdStateMachineBitNatural_rdAddrCnt + 6'b000001;
            rdStateMachineBitNatural_rdState_next = 2'b01;
          end
        end
      2'b10 :
        begin
          rdStateMachineBitNatural_doutVldReg1_next = 1'b0;
          if (sampleIdx >= 6'b110101) begin
            rdStateMachineBitNatural_rdAddrCnt_next = 6'b000001;
            rdStateMachineBitNatural_doutVldReg1_next = 1'b1;
            rdStateMachineBitNatural_rdState_next = 2'b11;
          end
          else begin
            rdStateMachineBitNatural_rdAddrCnt_next = 6'b000000;
            rdStateMachineBitNatural_rdState_next = 2'b10;
          end
        end
      2'b11 :
        begin
          rdStateMachineBitNatural_doutVldReg1_next = 1'b1;
          if (rdStateMachineBitNatural_rdAddrCnt == 6'b111111) begin
            rdStateMachineBitNatural_rdAddrCnt_next = 6'b000000;
            rdStateMachineBitNatural_rdState_next = 2'b00;
          end
          else begin
            rdStateMachineBitNatural_rdAddrCnt_next = rdStateMachineBitNatural_rdAddrCnt + 6'b000001;
            rdStateMachineBitNatural_rdState_next = 2'b11;
          end
        end
      default :
        begin
          rdStateMachineBitNatural_rdState_next = 2'b00;
          rdStateMachineBitNatural_rdAddrCnt_next = 6'b000000;
          rdStateMachineBitNatural_doutVldReg1_next = 1'b0;
        end
    endcase
    if (rdStateMachineBitNatural_doutVldReg1) begin
      rdStateMachineBitNatural_doutReReg_next = memOut_re;
      rdStateMachineBitNatural_doutImReg_next = memOut_im;
    end
    rdStateMachineBitNatural_doutVldReg2_next = rdStateMachineBitNatural_doutVldReg1;
    dout_re7_1 = rdStateMachineBitNatural_doutReReg;
    dout_im7_1 = rdStateMachineBitNatural_doutImReg;
    dout_vld7_1 = rdStateMachineBitNatural_doutVldReg2;
  end



  assign dout_re7 = dout_re7_1;

  assign dout_im7 = dout_im7_1;

  assign dout_vld7 = dout_vld7_1;

endmodule  // RADIX2FFT_bitNatural

