`define I_type 7'b001_0011 
`define I_type_LW 7'b000_0011           //lw instruction 
`define SW 7'b010_0011
`define U_type 7'b011_0111
module immgen(input [31:0]        IF_ID,
              input clk,
              input rst,
              output logic [31:0]   imm
             );

  always_ff@(posedge clk or posedge rst) begin
    if(rst) 
      imm <= 32'h0000_0000; 
    else begin
      if(IF_ID[6:0] == `I_type || IF_ID[6:0] == `I_type_LW)  //IMM_I
        imm <= {{21{IF_ID[31]}}, IF_ID[30:20]};
      else if(IF_ID[6:0]== `SW)
        imm <= { {21{IF_ID[31]}}, IF_ID[30:25], IF_ID[11:7] };
      else if(IF_ID[6:0] == `U_type)//U_TYPE
        imm <= {IF_ID[31:12],12'b0};
      else
        imm <= imm; 
    end
  end
endmodule // vscale_imm_gen
