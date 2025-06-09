module programCounter (
    input  logic        clock, 
    input  logic        reset,
    input  logic [31:0] pcIn,
    output logic [31:0] pcOut 
);

  	always_ff @(posedge clock) begin
        if (reset==1'b1) begin
            pcOut <= 32'b0;
        end else begin
          pcOut <= pcIn;
          $display($time," [PC] pcIn : %0d | pcOut : %0d",pcIn,pcOut);
        end
    end

endmodule