module mux4_1(
    input logic [31:0]  in1,
    input logic [31:0]  in2,
    input logic [31:0]  in3,
    input logic [31:0]  in4,
    input logic [1:0]   select,
    output logic [31:0] out
);

  assign out = (
    (select == 2'b00) ? in1 : 
      ((select == 2'b01) ? in2 :
       ((select == 2'b10) ? in3 : in4)
      )
  );

endmodule