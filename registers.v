// ECE 310 Project 1
// Sam Eddy
module registers(
 clk,
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
 zflag_next
 );
input wire clk;
input wire rst;
output reg [7:0]PC_reg;
input wire [7:0]PC_next;

output reg [15:0]IR_reg;
input wire [15:0]IR_next;
output reg [15:0]ACC_reg;
input wire [15:0]ACC_next;
output reg [15:0]MDR_reg;
input wire [15:0]MDR_next;
output reg [7:0]MAR_reg;
input wire [7:0]MAR_next;
output reg zflag_reg;
input wire zflag_next;

parameter l = 1'b0;
parameter h = 1'b1;

 always @ ( posedge clk )
 begin
   if( rst )
     begin
     	PC_reg <= l;
 		IR_reg <= l;
 		ACC_reg <= l;
 		MDR_reg <= l;
	 	MAR_reg <= l;
 		zflag_reg <= l;
     end
   else
    begin
    	PC_reg <= PC_next;
 		IR_reg <= IR_next;
 		ACC_reg <= ACC_next;
 		MDR_reg <= MDR_next;
	 	MAR_reg <= MAR_next;
 		zflag_reg <= zflag_next;
    end
 end
 endmodule
