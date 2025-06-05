`include "../../Mux4_1/mux4_1.sv"

module aluInputSelectMux2(
    input logic [31:0]  registerData,   // REGISTER
    input logic [31:0]  immediateValue, // IMMEDIATE
    input logic [1:0]   input2Select,    // SELECT LINE 2
    output logic [31:0] input2Alu      // INPUT 2 TO ALU
);

    // MUX 2 x 1
    mux2_1 m1 (
        .in1(registerData),
        .in2(immediateValue),
        .in3(32'b1),
        .in4(32'bx),
        .select(input2Select),
        .out(input2Alu)
    );
endmodule