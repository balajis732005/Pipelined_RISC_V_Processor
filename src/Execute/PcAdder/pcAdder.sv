module pcAdder(
    input logic [31:0] pc,    // CURRENT PC
    input logic [31:0] imm,   // IMMEDIATE
    output logic [31:0] newPc // NEXT PC
);

    assign newPc = pc + (imm << 1); // IMMEDIATE LSB MUST = 0

endmodule