module aluInputSelectMux1(
    input logic [31:0]  registerData,
    input logic [31:0]  pc,  
    input logic [1:0]   input1Select, 
    output logic [31:0] input1Alu  
);

  always_comb begin
  
    input1Alu = ((input1Select==2'b00) ? registerData :
                  ((input1Select==2'b01) ? pc : ((input1Select==2'b10) ? 32'b0 : 32'b0))
                 );
  end
endmodule