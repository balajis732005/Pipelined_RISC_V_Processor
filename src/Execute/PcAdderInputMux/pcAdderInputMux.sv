`include "../../Mux2_1/mux2_1.sv";

module pcadderInputMux(
    input logic [31:0] pc,
    input logic [31:0] value,
    input logic select,
    output logic [31:0] out
);

    mux2_1 m1(
        .in1(pc),
        .in2(value),
        .select(select),
        .out(out)
    );

endmodule