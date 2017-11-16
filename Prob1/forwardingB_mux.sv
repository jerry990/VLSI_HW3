module forwardingB_mux(input logic [31:0]in_normal,
                       input logic [31:0]alu_result,
					   input logic [31:0]mem_result,
					   input logic [2:0]forward_B,  //sel
					   output logic [31:0]alu_input_floor 
					   );
  always_comb begin
    
    case (forward_B )
      2'b00: alu_input_floor = in_normal;
	  2'b01: alu_input_floor = mem_result;
	  2'b10: alu_input_floor = alu_result;
	  default:alu_input_floor = in_normal;
	endcase
  end	
endmodule  
	  
	  
