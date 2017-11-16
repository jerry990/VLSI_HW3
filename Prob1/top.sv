`include "CPU.sv"
module top (input clk,
            input rst,
            input [31:0] IM_out,
            input [31:0] DM_out,
            output logic IM_enable,
            output logic [31:0] IM_address,
            output logic DM_write,
            output logic DM_enable,
            output logic [31:0] DM_in,
            output logic [31:0] DM_address
            );
  CPU CPU1(.clk(clk),  
         .rst(rst),
         .IM_out(IM_out),
         .DM_out(DM_out),
         .IM_enable(IM_enable),
         .IM_address(IM_address),
         .DM_enable(DM_enable),
         .DM_write(DM_write),
         
         
         .DM_address(DM_address),
         .DM_in(DM_in)
        );
endmodule
