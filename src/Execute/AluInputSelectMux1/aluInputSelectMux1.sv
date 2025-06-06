`include "../../Mux4_1/mux4_1.sv"

module aluInputSelectMux1(
    input logic [31:0]  registerData, // REGISTER
    input logic [31:0]  pc,           // PC
    input logic [1:0]   input1Select, // SELECT LINE 1
    output logic [31:0] input1Alu     // INPUT 1 TO ALU
);

    // 4 X 1  MUX
    mux4_1 muxALUIN1(
        .in1(registerData),
        .in2(pc),
      	.in3(32'b0),
      	.in4(32'b0),
        .select(input1Select),
        .out(input1Alu)
    );
endmodule