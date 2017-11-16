`define R_type 7'b011_0011 
`define I_type 7'b001_0011 
`define I_type_LW 7'b000_0011 
`define SW 7'b010_0011
`define B_type 7'b110_0011
`define U_type 7'b011_0111
`define J_type 7'b110_1111 

`define ADD 3'b000
`define SLL 3'b001
`define SLT 3'b010
`define XOR 3'b100
`define SRL 3'b101
`define OR  3'b110
`define AND 3'b111
//I_type
//`define NOP 12'b0000_0000_0000
`define ADDI 3'b000
`define SLTI 3'b010
`define XORI 3'b100
`define ORI  3'b110
`define ANDI 3'b111
`define SLLI 3'b001
`define SRLI 3'b101
//BEQ
`define BEQ 000
`define BNE 001
module ALU(//input clk,
           //input rst,
           input [31:0] ID_EX,
           input [31:0] IN_1, //rs
           input [31:0] IN_2,
           output logic [31:0] out,
           output logic zero,
           output logic DM_enable,
           output logic DM_write
           );
  logic [31:0] ID_EX_wire;
  
  always_comb begin
    ID_EX_wire = ID_EX;
    case (ID_EX_wire[6:0])
      `R_type :
        case (ID_EX_wire[14:12])
          `ADD: 
            case (ID_EX_wire[31:25])
              7'd0: out = IN_1 + IN_2;
              default: out = IN_1 - IN_2;
            endcase
          `SLL: out = IN_1 << IN_2[4:0];
          `SLT: out = (IN_1 < IN_2)? 32'h1:32'h0;
          `XOR: out = IN_1 ^ IN_2;
          `SRL: out = IN_1 >> IN_2[4:0];
          `OR:  out = IN_1 | IN_2;
          `AND: out = IN_1 & IN_2;
          default : out = 32'h0000_0000;  
        endcase                 
      `I_type :
        case (ID_EX_wire[14:12])
          `ADDI: 
            if(ID_EX_wire == 32'd13)
              out = 32'h0000_0000;
            else
              out = IN_1 + IN_2;            
          `SLTI : out = (IN_1<IN_2)? 32'h1:32'h0; 
          `XORI: out = IN_1^IN_2;
          `ORI : out = IN_1 | IN_2;
          `ANDI: out = IN_1 & IN_2;
          `SLLI: out = IN_1 << IN_2[4:0];
          default: out = IN_1 >> IN_2[4:0]; //`SRLI   
        endcase
      `I_type_LW : out =  IN_1 + IN_2;
      `SW    : out =      IN_1 + IN_2;
      `B_type:
        case(ID_EX_wire[14:12])
          `BEQ:  zero = ((IN_1-IN_2)==0)? 1'b1:1'b0;
          `BNE:  zero = ((IN_1-IN_2)!=0)? 1'b1:1'b0;
          default: zero = 1'b0;
        endcase
      default : out = 32'h0000_0000;
    endcase 
    if(ID_EX_wire[6:0] == `SW)
      DM_write = 1'b1; 
    else
      DM_write=1'b0;
    if((ID_EX_wire[6:0]==`SW) || (ID_EX_wire[6:0]== `I_type_LW))    
      DM_enable=1'b1;
    else
      DM_enable=1'b0;    
  end 
endmodule // vscale_alu
