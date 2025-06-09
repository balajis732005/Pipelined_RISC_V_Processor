module registerFile(
    input  logic        clock, 
    input  logic        reset,
    input  logic [4:0]  rs1, 
    input  logic [4:0]  rs2, 
    input  logic [4:0]  rd, 
    input  logic [31:0] writeData, 
    input  logic        registerWrite, 
    output logic [31:0] readData1,
    output logic [31:0] readData2 
);
    
    // REGISTER FILE
    logic [31:0] regFile [31:0];

    always_ff @(posedge clock) begin
      
        if (reset==1'b1) begin
            for (int i = 0; i < 32; i++) begin
                regFile[i] <= 32'b0;
            end
        end else if (registerWrite && (rd != 5'd0)) begin
            regFile[rd] <= writeData;
          	$display($time," [REG] WRITE[%0d] : %0d",rd,writeData);
        end
    end
  
  	assign readData1 = regFile[rs1];
    assign readData2 = regFile[rs2];

endmodule