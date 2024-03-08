module Register(parameter register_number=6)(parameter ancho_dato=32))(
    input clk,      // Clock input
    input rst,      // Reset input
    input [register_number-1:0] read_reg_1,
    input [register_number-1:0] read_reg_2,
    input write_reg,
    input [ancho_dato-1:0] write_data,
    output reg [ancho_dato-1:0] read_data_1,
    output reg [ancho_dato-1:0] read_data_2
);

// Almacenamiento
reg [7:0] reg_file [1:0];

// Lógica síncrona para escribir y leer
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // reset
        reg_file[0] <= 8'b0;
        reg_file[1] <= 8'b0;
    end else begin
        // Lectura de datos en base a read_reg
        read_data_1 <= reg_file[read_reg_1];
        read_data_2 <= reg_file[read_reg_2];

        //Escritura en base a la instrucción write_reg
        if (write_reg != 1'b0) // escribir solo cuando write no sea 00
            reg_file[write_reg] <= write_data;
    end
end

endmodule
