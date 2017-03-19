// ECE 310 Project 1
// Sam Eddy
module alu(
 A,
 B,
 opALU,
 Rout
);

input [15:0] A;
input [15:0] B;
input opALU;
output reg [15:0] Rout;

always @(*)
begin
	if (opALU) Rout <= A + B;
	else Rout <= A^B;
end
endmodule 
