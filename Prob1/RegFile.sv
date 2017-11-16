`timescale 1ns/10ps
`define JAL 7'b110_1111
`define R_type 7'b011_0011 
`define U_type 7'b011_0111
`define B_type 7'b110_0011
`define I_type 7'b001_0011 
`define I_type_LW 7'b000_0011
module RegFile(  input [31:0] wb_data,
                 input clk,
                 input rst,
                 input [22:0] IF_ID,
                 input [31:0] pc_p,
                 input [31:0] MEM_WB,
                 output logic sel,
                 output logic [31:0] rs,
                 output logic [31:0] rt,
                 
                 output logic [31:0] sw_data,
				 output logic zero_max,
				 output logic [1:0] flush   //flush the control harzard
				
                 );
  parameter REGSize = 32;
  parameter DASize = 32;
    
  logic [DASize-1:0] mem [REGSize-1:0];
    
  //always_ff@(posedge clk) begin
    
  //end
  always_ff@(posedge clk) begin
    if(rst)begin
      for(int i=0; i<REGSize; i=i+1)begin
        mem[i] <= 32'h0000_0000;
      end
    end
    else begin
      if(IF_ID[6:0]==`JAL) begin//jal
        mem[IF_ID[11:7]]<= pc_p - 32'd4;
      end
      rs <= mem[IF_ID[16:12]];
      rt <= mem[IF_ID[21:17]];
      if(MEM_WB[11:7] == 5'b00000)
        mem[MEM_WB[11:7]] <= 32'h0000_0000;
      else if(MEM_WB[6:0] == `U_type || MEM_WB[6:0] == `R_type || MEM_WB[6:0] == `I_type_LW) 
        mem[MEM_WB[11:7]] <= wb_data;
      else if(MEM_WB[6:0] == `I_type) begin
        if(MEM_WB == 32'h13)
          mem[MEM_WB[11:7]] <= mem[MEM_WB[11:7]];
        else 
          mem[MEM_WB[11:7]] <= wb_data;
      end
      else
        mem[MEM_WB[11:7]] <= mem[MEM_WB[11:7]];    
    end
    sel <= (IF_ID[6:0] == `R_type || IF_ID[6:0] == `B_type) ? 1'b0:1'b1;
   //beq zero_max
      if(mem[IF_ID[16:12]]==mem[IF_ID[21:17]]&&IF_ID[6:0] == `B_type&&IF_ID[12]==0||mem[IF_ID[16:12]]!=mem[IF_ID[21:17]]&&IF_ID[6:0] == `B_type&&IF_ID[12]==1)begin	    
	    zero_max <= 1'b1;
		flush    <= 2'b01;
	end	
	else  begin
      zero_max <= 1'b0;	
	  flush    <= 2'b00;
	end  
   
   
    sw_data <= mem[IF_ID[21:17]];     
  end 
endmodule
