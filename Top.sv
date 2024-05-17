`timescale 1ns / 1ps

module top
    #(
        parameter   UN_KHZ = 28'd10_000,
                    DOS_SEG = 28'd20_000_000,
                    UN_SEG = 28'd10_000_000,
                    MEDIO_SEG = 28'd5_000_000
    )                       
    (
        input logic                 sysclk_pi,
        input logic  [15:0]         ent_pi,
    
    
        
        output logic [3:0]          anodos_po,
        output logic [15:0]         led,
        output logic [6:0]          segmento_po
    
        );
    
        logic           CLK_10MHZ;
        logic           CLK_1KHZ;
        logic           CLK_1HZ;
        logic           CLK_05HZ;
        logic           CLK_2HZ;
        logic           CLK_SEL;
        logic [15:0]    LFSR_Data; 
        logic           LFSR_Done;
        logic [15:0]    reg1;
        logic [15:0]    reg2;
        logic [15:0]    reg_display;
        logic           counter = 1'b0;
        
        assign led[14] = ~ent_pi[1];
        assign led[15] = ent_pi[1];
        assign led[0] = ~ent_pi[4]&~ent_pi[3];
        assign led[1] = ~ent_pi[4]&ent_pi[3];
        assign led[2] = ent_pi[4]&~ent_pi[3];
        assign led[3] = ent_pi[4]&ent_pi[3];
        
        clk_wiz_0 Reloj
        (
            .clk_out1      (CLK_10MHZ),     
            .clk_in1        (sysclk_pi)
        ); 
    
        Clock_Divider #(.DIVISOR(UN_KHZ)) DivClk_1khz
        (
            .clock_in       (CLK_10MHZ),
            .clock_out      (CLK_1KHZ)
        );
        
        Clock_Divider #(.DIVISOR(DOS_SEG)) DivClk_2seg
        (
            .clock_in       (CLK_10MHZ),
            .clock_out      (CLK_05HZ)
        );
        
        Clock_Divider #(.DIVISOR(UN_SEG)) DivClk_1seg
        (
            .clock_in       (CLK_10MHZ),
            .clock_out      (CLK_1HZ)
        );
        
        Clock_Divider #(.DIVISOR(MEDIO_SEG)) DivClk_2hz
        (
            .clock_in       (CLK_10MHZ),
            .clock_out      (CLK_2HZ)
        );
        
        LFSR RNG
        (
            .i_Clk          (CLK_10MHZ),
            .i_Rst          (ent_pi[0]),
            .i_Enable       (CLK_05HZ),
            .i_Seed_Data    (16'b0000000000000000),
            .o_LFSR_Data    (LFSR_Data),
            .o_LFSR_Done    (LFSR_Done)
        );
        
 
            register register1
                (
                .clk_i          (CLK_10MHZ),
                .rst_i          (ent_pi[0]),
                .en_i           (ent_pi[2]),
                .en_s           (~ent_pi[1]),
                .data_i         (LFSR_Data),
                .data_o         (reg1)           
            
                );

            register register2
                (
                .clk_i          (CLK_10MHZ),
                .rst_i          (ent_pi[0]),
                .en_i           (ent_pi[2]),
                .en_s           (ent_pi[1]),
                .data_i         (LFSR_Data),
                .data_o         (reg2)           
            
                );

        
        always @(*) begin
            case(ent_pi[4:3])
                2'b00: CLK_SEL = 1'b0;
                2'b01: CLK_SEL = CLK_05HZ;
                2'b10: CLK_SEL = CLK_1HZ;
                2'b11: CLK_SEL = CLK_2HZ;
                endcase
            end
        
        always@(posedge CLK_SEL)
            counter <= counter + 1'b1;

        always_comb begin
            case(counter)
                1'b0: reg_display = reg1;
                1'b1: reg_display = reg2;
                endcase
            end
                
        display_7seg Disp_7seg
            (
            .clk_i     (CLK_1KHZ),
            .data_i    (reg_display),
            .an_o      (anodos_po[3:0]),
            .seg_o     (segmento_po)
            );    
        
endmodule