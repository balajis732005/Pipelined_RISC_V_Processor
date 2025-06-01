`include "../../Mux2_1/mux2_1.sv"

module aluInputSelectMux(
    input logic [31:0] registerData,
    input logic [31:0] immediateValue,
    input logic inputSelect,
    output logic [31:0] input2Alu
);

    mux2_1 m1 (
        .in1(registerData),
        .in2(immediateValue),
        .select(inputSelect),
        .out(input2Alu)
    );
endmodule