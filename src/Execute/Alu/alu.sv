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
            aluOperations.SLL : aluOutput = in1 << in2[4:0];
            aluOperations.SRL : aluOutput = in1 >> in2[4:0];
            aluOperations.SRA : aluOutput = $signed(in1) >>> in2[4:0];
            aluOperations.SLT : aluOutput = ($signed(in1) < $signed(in2)) ? 32'b1 : 32'b0;
            aluOperations.SLTU : aluOutput = in1 < in2 ? 32'b1 : 32'b0;
            default : aluOutput = 32'b0;
        endcase
    end

    assign zero = (aluOutput == 32'b0) ? 1'b1 : 1'b0;

endmodule
