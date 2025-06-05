module fetchToDecodeRegister (
    input  logic        clock,
    input  logic        reset,
    input  logic [31:0] pc,
    input  logic [31:0] instruction,
    output logic [31:0] pcOut,
    output logic [31:0] instOut
);

    always_ff @(posedge clock) begin
        if (reset) begin
            pcOut   <= 32'b0;
            instOut <= 32'b0;
        end else begin
            pcOut   <= pc;
            instOut <= instruction;
        end
    end

endmodule
