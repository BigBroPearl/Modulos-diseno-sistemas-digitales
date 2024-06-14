module demux(
	input  logic wr_i, //entrada de escritura
	input  logic reg_sel_i, //seleccion de registro
	output logic wr1c_o, //salida de habilitacion de escritura del registro de control
	output logic wr1d_o  //salida de habilitacion de escritura del registro de datos
);

assign wr1c_o = (reg_sel_i == 1'b0) ? wr_i : 1'b0; //solo si la seleccion del registro es 0, habilita la escritura del registro de control 
assign wr1d_o = (reg_sel_i == 1'b1) ? wr_i : 1'b0; //solo si la seleccion del registro es 1, habilita la escritura del registro de datos 

endmodule
