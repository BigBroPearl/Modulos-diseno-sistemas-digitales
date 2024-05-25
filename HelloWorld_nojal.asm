#CARGA DIRECCION (0x2018) EN t0
addi t0, zero, 0x2  #t0=0x00000002
addi x0, x0, 0
addi x0, x0, 0
slli t0, t0, 12     #t0=0x00002000
addi x0, x0, 0
addi x0, x0, 0
addi t0, t0, 0x18   #t0=0x00002018
#CARGA DIRECCION (0x2010) EN t2
addi t2, zero, 0x2  #t2=0x00000002
addi x0, x0, 0
addi x0, x0, 0
slli t2, t2, 12     #t2=0x00002000
addi x0, x0, 0
addi x0, x0, 0
addi t2, t2, 0x10   #t2=0x00002010
#Poner new_rx=1,send=1 EN t3
addi t3, zero, 0X3  #t2=0x00000011
#Poner new_rx=1,send=0 EN t5
addi t5, zero, 0X2  #t2=0x00000010

addi t1, zero, 0X20  	 #ASCII SPACE EN t1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN  t0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND0:
lw  t4,   0(t2) #CARGA t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND0  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X48  	 #ASCII H EN t1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN UART_DATASEND t0
sw   t3, 0(t2) #GUARDA SEND t3 EN UART_CTRL t2
WAITSEND1:
lw  t4,   0(t2) #CARGA t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND1  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X65  	 #ASCII e EN T1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN  t0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND2:
lw  t4,   0(t2) #CARGA  t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND2  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X6C  	 #ASCII l EN T1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN  t0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND3:
lw  t4,   0(t2) #CARGA  t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND3  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X6C  	 #ASCII l EN T1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN  t0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND4:
lw  t4,   0(t2) #CARGA  t2 ACTUAL EN t4
bne t4, t5, WAITSEND4  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X6F  	 #ASCII o EN T1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN  t0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND5:
lw  t4,   0(t2) #CARGA  t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND5  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X20  	 #ASCII SPACE EN T1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN  t0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND6:
lw  t4,   0(t2) #CARGA  t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND6  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X57  	 #ASCII W EN T1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN  t0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND7:
lw  t4,   0(t2) #CARGA  t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND7  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X6F  	 #ASCII o EN T1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN  t0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND8:
lw  t4,   0(t2) #CARGA  t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND8  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X72  	 #ASCII r EN T1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN  t0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND9:
lw  t4,   0(t2) #CARGA  t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND9  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X6C  	 #ASCII l EN T1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN  t0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND10:
lw  t4,   0(t2) #CARGA  t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND10  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X64  	 #ASCII d EN T1
sw   t1, 0(t0) #GUARDA t1 EN  t0
addi x0, x0, 0
addi x0, x0, 0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND11:
lw  t4,   0(t2) #CARGA UART_CTRL t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND11  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X20  	 #ASCII SPACE EN T1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN  t0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND12:
lw  t4,   0(t2) #CARGA UART_CTRL t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND12  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait

addi t1, zero, 0X21  	 #ASCII ! EN T1
addi x0, x0, 0
addi x0, x0, 0
sw   t1, 0(t0) #GUARDA t1 EN  t0
sw   t3, 0(t2) #GUARDA SEND t3 EN  t2
WAITSEND13:
lw  t4,   0(t2) #CARGA UART_CTRL t2 ACTUAL EN t4
addi x0, x0, 0
addi x0, x0, 0
bne t4, t5, WAITSEND13  #SI SEND ACTUAL t4, es diferente del send ya bajo (t5 de la linea 12), vuelve a wait
