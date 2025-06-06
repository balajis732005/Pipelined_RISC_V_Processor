module nextPcValueSelect(
    input logic  pcUpdate,   // PC_UPDATE FROM CONTROL UNIT
    input logic  branchAlu,   // BRANCH FROM ALU
    output logic pcSelectOut // NEXT PC VALUE SELECTION
);

    assign pcSelectOut = pcUpdate & branchAlu; // IF BOTH 1 THE PC IS JUMP

endmodule