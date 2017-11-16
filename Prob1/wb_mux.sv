module wb_mux(
                  input [6:0]  MEM_WBk,
                  input [31:0]  alu_out, 
                  input [31:0]  DM_out,                 
                  input [31:0]  lui_out,
                  output logic [31:0] wb_out
                  );
  always_comb begin
    if(MEM_WBk[6:0]==7'b000_0011)
      wb_out = DM_out;
    else if(MEM_WBk[6:0]==7'b011_0111)begin
      wb_out  = lui_out ; 
    end
    else
      wb_out = alu_out;
  end

endmodule                 
