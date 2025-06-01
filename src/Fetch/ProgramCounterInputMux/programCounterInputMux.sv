`include "../../Mux2_1/mux2_1.sv"

module programCounterInputMux (
    input  logic [31:0] pcIncrement,
    input  logic [31:0] pcJump,
    input  logic pcIncrementOrJump,
    output logic [31:0] pcInput
);

    mux2_1 m1 (
        .in1(pcIncrement),
        .in2(pcJump),
        .select(pcIncrementOrJump),
        .out(pcInput)
    );

endmodule