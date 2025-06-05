`include "Fetch\ProgramCounterInputMux\programCounterInputMux.sv"
`include "Fetch\ProgramCounter\programCounter.sv"
`include "Fetch\ProgramCounterIncrementor\programCounterIncrementor.sv"
`include "Fetch\InstructionMemory\instructionMemory.sv"
`include "PipelineRegisters\FetchToDecodeRegister\fetchToDecodeRegister.sv"
`include "Decode\InstructionDecoder\instructionDecoder.sv"
`include "Decode\RegisterFile\registerFile.sv"
`include "Decode\ControlUnit\controlUnit.sv"
`include "Decode\ImmediateGenerator\immediateGenerator.sv"

module processor(
    input logic clock,
    input logic reset
);

    // FETCH
    logic [31:0] pcIncrement;
    logic [31:0] pcJump;
    logic        pcIncrementOrJump;
    logic [31:0] pcInput;
    logic [31:0] pcOut;
    logic [31:0] currentInstruction;

    //FETCH TO DECODE REGISTER
    logic [31:0] pcOutReg;
    logic [31:0] instructionReg;

    //DECODE
    logic [6:0] opcode;
    logic [4:0] rd;
    logic [2:0] funct3;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [6:0] funct7;
    logic       pcUpdate;
    logic       memoryReadEnable;
    logic       memoryWriteEnable;
    logic       registerWriteEnable;
    logic [1:0] aluSrc1;
    logic [1:0] aluSrc2;
    logic [2:0] aluOperation;
    logic       pcAdderSrc;
    logic       writeBackFromAluOrMemory;
    logic [31:0] writeData;
    logic [31:0] readData1;
    logic [31:0] readData2;
    logic [31:0] immediateValue;

    /* --------------------------------------------------FETCH------------------------------------------------- */

    programCounterInputMux programCounterInputMuxDut(
        .pcIncrement(pcIncrement),
        .pcJump(pcJump),
        .pcIncrementOrJump(pcIncrementOrJump),
        .pcInput(pcInput)
    );

    programCounter programCounterDut(
        .clock(clock),
        .reset(reset),
        .pcIn(pcInput),
        .pcOut(pcOut)
    );

    programCounterIncrementor programCounterIncrementorDut(
        .pcCurrent(pcOut),
        .pcNext(pcIncrement)
    );

    instructionMemory instructionMemoryDut(
        .instructionAddress(pcOut),
        .instruction(currentInstruction)
    );

    /* ----------------------------------FETCH TO DECODE PIPELINED REGISTER--------------------------------------*/

    fetchToDecodeRegister fetchToDecodeRegisterDut(
        .clock(clock),
        .reset(reset),
        .pc(pcOut),
        .instruction(currentInstruction),
        .pcOut(pcOutReg),
        .instOut(instructionReg)
    );

    /* ---------------------------------------------DECODE------------------------------------------------------*/

    instructionDecoder instructionDecoderDut(
        .instruction(instructionReg),
        .opcode(opcode),
        .rd(rd),
        .funct3(funct3),
        .rs1(rs1),
        .rs2(rs2),
        .func7(func7)
    );

    controlUnit controlUnitDut(
        .opcode(opcode),
        .pcUpdate(pcUpdate),
        .memoryReadEnable(memoryReadEnable),
        .memoryWriteEnable(memoryWriteEnable),
        .registerWriteEnable(registerWriteEnable),
        .aluSrc1(aluSrc1),
        .aluSrc2(aluSrc2),
        .aluOperation(aluOperation),
        .pcAdderSrc(pcAdderSrc),
        .writeBackFromAluOrMemory(writeBackFromAluOrMemory)
    );

    registerFile registerFileDut(
        .clock(clock),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .writeData(writeData),
        .registerWrite(registerWriteEnable),
        .readData1(readData1),
        .readData2(readData2)
    );

    immediateGenerator immediateGeneratorDut(
        .instruction(instructionReg),
        .immediateValue(immediateValue)
    );

    /* ------------------------------------------DECODE TO EXECUTE REGISTER-----------------------------------------*/

    
    
endmodule