module nextPcValueSelect(

    input logic  pcUpdate, 
    input logic  branchAlu, 
    output logic pcSelectOut 
);

  always_comb begin
    
    pcSelectOut = pcUpdate & branchAlu; // IF BOTH 1 THE PC IS JUMP
  end

endmodule