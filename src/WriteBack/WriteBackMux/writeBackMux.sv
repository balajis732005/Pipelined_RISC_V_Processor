`include "../../Mux2_1/mux2_1.sv";

module writeBackMux(
    input logic [31:0]  aluData,              // ALU OUTPUT DATA
    input logic [31:0]  memoryData,           // MEMORY READ DATA
    input logic         writeBackFromMemoryOrAlu, // WRITE BACK SELECT LINE
    output logic [31:0] dataBack              // DATA BACK TO REGISTER
);

    // 2 x 1 MUX
    mux2_1 muxWB(
        .in1(aluData),
        .in2(memoryData),
        .select(writeBackFromMemoryOrAlu),
        .out(dataBack)
    );

endmodule