#CARGA DIRECCION DE UART_DATASEND (0x2018) EN t0
addi t0, zero, 0x2  #t0=0x00000002
slli t0, t0, 12     #t0=0x00002000
addi t0, t0, 0x18   #t0=0x00002018
#CARGA DIRECCION DE UART_CONTROL (0x2010) EN t2
addi t2, zero, 0x2  #t2=0x00000002
slli t2, t2, 12     #t2=0x00002000
addi t2, t2, 0x10   #t2=0x00002010
#Poner new_rx=1,send=1 EN t3
addi t3, zero, 0X3  #t2=0x00000011
#Poner new_rx=1,send=0 EN t3
addi t5, zero, 0X2  #t2=0x00000010
#START
addi t1, zero, 0X20       #ASCII SPACE EN t1
jal  ra, SEND
addi t1, zero, 0X48       #ASCII H EN t1
jal  ra, SEND
addi t1, zero, 0X65       #ASCII e EN t1
jal  ra, SEND
addi t1, zero, 0X6C       #ASCII l EN t1
jal  ra, SEND
addi t1, zero, 0X6C       #ASCII l EN t1
jal  ra, SEND
addi t1, zero, 0X6F       #ASCII o EN t1
jal  ra, SEND
addi t1, zero, 0X20       #ASCII SPACE EN t1
jal  ra, SEND
addi t1, zero, 0X57       #ASCII W EN t1
jal  ra, SEND
addi t1, zero, 0X6F       #ASCII o EN t1
jal  ra, SEND
addi t1, zero, 0X72       #ASCII r EN t1
jal  ra, SEND
addi t1, zero, 0X6C       #ASCII l EN t1
jal  ra, SEND
addi t1, zero, 0X64       #ASCII d EN t1
jal  ra, SEND
addi t1, zero, 0X21       #ASCII ! EN t1
jal  ra, SEND
END:
beq zero, zero, END


SEND:
sw   t1, 0(t0) #GUARDA DATO EN UART_DATASEND
sw   t3, 0(t2) #GUARDA SEND EN UART_CTRL
SENT:
lw  t4,   0(t2) #CARGA UART_CTRL ACTUAL EN T4
bne t4, t5, SENT
jalr zero, 0(ra)