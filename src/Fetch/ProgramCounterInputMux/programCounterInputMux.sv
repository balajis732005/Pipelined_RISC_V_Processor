`include "../../Mux2_1/mux2_1.sv"

module programCounterInputMux (
    input  logic [31:0] pcIncrement,       // PC INC
    input  logic [31:0] pcJump,            // PC JUMP
    input  logic        pcIncrementOrJump, // PC TO INC OR JUMP
    output logic [31:0] pcInput            // NEXXT PC
);

    // 2 x 1 MUX
    mux2_1 m1 (
        .in1(pcIncrement),
        .in2(pcJump),
        .select(pcIncrementOrJump),
        .out(pcInput)
    );

endmodule