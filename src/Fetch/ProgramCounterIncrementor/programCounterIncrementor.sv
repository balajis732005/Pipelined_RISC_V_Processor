module programCounterIncrementor(
    input logic [31:0] pcCurrent, // CURRENT PC
    output logic [31:0] pcNext    // NEXT PC
);

    assign pcNext = pcCurrent + 1; // WORD ADDRESSABLE SO +1

endmodule