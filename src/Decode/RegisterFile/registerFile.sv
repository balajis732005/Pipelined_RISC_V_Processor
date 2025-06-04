module registerFile(
    input  logic        clock,         // CLOCK
    input  logic        reset,         // RESET
    input  logic [4:0]  rs1,           // SOUREC REGISTER 1
    input  logic [4:0]  rs2,           // SOUREC REGISTER 2
    input  logic [4:0]  rd,            // DESTINATION REGISTER
    input  logic [31:0] writeData,     // REGISTER WRITE DATA
    input  logic        registerWrite, // ENABLE SIGNAL TO WRITE IN REGISTER
    output logic [31:0] readData1,     // READ DATA 1
    output logic [31:0] readData2      // READ DATA 2
);
    
    // REGISTER FILE
    logic [31:0] regFile [31:0];

    // X0 = 0 (ZERO REGISTER)
    assign readData1 = (rs1 == 5'd0) ? 32'b0 : regFile[rs1];
    assign readData2 = (rs2 == 5'd0) ? 32'b0 : regFile[rs2];

    // SYNCHRONOUS WRITE
    always_ff @(posedge clock) begin
        if (reset==1'b1) begin
            for (int i = 0; i < 32; i++) begin
                regFile[i] <= 32'b0;
            end
        end else if (registerWrite && (rd != 5'd0)) begin
            regFile[rd] <= writeData;
        end
    end

endmodule
