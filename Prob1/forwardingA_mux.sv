module forwardingA_mux(input logic [31:0]in_normal,
                       input logic [31:0]alu_result,
					   input logic [31:0]mem_result,
					   input logic [1:0]forward_A,  //sel
					   output logic [31:0]alu_input_sky 
					   );
  always_comb begin
    
    case (forward_A )
      2'b00: alu_input_sky = in_normal;
	  2'b01: alu_input_sky = mem_result;
	  2'b10: alu_input_sky = alu_result;
	  default:alu_input_sky = in_normal;
	endcase
  end	
endmodule 
