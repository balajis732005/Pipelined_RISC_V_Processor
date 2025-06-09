module processor_tb;

    logic clock;
    logic reset;

    processor processorDut(
        .clock(clock),
        .reset(reset)
    );

    initial begin
        clock = 1'b0;
        reset = 1'b1;
    end

    always begin
        #5 clock = ~clock;
    end

    initial begin
        #10 reset = 1'b0;
        #200 
      $finish;
    end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1,processorDut);
  end

endmodule