// ECE 310 Project 1
// Sam Eddy
module  ram(
       We,
       D,
       Q,
       Addr
	  );
	  parameter d_width=16, addr_width=8, mem_depth=256;
      input We;
      input [d_width-1:0]D;
      output reg[d_width-1: 0]Q;
      input [addr_width-1:0]Addr;

	  reg  [d_width-1:0] mem256x16 [mem_depth-1:0];

always @ ( Addr or D or We )
begin
if ( We == 1'b1)
   mem256x16[Addr] <= D;
   else
   Q <= mem256x16[Addr];
end

endmodule
