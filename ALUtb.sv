`timescale 1ns / 1ps

module tb_ALUparam;

  parameter n = 4;
  integer i;
  integer j;
  integer k;
  
  logic [n-1:0] ALUA, ALUB;
  logic [3:0] ALUcontrol;
  logic ALUFLAGin;
  logic [n-1:0] ALUresult;
  logic [1:0] ALUflags;
  

  ALUparam #(n) ALU_tb (
    .ALUA(ALUA),
    .ALUB(ALUB),
    .ALUcontrol(ALUcontrol),
    .ALUFLAGin(ALUFLAGin),
    .ALUresult(ALUresult),
    .ALUflags(ALUflags)
  );

  // Clock generation
initial begin
ALUA <= 0;
ALUB <= 0;
ALUcontrol <= 0;
ALUFLAGin <= 0;
#3;
    for (i=0; i < 10; i=i+1) begin
        ALUcontrol <= i;
        #3;
    case(ALUcontrol)
        0:   //AND
            begin
            $display("[%0d", i , "h] Operacion AND");
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=0; k < 16; k=k+1) begin
                ALUB <= k;
                #3
                if((ALUA&ALUB)!== ALUresult) begin
                $display("ERROR VERIFICAR"); 
                $display("Entrada A = %4b - Entrada B = %4b", ALUA, ALUB);
                $display("Salida = %4b", ALUresult);
                $display("Resultado Cero = %0b", ALUflags[1]);
                $display("");
                #3
                $finish; 
                end     
                end          
                #3;
            end
            $display("TODAS LAS OPERACIONES AND FUERON CORRECTAS");
            $display(""); 
            end
            
        1:   //OR
            begin
            $display("[%0d", i , "h] Operacion OR");
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=0; k < 16; k=k+1) begin
                ALUB <= k;
                #3
                if((ALUA | ALUB)!==ALUresult) begin
                $display("ERROR VERIFICAR"); 
                $display("Entrada A = %4b - Entrada B = %4b", ALUA, ALUB);
                $display("Salida = %4b", ALUresult);
                $display("Resultado Cero = %0b", ALUflags[1]);
                $display("");
                #3
                $finish;  
                end 
                end                  
                #3;
            end
            $display("TODAS LAS OPERACIONES OR FUERON CORRECTAS");
            $display("");
            end
            
        2:   //Suma lleva flagin
            begin
            $display("[%0d", i , "h] Operacion Suma");
            ALUFLAGin <= 0;
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=0; k < 16; k=k+1) begin
                ALUB <= k;
                #3
                if((ALUA + ALUB+ALUFLAGin)!==ALUresult) begin
                $display("ERROR VERIFICAR");  
                $display("Entrada A = %4b - Entrada B = %4b", ALUA, ALUB);
                $display("Salida = %4b", ALUresult);
                $display("Resultado Cero = %0b - Acarreo = %0b", ALUflags[1], ALUflags[0]);
                $display("");
                #3
                $finish;               
                end                
                #3;
            end
            end
            $display("TODAS LAS OPERACIONES SUMA (Acarreo 0) FUERON CORRECTAS");
            $display(""); 
            ALUFLAGin <= 1;
            #3;
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=0; k < 16; k=k+1) begin
                ALUB <= k;
                #3
                if((ALUA + ALUB + ALUFLAGin)!==ALUresult) begin
                $display("ERROR PLEASE VERIFY");
                $display("Entrada A = %4b - Entrada B = %4b", ALUA, ALUB);
                $display("Salida = %4b", ALUresult);
                $display("Resultado Cero = %0b - Acarreo = %0b", ALUflags[1], ALUflags[0]);
                $display("");
                #3
                $finish;                    
                end            
                #3;
            end
            end
            $display("TODAS LAS OPERACIONES SUMA (Acarreo 1) FUERON CORRECTAS");
            $display(""); 
            end
            
        3:   //incrementar 1 lleva flagin
            begin
            $display("[%0d", i , "h] Operacion Incremento");
            ALUFLAGin <= 0;
            for (j=0; j < 15; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=0; k < 15; k=k+1) begin
                ALUB <= k;
                #3
            if((ALUA + 1)!==ALUresult) begin
            $display("ERROR VERIFICAR");
            $display("Entrada A = %4b - Entrada B = %4b - Operando a usar = %1b", ALUA, ALUB, ALUFLAGin);
            $display("Salida = %4b", ALUresult);
            $display("Resultado Cero = %0b", ALUflags[1]);
                $display("");
                #3
                $finish; 
            end                   
            #3;
            end
            end
            $display("TODAS LAS OPERACIONES INCREMENTO (OPERANDO 0) FUERON CORRECTAS");
            $display(""); 
            ALUFLAGin <= 1;
            for (j=0; j < 15; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=0; k < 15; k=k+1) begin
                ALUB <= k;
                #3
                       if((ALUB + 1)!==ALUresult) begin
            $display("ERROR VERIFICAR");
            $display("Entrada A = %4b - Entrada B = %4b - Operando a usar = %1b", ALUA, ALUB, ALUFLAGin);
            $display("Salida = %4b", ALUresult);
            $display("Resultado Cero = %0b", ALUflags[1]);
                $display("");
                #3
                $finish;  
            end                   
            #3;
            end
            end
            $display("TODAS LAS OPERACIONES INCREMENTO (OPERANDO 1) FUERON CORRECTAS");
            $display("");
            end
            
        4:   //decrementar 1 lleva flagin
            begin
            $display("[%0d", i , "h] Operacion Decremento");
            ALUFLAGin <= 0;
            for (j=1; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=1; k < 16; k=k+1) begin
                ALUB <= k;
                #3
            if((ALUA - 1)!==ALUresult) begin
            $display("ERROR VERIFICAR");
            $display("Entrada A = %4b - Entrada B = %4b - Operando a usar = %1b", ALUA, ALUB, ALUFLAGin);
            $display("Salida = %4b", ALUresult);
            $display("Resultado Cero = %0b", ALUflags[1]);
                $display("");
                #3
                $finish; 
            end                   
            #3;
            end
            end
            $display("TODAS LAS OPERACIONES DECREMENTO (OPERANDO 0) FUERON CORRECTAS");
            $display(""); 
            ALUFLAGin <= 1;
            for (j=1; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=1; k < 16; k=k+1) begin
                ALUB <= k;
                #3
                       if((ALUB - 1)!==ALUresult) begin
            $display("ERROR VERIFICAR");
            $display("Entrada A = %4b - Entrada B = %4b - Operando a usar = %1b", ALUA, ALUB, ALUFLAGin);
            $display("Salida = %4b", ALUresult);
            $display("Resultado Cero = %0b", ALUflags[1]);
                $display("");
                #3
                $finish;  
            end                   
            #3;
            end
            end
            $display("TODAS LAS OPERACIONES DECREMENTO (OPERANDO 1) FUERON CORRECTAS");
            $display("");
            end
            
        5:   //NOT lleva flagin
            begin
            $display("[%0d", i , "h] Operacion NOT");
            ALUFLAGin <= 0;
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=0; k < 16; k=k+1) begin
                ALUB <= k;
                #3
                if((~ALUA)!== ALUresult) begin
                $display("ERROR VERIFICAR"); 
                $display("Entrada A = %4b - Entrada B = %4b - Operando a usar = %1b", ALUA, ALUB, ALUFLAGin);
                $display("Salida = %4b", ALUresult);
                $display("Resultado Cero = %0b", ALUflags[1]);
                $display("");
                #3
                $finish; 
                end     
                end          
                #3;
            end
            $display("TODAS LAS OPERACIONES NOT CON OPERANDO 0 FUERON CORRECTAS");
            $display(""); 
            ALUFLAGin <= 1;
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=0; k < 16; k=k+1) begin
                ALUB <= k;
                #3
                if((~ALUB)!== ALUresult) begin
                $display("ERROR VERIFICAR"); 
                $display("Entrada A = %4b - Entrada B = %4b - Operando a usar = %1b", ALUA, ALUB, ALUFLAGin);   
                $display("Salida = %4b", ALUresult);
                $display("Resultado Cero = %0b", ALUflags[1]);
                $display("");
                #3
                $finish; 
                end     
                end          
                #3;
            end
            $display("TODAS LAS OPERACIONES NOT CON OPERANDO 1 FUERON CORRECTAS");
            $display(""); 
            end
            
        6:   //Resta lleva flagin
            begin
            $display("[%0d", i , "h] Operacion Resta", "");
            ALUFLAGin <= 0;
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=0; k < 16; k=k+1) begin
                ALUB <= k;
                #3
                if((ALUA - ALUB+ALUFLAGin)!==ALUresult) begin
                $display("ERROR VERIFICAR");  
                $display("Entrada A = %4b - Entrada B = %4b", ALUA, ALUB);
                $display("Salida = %4b", ALUresult);
                $display("Resultado Cero = %0b - Acarreo = %0b", ALUflags[1], ALUflags[0]);
                $display("");
                #3
                $finish;               
                end                
                #3;
            end
            end
            $display("TODAS LAS OPERACIONES RESTA (Acarreo 0) FUERON CORRECTAS");
            $display(""); 
            ALUFLAGin <= 1;
            #3;
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=0; k < 16; k=k+1) begin
                ALUB <= k;
                #3
                if((ALUA - ALUB - ALUFLAGin)!==ALUresult) begin
                $display("ERROR PLEASE VERIFY");
                $display("Entrada A = %4b - Entrada B = %4b", ALUA, ALUB);
                $display("Salida = %4b", ALUresult);
                $display("Resultado Cero = %0b - Acarreo = %0b", ALUflags[1], ALUflags[0]);
                $display("");
                #3
                $finish;                    
                end            
                #3;
            end
            end
            $display("TODAS LAS OPERACIONES RESTA (Acarreo 1) FUERON CORRECTAS");
            $display(""); 
            end
            
        7:   //XOR
            begin
            $display("[%0d", i , "h] Operacion XOR");
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=0; k < 16; k=k+1) begin
                ALUB <= k;
                #3
                if((ALUA^ALUB)!== ALUresult) begin
                $display("ERROR VERIFICAR"); 
                $display("Entrada A = %4b - Entrada B = %4b", ALUA, ALUB);
                $display("Salida = %4b", ALUresult);
                $display("Resultado Cero = %0b", ALUflags[1]);
                $display("");
                #3
                $finish; 
                end     
                end          
                #3;
            end
            $display("TODAS LAS OPERACIONES XOR FUERON CORRECTAS");
            $display(""); 
            end
            
        8:   //Correr izquierda A lleva flagin
            begin
            $display("[%0d", i , "h] Operacion Corrimiento izquierda");
            ALUFLAGin <= 0;
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=1; k < 4; k=k+1) begin
                ALUB <= k;
                #3
                if((ALUA<<ALUB)!==ALUresult) begin
                $display("ERROR VERIFICAR");  
            $display("Entrada A = %4b - Desplaza = %1d - Rellena con = %1b", ALUA, ALUB, ALUFLAGin);
            $display("Salida = %4b - Ultimo bit = %1b", ALUresult, ALUflags[0]);
            $display("Resultado Cero = %0b", ALUflags[1]);
            $display(""); 
                #3
                $finish;               
                end                
                #3;
            end
            end
            $display("TODAS LAS OPERACIONES CORRIMIENTO IZQUIERDA (OPERANDO 0) FUERON CORRECTAS");
            $display(""); 
            ALUFLAGin <= 1;
            #3;
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=1; k < 4; k=k+1) begin
                ALUB <= k;
                #3
                if(ALUresult ==! ((ALUA<<ALUB)|({n{ALUFLAGin}}>>(n-ALUB)))) begin
                $display("ERROR VERIFICAR");  
            $display("Entrada A = %4b - Desplaza = %1d - Rellena con = %1b", ALUA, ALUB, ALUFLAGin);
            $display("Salida = %4b - Ultimo bit = %1b", ALUresult, ALUflags[0]);
            $display("Resultado Cero = %0b", ALUflags[1]);
            $display("");
            #3
            $finish;       
                end                
                #3;
            end
            end
            $display("TODAS LAS OPERACIONES CORRIMIENTO IZQUIERDA (OPERANDO 1) FUERON CORRECTAS");
            $display(""); 
            end
            
        9:   //Correr derecha A lleva flagin
                        begin
            $display("[%0d", i , "h] Operacion Corrimiento derecha");
            ALUFLAGin <= 0;
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=0; k < 16; k=k+1) begin
                ALUB <= k;
                #3
                if(((ALUA>>ALUB)|({n{ALUFLAGin}}<<(n-ALUB)))!==ALUresult) begin
                $display("ERROR VERIFICAR");  
            $display("Entrada A = %4b - Desplaza = %1d - Rellena con = %1b", ALUA, ALUB, ALUFLAGin);
            $display("Salida = %4b - Ultimo bit = %1b", ALUresult, ALUflags[0]);
            $display("Resultado Cero = %0b", ALUflags[1]);
            $display(""); 
                #3
                $finish;               
                end                
                #3;
            end
            end
            $display("TODAS LAS OPERACIONES CORRIMIENTO DERECHA (OPERANDO 0) FUERON CORRECTAS");
            $display(""); 
            ALUFLAGin <= 1;
            #3;
            for (j=0; j < 16; j=j+1) begin
            ALUA <= j;
            #3;
                for (k=1; k < 16; k=k+1) begin
                ALUB <= k;
                #3
                if(ALUresult ==! ((ALUA>>ALUB)|({n{ALUFLAGin}}<<(n-ALUB)))) begin
                $display("ERROR VERIFICAR");  
            $display("Entrada A = %4b - Desplaza = %1d - Rellena con = %1b", ALUA, ALUB, ALUFLAGin);
            $display("Salida = %4b - Ultimo bit = %1b", ALUresult, ALUflags[0]);
            $display("Resultado Cero = %0b", ALUflags[1]);
            $display(""); 
                #3
                $finish;               
                end                
                #3;
            end
            end
            $display("TODAS LAS OPERACIONES CORRIMIENTO DERECHA (OPERANDO 1) FUERON CORRECTAS");
            $display(""); 
            end
      endcase
      end
      #3 $finish;
    end
endmodule