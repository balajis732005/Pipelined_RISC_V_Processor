`include "../../DefaultParameters/defaultParameters.sv";

module alu(
    input logic [31:0] in1,
    input logic [31:0] in2,
    input logic [3:0] aluOperation,
    output logic [31:0] aluOutput,
    output logic zero
);

    always_comb begin
        
        case(aluOperation)
            aluOperations.ADD : aluOutput = in1 + in2;
            aluOperations.SUB : aluOutput = in1 - in2;
            aluOperations.LOGIAND : aluOutput = in1 & in2;
            aluOperations.LOGIOR : aluOutput = in1 | in2;
            aluOperations.LOGIXOR : aluOutput = in1 ^ in2;
            aluOperations.SLL_OP : aluOutput = in2 << in1[4:0];
            aluOperations.SRL_OP : aluOutput = in2 >> in1[4:0];
            aluOperations.SRA_OP : aluOutput = $signed(in2) >>> in1[4:0];
            aluOperations.SLT_OP : aluOutput = ($signed(in1) < $signed(in2)) ? 32'b1 : 32'b0;
            default : aluOutput = 32'b0;
        endcase
    end

    assign zero = (aluOutput == 32'b0) ? 1'b1 : 1'b0;

endmodule
