module top_control(
    input logic         clk_i,
    input logic         reset_i,
    input logic         we_pi,
    input logic  [31:0] address,
    input logic  [31:0] entrada_pi,
    output logic [31:0] salida_po,
    input logic         rx, //Entrada del dispositivo externo 
    output logic        tx
);
wire reg_sel_pi, addr_i;
assign addr_i=address[2];
assign reg_sel_pi=address[3];

//Variables internas
//demux
logic [1:0]         wr_reg;
//mux
//registro de datos
logic [31:0]        entrada2_i;     //numero externo
logic [1:0] [31:0] out_o;
//registro de control
logic               wr1;
logic [31:0]        salida_control;
//UART
logic               tx_start;           //tx que se activa en la maquina de estados con el boton  
logic               rx_data_rdy;        //Flanco que indica que la transferencia par�
logic               tx_rdy;
//FSM       
logic               clear_send_i;
logic               set_new_i; 
/////////////////////////////////////////////////////////////////////////////////
assign entrada2_i     [31:8] = 0;
//clk_wiz_0 clk_wiz_0(
//    .clk_out1(clk_o),
//    .clk_in1 (clk_i)
//);
demux demux (
    .wr_i     (we_pi),
    .reg_sel_i(reg_sel_pi),        //Selector de registros
    .wr1c_o   (wr1),           //Write para el registro de control 
    .wr1d_o   (wr_reg[0])        //Write para el registro de datos
);
mux mux (
    .reg_sel_i(reg_sel_pi),
    .outc_i   (salida_control),  //salida del registro de control
    .outd_i   (out_o[addr_i]),     //salida del registro de datos **Ver lo de los datos
    .salida_o (salida_po)              //Salida a los leds
); 
registro_datos registro_datos (
    .clk       (clk_i),
    .rst_i     (reset_i),
    .we_i      (wr_reg),           //Write viene del demux y rx 
    .addr_i    (addr_i),         //viene de switches
    .entrada_i (entrada_pi),  //entrada switches
    .entrada2_i(entrada2_i), //entrada en paralelo del uart
    .out_o     (out_o)            //salida para el mux
);
registro_control registro_control (
    .clk_i       (clk_i),
    .rst_i       (reset_i),
    .in_i        (entrada_pi),          //numero para el send
    .wr_i        (wr1),                 //Write proviede del demux
    .clear_send_i(clear_send_i),
    .set_new_i   (set_new_i),
    .out_o       (salida_control)      //salida para el mux
);
UART uart (
    .clk(clk_i),
    .reset(reset_i),
    .tx_start(tx_start),
    .tx_rdy(tx_rdy),
    .rx_data_rdy(rx_data_rdy),  
    .data_in(out_o[0][7:0]),
    .data_out(entrada2_i[7:0]),
    .rx(rx),
    .tx(tx)
);
fsm_tx fsmtx(
    .rst_i(reset_i),
    .clk_i(clk_i),
    .in1(salida_control[0]),    //numero que lee del reg de control
    .tx_rdy(tx_rdy),
    .tx_start(tx_start),        //tx para el send de la transmici?n
    .clear_send_i(clear_send_i)
    );
fsm_rx fsmrx(
    .rst_i(reset_i),
    .clk_i(clk_i),
    .rx_data_rdy_i(rx_data_rdy), //rx cuando ya est? listo 
    .we_o(wr_reg[1]),          //Write de los registros
    .set_new_o(set_new_i)
);
endmodule
