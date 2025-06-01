module programCounterIncrementor(
    input logic [31:0] pcCurrent,
    output logic [31:0] pcNext
);

    assign pcNext = pcCurrent + 1;

endmodule