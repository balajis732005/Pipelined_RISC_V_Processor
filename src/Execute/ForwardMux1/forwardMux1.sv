module forwardMux1(
  input logic [31:0] readData1,
  input logic [31:0] prevDataExecuteToMemory,
  input logic [31:0] prevDataMemoryToWriteBack,
  input logic [1:0] forwardSelect1,
  output logic [31:0] aluForwardInput1
);
  
  always_comb begin
    aluForwardInput1 = ((forwardSelect1 == 2'b00) ? readData1 : 
                        ((forwardSelect1 == 2'b01) ? prevDataExecuteToMemory : prevDataMemoryToWriteBack)
                       );
  end
  
endmodule