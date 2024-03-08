`timescale 1ns / 1ps

module ALUparam #(parameter n = 4)(
    input [n-1:0] ALUA, ALUB, 
    input [3:0] ALUcontrol,
    input ALUFLAGin,
    output [n-1:0] ALUresult,
    output [1:0] ALUflags //ALUflags[Z,C]
    

);
always @(*) begin
    //valores medios que permitiran sacar banderas o sumar enteros externos que no son entradas como tal
    wire [n-1:0] ALUA_modificado;
    wire [n-1:0] ALUB_modificado;
    wire [n:0] ALUAmedio;
      
    case(ALUcontrol)
        4'b0000:   //AND
            begin
            ALUresult = ALUA & ALUB;
            ALUflags = {(ALUresult == 0), ALUFLAGin};
            end
        4'b0001:   //OR
            begin
            ALUresult = ALUA | ALUB;
            ALUflags = {(ALUresult == 0), ALUFLAGin};
            end
        4'b0010:   //Suma
            begin
            ALUAmedio = ALUA + ALUB + ALUFLAGin;
            ALUresult = ALUA + ALUB + ALUFLAGin;
            ALUflags = {(ALUresult == 0), ALUAmedio[n]};
            end
        4'b0110:   //Resta
            begin
            ALUAmedio = ALUA - ALUB - ALUFLAGin;
            ALUresult = ALUA - ALUB - ALUFLAGin;
            ALUflags = {(ALUresult == 0), ALUAmedio[n]};
            end
        default ALUresult = ALUA + ALUB;
    endcase

end

endmodule
