module mux2_1(
    input logic [31:0] in1,
    input logic [31:0] in2,
    input logic select,
    output logic [31:0] out
);

    assign out = select ? in2 : in1;

endmodule