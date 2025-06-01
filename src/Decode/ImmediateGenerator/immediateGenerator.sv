`include "../../DefaultParameters/defaultParameters.sv"

module immediateGenerator(
    input  logic [31:0] instruction,
    output logic [31:0] immediateValue
);

    logic [6:0] opcode;
    assign opcode = instruction[6:0];

    always_comb begin
        
        // DEFAULT
        immediateValue = 32'b0;

        case(opcode)
            instructionType.IType: begin
                immediateValue = {{20{instruction[31]}}, instruction[31:20]};
            end

            instructionType.SType: begin
                immediateValue = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end

            instructionType.BType: begin
                immediateValue = {{19{instruction[12]}}, instruction[12], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            end

            instructionType.UType: begin
                immediateValue = {instruction[31:12], 12'b0};
            end

            instructionType.JType: begin
                immediateValue = {{19{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            end

            default: begin
                immediateValue = 32'b0;
            end
        endcase
    end

endmodule
