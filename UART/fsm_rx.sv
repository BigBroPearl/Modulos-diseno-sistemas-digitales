module fsm_rx(
    input  logic rst_i,
    input  logic clk_i,
    input  logic rx_data_rdy_i,//rx cuando ya est? listo 
    
    output logic we_o,       //Write de los registros
    output logic set_new_o      //numero para el registro de control. New
    ); 

typedef enum {
    estado1, //Estado inicial. Todo en 0, esperar new_rx
    estado2, //Estado para meter dato 
    estado3, //Estado para el control 
    estado4
} state;
              
state current_state, next_state;

always_ff @(posedge clk_i) begin
    if(rst_i) current_state <= estado1;
    else      current_state <= next_state;
end

always_comb begin
    set_new_o = 0;
    we_o      = 0;     
    case(current_state)
        estado1: begin
            set_new_o = 0;
            we_o      = 0;
            if (rx_data_rdy_i) next_state = estado2;
            else               next_state = estado1;
        end
        
        estado2: begin
            if (rx_data_rdy_i) begin
                set_new_o = 0;
                we_o      = 0;
                next_state = estado2;
            end
            else next_state <= estado3;
        end
        
        estado3: begin        //activar el wr para el registro de datos
            set_new_o = 0;
            we_o      = 1;       //Write de los registros
            next_state = estado4;
        end

        estado4: begin             //levantar el new
            set_new_o = 1;
            we_o      = 1;
            next_state = estado1;
        end
    endcase 
end   
endmodule