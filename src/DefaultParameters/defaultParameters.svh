// OPCODE OF INSTRUCTIONS
typedef enum logic [6:0] {
  RType      = 7'b0110011,
  IType      = 7'b0010011,
  ITypeLoad  = 7'b0000011,
  ITypeJALR  = 7'b1100111,
  SType      = 7'b0100011,
  BType      = 7'b1100011,
  UType      = 7'b0110111,
  UTypeAUIPC = 7'b0010111,
  JType      = 7'b1101111
} instructionType;

// ALU CODE FOR INSTRUCTIONS
typedef enum logic [2:0] {
   LoadStoreType  = 3'b000,
   BTypeALU 	   = 3'b001,
   RTypeALU       = 3'b010,
   ITypeALU       = 3'b011,
   JTypeALU       = 3'b100,
   ITypeJALR_ALU  = 3'b101,
   UTypeALU       = 3'b110,
   UTypeAUIPC_ALU = 3'b111
} typeOfInstructionAluControl;

// ALU CODE FOR OPERATION
typedef enum logic [3:0] {
   ADD  = 4'b0000,
   SUB  = 4'b0001,
   AND  = 4'b0010,
   OR   = 4'b0011,
   XOR  = 4'b0100,
   SLL  = 4'b0101,
   SRL  = 4'b0110,
   SRA  = 4'b0111,
   SLT  = 4'b1000,
   SLTU = 4'b1001,
   BEQ  = 4'b1010,
   BNE  = 4'b1011,
   BLT  = 4'b1100,
   BGE  = 4'b1101,
   BLTU = 4'b1110,
   BGEU = 4'b1111
} aluOperations;