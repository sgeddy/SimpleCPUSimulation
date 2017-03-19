// ECE 310 Project 1
// Sam Eddy
module proj1_tb;
           reg clk;
           reg rst;
	   wire MemRW_IO;
	   wire [7:0]MemAddr_IO;
           wire [15:0]MemD_IO;
	   
proj1 dut(
           clk,
           rst,
		   MemRW_IO,
		   MemAddr_IO,
           MemD_IO
		    );


always @(proj1_tb.dut.ctr1.state_reg)
case (proj1_tb.dut.ctr1.state_reg)
0: $display($time," Fetch_1");
1: $display($time," Fetch_2");
2: $display($time," Fetch_3");
3: $display($time," Decode");
4: $display($time," ExecADD_1");
5: $display($time," ExecADD_2");
6: $display($time," ExecOR_1");
7: $display($time," ExecOR_2");
8: $display($time," ExecLoad_1");
9: $display($time," ExecLoad_2");
10: $display($time," ExecStore_1");
11: $display($time," ExecStore_2");
12: $display($time," ExecJump");
default: $display($time," Unrecognized State");
endcase // case(state)

always 
      #5  clk =  !clk; 
		
initial begin
clk=1'b0;
rst=1'b1;
$readmemh("data.list", proj1_tb.dut.ram1.mem256x16);
#20 rst=1'b0;
#435 
$display("Final value\n");
$display("0x00d %d\n",proj1_tb.dut.ram1.mem256x16[16'h000d]);
$finish;
end


endmodule
