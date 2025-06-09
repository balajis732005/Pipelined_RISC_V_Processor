module instructionDecoder(
    input  logic [31:0] instruction, 
    output logic [6:0]  opcode, 
    output logic [4:0]  rd, 
    output logic [2:0]  func3, 
    output logic [4:0]  rs1, 
    output logic [4:0]  rs2,
    output logic [6:0]  func7 
);

  always_comb begin
    
    opcode = instruction[6:0];
    rd     = instruction[11:7];
    func3 = instruction[14:12];
    rs1    = instruction[19:15];
    rs2    = instruction[24:20];
    func7 = instruction[31:25];
    
  end

endmodule