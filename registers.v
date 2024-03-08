module Register(
    input clk,      // Clock input
    input rst,      // Reset input
    input [4:0] read_reg_1,
    input [4:0] read_reg_2,
    input [1:0] write_reg,
    input [7:0] write_data,
    output reg [4:0] read_data_1,
    output reg [4:0] read_data_2
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
        if (write_reg != 2'b00) // Write only when write_reg is not 00
            reg_file[write_reg] <= write_data;
    end
end
