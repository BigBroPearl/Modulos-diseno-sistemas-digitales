`timescale 1ns / 1ps

module Clock_Divider 
    #(
        parameter DIVISOR = 28'd10000
    )
    (
    input logic clock_in,
    output logic clock_out
    );

    reg[27:0] counter=28'd0;
    

    always @(posedge clock_in) begin
     counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
        counter <= 28'd0;
     clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule