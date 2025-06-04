`include "../../DefaultParameters/defaultParameters.sv"

module controlUnit(
    input  logic [6:0] opcode,
    output logic branchEnable,
    output logic memoryReadEnable,
    output logic memoryWriteEnable,
    output logic registerWriteEnable,
    output logic [1:0] aluSrc1,
    output logic [1:0] aluSrc2,
    output logic [2:0] aluOperation,
    output logic pcAdderSrc,
    output logic writeBackFromMemoryOrAlu
);

    always_comb begin
    
        case(opcode)
            instructionType.RType: begin
                branchEnable = 1'b0;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b00;
                aluSrc2 = 2'b00;
                aluOperation = 3'b010;
                pcAdderSrc = 1'bx;
                writeBackFromMemoryOrAlu = 1'b0;
            end

            instructionType.IType: begin
                branchEnable = 1'b0;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b00;
                aluSrc2 = 2'b01;
                aluOperation = 3'b011;
                pcAdderSrc = 1'bx;
                writeBackFromMemoryOrAlu = 1'b0;
            end

            instructionType.ITypeLoad: begin
                branchEnable = 1'b0;
                memoryReadEnable = 1'b1;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b00;
                aluSrc2 = 2'b01;
                aluOperation = 3'b000;
                pcAdderSrc = 1'bx;
                writeBackFromMemoryOrAlu = 1'b1;
            end

            instructionType.ITypeJALR: begin
                branchEnable = 1'b1;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b01;
                aluSrc2 = 2'b10;
                aluOperation = 3'b101;
                pcAdderSrc = 1'b1;
                writeBackFromMemoryOrAlu = 1'b0;
            end

            instructionType.SType: begin
                branchEnable = 1'b0;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b1;
                registerWriteEnable = 1'b0;
                aluSrc1 = 2'b00;
                aluSrc2 = 2'b01;
                aluOperation = 3'b000;
                pcAdderSrc = 1'bx;
                writeBackFromMemoryOrAlu = 1'bx;
            end

            instructionType.BType: begin
                branchEnable = 1'b1;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b0;
                aluSrc1 = 2'b00;
                aluSrc2 = 2'b00;
                aluOperation = 3'b001;
                pcAdderSrc = 1'b0;
                writeBackFromMemoryOrAlu = 1'bx;
            end

            instructionType.UType: begin
                branchEnable = 1'b0;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b10;
                aluSrc2 = 2'b10;
                aluOperation = 2'bx;
                pcAdderSrc = 3'b110;
                writeBackFromMemoryOrAlu = 1'b0;
            end

            instructionType.UTypeAUIPC: begin
                branchEnable = 1'b0;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b01;
                aluSrc2 = 2'b01;
                aluOperation = 2'bx;
                pcAdderSrc = 3'b111;
                writeBackFromMemoryOrAlu = 1'b1;
            end

            instructionType.JType: begin
                branchEnable = 1'b1;
                memoryReadEnable = 1'b0;
                memoryWriteEnable = 1'b0;
                registerWriteEnable = 1'b1;
                aluSrc1 = 2'b01;
                aluSrc2 = 2'b10;
                aluOperation = 3'b100;
                pcAdderSrc = 1'b0;
                writeBackFromMemoryOrAlu = 1'b0;
            end

            default: begin
                branchEnable = 1'bx;
                memoryReadEnable = 1'bx;
                memoryWriteEnable = 1'bx;
                registerWriteEnable = 1'bx;
                aluSrc1 = 2'bx;
                aluSrc2 = 2'bx;
                aluOperation = 3'bx;
                pcAdderSrc = 1'bx;
                writeBackFromMemoryOrAlu = 1'bx;
            end
        endcase
    end

endmodule
