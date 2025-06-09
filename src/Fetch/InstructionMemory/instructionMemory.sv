module instructionMemory (
  input logic clock,
  input logic reset,
    input  logic [31:0] instructionAddress,
    output logic [31:0] instruction 
);

    logic [31:0] instMem [0:1023];

    initial begin
        $readmemb("../../Instructions/instructions.mem",instMem);
    end
  
  always_ff @(posedge clock) begin
    if(reset==1'b1) begin
      instruction <= 32'bx;
    end
    
    else begin
    	instruction <= instMem[instructionAddress[9:0]];
    end
  end

endmodule