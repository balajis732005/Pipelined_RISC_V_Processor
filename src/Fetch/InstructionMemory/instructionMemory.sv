module instructionMemory (
    input  logic [31:0] instructionAddress,
    output logic [31:0] instruction
);

    logic [31:0] instMem [0:1023];

    assign instruction = instMem[instructionAddress[11:2]];

endmodule
