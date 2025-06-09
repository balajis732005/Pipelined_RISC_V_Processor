module forwardUnit(
  input logic registerWriteEnableExecuteToMemory,
  input logic registerWriteEnableMemoryToWriteBack,
  input logic [4:0] prevRdExecuteToMemory,
  input logic [4:0] prevRdMemoryToWriteBack,
  input logic [4:0] presentRs1,
  input logic [4:0] presentRs2,
  output logic [1:0] forwardSelect1,
  output logic [1:0] forwardSelect2
);
  
  always_comb begin

    forwardSelect1 = 2'b00;
    forwardSelect2 = 2'b00;

    if (registerWriteEnableExecuteToMemory && prevRdExecuteToMemory != 0) begin
      if (prevRdExecuteToMemory == presentRs1)
        forwardSelect1 = 2'b01;
      if (prevRdExecuteToMemory == presentRs2)
        forwardSelect2 = 2'b01;
    end

    if (registerWriteEnableMemoryToWriteBack && prevRdMemoryToWriteBack != 0) begin
      if (prevRdMemoryToWriteBack == presentRs1)
        forwardSelect1 = 2'b10;
      if (prevRdMemoryToWriteBack == presentRs2)
        forwardSelect2 = 2'b10;
    end
  end

  
endmodule