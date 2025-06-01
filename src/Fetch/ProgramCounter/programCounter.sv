module programCounter (
    input  logic clock,
    input  logic reset,
    input  logic [31:0] pcIn,
    output logic [31:0] pcOut
);

    always_ff @(posedge clock) begin
        if (reset) begin
            pcOut <= 32'b0;
        end else begin
            pcOut <= pcIn;
        end
    end

endmodule
