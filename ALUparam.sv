`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 28.02.2024 
// Design Name: Laboratorio 1
// Module Name: ALUparam
//
// Revision: 3/6/2024
// Revision 0.01 - File Created
// Additional Comments: 
//////////////////////////////////////////////////////////////////////////////////


module ALUparam #(parameter n = 4)(
    input logic [n-1:0] ALUA, ALUB, 
    input logic [3:0] ALUcontrol,
    input logic ALUFLAGin,
    output logic [n-1:0] ALUresult,
    output logic [1:0] ALUflags //ALUflags[Z,C]
    

);


always_comb begin
    //valores medios que permitiran sacar banderas o sumar enteros externos que no son entradas como tal
    logic [n-1:0] ALUA_modificado;
    logic [n-1:0] ALUB_modificado;
    logic [n:0] ALUAmedio;
    
    //Condicionales para determinar si A o B se les suman o restan 1, se niegan
    //o se les asigna a un valor con n bits para sacar las banderas de corrimiento
    case ({ALUcontrol,ALUFLAGin})
        5'b01000:
        ALUA_modificado = ALUA - 1;
        5'b01001:
        ALUB_modificado = ALUB - 1;
        5'b00110:
        ALUA_modificado = ALUA + 1;
        5'b00111:
        ALUB_modificado = ALUB + 1;
        5'b01010:
        ALUA_modificado = ~ALUA;
        5'b01011:
        ALUB_modificado = ~ALUB;
        5'b10000:
        ALUAmedio = ALUA;
        5'b10001:
        ALUAmedio = ALUA;
        5'b10010:
        ALUAmedio = {ALUA[n-1],ALUA[n-2:0]};
        5'b10011:
        ALUAmedio = {ALUA[n-1],ALUA[n-2:0]};
    default ALUAmedio = ALUB;
    endcase
        //Viejos condicionales reemplazados por el case de arriba
//    if (ALUcontrol == 4'h4 && ALUFLAGin == 1'b0)
//        ALUA_modificado = ALUA - 1;
//    else if (ALUcontrol == 4'h4 && ALUFLAGin == 1'b1)
//        ALUB_modificado = ALUB - 1;
//    else if (ALUcontrol == 4'h3 && ALUFLAGin == 1'b0)
//        ALUA_modificado = ALUA + 1;
//    else if (ALUcontrol == 4'h3 && ALUFLAGin == 1'b1)
//        ALUB_modificado = ALUB + 1;
//    else if (ALUcontrol == 4'h5 && ALUFLAGin == 1'b0)
//        ALUA_modificado = ~ALUA;
//    else if (ALUcontrol == 4'h5 && ALUFLAGin == 1'b1)
//        ALUB_modificado = ~ALUB;
//     else if (ALUcontrol == 4'h8)
//        ALUAmedio = ALUA;
//     else if (ALUcontrol == 4'h9)
//        ALUAmedio = {ALUA[n-1],ALUA[n-2:0]};
     
    case(ALUcontrol)
        4'h0:   //AND
            begin
            ALUresult = ALUA & ALUB;
            ALUflags = {(ALUresult == 0), ALUFLAGin};
            end
        4'h1:   //OR
            begin
            ALUresult = ALUA | ALUB;
            ALUflags = {(ALUresult == 0), ALUFLAGin};
            end
        4'h2:   //Suma
            begin
            ALUAmedio = ALUA + ALUB + ALUFLAGin;
            ALUresult = ALUA + ALUB + ALUFLAGin;
            ALUflags = {(ALUresult == 0), ALUAmedio[n]};
            end
        4'h3:   //incrementar 1
            begin
            ALUresult = (ALUFLAGin == 1'b0) ? ALUA_modificado : ALUB_modificado;
            ALUflags = {(ALUresult == 0), ALUFLAGin};
            end
        4'h4:   //decrementar 1
            begin
            ALUresult = (ALUFLAGin == 1'b0) ? ALUA_modificado : ALUB_modificado;
            ALUflags = {(ALUresult == 0), ALUFLAGin};
            end
        4'h5:   //NOT
            begin
            ALUresult = (ALUFLAGin == 1'b0) ? ALUA_modificado : ALUB_modificado;
            ALUflags = {(ALUresult == 0), ALUFLAGin};
            end
        4'h6:   //Resta
            begin
            ALUAmedio = ALUA - ALUB - ALUFLAGin;
            ALUresult = ALUA - ALUB - ALUFLAGin;
            ALUflags = {(ALUresult == 0), ALUAmedio[n]};
            end
        4'h7:   //XOR
            begin
            ALUresult = ALUA ^ ALUB;
            ALUflags = {(ALUresult == 0), ALUFLAGin};
            end
        4'h8:   //Correr izquierda A
            begin
            ALUAmedio = ALUA<<ALUB;
            ALUresult = (ALUA<<ALUB)|({n{ALUFLAGin}}>>(n-ALUB));
            ALUflags = {(ALUresult == 0), ALUAmedio[n]};
            end
        4'h9:   //Correr derecha A
            begin
            ALUAmedio = {ALUA[n-1],ALUA[n-2:0]} >> ALUB + 1;
            ALUresult = ((ALUA>>ALUB)|({n{ALUFLAGin}}<<(n-ALUB)));
            ALUflags = {(ALUresult == 0), ALUAmedio[0]};
            end
        default ALUresult = ALUA + ALUB;
    endcase

end

endmodule



