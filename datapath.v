// ECE 310 Project 1
// Sam Eddy
module datapath(
clk,
rst,
muxPC,
muxMAR,
muxACC,
loadMAR,
loadPC,
loadACC,
loadMDR,
loadIR,
opALU,
zflag,
opcode,
MemAddr,
MemD,
MemQ
);
input clk;
input rst;
input muxPC;
input muxMAR;
input muxACC;
input loadMAR;
input loadPC;
input loadACC;
input loadMDR;
input loadIR;
input opALU;
output reg zflag;
output reg [7:0]opcode;
output reg [7:0]MemAddr;
output reg [15:0]MemD;
input [15:0]MemQ;
reg [7:0]PC_next;
reg [15:0]IR_next;
reg [15:0]ACC_next;
reg [15:0]MDR_next;
reg [7:0]MAR_next;
reg zflag_next;
wire [7:0]PC_reg;
wire [15:0]IR_reg;
wire [15:0]ACC_reg;
wire [15:0]MDR_reg;
wire [7:0]MAR_reg;
wire zflag_reg;
wire [15:0]ALU_out;
//one instance of ALU
alu a1(ACC_reg,MDR_reg,opALU,ALU_out);
// one instance of registers.
registers a2(clk,
rst,
PC_reg,
PC_next,
IR_reg,
IR_next,
ACC_reg,
ACC_next,
MDR_reg,
MDR_next,
MAR_reg,
MAR_next,
zflag_reg,
zflag_next);
//code to generate
/*try put instead of * in always 
muxPC;
 muxMAR;
 muxACC;
 loadMAR;
 loadPC;
 loadACC;
 loadMDR;
 loadIR;
opALU;
if something goes */
always@*
begin
/*[7:0]PC_next;
Only change if loadpc is enabled.
muxPC decides between pc+1 or branch address
Reset address is 0, Hence nothing for the datapath to do at reset.*/
 if(loadPC) 
PC_next=muxPC?IR_reg[15:8]:(PC_reg+1'b1);
else PC_next=PC_reg;

//[15:0]IR_next;
/*Gets value of mdr_reg if loadir is set*/
if(loadIR)IR_next=MDR_reg;
else IR_next=IR_reg;

//[15:0]ACC_next;
/*Only change when loaddacc is enabled.
Muxacc decides between mdr_reg and alu out*/
if(loadACC) ACC_next=muxACC?MDR_reg:ALU_out;
else ACC_next=ACC_reg;

//[15:0]MDR_next;
/*Gets value from memeory, if load mdr is set*/
if(loadMDR)MDR_next=MemQ;
else MDR_next=MDR_reg;

//[7:0]MAR_next;
/*Only change if loadmar is enabled.
Mux mar decides between pcreg or IR[15:8]reg*/
if(loadMAR)MAR_next=muxMAR?IR_reg[15:8]:PC_reg;
else MAR_next=MAR_reg;

//zflag_next<=!ACC_reg; or if(!ACC_reg)zflag_next<=1; else zflag_next<=0;
 zflag_next=(ACC_reg==0);
//Decide based on the content of acc_reg


//needs to generate the following outputs
//set this outputs based on the registered value and not the next value to prevent glitches.
zflag=(ACC_reg==0); //=> based on ACC reg
opcode=IR_reg[7:0]; //=> based on IR_reg
MemAddr=MAR_reg; //=> Same as MAR_reg
MemD =ACC_reg; //=> Same as ACC reg
end


endmodule
