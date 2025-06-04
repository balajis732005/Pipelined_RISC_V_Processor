`include "../../Mux4_1/mux4_1.sv"

module aluInputSelectMux1(
    input logic [31:0]  registerData, // REGISTER
    input logic [31:0]  pc,           // PC
    input logic [1:0]   input1Select, // SELECT LINE 1
    output logic [31:0] input1Alu     // INPUT 1 TO ALU
);

    // 2 X 1  MUX
    mux2_1 m1 (
        .in1(registerData),
        .in2(pc),
        .in3(31'b0),
        .in4(31'bx),
        .select(input1Select),
        .out(input1Alu)
    );
endmodule