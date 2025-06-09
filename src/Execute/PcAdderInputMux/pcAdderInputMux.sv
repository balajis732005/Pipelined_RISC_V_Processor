module pcAdderInputMux(

    input logic [31:0]  pc, 
    input logic [31:0]  regis, 
    input logic         select,
    output logic [31:0] out 
);

  always_comb begin
    out = (select==1'b0) ? pc : regis;
  end

endmodule