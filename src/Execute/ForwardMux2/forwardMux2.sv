module forwardMux2(
  input logic [31:0] readData2,
  input logic [31:0] prevDataExecuteToMemory,
  input logic [31:0] prevDataMemoryToWriteBack,
  input logic [1:0] forwardSelect2,
  output logic [31:0] aluForwardInput2
);
  
  always_comb begin
    aluForwardInput2 = ((forwardSelect2 == 2'b00) ? readData2 : 
                        ((forwardSelect2 == 2'b01) ? prevDataExecuteToMemory : prevDataMemoryToWriteBack)
                       );
  end
  
endmodule