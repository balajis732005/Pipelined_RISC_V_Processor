module mux4_1(
    input logic [31:0]  in1,
    input logic [31:0]  in2,
    input logic [31:0]  in3,
    input logic [31:0]  in4,
    input logic [1:0]   select,
    output logic [31:0] out
);

    assign out = ((sel==2'b00) ? in1 : ((sel==2'01) ? : in2 : ((sel==2'b10) ? in3 : in4)));

endmodule