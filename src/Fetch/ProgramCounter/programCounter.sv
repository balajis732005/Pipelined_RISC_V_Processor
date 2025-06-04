module programCounter (
    input  logic        clock, // CLOCK
    input  logic        reset, // RESET
    input  logic [31:0] pcIn,  // PC_IN
    output logic [31:0] pcOut  // PC_OUT
);

    // SYNCHRONOUS OPERATION
    always_ff @(posedge clock) begin
        if (reset==1'b1) begin
            pcOut <= 32'b0;
        end else begin
            pcOut <= pcIn;
        end
    end

endmodule
