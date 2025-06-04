`include "../../Mux4_1/mux4_1.sv"

module aluInputSelectMux1(
    input logic [31:0] registerData,
    input logic [31:0] pc,
    input logic [1:0] inputSelect,
    output logic [31:0] input1Alu
);

    mux2_1 m1 (
        .in1(registerData),
        .in2(pc),
        .in3(31'b0),
        .in4(31'bx),
        .select(inputSelect),
        .out(input1Alu)
    );
endmodule