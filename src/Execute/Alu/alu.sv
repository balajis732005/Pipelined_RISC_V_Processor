`include "../../DefaultParameters/defaultParametersPkg.sv"
import defaultParametersPkg::*;

module alu(
    input  logic [31:0] in1, 
    input  logic [31:0] in2,
    input  logic [3:0]  aluOperation,
  input logic [2:0] aluControl,
    output logic [31:0] aluOutput,
    output logic        branch 
);

  always_comb begin

         aluOutput = 32'b0;
         branch    = 1'b0;

        case(aluOperation)
            ADD  : aluOutput = in1 + in2;
            SUB  : aluOutput = in1 - in2;
            AND  : aluOutput = in1 & in2;
            OR   : aluOutput = in1 | in2;
            XOR  : aluOutput = in1 ^ in2;
            SLL  : aluOutput = in1 << in2[4:0];
            SRL  : aluOutput = in1 >> in2[4:0];
            SRA  : aluOutput = $signed(in1) >>> in2[4:0];
            SLT  : aluOutput = ($signed(in1) < $signed(in2)) ? 32'b1 : 32'b0;
            SLTU : aluOutput = (in1 < in2) ? 32'b1 : 32'b0;
          BEQ  : branch    = (in1 == in2) ? 1'b1 : 1'b0;
            BNE  : branch    = ($signed(in1) != $signed(in2)) ? 1'b1 : 1'b0;
            BLT  : branch    = ($signed(in1) < $signed(in2)) ? 1'b1 : 1'b0;
            BGE  : branch    = ($signed(in1) >= $signed(in2)) ? 1'b1 : 1'b0;
            BLTU : branch    = (in1 < in2) ? 1'b1 : 1'b0;
            BGEU : branch    = (in1 >= in2) ? 1'b1 : 1'b0;
            default            : aluOutput = 32'bx;
        endcase
    
    case(aluControl)
      JTypeALU : branch = 1'b1;
      ITypeJALR_ALU : branch = 1'b1;
    endcase
    
    end

endmodule