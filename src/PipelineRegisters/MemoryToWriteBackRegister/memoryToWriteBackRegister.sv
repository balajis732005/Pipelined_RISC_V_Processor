module memoryToWriteBackRegister(
    input logic         clock,
    input logic         reset,
    input logic         writeBackFromMemoryOrAlu,
    input logic [31:0]  memoryReadData,
    input logic [31:0]  aluData,
  	input logic 		registerWriteEnable,
  input logic [4:0] rd,
    output logic        writeBackFromMemoryOrAluOut,
    output logic [31:0] memoryReadDataOut,
  output logic [31:0] aluDataOut,
  output logic 		registerWriteEnableOut,
  output logic [4:0] rdOut
);

    always_ff @(posedge clock) begin

        if(reset==1'b1) begin
            writeBackFromMemoryOrAluOut <= 1'b0;
            memoryReadDataOut <= 32'b0;
            aluDataOut <= 32'b0;
          registerWriteEnableOut <= 1'b0;
          rdOut <= 5'b0;
        end
        else begin
            writeBackFromMemoryOrAluOut <= writeBackFromMemoryOrAlu;
            memoryReadDataOut <= memoryReadData;
            aluDataOut <= aluData;
          registerWriteEnableOut <= registerWriteEnable;
          rdOut <= rd;
        end

    end

endmodule