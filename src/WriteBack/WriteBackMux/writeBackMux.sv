`include "../../Mux2_1/mux2_1.sv";

module writeBackMux(
    input logic [31:0] aluData,
    input logic [31:0] memoryData,
    input logic writeBackMemoryOrAlu,
    output logic [31:0] dataBack
);

    mux2_1 m1(
        .in1(aluData),
        .in2(memoryData),
        .select(writeBackFromMemoryOrAlu),
        .out(dataBack)
    );

endmodule