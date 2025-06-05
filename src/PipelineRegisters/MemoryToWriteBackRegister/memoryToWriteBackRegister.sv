module memoryTOWriteBackRegister(
    input logic         clock,
    input logic         reset,
    input logic         writeBackFromMemoryOrAlu,
    input logic [31:0]  memoryReadData,
    input logic [31:0]  aluData,
    output logic        writeBackFromMemoryOrAluOut,
    output logic [31:0] memoryReadDataOut,
    output logic [31:0] aluDataOut
);

    always_ff @(posedge clock) begin

        if(reset==1'b1) begin
            writeBackFromMemoryOrAluOut <= 1'b0;
            memoryReadDataOut <= 32'b0;
            aluDataOut <= 32'b0;
        end
        else begin
            writeBackFromMemoryOrAluOut <= writeBackFromMemoryOrAlu;
            memoryReadDataOut <= memoryReadData;
            aluDataOut <= aluData;
        end

    end

endmodule