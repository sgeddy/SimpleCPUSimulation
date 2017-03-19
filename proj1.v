// ECE 310 Project 1
// Sam Eddy
module proj1(
           clk,
           rst,
            MemRW_IO,
            MemAddr_IO,
           MemD_IO
                            );

           input clk;
           input rst;
           output MemRW_IO;
           output [7:0]MemAddr_IO;
           output [15:0]MemD_IO;

wire zflag,  muxPC, muxMAR, muxACC, loadMAR,  loadPC, loadACC,  loadMDR, loadIR,
           opALU, MemRW ;

wire  [7:0] opcode, MemAddr;
wire  [15:0] MemD,  MemQ;


ram  ram1(MemRW,  MemD,  MemQ ,  MemAddr  );

ctr  ctr1( clk,  rst, zflag,
           opcode, muxPC, muxMAR,
           muxACC, loadMAR,  loadPC,
           loadACC,  loadMDR, loadIR,
           opALU, MemRW );

datapath  datapath1( clk, rst,  muxPC,  muxMAR,
         muxACC,  loadMAR,  loadPC,
         loadACC,  loadMDR,  loadIR,
         opALU,  zflag,  opcode,
         MemAddr,  MemD,  MemQ  );


 
 assign MemAddr_IO = MemAddr;
 assign MemD_IO = MemD;
 assign MemRW_IO = MemRW; 

endmodule
