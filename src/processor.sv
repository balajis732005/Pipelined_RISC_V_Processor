`include "Fetch\ProgramCounterInputMux\programCounterInputMux.sv"
`include "Fetch\ProgramCounter\programCounter.sv"
`include "Fetch\ProgramCounterIncrementor\programCounterIncrementor.sv"
`include "Fetch\InstructionMemory\instructionMemory.sv"
`include "PipelineRegisters\FetchToDecodeRegister\fetchToDecodeRegister.sv"
`include "Decode\InstructionDecoder\instructionDecoder.sv"
`include "Decode\RegisterFile\registerFile.sv"
`include "Decode\ControlUnit\controlUnit.sv"
`include "Decode\ImmediateGenerator\immediateGenerator.sv"
`include "PipelineRegisters\DecodeToExecuteRegister\decodeToExecuteRegister.sv"
`include "Execute\AluControl\aluControl.sv"
`include "Execute\AluInputSelectMux1\aluInputSelectMux1.sv"
`include "Execute\AluInputSelectMux2\aluInputSelectMux2.sv"
`include "Execute\Alu\alu.sv"
`include "Execute\PcAdderInputMux\pcAdderInputMux.sv"
`include "Execute\PcAdder\pcAdder.sv"
`include "PipelineRegisters\ExecuteToMemoryRegister\executeToMemoryRegister.sv"
`include "MemoryAccess\NextPcValueSelect\nextPcValueSelect.sv"
`include "MemoryAccess\DataMemory\dataMemory.sv" 
`include "PipelineRegisters\MemoryToWriteBackRegister\memoryToWriteBackRegister.sv"
`include "WriteBack\WriteBackMux\writeBackMux.sv"

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

    // FETCH TO DECODE REGISTER
    logic [31:0] pcOutRegFetch;
    logic [31:0] instructionReg;

    // DECODE
    logic [6:0]  opcode;
    logic [4:0]  rd;
    logic [2:0]  func3;
    logic [4:0]  rs1;
    logic [4:0]  rs2;
    logic [6:0]  func7;
    logic        pcUpdate;
    logic        memoryReadEnable;
    logic        memoryWriteEnable;
    logic        registerWriteEnable;
    logic [1:0]  aluSrc1;
    logic [1:0]  aluSrc2;
    logic [2:0]  aluOperation;
    logic        pcAdderSrc;
    logic        writeBackFromAluOrMemory;
    logic [31:0] writeData;
    logic [31:0] readData1;
    logic [31:0] readData2;
    logic [31:0] immediateValue;

    // DECODE TO EXECUTE REGISTER
    logic [31:0] pcOutRegDecode;
    logic [31:0] readData1OutReg;
    logic [31:0] readData2OutReg;
    logic [31:0] immediateValueOutReg;
    logic [4:0]  rs1OutReg;
    logic [4:0]  rs2OutRegDecode;
    logic [4:0]  rdOutReg;
    logic [2:0]  func3OutRegDecode;
    logic [6:0]  func7OutReg;
    logic        pcUpdateOutRegDecode;
    logic        memoryReadEnableOutRegDecode;
    logic        memoryWriteEnableOutRegDecode;
    logic        registerWriteEnableOutReg;
    logic [1:0]  aluSrc1OutReg;
    logic [1:0]  aluSrc2OutReg;
    logic [2:0]  aluOperationOutReg;
    logic        pcAdderSrcOutReg;
    logic        writeBackFromMemoryOrAluOutRegDecode;

    // EXECUTE
    logic [3:0]  aluControlOut;
    logic [31:0] input1Alu;
    logic [31:0] input2Alu;
    logic [31:0] aluOutput;
    logic        pcBranch;
    logic [31:0] pcAdderOut;
    logic [31:0] newPc;

    // EXECUTE TO MEMORY REGISTER
    logic [31:0] pcAdderOutReg,
    logic [31:0] aluOutReg,
    logic branchOutReg,
    logic pcUpdateOutReg,
    logic memoryReadEnableOutReg,
    logic memoryWriteEnableOutReg,
    logic writeBackFromMemoryOrAluOutRegExecute,
    logic [31:0] rs2OutReg,
    logic [2:0] func3OutReg

    // MEMORY ACCESS
    logic [31:0] dataMemoryOut;

    // MEMORY TO WRITE BACK REGISTER
    logic        writeBackFromMemoryOrAluOutRegMemory;
    logic [31:0] memoryReadDataOutReg;
    logic [31:0] aluOutDataReg;


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
        .pcOut(pcOutRegFetch),
        .instOut(instructionReg)
    );

    /* ---------------------------------------------DECODE------------------------------------------------------*/

    instructionDecoder instructionDecoderDut(
        .instruction(instructionReg),
        .opcode(opcode),
        .rd(rd),
        .func3(func3),
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

    decodeToExecuteRegister decodeToExecuteRegisterDut(
        .clock(clock),
        .reset(reset),
        .pc(pcOutRegFetch),
        .readData1(readData1),
        .readData2(readData2),
        .immediateValue(immediateValue),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .func3(func3),
        .func7(func7),
        .pcUpadte(pcUpdate),
        .memoryReadEnable(memoryReadEnable),
        .memoryWriteEnable(memoryWriteEnable),
        .registerWriteEnable(registerWriteEnable),
        .aluSrc1(aluSrc1),
        .aluSrc2(aluSrc2),
        .aluOperation(aluOperation),
        .pcAdderSrc(pcAdderSrc),
        .writeBackFromMemoryOrAlu(writeBackFromMemoryOrAlu),
        .pcOut(pcOutRegDecode),
        .readData1Out(readData1OutReg),
        .readData2Out(readData2OutReg),
        .immediateValueOut(immediateValueOutReg),
        .rs1Out(rs1OutReg),
        .rs2Out(rs2OutReg),
        .rdOut(rdOutReg),
        .func3Out(func3OutReg),
        .func7Out(func7OutReg),
        .pcUpdateOut(pcUpdateOutRegDecode),
        .memoryReadEnableOut(memoryReadEnableOutRegDecode),
        .memoryWriteEnableOut(memoryWriteEnableOutReg),
        .registerWriteEnableOut(registerWriteEnableOutReg),
        .aluSrc1Out(aluSrc1OutReg),
        .aluSrc2Out(aluSrc2OutReg),
        .aluOperationOut(aluOperationOutReg),
        .pcAdderSrcOut(pcAdderSrcOutReg),
        .writeBackFromMemoryOrAluOut(writeBackFromMemoryOrAluOutReg)
    );

    /* ------------------------------------------------EXECUTE-------------------------------------------------------*/

    aluControl aluControlDut(
        .aluControl(aluOperationOutReg),
        .func3(func3OutRegDecode),
        .func7(func7OutReg),
        .aluControlOut(aluControlOut)
    );

    aluInputSelectMux1 aluInputSelectMux1Dut(
        .registerData(rs1OutReg),
        .pc(pcOutRegDecode),
        .input1Select(aluSrc1OutReg),
        .input1Alu(input1Alu)
    );

    aluInputSelectMux2 aluInputSelectMux2Dut(
        .registerData(rs2OutRegDecode),
        .immediateValue(immediateValueOutReg),
        .input2Select(aluSrc2OutReg),
        .input2Alu(input2Alu)
    );

    alu aluDut(
        .in1(input1Alu),
        .in2(input2Alu),
        .aluOperation(aluControlOut),
        .aluOutput(aluOutput),
        .branch(pcBranch)
    );

    pcAdderInputMux pcAdderInputMuxDut(
        .pc(pcOutRegDecode),
        .regis(rs1OutReg),
        .select(pcAdderSrcOutReg),
        .out(pcAdderOut)
    );

    pcAdder pcAdderDut(
        .pcOrReg(pcAdderOut),
        .imm(immediateValueOutReg)
        .newPc(newPc)
    );

    /* --------------------------------------------EXECUTE TO MEMORY REGISTER---------------------------------------------*/

    executeToMemoryRegister executeToMemoryRegisterDut(
        .clock(clock),
        .reset(reset),
        .pcAdder(newPc),
        .alu(aluOutput),
        .branch(pcBranch),
        .pcUpdate(pcUpdateOutRegDecode),
        .memoryReadEnable(memoryReadEnableOutRegDecode),
        .memoryWriteEnable(memoryWriteEnableOutRegDecode),
        .writeBackFromMemoryOrAlu(writeBackFromMemoryOrAluOutRegDecode),
        .rs2(rs2OutRegDecode),
        .func3(func3OutRegDecode),
        .pcAdderOut(pcAdderOutReg),
        .aluOut(aluOutReg),
        .branchOut(branchOutReg),
        .pcUpdateOut(pcUpdateOutReg),
        .memoryReadEnableOut(memoryReadEnableOutReg),
        .memoryWriteEnableOut(memoryWriteEnableOutReg),
        .writeBackFromMemoryOrAluOut(writeBackFromMemoryOrAluOutRegExecute),
        .rs2Out(rs2OutReg),
        .func3Out(func3OutReg)
    );

    /* ------------------------------------------------MEMORY ACCESS-----------------------------------------------------*/

    nextPcValueSelect nextPcValueSelectDut(
        .pcUpadate(pcUpdateOutReg),
        .branchAlu(branchOutReg),
        .pcSelectOut(pcIncrementOrJump)
    );

    dataMemory dataMemoryDut(
        .clock(clock),
        .reset(reset),
        .memoryReadEnable(memoryReadEnableOutReg),
        .memoryWriteEnable(memoryWriteEnableOutReg),
        .func3(func3OutReg),
        .memoryAddress(aluOutReg),
        .writeData(rs2OutReg)
        .readData(dataMemoryOut)
    );

    /* -----------------------------------------MEMORY TO WRITE BACK REGISTER--------------------------------------------*/

    memoryToWriteBackRegister memoryToWriteBackRegisterDut(
        .clock(clock),
        .reset(reset),
        .writeBackFromAluOrMemory(writeBackFromMemoryOrAluOutRegExecute),
        .memoryReadData(dataMemoryOut),
        .aluData(aluOutReg),
        .writeBackFromMemoryOrAluOut(writeBackFromMemoryOrAluOutRegMemory),
        .memoryReadDataOut(memoryReadDataOutReg),
        .aluDataOut(aluOutDataReg)
    );

    /* ------------------------------------------------WRITE BACK--------------------------------------------------------*/

    writeBackMux writeBackMuxDut(
        .aluData(aluOutDataReg),
        .memoryData(memoryReadDataOutReg),
        .writeBackMemoryOrAlu(writeBackFromMemoryOrAluOutRegMemory),
        .dataBack(writeData)
    );
    
endmodule