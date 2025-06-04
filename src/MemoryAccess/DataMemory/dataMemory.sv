module dataMemory(
    input logic clock,
    input logic reset,
    input logic memoryReadEnable,
    input logic memoryWriteEnable,
    input logic [31:0] memoryAddress,
    input logic [31:0] writeData,
    output logic [31:0] readData
);

    logic [31:0] dataMem [0:1023];

    always @(*) begin
        if(memoryReadEnable==1'b1) begin
            readData <= dataMem[memoryAddress];
        end
        else begin
            readData <= 32'b0;
        end
    end

    always @(posedge clock) begin
        if(reset==1'b1) begin
            for(int i=0;i<1024;i++) begin
                dataMem[i] <= 1'b0;
            end
        end
        else if(memoryWriteEnable==1'b1)begin
            dataMem[memoryAddress] <= writeData;
        end
    end

endmodule