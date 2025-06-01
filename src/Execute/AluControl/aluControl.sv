`include "../../DefaultParameters/defaultParameters.sv";

module aluControl(
    input logic [1:0] aluControl,
    input logic [2:0] func3,
    input logic [6:0] func7,
    output logic [3:0] aluControlOut
);

    always_comb begin
        aluControlOut = 4'b0000; // DEFAULT

        case(aluControl)
            typeOfInstructionAluControl.LoadStoreType: begin
                aluControlOut = 4'b0010; // ADD - LOAD/STORE
            end

            typeOfInstructionAluControl.BTypeALU: begin
                aluControlOut = 4'b0110; // SUB - BRANCH
            end

            typeOfInstructionAluControl.RTypeALU: begin
                case(func3)
                    3'b000: aluControlOut = (func7 == 7'b0100000) ? 4'b0110 : 4'b0010; // SUB/ADD
                    3'b111: aluControlOut = 4'b0000; // AND
                    3'b110: aluControlOut = 4'b0001; // OR
                    3'b100: aluControlOut = 4'b1000; // XOR
                    3'b001: aluControlOut = 4'b1001; // SLL
                    3'b101: aluControlOut = (func7 == 7'b0100000) ? 4'b1011 : 4'b1010; // SRA/SRL
                    3'b010: aluControlOut = 4'b0111; // SLT
                    3'b011: aluControlOut = 4'b1000; // SLTU
                    default: aluControlOut = 4'b0000;
                endcase
            end

            typeOfInstructionAluControl.ITypeALU: begin
                case(func3)
                    3'b000: aluControlOut = 4'b0010; // ADDI & AUIPC & JALR
                    3'b111: aluControlOut = 4'b0000; // ANDI
                    3'b110: aluControlOut = 4'b0001; // ORI
                    3'b100: aluControlOut = 4'b1000; // XORI
                    3'b001: aluControlOut = 4'b1001; // SLLI
                    3'b101: aluControlOut = (func7 == 7'b0100000) ? 4'b1011 : 4'b1010; // SRAI/SRLI
                    3'b010: aluControlOut = 4'b0111; // SLTI
                    3'b011: aluControlOut = 4'b1000; // SLTIU
                    default: aluControlOut = 4'b0000;
                endcase
            end

            default: begin
                aluControlOut = 4'b0000;
            end
        endcase
    end

endmodule
