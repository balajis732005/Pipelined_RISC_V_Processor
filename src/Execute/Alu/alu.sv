`include "../../DefaultParameters/defaultParameters.sv";

module alu(
    input  logic [31:0] in1,         // INPUT 1
    input  logic [31:0] in2,         // INPUT 2
    input  logic [3:0]  aluOperation,// ALU_OPERATION
    output logic [31:0] aluOutput,   // ALU_OUTPUT
    output logic        branch       // REQUIRE BRANCH
);

    always_comb begin
        
        // DEFAULT
        aluOutput = 32'b0;
        branch    = 1'b0;

        case(aluOperation)
            aluOperations.ADD  : aluOutput = in1 + in2;
            aluOperations.SUB  : aluOutput = in1 - in2;
            aluOperations.AND  : aluOutput = in1 & in2;
            aluOperations.OR   : aluOutput = in1 | in2;
            aluOperations.XOR  : aluOutput = in1 ^ in2;
            aluOperations.SLL  : aluOutput = in1 << in2[4:0];
            aluOperations.SRL  : aluOutput = in1 >> in2[4:0];
            aluOperations.SRA  : aluOutput = $signed(in1) >>> in2[4:0];
            aluOperations.SLT  : aluOutput = ($signed(in1) < $signed(in2)) ? 32'b1 : 32'b0;
            aluOperations.SLTU : aluOutput = (in1 < in2) ? 32'b1 : 32'b0;
            aluOperations.BEQ  : branch    = (in1 == in2) ? 1'b1 : 1'b0;
            aluOperations.BNE  : branch    = ($signed(in1) != $signed(in2)) ? 1'b1 : 1'b0;
            aluOperations.BLT  : branch    = ($signed(in1) < $signed(in2)) ? 1'b1 : 1'b0;
            aluOperations.BGE  : branch    = ($signed(in1) >= $signed(in2)) ? 1'b1 : 1'b0;
            aluOperations.BLTU : branch    = (in1 < in2) ? 1'b1 : 1'b0;
            aluOperations.BGEU : branch    = (in1 >= in2) ? 1'b1 : 1'b0;
            default            : aluOutput = 32'bx;
        endcase
    end

endmodule