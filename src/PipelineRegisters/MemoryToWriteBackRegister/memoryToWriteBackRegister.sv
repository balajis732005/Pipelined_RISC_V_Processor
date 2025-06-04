module memoryTOWriteBackRegister(
    input logic clock,
    input logic reset,
    input logic writeBackFromMemoryOrAlu,
    input [31:0] logic memoryReadData,
    input [31:0] logic aluData
    output logic writeBackFromMemoryOrAluOut,
    output [31:0] logic memoryReadDataOut,
    output [31:0] logic aluDataOut
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