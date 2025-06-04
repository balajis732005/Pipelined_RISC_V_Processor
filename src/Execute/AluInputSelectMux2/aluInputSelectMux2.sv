`include "../../Mux4_1/mux4_1.sv"

module aluInputSelectMux2(
    input logic [31:0] registerData,
    input logic [31:0] immediateValue,
    input logic [1:0] inputSelect,
    output logic [31:0] input2Alu
);

    mux2_1 m1 (
        .in1(registerData),
        .in2(immediateValue),
        .in3(31'b1),
        .in4(31'bx),
        .select(inputSelect),
        .out(input2Alu)
    );
endmodule