module registerFile(
    input logic clock,
    input logic reset,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic [31:0] writeData,
    input logic registerWrite,
    output logic [31:0] readData1,
    output logic [31:0] readData2
);

    logic [31:0] regFile [31:0];

    assign readData1 = (rs1 == 0) ? 32'b0 : regFile[rs1];
    assign readData2 = (rs2 == 0) ? 32'b0 : regFile[rs2];

    always_ff @(posedge clock) begin
        if (reset) begin
            for (int i = 0; i < 32; i = i + 1) begin
                regFile[i] <= 32'b0;
            end
        end else begin
            if (registerWrite && (rd != 0)) begin
                regFile[rd] <= writeData;
            end
        end
    end

endmodule
