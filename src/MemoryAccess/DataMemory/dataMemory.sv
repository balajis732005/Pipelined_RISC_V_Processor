module dataMemory(
    input  logic         clock,             // CLOCK 
    input  logic         reset,             // RESET
    input  logic         memoryReadEnable,  // REQUIRE TO READ IN MEMORY
    input  logic         memoryWriteEnable, // REQUIRE TO WRITE IN MEMORY
    input  logic [2:0]   func3,             // FUNC3 OPERATION
    input  logic [31:0]  memoryAddress,     // ADDRESS TO WRITE OR READ
    input  logic [31:0]  writeData,         // DATA TO BE WRITE
    output logic [31:0]  readData           // READ DATA FROM MEMORY
);

    // 1KB x 32-bit MEMORY
    logic [31:0] dataMem [0:1023];

    // READ LOGIC
    always_comb begin
        if (memoryReadEnable) begin
            logic [31:0] rawRead = dataMem[memoryAddress[11:2]]; // word-aligned access
            case (func3)
                3'b000: readData = {{24{rawRead[7]}}, rawRead[7:0]};     // LB
                3'b001: readData = {{16{rawRead[15]}}, rawRead[15:0]};   // LH
                3'b100: readData = {{24{1'b0}}, rawRead[7:0]};           // LBU
                3'b101: readData = {{16{1'b0}}, rawRead[15:0]};          // LHU
                default: readData = rawRead;                             // LW
            endcase
        end else begin
            readData = 32'b0;
        end
    end

    // WRITE LOGIC
    always_ff @(posedge clock) begin
        if (reset) begin
            for (int i = 0; i < 1024; i++) begin
                dataMem[i] <= 32'b0;
            end
        end else if (memoryWriteEnable) begin
            logic [31:0] modifiedWriteData = writeData;
            case (func3)
                3'b000: modifiedWriteData = {24'b0, writeData[7:0]};     // SB
                3'b001: modifiedWriteData = {16'b0, writeData[15:0]};    // SH
                default: modifiedWriteData = writeData;                  // SW
            endcase
            dataMem[memoryAddress[11:2]] <= modifiedWriteData;
        end
    end

endmodule