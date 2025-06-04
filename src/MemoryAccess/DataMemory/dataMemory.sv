module dataMemory(
    input logic clock,
    input logic reset,
    input logic memoryReadEnable,
    input logic memoryWriteEnable,
    input logic [2:0] func3,
    input logic [31:0] memoryAddress,
    input logic [31:0] writeData,
    output logic [31:0] readData
);

    logic [31:0] dataMem [0:1023];

    always @(*) begin
        if(memoryReadEnable==1'b1) begin
            readData <= dataMem[memoryAddress];
            case(func3)
                3'b000 : readData <= {{24{readData[7]}},readData[7:0]}; // BYTE
                3'b001 : readData <= {{16{readData[15]}},readData[15:0]}; // HALF
                3'b100 : readData <= {{24{1'b0}}},readData[7:0]}; // BYTE - UNSIGNED
                3'b101 : readData <= {{24{1'b0}},readData[15:0]}; // HALF - UNSIGNED
            endcase
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
            case(func3)
                3'b000 : writeData <= {{24{writeData[7]}},writeData[7:0]}; // BYTE
                3'b001 : writeData <= {{16{writeData[15]}},writeData[15:0]}; // HALF
            endcase
            dataMem[memoryAddress] <= writeData;
        end
    end

endmodule