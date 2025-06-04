module executeToMemory(
    input logic clock,
    input logic reset,
    input logic [31:0] pcAdder,
    input logic [31:0] alu,
    input logic branch,
    input logic branchEnable,
    input logic memoryReadEnable,
    input logic memoryWriteEnable,
    input logic writeBackFromMemoryOrAlu,
    input logic [31:0] rs2,
    output logic [31:0] pcAdderOut,
    output logic [31:0] aluOut,
    output logic branchOut,
    output logic branchEnableOut,
    output logic memoryReadEnableOut,
    output logic memoryWriteEnableOut,
    output logic writeBackFromMemoryOrAluOut,
    output logic [31:0] rs2Out,
);

    always_ff @(posedge clock) begin

        if(reset) begin
            pcAdderOut <= 32'b0;
            aluOut <= 31'b0;
            branchOut <= 1'b0;
            branchEnableOut <= 1'b0;
            memoryReadEnableOut <= 1'b0;
            memoryWriteEnableOut <= 1'b0;
            writeBackFromMemoryOrAlu <= 1'b0;
            rs2Out <= 32'b0;
        end
        else begin
            pcAdderOut <= pcAdder;
            aluOut <= aluOut;
            branchOut <= branch;
            branchEnableOut <= branchEnable;
            memoryReadEnableOut <= memoryReadEnable;
            memoryWriteEnableOut <= memoryWriteEnable;
            writeBackFromMemoryOrAlu <= writeBackFromMemoryOrAluOut;
            rs2Out <= rs2;
        end
    end

endmodule