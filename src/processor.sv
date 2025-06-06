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
  	logic [31:0] pcIncrementOut;
    logic [31:0] pcInput;
  	logic [31:0] pcOutput;
    logic [31:0] currentInstruction;

    // FETCH TO DECODE REGISTER
  	logic [31:0] pcOutputFetchToDecode;
  	logic [31:0] currentInstructionFetchToDecode;

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
    logic        writeBackFromMemoryOrAlu;
    logic [31:0] readData1;
    logic [31:0] readData2;
    logic [31:0] immediateValue;

    // DECODE TO EXECUTE REGISTER
  	logic [31:0] pcOutputDecodeToExecute;
    logic [31:0] readData1DecodeToExecute;
    logic [31:0] readData2DecodeToExecute;
    logic [31:0] immediateValueDecodeToExecute;
    logic [2:0]  func3DecodeToExecute;
    logic [6:0]  func7DecodeToExecute;
    logic        pcUpdateDecodeToExecute;
    logic        memoryReadEnableDecodeToExecute;
    logic        memoryWriteEnableDecodeToExecute;
    logic        registerWriteEnableDecodeToExecute;
    logic [1:0]  aluSrc1DecodeToExecute;
    logic [1:0]  aluSrc2DecodeToExecute;
    logic [2:0]  aluOperationDecodeToExecute;
    logic        pcAdderSrcDecodeToExecute;
    logic        writeBackFromMemoryOrAluOutDecodeToExecute;

    // EXECUTE
    logic [3:0]  aluControlOut;
    logic [31:0] input1Alu;
    logic [31:0] input2Alu;
    logic [31:0] aluOutput;
    logic        pcBranch;
  	logic [31:0] pcAdderInput;
    logic [31:0] newPc;

    // EXECUTE TO MEMORY REGISTER
  	logic [31:0] pcAdderOutExecuteToMemory;
  	logic [31:0] aluOutExecuteToMemory;
    logic        branchOutExecuteToMemory;
    logic        pcUpdateOutExecuteToMemory;
    logic        memoryReadEnableOutExecuteToMemory;
    logic        memoryWriteEnableOutExecuteToMemory;
    logic        writeBackFromMemoryOrAluOutExecuteToMemory;
  	logic [31:0] readData2OutExecuteToMemory;
  	logic [2:0]  func3OutExecuteToMemory;

    // MEMORY ACCESS
  	logic pcIncrementOrJump;
    logic [31:0] dataMemoryOut;

    // MEMORY TO WRITE BACK REGISTER
    logic        writeBackFromMemoryOrAluOutMemoryToWriteBack;
    logic [31:0] memoryReadDataOutMemoryToWriteBack;
    logic [31:0] aluOutDataMemoryToWriteBack;
  
    // WRITE BACK
  	logic [31:0] registerWriteData;

    // FETCH

    programCounterInputMux programCounterInputMuxDut(
      .pcIncrement(pcIncrementOut),
      	.pcJump(),
        .pcIncrementOrJump(),
        .pcInput(pcInput)
    );

    programCounter programCounterDut(
        .clock(clock),
        .reset(reset),
        .pcIn(pcInput),
      	.pcOut(pcOutput)
    );

    programCounterIncrementor programCounterIncrementorDut(
      	.pcCurrent(pcOutput),
      	.pcNext(pcIncrementOut)
    );

    instructionMemory instructionMemoryDut(
      	.instructionAddress(pcOutput),
        .instruction(currentInstruction)
    );

    // FETCH TO DECODE PIPELINED REGISTER

    fetchToDecodeRegister fetchToDecodeRegisterDut(
        .clock(clock),
        .reset(reset),
      	.pc(pcOutput),
        .instruction(currentInstruction),
      	.pcOut(pcOutputFetchToDecode),
      	.instOut(currentInstructionFetchToDecode)
    );

    // DECODE

    instructionDecoder instructionDecoderDut(
        .instruction(currentInstructionFetchToDecode),
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
      .writeBackFromAluOrMemory(writeBackFromMemoryOrAlu)
    );

    registerFile registerFileDut(
        .clock(clock),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .writeData(registerWriteData),
        .registerWrite(registerWriteEnable),
        .readData1(readData1),
        .readData2(readData2)
    );

    immediateGenerator immediateGeneratorDut(
        .instruction(currentInstructionFetchToDecode),
        .immediateValue(immediateValue)
    );

    // DECODE TO EXECUTE PIPELINED REGISTER

    decodeToExecuteRegister decodeToExecuteRegisterDut(
        .clock(clock),
        .reset(reset),
        .pc(pcOutputFetchToDecode),
        .readData1(readData1),
        .readData2(readData2),
        .immediateValue(immediateValue),
        .func3(func3),
        .func7(func7),
        .pcUpdate(pcUpdate),
        .memoryReadEnable(memoryReadEnable),
        .memoryWriteEnable(memoryWriteEnable),
        .registerWriteEnable(registerWriteEnable),
        .aluSrc1(aluSrc1),
        .aluSrc2(aluSrc2),
        .aluOperation(aluOperation),
        .pcAdderSrc(pcAdderSrc),
        .writeBackFromMemoryOrAlu(writeBackFromMemoryOrAlu),
        .pcOut(pcOutputDecodeToExecute),
      	.readData1Out(readData1DecodeToExecute),
        .readData2Out(readData2DecodeToExecute),
        .immediateValueOut(immediateValueDecodeToExecute),
      	.func3Out(func3DecodeToExecute),
        .func7Out(func7DecodeToExecute),
        .pcUpdateOut(pcUpdateDecodeToExecute),
        .memoryReadEnableOut(memoryReadEnableDecodeToExecute),
        .memoryWriteEnableOut(memoryWriteEnableDecodeToExecute),
        .registerWriteEnableOut(registerWriteEnableDecodeToExecute),
        .aluSrc1Out(aluSrc1DecodeToExecute),
        .aluSrc2Out(aluSrc2DecodeToExecute),
        .aluOperationOut(aluOperationDecodeToExecute),
        .pcAdderSrcOut(pcAdderSrcDecodeToExecute),
        .writeBackFromMemoryOrAluOut(writeBackFromMemoryOrAluOutDecodeToExecute)
    );

    // EXECUTE

    aluControl aluControlDut(
        .aluControl(aluOperationDecodeToExecute),
        .func3(func3DecodeToExecute),
        .func7(func7DecodeToExecute),
        .aluControlOut(aluControlOut)
    );

    aluInputSelectMux1 aluInputSelectMux1Dut(
      .registerData(readData1DecodeToExecute),
        .pc(pcOutputDecodeToExecute),
        .input1Select(aluSrc1DecodeToExecute),
        .input1Alu(input1Alu)
    );

    aluInputSelectMux2 aluInputSelectMux2Dut(
      .registerData(readData2DecodeToExecute),
        .immediateValue(immediateValueDecodeToExecute),
        .input2Select(aluSrc2DecodeToExecute),
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
        .pc(pcOutputDecodeToExecute),
      	.regis(readData1DecodeToExecute),
        .select(pcAdderSrcDecodeToExecute),
      	.out(pcAdderInput)
    );

    pcAdder pcAdderDut(
      	.pcOrReg(pcAdderInput),
      	.imm(immediateValueDecodeToExecute),
        .newPc(newPc)
    );

    /// EXECUTE TO MEMORY PIPELINED REGISTER

    executeToMemoryRegister executeToMemoryRegisterDut(
        .clock(clock),
        .reset(reset),
        .pcAdder(newPc),
        .alu(aluOutput),
        .branch(pcBranch),
        .pcUpdate(pcUpdateDecodeToExecute),
        .memoryReadEnable(memoryReadEnableDecodeToExecute),
        .memoryWriteEnable(memoryWriteEnableDecodeToExecute),
        .writeBackFromMemoryOrAlu(writeBackFromMemoryOrAluOutDecodeToExecute),
      	.readData2(readData2DecodeToExecute),
        .func3(func3DecodeToExecute),
        .pcAdderOut(pcAdderOutExecuteToMemory),
        .aluOut(aluOutExecuteToMemory),
        .branchOut(branchOutExecuteToMemory),
      	.pcUpdateOut(pcUpdateOutExecuteToMemory),
      	.memoryReadEnableOut(memoryReadEnableOutExecuteToMemory),
      	.memoryWriteEnableOut(memoryWriteEnableOutExecuteToMemory),
        .writeBackFromMemoryOrAluOut(writeBackFromMemoryOrAluOutExecuteToMemory),
      	.readData2Out(readData2OutExecuteToMemory),
      	.func3Out(func3OutExecuteToMemory)
    );

    // MEMORY ACCESS

    nextPcValueSelect nextPcValueSelectDut(
      	.pcUpdate(pcUpdateDecodeToExecute),
        .branchAlu(branchOutExecuteToMemory),
        .pcSelectOut(pcIncrementOrJump)
    );

    dataMemory dataMemoryDut(
        .clock(clock),
        .reset(reset),
      	.memoryReadEnable(memoryReadEnableOutExecuteToMemory),
      	.memoryWriteEnable(memoryWriteEnableOutExecuteToMemory),
        .func3(func3OutExecuteToMemory),
        .memoryAddress(aluOutExecuteToMemory),
      	.writeData(readData2OutExecuteToMemory),
        .readData(dataMemoryOut)
    );

    // MEMORY TO WRITE BACK PIPELINED REGISTER

    memoryToWriteBackRegister memoryToWriteBackRegisterDut(
        .clock(clock),
        .reset(reset),
        .writeBackFromMemoryOrAlu(writeBackFromMemoryOrAluOutExecuteToMemory),
        .memoryReadData(dataMemoryOut),
        .aluData(aluOutExecuteToMemory),
        .writeBackFromMemoryOrAluOut(writeBackFromMemoryOrAluOutMemoryToWriteBack),
        .memoryReadDataOut(memoryReadDataOutMemoryToWriteBack),
        .aluDataOut(aluOutDataMemoryToWriteBack)
    );

    // WRITE BACK

    writeBackMux writeBackMuxDut(
        .aluData(aluOutDataMemoryToWriteBack),
        .memoryData(memoryReadDataOutMemoryToWriteBack),
        .writeBackFromMemoryOrAlu(writeBackFromMemoryOrAluOutMemoryToWriteBack),
      	.dataBack(registerWriteData)
    );
    
endmodule