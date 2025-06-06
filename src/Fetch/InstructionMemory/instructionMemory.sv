module instructionMemory (
    input  logic [31:0] instructionAddress, // PC VALUE OR CUURENT INSTRUCTION ADDRESS
    output logic [31:0] instruction         // INSTRUCTION OUT
);

    //INSTRUCTION MEMORY 32 x 1Kb
    logic [31:0] instMem [0:1023];

    initial begin
        $readmemb("../../Instructions/instructions.mem",instMem);
    end

    assign instruction = instMem[instructionAddress[9:0]]; // 1024 = 2^10 -> SO ADDRESS LENGTH = 10

endmodule