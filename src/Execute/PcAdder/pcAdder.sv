module pcAdder(
    input logic [31:0] pc,
    input logic [31:0] imm,
    output logic [31:0] newPc
);

    assign newPc = pc + newPc;

endmodule