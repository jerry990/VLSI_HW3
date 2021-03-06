module fw_unit(input logic [31:0]EX_MEM,  //transfer EX_MEM Regwrite and reg_destination
               input logic [31:0]ID_EX,   //transfer rs rt
			   input logic [31:0]MEM_WB,
			   output logic [1:0] forward_A,
			   output logic [1:0] forward_B
			   );
  always_comb begin
    if((EX_MEM[6:0]==7'b011_0011||EX_MEM[6:0]==7'b001_0011)&&EX_MEM[11:7]!=0&&EX_MEM[11:7]==ID_EX[19:15])//EX harzard forward_A R_type rs
	  forward_A = 2'b10;
	else if((MEM_WB[6:0]==7'b011_0011||MEM_WB[6:0]==7'b001_0011)&&MEM_WB[11:7]!=0&&MEM_WB[11:7]==ID_EX[19:15])//MEM_harzard  addi和add
      forward_A = 2'b01;	
	else
	  forward_A = 2'b00; //normal condition
     	   
	if(EX_MEM[6:0]==7'b011_0011&&EX_MEM[11:7]!=0&&EX_MEM[11:7]==ID_EX[24:20])// ('') forwad_b  
      forward_B = 2'b10;
	else if(MEM_WB[6:0]==7'b011_0011&&MEM_WB[11:7]!=0&&MEM_WB[11:7]==ID_EX[24:20])
      forward_B = 2'b01;  
	else
      forward_B = 2'b00; //normal condition	
  
  end  
endmodule
