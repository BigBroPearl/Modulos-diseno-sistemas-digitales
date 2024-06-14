    addi x4, x0, 0x00000200
    slli x4, x4, 4
    addi x5, x0, 5
    sw x5,0(x4)  # Store 5
    addi x6, x4, 4
    addi x5, x0, 1
    sw x5,0(x6)  # Store 1
    addi x6, x6, 4
    addi x5, x0, 4
    sw x5,0(x6)  # Store 4
    addi x6, x6, 4
    addi x5, x0, 2
    sw x5,0(x6)  # Store 2
    addi x6, x6, 4
    addi x5, x0, 8
    sw x5,0(x6)  # Store 8

    # Put your code here

    # Initiate the variable
    addi x7, x0, 5     # Initiate n as 5
    add x28, x0, x0    # Initiate i as 0

LOOPBACK:    
    add x29, x0, x0  # Initiate j as 0
    add x5, x4, x0   # Store pointer address of array

FORI:
    beq x28, x7, END
    addi x6, x7, -1
    sub x6, x6, x28
    addi x28, x28, 1

FORJ:
    beq x29, x6, LOOPBACK
    lw x25, 0(x5)
    addi x5, x5, 4
    lw x26, 0(x5)
    blt x25, x26, JSWAP
    sw x26, -4(x5)
    sw x25, 0(x5)

JSWAP:    
    addi x29, x29, 1
    jal x0, FORJ

END:

