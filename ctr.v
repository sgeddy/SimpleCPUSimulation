// ECE 310 Project 1
// Sam Eddy
module ctr (
           clk,
           rst,
		   zflag,
           opcode,
           muxPC,
           muxMAR,
           muxACC,
           loadMAR,
           loadPC,
           loadACC,
           loadMDR,
           loadIR,
           opALU,
           MemRW
);
parameter d_width=16, addr_width=8, mem_depth=256;
parameter Fetch_1=4'b0000;
parameter Fetch_2=4'b0001;
parameter Fetch_3=4'b0010;
parameter Decode=4'b0011;
parameter ExecADD_1=4'b0100;
parameter ExecADD_2=4'b0101;
parameter ExecOR_1=4'b0110;
parameter ExecOR_2=4'b0111;
parameter ExecLoad_1=4'b1000;
parameter ExecLoad_2=4'b1001;
parameter ExecStore_1=4'b1010;
parameter ExecStore_2=4'b1011;
parameter ExecJump=4'b1100;

parameter op_add=8'b001;
parameter op_or= 8'b010;
parameter op_load=8'b011;
parameter op_store=8'b100;
parameter op_jump=8'b101;
parameter op_jumpz=8'b110;

           input clk;
           input rst;
		   input zflag;
           input [addr_width-1:0]opcode;
           output reg muxPC;
           output reg muxMAR;
           output reg muxACC;
           output reg loadMAR;
           output reg loadPC;
           output reg loadACC;
           output reg loadMDR;
           output reg loadIR;
           output reg opALU;
           output reg MemRW;
		   
		   reg [3:0]state_reg;
		   reg [3:0]state_next;
		   

  always @ ( posedge clk )
 begin
   if( rst )
     state_reg =  Fetch_1 ;
   else
     state_reg= state_next ;
 end


  always @ (state_reg or opcode or zflag)
  begin
    case (state_reg)
      Fetch_1:	 
        state_next = Fetch_2;  
       Fetch_2: 
        state_next = Fetch_3;  
       Fetch_3:	 
        state_next = Decode;  
       Decode: 
	     begin
		  case (opcode)
		     op_add:	
			    state_next = ExecADD_1;  
			 op_or:	 
			    state_next = ExecOR_1;  
			 op_load:	
             state_next = ExecLoad_1;  			  
			 op_store:	 
             state_next = ExecStore_1;  			  
			 op_jump: 
             state_next = ExecJump;  
			 op_jumpz:
             begin	
               if( zflag == 1'b1 )			 
			    state_next = ExecJump;  
			   else
               state_next = Fetch_1;  
			end
			endcase
		end	

       ExecADD_1:	 
        state_next = ExecADD_2;  
      ExecADD_2:	 
        state_next = Fetch_1;  
 
      ExecOR_1:	 
        state_next = ExecOR_2;  
      ExecOR_2:	 
        state_next = Fetch_1;  
		  
      ExecLoad_1:	 
        state_next = ExecLoad_2;  
      ExecLoad_2:	 
        state_next = Fetch_1;  
		  
      ExecStore_1:	  
        state_next = Fetch_1;  

      ExecJump:	 
        state_next = Fetch_1;  

    endcase
end				 

   always @ (state_reg )
  begin
  
    muxPC = 1'b0; 
    muxMAR = 1'b0; 
    muxACC = 1'b0; 
    loadMAR = 1'b0; 
    loadPC = 1'b0; 
    loadACC = 1'b0; 
    loadMDR = 1'b0; 
    loadIR = 1'b0; 
    opALU = 1'b0; 
    MemRW = 1'b0; 
	 
    case (state_reg)
      Fetch_1:	 
	  begin
	muxPC = 1'b0; 
    muxMAR = 1'b0; 
    muxACC = 1'b0; 
    loadMAR = 1'b1; 
    loadPC = 1'b1; 
    loadACC = 1'b0; 
    loadMDR = 1'b0; 
    loadIR = 1'b0; 
    opALU = 1'b0; 
    MemRW = 1'b0; 
	   end
		  
      Fetch_2:	
	  begin
		    muxPC = 1'b0; 
    muxMAR = 1'b0; 
    muxACC = 1'b0; 
    loadMAR = 1'b0; 
    loadPC = 1'b0; 
    loadACC = 1'b0; 
    loadMDR = 1'b1; 
    loadIR = 1'b0; 
    opALU = 1'b0; 
    MemRW = 1'b0; 
		
		end
		  
      Fetch_3:	 
	  begin
		    muxPC = 1'b0; 
    muxMAR = 1'b0; 
    muxACC = 1'b0; 
    loadMAR = 1'b0; 
    loadPC = 1'b0; 
    loadACC = 1'b0; 
    loadMDR = 1'b0; 
    loadIR = 1'b1; 
    opALU = 1'b0; 
    MemRW = 1'b0; 
		end

		  
      Decode:	 
	  begin
	muxPC = 1'b0; 
    muxMAR = 1'b1; 
    muxACC = 1'b0; 
    loadMAR = 1'b1; 
    loadPC = 1'b0; 
    loadACC = 1'b0; 
    loadMDR = 1'b0; 
    loadIR = 1'b0; 
    opALU = 1'b0; 
    MemRW = 1'b0; 
      end
		  
      ExecADD_1:	
      begin	  
		      muxPC = 1'b0; 
    muxMAR = 1'b0; 
    muxACC = 1'b0; 
    loadMAR = 1'b0; 
    loadPC = 1'b0; 
    loadACC = 1'b0; 
    loadMDR = 1'b1; 
    loadIR = 1'b0; 
    opALU = 1'b0; 
    MemRW = 1'b0; 
		  
		  end
		  
      ExecADD_2:	 
	  begin
        loadACC = 1'b1;
		  muxACC  = 1'b0;
		  opALU   = 1'b1;
		  end
 
 
      ExecOR_1:	 
	  begin
		      muxPC = 1'b0; 
    muxMAR = 1'b0; 
    muxACC = 1'b0; 
    loadMAR = 1'b0; 
    loadPC = 1'b0; 
    loadACC = 1'b0; 
    loadMDR = 1'b1; 
    loadIR = 1'b0; 
    opALU = 1'b0; 
    MemRW = 1'b0; 
		  
		  end

		ExecOR_2:
        begin		
		      muxPC = 1'b0; 
    muxMAR = 1'b0; 
    muxACC = 1'b0; 
    loadMAR = 1'b0; 
    loadPC = 1'b0; 
    loadACC = 1'b1; 
    loadMDR = 1'b0; 
    loadIR = 1'b0; 
    opALU = 1'b0; 
    MemRW = 1'b0; 
		  
         end
 
      ExecLoad_1:	
         begin	  
		      muxPC = 1'b0; 
    muxMAR = 1'b0; 
    muxACC = 1'b0; 
    loadMAR = 1'b0; 
    loadPC = 1'b0; 
    loadACC = 1'b0; 
    loadMDR = 1'b1; 
    loadIR = 1'b0; 
    opALU = 1'b0; 
    MemRW = 1'b0; 
		  
		  
         end		  
		  
      ExecLoad_2:
        begin	  
		      muxPC = 1'b0; 
    muxMAR = 1'b0; 
    muxACC = 1'b1; 
    loadMAR = 1'b0; 
    loadPC = 1'b0; 
    loadACC = 1'b1; 
    loadMDR = 1'b0; 
    loadIR = 1'b0; 
    opALU = 1'b0; 
    MemRW = 1'b0; 
		  
		  
        end		  
 
		  
      ExecStore_1:
        begin	  
	  
		      muxPC = 1'b0; 
    muxMAR = 1'b0; 
    muxACC = 1'b0; 
    loadMAR = 1'b0; 
    loadPC = 1'b0; 
    loadACC = 1'b0; 
    loadMDR = 1'b0; 
    loadIR = 1'b0; 
    opALU = 1'b0; 
    MemRW = 1'b1; 
		  
		  
		  end


      ExecJump:
        begin	  
		      muxPC = 1'b1; 
    muxMAR = 1'b0; 
    muxACC = 1'b0; 
    loadMAR = 1'b0; 
    loadPC = 1'b1; 
    loadACC = 1'b0; 
    loadMDR = 1'b0; 
    loadIR = 1'b0; 
    opALU = 1'b0; 
    MemRW = 1'b0; 
		  
		  
		  end

   endcase  
   
   end
		   
  endmodule
