module registro_datos #(parameter ANCHO = 32, parameter SEL = 2)(
    input  logic                       clk, //clock de 100MHz de entrada
    input  logic                       rst_i, //reset
    input  logic [SEL-1  :0]           we_i,  //write enable 
    input logic                        addr_i,
    input  logic [ANCHO-1:0]           entrada_i,    //entrada  
    input  logic [ANCHO-1:0]           entrada2_i,    //entrada2                     
    output logic [SEL-1:0] [ANCHO-1:0] out_o
);

logic [SEL-1:0] [ANCHO-1:0]  regfile;
integer i;
   
assign out_o[0] = ~addr_i ? regfile[0] : 0;
assign out_o[1] =  addr_i ? regfile[1] : 0;
 
always_ff @(posedge clk) begin
    if(rst_i) begin
        for (i = 0; i < SEL; i = i+1) 
            regfile[i] <= 0;       
        end
        
        else begin
            if (we_i[1]) regfile[1] <= {24'b0,entrada2_i[7:0]}; 
            else         regfile[1] <= {24'b0,regfile[1][7:0]};
            case (addr_i) 
                1'b0:
                    if (we_i[0]) regfile[0] <= {24'b0,entrada_i[7:0]}; 
                    else         regfile[0] <= {24'b0,regfile[0][7:0]};                            
            endcase
        end
end
endmodule
