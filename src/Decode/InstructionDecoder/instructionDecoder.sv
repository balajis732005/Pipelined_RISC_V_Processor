module instructionDecoder(
    input  logic [31:0] instruction,  // INSTRUCTION
    output logic [6:0]  opcode,       // OPCODE
    output logic [4:0]  rd,           // DESTINATION REGISTER
    output logic [2:0]  funct3,       // FUNC3 OPERATION
    output logic [4:0]  rs1,          // SOUREC REGISTER 1
    output logic [4:0]  rs2,          // SOUREC REGISTER 2
    output logic [6:0]  funct7        // FUNC7 OPERATION
);

    assign opcode = instruction[6:0];
    assign rd     = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1    = instruction[19:15];
    assign rs2    = instruction[24:20];
    assign funct7 = instruction[31:25];

endmodule
