module executeToMemoryRegister(
    input logic         clock,
    input logic         reset,
    input logic [31:0]  pcAdder,
    input logic [31:0]  alu,
    input logic         branch,
    input logic         pcUpdate,
    input logic         memoryReadEnable,
    input logic         memoryWriteEnable,
    input logic         writeBackFromMemoryOrAlu,
  	input logic [31:0]  readData2,
    input logic [2:0]   func3,
  	input logic 		registerWriteEnable,
  	input logic [4:0] 	rd,
    output logic [31:0] pcAdderOut,
    output logic [31:0] aluOut,
    output logic        branchOut,
    output logic        pcUpdateOut,
    output logic        memoryReadEnableOut,
    output logic        memoryWriteEnableOut,
    output logic        writeBackFromMemoryOrAluOut,
  	output logic [31:0] readData2Out,
  output logic [2:0]  func3Out,
  output logic 		registerWriteEnableOut,
  output logic [4:0] rdOut
);

    always_ff @(posedge clock) begin

      if(reset==1'b1) begin
            pcAdderOut <= 32'b0;
            aluOut <= 32'b0;
            branchOut <= 1'b0;
            pcUpdateOut <= 1'b0;
            memoryReadEnableOut <= 1'b0;
            memoryWriteEnableOut <= 1'b0;
            writeBackFromMemoryOrAluOut <= 1'b0;
            readData2Out <= 32'b0;
            func3Out <= 3'b0;
        	registerWriteEnableOut <= 1'b0;
        rdOut <= 5'b0;
        end
        else begin
            pcAdderOut <= pcAdder;
            aluOut <= alu;
            branchOut <= branch;
            pcUpdateOut <= pcUpdate;
            memoryReadEnableOut <= memoryReadEnable;
            memoryWriteEnableOut <= memoryWriteEnable;
            writeBackFromMemoryOrAluOut <= writeBackFromMemoryOrAlu;
            readData2Out <= readData2;
            func3Out <= func3;
          	registerWriteEnableOut <= registerWriteEnable;
          rdOut <= rd;
        end
    end

endmodule