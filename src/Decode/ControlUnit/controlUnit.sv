`include "../../DefaultParameters/defaultParameters.sv"

module controlUnit(
    input  logic [6:0] opcode,
    output logic       branchEnable,
    output logic       memoryReadEnable,
    output logic       memoryWriteEnable,
    output logic       registerWriteEnable,
    output logic       immediateEnable,
    output logic [1:0] aluOperation,
    output logic       memoryOrAlu
);

    always_comb begin
        
        // DEFAULT
        branchEnable        = 1'b0;
        memoryReadEnable    = 1'b0;
        memoryWriteEnable   = 1'b0;
        registerWriteEnable = 1'b0;
        immediateEnable     = 1'b0;
        aluOperation        = 2'b00;
        memoryOrAlu         = 1'b0;

        case(opcode)
            instructionType.RType: begin
                branchEnable        = 1'b0;
                memoryReadEnable    = 1'b0;
                memoryWriteEnable   = 1'b0;
                registerWriteEnable = 1'b1;
                immediateEnable     = 1'b0;
                aluOperation        = 2'b10;
                memoryOrAlu         = 1'b0;
            end

            instructionType.IType: begin
                branchEnable        = 1'b0;
                memoryReadEnable    = 1'b0;
                memoryWriteEnable   = 1'b0;
                registerWriteEnable = 1'b1;
                immediateEnable     = 1'b1;
                aluOperation        = 2'b11;
                memoryOrAlu         = 1'b0;
            end

            instructionType.ITypeLoad: begin
                branchEnable        = 1'b0;
                memoryReadEnable    = 1'b1;
                memoryWriteEnable   = 1'b0;
                registerWriteEnable = 1'b1;
                immediateEnable     = 1'b1;
                aluOperation        = 2'b00;
                memoryOrAlu         = 1'b1;
            end

            instructionType.ITypeJALR: begin
                branchEnable        = 1'b1;
                memoryReadEnable    = 1'b0;
                memoryWriteEnable   = 1'b0;
                registerWriteEnable = 1'b1;
                immediateEnable     = 1'b1;
                aluOperation        = 2'bx;
                memoryOrAlu         = 1'b0;
            end

            instructionType.SType: begin
                branchEnable        = 1'b0;
                memoryReadEnable    = 1'b0;
                memoryWriteEnable   = 1'b1;
                registerWriteEnable = 1'b0;
                immediateEnable     = 1'b1;
                aluOperation        = 2'b00;
                memoryOrAlu         = 1'bx;
            end

            instructionType.BType: begin
                branchEnable        = 1'b1;
                memoryReadEnable    = 1'b0;
                memoryWriteEnable   = 1'b0;
                registerWriteEnable = 1'b0;
                immediateEnable     = 1'b0;
                aluOperation        = 2'b01;
                memoryOrAlu         = 1'bx;
            end

            instructionType.UType: begin
                branchEnable        = 1'b0;
                memoryReadEnable    = 1'b0;
                memoryWriteEnable   = 1'b0;
                registerWriteEnable = 1'b1;
                immediateEnable     = 1'b1;
                aluOperation        = 2'bx;
                memoryOrAlu         = 1'b0;
            end

            instructionType.UTypeAUIPC: begin
                branchEnable        = 1'b0;
                memoryReadEnable    = 1'b0;
                memoryWriteEnable   = 1'b0;
                registerWriteEnable = 1'b1;
                immediateEnable     = 1'b1;
                aluOperation        = 2'bx;
                memoryOrAlu         = 1'b1;
            end

            instructionType.JType: begin
                branchEnable        = 1'b1;
                memoryReadEnable    = 1'b0;
                memoryWriteEnable   = 1'b0;
                registerWriteEnable = 1'b1;
                immediateEnable     = 1'b1;
                aluOperation        = 2'bx;
                memoryOrAlu         = 1'b0;
            end

            default: begin
                branchEnable        = 1'b0;
                memoryReadEnable    = 1'b0;
                memoryWriteEnable   = 1'b0;
                registerWriteEnable = 1'b0;
                immediateEnable     = 1'b0;
                aluOperation        = 2'b00;
                memoryOrAlu         = 1'b0;
            end
        endcase
    end

endmodule
