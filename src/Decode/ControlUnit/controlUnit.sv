`include "../../DefaultParameters/defaultParameters.sv"

module controlUnit(
    input  logic [6:0] opcode,                  // OPCODE
    output logic       pcUpdate,                // REQUIRE TO UPDATE OR NOT
    output logic       memoryReadEnable,        // REQUIRE TO READ IN MEMORY OR NOT
    output logic       memoryWriteEnable,       // REQUIRE TO WRITE IN MEMORY OR NOT
    output logic       registerWriteEnable,     // REQUIRE TO WRITE IN REGISTER OR NOT
    output logic [1:0] aluSrc1,                 // INPUT1 SOURCE FOR ALU 
    output logic [1:0] aluSrc2,                 // INPUT2 SOURCE FOR ALU
    output logic [2:0] aluOperation,            // INSTRUCTION OPERATION TO PERFORM IN ALU
    output logic       pcAdderSrc,              // INPUT SOUREC FOR PC UPDATE ADDER
    output logic       writeBackFromAluOrMemory // WRITE BACK DATA FROM ALU=0 OR MEMORY=1
);

    /*
    ALUSRC1 -> 00 => REGISTER | 01 => PC | 10 => CONSTANT - 0
    ALUSRC2 -> 00 => REGISTER | 01 => IMMEDIATE | 10 => CONSTANT - 1
    ALUOPERATION => Ref defaultParameters.sv
    */

    always_comb begin
        
        // DEFAULT
        pcUpdate               = 1'b0;
        memoryReadEnable       = 1'b0;
        memoryWriteEnable      = 1'b0;
        registerWriteEnable    = 1'b0;
        aluSrc1                = 2'b00;
        aluSrc2                = 2'b00;
        aluOperation           = 3'b000;
        pcAdderSrc             = 1'b0;
        writeBackFromAluOrMemory = 1'b0;

        // INSTRUCTION
        case(opcode)

            // R-TYPE
            instructionType.RType: begin
                registerWriteEnable    = 1'b1;
                aluSrc1                = 2'b00;
                aluSrc2                = 2'b00;
                aluOperation           = 3'b010;
            end

            // I-TYPE
            instructionType.IType: begin
                registerWriteEnable    = 1'b1;
                aluSrc1                = 2'b00;
                aluSrc2                = 2'b01;
                aluOperation           = 3'b011;
            end

            // I-TYPE_LOAD
            instructionType.ITypeLoad: begin
                memoryReadEnable       = 1'b1;
                registerWriteEnable    = 1'b1;
                aluSrc1                = 2'b00;
                aluSrc2                = 2'b01;
                aluOperation           = 3'b000;
                writeBackFromAluOrMemory = 1'b1;
            end

            // S-TYPE
            instructionType.SType: begin
                memoryWriteEnable      = 1'b1;
                aluSrc1                = 2'b00;
                aluSrc2                = 2'b01;
                aluOperation           = 3'b000;
            end

            // B-TYPE
            instructionType.BType: begin
                pcUpdate               = 1'b1;
                aluSrc1                = 2'b00;
                aluSrc2                = 2'b00;
                aluOperation           = 3'b001;
                pcAdderSrc             = 1'b0;
            end

            // J-TYPE
            instructionType.JType: begin
                pcUpdate               = 1'b1;
                registerWriteEnable    = 1'b1;
                aluSrc1                = 2'b01;
                aluSrc2                = 2'b10;
                aluOperation           = 3'b100;
                pcAdderSrc             = 1'b0;
            end

            // I-TYPE_JALR
            instructionType.ITypeJALR: begin
                pcUpdate               = 1'b1;
                registerWriteEnable    = 1'b1;
                aluSrc1                = 2'b01;
                aluSrc2                = 2'b10;
                aluOperation           = 3'b101;
                pcAdderSrc             = 1'b1;
            end


            // U-TYPE
            instructionType.UType: begin
                registerWriteEnable    = 1'b1;
                aluSrc1                = 2'b10;
                aluSrc2                = 2'b01;
                aluOperation           = 3'b110;
            end

            // U-TYPE_AUPIC
            instructionType.UTypeAUIPC: begin
                registerWriteEnable    = 1'b1;
                aluSrc1                = 2'b01;
                aluSrc2                = 2'b01;
                aluOperation           = 3'b111;
            end

        endcase
    end

endmodule