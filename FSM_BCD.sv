`timescale 1ns / 1ps



module FSM_BCD #(parameter i=3)(
    input  logic rst_i,
    input  logic clk_i,
    input logic data_ready,
    input logic [23:0]entrada,
    output logic [7:0] salida,
    output logic we_i,
    output logic reg_sel_i,
    output logic more_data
    );
logic [23:0] dato;
logic [1:0] contador;
    typedef enum {
    estado1,
    estado2,
    estado3,
    estado4,
    estado5,
    estado6     } state;
    state current_state, next_state;
    
always_ff @(posedge clk_i)begin
    if(rst_i)begin
        current_state <= estado1;
    end
    else begin
        current_state <= next_state;
    end
end

always_comb begin
    contador=0;
    we_i=0;
    reg_sel_i=0;
    more_data=0;
    
    next_state = current_state;
    case(current_state)
    estado1: begin
        if (data_ready== 1'b1) begin
            dato = entrada;
            we_i = 0;
            reg_sel_i = 1;
            next_state = estado2; end
        else
        next_state = estado1;
    end
    estado2: begin
        if(contador <= i) begin
            contador = contador +1;
            salida = dato[23:16];
            we_i = 1;
            next_state = estado3; end
        else
        next_state = estado5;
    end
    estado3: begin
        if(contador <= i) begin
            we_i = 0;
            reg_sel_i = 0;
            dato = dato << 8;
            salida[0] = 1;  
            next_state = estado4; end
            else
            next_state = estado5;
    end
    estado4: begin
        if(contador <= i) begin
        we_i = 1;
        next_state = estado2;
        end
        else
        next_state = estado5;
    end
    estado5: begin
        we_i = 0;
        next_state = estado2;

    end
    estado6: begin
        more_data = 1;
        contador = 0;
        next_state = estado1;

    end
    endcase
end
 
    
endmodule
