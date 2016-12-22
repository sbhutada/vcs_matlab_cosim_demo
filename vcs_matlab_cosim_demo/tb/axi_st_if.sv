// AXI Streaming interface with 16bit data width

interface axi_st_if(input bit aclk, input bit areset);
    logic tready;
    logic tvalid;
    logic [31:0] tdata;
endinterface
