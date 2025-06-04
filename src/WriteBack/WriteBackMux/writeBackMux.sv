`include "../../Mux2_1/mux2_1.sv";

module writeBackMux(
    input logic [31:0] memoryData,
    input logic [31:0] aluData,
    input logic writeBackMemoryOrAlu,
    output logic [31:0] dataBack
);

    mux2_1 m1(
        .in1(memoryData),
        .in2(aluData),
        .select(writeBackFromMemoryOrAlu),
        .out(dataBack)
    );

endmodule