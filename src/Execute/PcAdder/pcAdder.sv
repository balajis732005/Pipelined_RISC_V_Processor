module pcAdder(
  input logic [31:0]  pcOrReg,
  input logic [31:0]  imm,
  output logic [31:0] newPc
);

  always_comb begin
    newPc = pcOrReg + (imm << 1); // IMMEDIATE LSB MUST = 0
  end


endmodule