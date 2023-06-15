// full RTL behavioral code for memory. hernan m2000 july 2008
//======================================================

//`include "timescale.v"
//`include "defines.v"

//*************************************************
// Module Definition
//*************************************************


module memory (DATI,
    ADR,
    WE,
    CE,
    CLK,
    SEL,
    DATO);
    parameter d_width = 32;
    parameter a_width = 14;
    input [d_width-1:0] DATI;
    input [a_width-1:0] ADR;
    input WE, CLK,CE;
    input [3:0] SEL;
    output [d_width-1:0] DATO;
    reg [d_width-1:0] DATO;
    reg [d_width-1:0] mem [(1<<a_width)-1:0];
    reg [a_width-1:0] ADR_save;
    reg [a_width-1:0] ADR_save_2;

    reg WE_save;
    reg CE_save;
    reg [d_width-1:0] DATI_save;
    
    always @(posedge CLK) begin
            CE_save <= CE;
            WE_save <= WE;
            ADR_save <= ADR;
            ADR_save_2 <= ADR_save;            
    end
    
    always @(posedge CLK)
    begin
        if(CE_save)
            if (WE_save)
                mem[ADR_save_2] <= DATI_save;
    end
    always @(posedge CLK) begin
        if(CE_save)
            DATO <= mem[ADR_save_2];
    end
    always @(posedge CLK) begin
        if(CE_save & WE_save) begin
            case (1'b1) // synthesis parallel_case full_case
                SEL[0]: DATI_save[7:0] <= DATI[7:0];
                SEL[1]:  DATI_save[15:8] <= DATI[15:8];
                SEL[2]:  DATI_save[23:16] <= DATI[23:16];
                SEL[3]:  DATI_save[31:24] <= DATI[31:24];
            endcase
        end
    end
    
endmodule
    
    
   

