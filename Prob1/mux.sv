module rt_mux( input sel,
               input   [31:0] IN_1,
               input   [31:0] IN_2,
               output logic [31:0]  OUT
             );

  always_comb begin
    OUT = (sel) ? IN_2:IN_1;
  end
endmodule 
