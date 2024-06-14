module registro_control #(parameter ANCHO = 32)(
    input  logic             clk_i,
    input  logic             rst_i,
    input  logic [ANCHO-1:0] in_i,
    input  logic             wr_i,
    input logic              clear_send_i,
    input logic              set_new_i,
    output logic [ANCHO-1:0] out_o
);
    
always_ff @(posedge clk_i) begin
    out_o[31:2]<=0;
    if (wr_i)     out_o<= in_i;
    else if (rst_i) out_o <=0;
    else begin
        if(clear_send_i) out_o[0]<=0;
        if(set_new_i)    out_o[1]<=1;
    end 
end    
endmodule
