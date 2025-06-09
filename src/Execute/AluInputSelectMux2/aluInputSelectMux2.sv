module aluInputSelectMux2(
    input logic [31:0]  registerData, 
    input logic [31:0]  immediateValue,
    input logic [1:0]   input2Select, 
    output logic [31:0] input2Alu 
);

  always_comb begin
  
    input2Alu <= ((input2Select==2'b00) ? registerData :
                  ((input2Select==2'b01) ? immediateValue : ((input2Select==2'b10) ? 32'b1 : 32'b0))
                 );
  end
endmodule