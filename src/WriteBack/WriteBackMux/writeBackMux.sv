module writeBackMux(
    input logic [31:0]  aluData, 
    input logic [31:0]  memoryData, 
    input logic         writeBackFromMemoryOrAlu,
    output logic [31:0] dataBack
);

  always_comb begin
    dataBack = (writeBackFromMemoryOrAlu==1'b0) ? aluData : memoryData;
  end

endmodule