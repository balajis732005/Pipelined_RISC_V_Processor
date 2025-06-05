`include "Fetch\ProgramCounterInputMux\programCounterInputMux.sv"
`include "Fetch\ProgramCounter\programCounter.sv"
`include "Fetch\ProgramCounterIncrementor\programCounterIncrementor.sv"
`include "Fetch\InstructionMemory\instructionMemory.sv"

module processor(
    input logic clock,
    input logic reset
);

    logic [31:0] pcPlus;
    logic [31:0] pcJump;
    logic        pcIJSel;
    logic [31:0] pcVal;
    logic [31:0] pcInst;
    logic [31:0] currentInst;

    programCounterInputMux programCounterInputMuxDut(
        .pcIncrement(pcPlus),
        .pcJump(pcJump),
        .pcIncrementOrJump(pcIJSel),
        .pcInput(pcVal)
    );

    programCounter programCounterDut(
        .clock(clock),
        .reset(reset),
        .pcIn(pcVal),
        .pcOut(pcInst)
    );

    programCounterIncrementor programCounterIncrementorDut(
        .pcCurrent(pcInst),
        .pcNext(pcPlus)
    );

    instructionMemory instructionMemoryDut(
        .instructionAddress(pcInst),
        .instruction(currentInst)
    );

    
    
endmodule