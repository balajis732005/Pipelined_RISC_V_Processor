module programCounterIncrementor(
    input logic [31:0]  pcCurrent,
    output logic [31:0] pcNext
);
    
  always_comb begin
    pcNext = pcCurrent + 1;
  end

endmodule