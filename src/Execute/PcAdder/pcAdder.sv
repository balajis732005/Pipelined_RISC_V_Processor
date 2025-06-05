module pcAdder(
    input logic [31:0]  pcOrReg,    // CURRENT PC
    input logic [31:0]  imm,   // IMMEDIATE
    output logic [31:0] newPc // NEXT PC
);

    assign newPc = pcOrReg + (imm << 1); // IMMEDIATE LSB MUST = 0

endmodule