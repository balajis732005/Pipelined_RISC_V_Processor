LUI x27, 0 
ADDI x27, x27, 10 

LUI x28, 0 
ADDI x28, x28, 50

LUI  x10, 0 
ADDI x10,x10,5 

LUI x21, 0
ADDI x21, x21, 1 
LUI x22, 0	
ADDI x22, x22, 2
LUI x23, 0	
ADDI x23, x23, 3
LUI x24, 0
ADDI x24, x24, 4
LUI x25, 0	
ADDI x25, x25, 5 

LUI x11, 0	
ADDI x11, x11, 5 

SW x10, 0(x27)

SW x21, 1(x28)
SW x22, 2(x28)
SW x23, 3(x28)
SW x24, 4(x28)	
SW x25, 5(x28)	

SW x11, 1(x27)

ADDI x17, x0, -1
ADDI x5, x0, 10
LW x6, 0(x5)
ADDI x5, x0, 11
LW x7, 0(x5)
ADDI x8, x0, 0
ADDI x9, x0, 51

loop:
    BGE x8, x6, 8
    ADD x10, x8, x9
    LW x11, 0(x10)
    BEQ x11, x7, 3
    ADDI x8, x8, 1
    JAL x0, -5
found:
    ADD x17, x10, x0
end: