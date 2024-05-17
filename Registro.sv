`timescale 1ns / 1ps

module register #(parameter N = 16) 
    (
        input logic         clk_i,
        input logic         en_i,
        input logic         en_s,
        input logic [N-1:0] data_i,
        input logic         rst_i,

        output logic [N-1:0] data_o
    );

    always@(posedge clk_i)begin
        if (~rst_i)
            data_o <=16'd0;
        else if(en_i&en_s)
            data_o<=data_i;

    end

endmodule