`include "../../Mux2_1/mux2_1.sv";

module pcadderInputMux(
    input logic [31:0]  pc,     // INPUT 1 PC
    input logic [31:0]  regis,  // INPUT 2 REGISTER
    input logic         select, // SELECT LINE
    output logic [31:0] out     // ADDER SOURCE
);

    // 2 x 1 MUX
    mux2_1 m1(
        .in1(pc),
        .in2(regis),
        .select(select),
        .out(out)
    );

endmodule