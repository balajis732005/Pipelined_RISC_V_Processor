module nextPcValueSelect(
    input logic branchEnable,
    input logic branchAlu,
    output logic pcSelectOut
);

    assign pcSelectOut = branchEnable & pcSelectOut;

endmodule