module fsm_tx(
    input  logic        rst_i,
    input  logic        clk_i,
    input  logic        tx_rdy,
    input  logic        in1,        //numero que envia el boton al reg de control

    output logic        clear_send_i,
    output logic        tx_start   //tx para el send de la transmici?n
);
    
typedef enum {
    estado1,  //Esperando send
    estado1_1,
    estado2,  //Escribir en el registro de control el send    
    estado3  //leer dato
} state;    
              
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
    clear_send_i = 0;
    tx_start     = 0;
    case(current_state)
        estado1: begin //esperar send
            clear_send_i = 0;
            tx_start     = 0;
            if (in1== 1'b1) next_state = estado1_1;
            else next_state = estado1;
        end
        
        estado1_1: begin
            clear_send_i = 0;
            tx_start     = 1;
            next_state = estado2;
        end
        
        estado2: begin
            if (tx_rdy) begin
                next_state = estado3;
                clear_send_i = 1;
                tx_start     = 0;
            end
            else begin
                clear_send_i = 0;
                tx_start     = 1;
                next_state = estado2;
            end
        end
        
        estado3: begin
            clear_send_i = 1;
            tx_start     = 0;
            next_state = estado1;
        end
    endcase 
end   
endmodule
