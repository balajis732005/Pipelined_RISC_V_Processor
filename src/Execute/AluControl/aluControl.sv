`include "../../DefaultParameters/defaultParameters.sv";

module aluControl(
    input logic [1:0] aluControl,
    input logic [2:0] func3,
    input logic [6:0] func7,
    output logic [3:0] aluControlOut
);

    always_comb begin

        case(aluControl)
            typeOfInstructionAluControl.LoadStoreType: begin
                aluControlOut = 4'b0000; // ADD - LOAD/STORE
            end

            typeOfInstructionAluControl.BTypeALU: begin
                case(func3)
                    3'b000 : aluControlOut = 1010;
                    3'b001 : aluControlOut = 1011;
                    3'b100 : aluControlOut = 1100;
                    3'b101 : aluControlOut = 1101;
                    3'b110 : aluControlOut = 1110;
                    3'b111 : aluControlOut = 1111;
                    default : aluControlOut = 4'bx;
                endcase
            end

            typeOfInstructionAluControl.RTypeALU: begin
                case(func3)
                    3'b000: aluControlOut = (func7 == 7'b0100000) ? 4'b0001 : 4'b0000; // SUB/ADD
                    3'b111: aluControlOut = 4'b0010; // AND
                    3'b110: aluControlOut = 4'b0011; // OR
                    3'b100: aluControlOut = 4'b0100; // XOR
                    3'b001: aluControlOut = 4'b0101; // SLL
                    3'b101: aluControlOut = (func7 == 7'b0100000) ? 4'b0111 : 4'b0110; // SRA/SRL
                    3'b010: aluControlOut = 4'b1000; // SLT
                    3'b011: aluControlOut = 4'b1001; // SLTU
                    default: aluControlOut = 4'bx;
                endcase
            end

            typeOfInstructionAluControl.ITypeALU: begin
                case(func3)
                    3'b000: aluControlOut = 4'b0000; // ADDI
                    3'b111: aluControlOut = 4'b0010; // ANDI
                    3'b110: aluControlOut = 4'b0011; // ORI
                    3'b100: aluControlOut = 4'b0100; // XORI
                    3'b001: aluControlOut = 4'b0101; // SLLI
                    3'b101: aluControlOut = (func7 == 7'b0100000) ? 4'b0111 : 4'b0110; // SRAI/SRLI
                    3'b010: aluControlOut = 4'b1000; // SLTI
                    3'b011: aluControlOut = 4'b1001; // SLTIU
                    default: aluControlOut = 4'bx;
                endcase
            end

            default: begin
                aluControlOut = 4'bx;
            end
        endcase
    end

endmodule
