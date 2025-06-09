module programCounterInputMux (
    input  logic [31:0] pcIncrement,
    input  logic [31:0] pcJump,
    input  logic 		pcIncrementOrJump,
    output logic [31:0] pcInput
);
  
  always_comb begin
  	pcInput = (pcIncrementOrJump==1'b0) ? pcIncrement : pcJump;
  end
  
endmodule