`include "../../DefaultParameters/defaultParameters.sv"

module controlUnit(
    input  logic [6:0] opcode,
    output logic pcUpdate,
    output logic memoryReadEnable,
    output logic memoryWriteEnable,
    output logic registerWriteEnable,
    output logic [1:0] aluSrc1,
    output logic [1:0] aluSrc2,
    output logic [2:0] aluOperation,
    output logic pcAdderSrc,
    output logic writeBackFromAluOrMemory
);

    always_comb begin
    
        case(opcode)
            instructionType.RType: begin
                pcUpdate = 1'b0;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b00; // REGISTER
                aluSrc2 = 2'b00; // REGISTER
                aluOperation = 3'b010;
                pcAdderSrc = 1'bx;
                writeBackFromAluOrMemory = 1'b0; // ALU
            end

            instructionType.IType: begin
                pcUpdate = 1'b0;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b00; // REGISTER
                aluSrc2 = 2'b01; // IMMEDIATE
                aluOperation = 3'b011;
                pcAdderSrc = 1'bx;
                writeBackFromAluOrMemory = 1'b0; // ALU
            end

            instructionType.ITypeLoad: begin
                pcUpdate = 1'b0;
                memoryReadEnable = 1'b1;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b00; // REGISTER
                aluSrc2 = 2'b01; // IMMEDIATE
                aluOperation = 3'b000;
                pcAdderSrc = 1'bx;
                writeBackFromAluOrMemory = 1'b1; // MEMORY
            end

            instructionType.ITypeJALR: begin
                pcUpdate = 1'b1;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b01; // PC
                aluSrc2 = 2'b10; // CONSTANT - 1
                aluOperation = 3'b101;
                pcAdderSrc = 1'b1; // REGISTER
                writeBackFromAluOrMemory = 1'b0; // ALU
            end

            instructionType.SType: begin
                pcUpdate = 1'b0;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b1;
                registerWriteEnable = 1'b0;
                aluSrc1 = 2'b00; // REGISTER
                aluSrc2 = 2'b01; // IMMEDIATE
                aluOperation = 3'b000;
                pcAdderSrc = 1'bx;
                writeBackFromAluOrMemory = 1'bx;
            end

            instructionType.BType: begin
                pcUpdate = 1'b1;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b0;
                aluSrc1 = 2'b00; // REGISTER
                aluSrc2 = 2'b00; // REGISTER
                aluOperation = 3'b001;
                pcAdderSrc = 1'b0; // PC
                writeBackFromAluOrMemory = 1'bx;
            end

            instructionType.UType: begin
                pcUpdate = 1'b0;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b10; // CONSTANT - 0
                aluSrc2 = 2'b01; // IMMEDIATE
                aluOperation = 3'b110;
                pcAdderSrc = 1'bx;
                writeBackFromAluOrMemory = 1'b0; // ALU
            end

            instructionType.UTypeAUIPC: begin
                pcUpdate = 1'b0;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b01; // PC
                aluSrc2 = 2'b01; // IMMEDIATE
                aluOperation = 3'b111;
                pcAdderSrc = 1'bx;
                writeBackFromAluOrMemory = 1'b0; // ALU
            end

            instructionType.JType: begin
                pcUpdate = 1'b1;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b01; // PC
                aluSrc2 = 2'b10; // CONSTANT - 1
                aluOperation = 3'b100;
                pcAdderSrc = 1'b0; // PC
                writeBackFromAluOrMemory = 1'b0; // ALU
            end

            default: begin
                pcUpdate = 1'bx;
                memoryReadEnable = 1'bx;
                memoryWriteEnable = 1'bx;
                registerWriteEnable = 1'bx;
                aluSrc1 = 2'bx;
                aluSrc2 = 2'bx;
                aluOperation = 3'bx;
                pcAdderSrc = 1'bx;
                writeBackFromAluOrMemory = 1'bx;
            end
        endcase
    end

endmodule
