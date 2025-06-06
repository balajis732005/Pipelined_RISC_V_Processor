module decodeToExecuteRegister (
    input logic         clock,
    input logic         reset,
    input logic [31:0]  pc,
    input logic [31:0]  readData1,
    input logic [31:0]  readData2,
    input logic [31:0]  immediateValue,
    input logic [4:0]   rs1,
    input logic [4:0]   rs2,
    input logic [4:0]   rd,
    input logic [2:0]   func3,
    input logic [6:0]   func7,
    input logic         pcUpdate,
    input logic         memoryReadEnable,
    input logic         memoryWriteEnable,
    input logic         registerWriteEnable,
    input logic [1:0]   aluSrc1,
    input logic [1:0]   aluSrc2,
    input logic [2:0]   aluOperation,
    input logic         pcAdderSrc,
    input logic         writeBackFromMemoryOrAlu,
    output logic [31:0] pcOut,
    output logic [31:0] readData1Out,
    output logic [31:0] readData2Out,
    output logic [31:0] immediateValueOut,
    output logic [4:0]  rs1Out,
    output logic [4:0]  rs2Out,
    output logic [4:0]  rdOut,
    output logic [2:0]  func3Out,
    output logic [6:0]  func7Out,
    output logic        pcUpdateOut,
    output logic        memoryReadEnableOut,
    output logic        memoryWriteEnableOut,
    output logic        registerWriteEnableOut,
    output logic [1:0]  aluSrc1Out,
    output logic [1:0]  aluSrc2Out,
    output logic [2:0]  aluOperationOut,
    output logic        pcAdderSrcOut,
    output logic        writeBackFromMemoryOrAluOut
);

    always_ff @(posedge clock) begin
        if (reset) begin
            pcOut <= 32'b0;
            readData1Out <= 32'b0;
            readData2Out <= 32'b0;
            immediateValueOut <= 32'b0;
            rs1Out <= 5'b0;
            rs2Out <= 5'b0;
            rdOut <= 5'b0;
            func3Out <= 3'b0;
            func7Out <= 7'b0;
            pcUpdateOut <= 1'b0;
            memoryReadEnableOut <= 1'b0;
            memoryWriteEnableOut <= 1'b0;
            registerWriteEnableOut <= 1'b0;
            aluSrc1Out <= 1'b0;
            aluSrc2Out <= 1'b0;
            aluOperationOut <= 2'b0;
            pcAdderSrcOut <= 1'b0;
            writeBackFromMemoryOrAluOut <= 1'b0;
        end else begin
            pcOut <= pc;
            readData1Out <= readData1;
            readData2Out <= readData2;
            immediateValueOut <= immediateValue;
            rs1Out <= rs1;
            rs2Out <= rs2;
            rdOut <= rd;
            func3Out <= func3;
            func7Out <= func7;
            pcUpdateOut <= pcUpdate;
            memoryReadEnableOut <= memoryReadEnable;
            memoryWriteEnableOut <= memoryWriteEnable;
            registerWriteEnableOut <= registerWriteEnable;
            aluSrc1Out <= aluSrc1;
            aluSrc2Out <= aluSrc2;
            aluOperationOut <= aluOperation;
            pcAdderSrcOut <= pcAdderSrc;
            writeBackFromMemoryOrAluOut <= writeBackFromMemoryOrAlu;
        end
    end

endmodule