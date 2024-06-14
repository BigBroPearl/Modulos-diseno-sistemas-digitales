module mux( 
	input  logic 	    reg_sel_i, //registro de selección
	input  logic [31:0] outc_i, //entrada que viene del registro de control
	input  logic [31:0] outd_i, //entrada que viene del registro de datos
	output logic [31:0] salida_o //salida del multiplexor
);

assign salida_o = reg_sel_i ? outd_i : outc_i; //dependiendo del valor de selección, la salida es el registro de control o datos

endmodule