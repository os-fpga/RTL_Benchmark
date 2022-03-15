`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:00:45 08/26/2021 
// Design Name: 
// Module Name:    MCPU8_1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MCPU8_1(input clk , input rst  , output [3:0] PC_OUT , output [3:0] MAR_OUT , output [3:0] IR_OUT1 , output [3:0] IR_OUT2 , output[7:0] DATA_OUT1 , output[3:0] ADDR_OUT1 , output [3:0] COUNT_OUT , output [7:0] ACCUMULATOR_OUT , output [7:0] DATA_OUTPUT , output [7:0] B_REG , output [7:0] ALU_OUT , output [7:0] OR_out , output [17:0] CW, output EP , output CP , output SELECT , output LM , output CE ,output LI , output EI , output CS , output LOAD , output CLR , output INC , output SELECT_ACC , output LA , output EA , output LB , output SU , output EU , output LO);
wire [3:0] IR_OUT_1_w , MUX_IN , PC_OUT_w , MAR_OUT_w , IR_OUT_2_w , MAR_IN_w;
wire [17:0] CW_w;
wire [7:0] DATA_IN_w;
wire[3:0] bus_4;
wire [3:0] bus_4_1;
wire [7:0] bus_8 , bus_8_1 , bus_8_2 , ACC_IN_w;
wire [7:0] ALU_A_w;
wire [7:0] ALU_B_w;
wire EP_w , CP_w , SELECT_w , CS_w , CE_w , LOAD_w , LI_w , LM_w , EI_w , CLR_w , INC_w, SELECT_ACC_w,  LA_w , EA_w , LB_w , SU_w , EU_w , LO_w;
assign EP = EP_w;
assign CP = CP_w;
assign SELECT = SELECT_w;
assign CW = CW_w;
assign LOAD = LOAD_w;
assign CS = CS_w;
assign LI = LI_w;
assign LM = LM_w;
assign CE = CE_w;
assign EI = EI_w;
assign INC = INC_w;
assign CLR = CLR_w;
assign SELECT_ACC = SELECT_ACC_w;
assign LA = LA_w;
assign EA = EA_w;
assign LB = LB_w;
assign SU = SU_w;
assign EU = EU_w;
assign LO = LO_w;
assign DATA_OUT1 = bus_8;
assign IR_OUT1 = IR_OUT_1_w;
assign IR_OUT2 = bus_4_1;
assign ADDR_OUT1 = MUX_IN;
assign PC_OUT = bus_4;
assign MAR_OUT = MAR_OUT_w;
assign ACCUMULATOR_OUT = ALU_A_w;
assign OR_out = bus_8_2;
assign B_REG = bus_8;
assign ALU_OUT = bus_8_1;
PC_4 UUT1 (.clk(clk) , .rst(rst) , .CP(CP_w) , .PC_OUT(PC_OUT_w));
PC_LATCH_4 UUT2(.EP(EP_w) , .PC_IN(PC_OUT_w) , .PC_OUT_FINAL(bus_4));
MAR_MUX UUT3(.a(bus_4) , .b(bus_4_1) , .select(SELECT_w) , .c(MAR_IN_w));
MAR UUT4(.clk(clk) , .LM(LM_w) , .MAR_IN(MAR_IN_w) , .MAR_OUT(MAR_OUT_w));
SRAM_8 UUT5(.clk(clk) , .ADDR(MAR_OUT_w) , .CE(CE_w) ,.DATA_OUT(bus_8)); 
IR_8 UUT6(.clk(clk) , .rst(rst) , .LI(LI_w) , .EI(EI_w) ,.DATA_IN(bus_8) , .IR_OUT_1(IR_OUT_1_w) , .IR_OUT_2(bus_4_1));
ADDR_ROM UUT7(.CS(CS_w) , .ADDR(IR_OUT_1_w) , .ADDR_OUT(MUX_IN));
PRESET_COUNT UUT8(.clk(clk) , .rst(rst) , .LOAD(LOAD_w) , .CLR(CLR_w) ,  .INC(INC_w) ,  .COUNT_IN(MUX_IN) , .COUNT_OUT(COUNT_OUT));
CONTROL_ROM UUT9(.ADDR_IN(COUNT_OUT) , .CW(CW_w));
MICRO_DECODER UUT10(.CW(CW_w) , .EP(EP_w) , .CP(CP_w) , .SELECT(SELECT_w) , .LM(LM_w) ,.CE(CE_w), .LI(LI_w) , .EI(EI_w) , .CS(CS_w) ,  .LOAD(LOAD_w) , .CLR(CLR_w) , .INC(INC_w) , .SELECT_ACC(SELECT_ACC_w) , .LA(LA_w) , .EA(EA_w) , .LB(LB_w) , .SU(SU_w) , .EU(EU_w) , .LO(LO_w));
ACC_8_MUX UUT11(.a(bus_8) , . b(bus_8_1) , .SELECT_ACC(SELECT_ACC_w) , .ACC_INPUT(ACC_IN_w));
ACC_8 UUT12(.clk(clk) , .ACC_IN(ACC_IN_w) , .LA(LA_w) , .EA(EA_w) , .ACC_OUT_ALU(ALU_A_w) , .ACC_OUT_BUS(bus_8_2));
B_REG_8 UUT13(.clk(clk) , .LB(LB_w) , .B_IN(bus_8) , .B_OUT(ALU_B_w));
OUT_REG_8 UUT14(.clk(clk) , .OUT_IN(bus_8_2) , .LO(LO_w) , .OUT_P(DATA_OUTPUT));
ALU_8 UUT15(.ALU_A(ALU_A_w) ,.ALU_B(ALU_B_w) ,.SU(SU_w) , .EU(EU_w) ,.ALU_OUT(bus_8_1));
endmodule

module PC_4(input clk , input rst , input CP , output [3:0] PC_OUT);
reg [3:0] PC_OUT_r;
assign PC_OUT = PC_OUT_r;
always@(posedge clk or posedge rst)
begin
if(rst)
PC_OUT_r <= 4'b0000;
else if(CP)
PC_OUT_r <= PC_OUT_r + 1'b1;
end
endmodule

module PC_LATCH_4(input EP ,  input [3:0] PC_IN , output [3:0] PC_OUT_FINAL);
reg[3:0] PC_r;
assign PC_OUT_FINAL = PC_r;
always@(EP)
begin
PC_r <= PC_IN;
end
endmodule

module MAR_MUX (input[3:0] a , input[3:0] b , input select , output [3:0] c);
assign c = select ? a : b;
endmodule

module MAR(input clk , input LM , input [3:0] MAR_IN , output [3:0] MAR_OUT);
reg[3:0]MAR_r;
assign MAR_OUT = MAR_r;
always@(posedge clk)
begin
if(~LM)
MAR_r <= MAR_IN;
end
endmodule

module SRAM_8(input clk , input [3:0] ADDR , input CE , output[7:0] DATA_OUT);
reg [7:0] SRAM [15:0] ;// A SRAM with 16 locations with each location capable of holding 8-bit of DATA
assign DATA_OUT = (~CE) ? SRAM[ADDR] : 8'h00;
always@(posedge clk)
begin
SRAM[0] <= 8'b00001001; //LDA 09 instruction - Load the contents of memory location 09 into the accumulator
SRAM[1] <= 8'b00011010; // ADD 0A instruction - Add the contents of Accumulator with the contents of memory location 0A and store the result in Accumulator
SRAM[2] <= 8'b00011011; // ADD 0B instruction - Add the contents of Accumulator that is obtained from previous instruction with the contents of memory location 0B and store the result in Accumulator
SRAM[3] <= 8'b0010xxxx; // OUT instruction - To output the content of accumulator that is obtained from previous subtraction operation
SRAM[4] <= 8'b1111xxxx; // HLT instruction - To stop the execution of instructions
SRAM[5] <= 8'b11111111; // Unused memory locations are filled with FF
SRAM[6] <= 8'b11111111; // Unused memory locations are filled with FF
SRAM[7] <= 8'b11111111; //Unused memory locations are filled with FF
SRAM[8] <= 8'b11111111; // Unused memory locations are filled with FF
SRAM[9] <= 8'b00000001; // 01H is the 8-bit value stored in the location 09
SRAM[10]<= 8'b00000010; // 02H is the 8-bit value stored in the location 0A
SRAM[11]<= 8'b00000011; // 03H is the 8-bit value stored in the location 0B
SRAM[12]<= 8'b11111111; // Unused memory locations are filled with FF
SRAM[13]<= 8'b11111111; // Unused memory locations are filled with FF
SRAM[14]<= 8'b11111111; // Unused memory locations are filled with FF
SRAM[15]<= 8'b11111111; // Unused memory locations are filled with FF
end
endmodule

module IR_8 (input clk , input rst , input LI , input EI,  input [7:0] DATA_IN , output[3:0] IR_OUT_1 , output [3:0] IR_OUT_2);
reg [7:0] IR_r;
assign IR_OUT_1 = IR_r[7:4];
assign IR_OUT_2 = EI ? IR_r[3:0] : 4'h0;
always@(posedge clk or posedge rst)
begin
if(rst)
IR_r <= 8'h00;
else if(~LI)
IR_r <= DATA_IN;
end
endmodule

module ADDR_ROM(input CS , input[3:0] ADDR , output[3:0] ADDR_OUT);
reg [3:0] AR [15:0];
assign ADDR_OUT = CS ? AR[ADDR] : 4'h0;
always @(ADDR)
begin
AR[0] <= 4'b0100;
AR[1] <= 4'b0111;
AR[2] <= 4'b1011;
AR[3] <= 4'b1110;
AR[4] <= 4'bxxxx;
AR[5] <= 4'bxxxx;
AR[6] <= 4'bxxxx;
AR[7] <= 4'bxxxx;
AR[8] <= 4'bxxxx;
AR[9] <= 4'bxxxx;
AR[10] <= 4'bxxxx;
AR[11] <= 4'bxxxx;
AR[12] <= 4'bxxxx;
AR[13] <= 4'bxxxx;
AR[14] <= 4'bxxxx;
AR[15] <= 4'bxxxx;
end
endmodule


module PRESET_COUNT(input clk , input rst , input INC , input CLR , input LOAD , input [3:0] COUNT_IN , output [3:0] COUNT_OUT); // Micro-Routine Program Counter
reg [3:0] COUNT_OUT_r;
assign COUNT_OUT = COUNT_OUT_r;
always@(posedge clk or posedge rst)
begin
if(rst)
COUNT_OUT_r <= 4'b0000;
else if(LOAD)
COUNT_OUT_r <= COUNT_IN;
else if(INC) // Always associate a signal that must occur along with CLOCK EDGE , for an operation to be done. This is the correct way.
COUNT_OUT_r <= COUNT_OUT_r + 1'b1;
else if(CLR)
COUNT_OUT_r <= COUNT_IN;
end
endmodule

module CONTROL_ROM(input [3:0] ADDR_IN , output [17:0] CW);
reg [17:0] CR [18:0];
assign CW = CR[ADDR_IN];
always@(ADDR_IN)
begin
// Fetch Micro-routine
CR[0] <= 18'b101111000010100011; // EP and INC signals active
CR[1] <= 18'b011011000010100011; // CP , LM and INC signals active
CR[2] <= 18'b001100000010100011; // CE , LI  and INC signals active
CR[3] <= 18'b000111111000100011; // EI , LOAD signals active
// LDA Micro-routine
CR[4] <= 18'b000011100010100011; // LM , EI , and INC active
CR[5] <= 18'b000101000011000011; // CE and LA , INC active 
CR[6] <= 18'b000111000101100011; // CLR signal active
// ADD Micro-routine
CR[7] <= 18'b000011100010100011;
CR[8] <= 18'b000101000010100001;
CR[9] <= 18'b000111000010000111;
CR[10] <= 18'b000111000100100011;
// SUB Micro-routine
//CR[11] <= 18'b000011100010100011;
//CR[12] <= 18'b000101000010100001;
//CR[13] <= 18'b000111000010001111;
//CR[14] <= 18'b000111000100100011;
// OUT Micro-routine
CR[11] <= 18'b000011100010100011;
CR[12] <= 18'b000111000010110010;
CR[13] <= 18'b000111000100100011;
// HLT Micro-routine
CR[14] <= 18'b0000111000000100011;
end
endmodule

module MICRO_DECODER(input [17:0] CW , output EP , CP , SELECT , LM ,  CE , LI , EI , CS , LOAD , CLR , INC , SELECT_ACC, LA , EA , LB , SU , EU , LO);
assign EP = CW[17];
assign CP = CW[16];
assign SELECT = CW[15];
assign LM = CW[14];
assign CE = CW[13];
assign LI = CW[12];
assign EI = CW[11];
assign CS = CW[10];
assign LOAD = CW[9];
assign CLR = CW[8];
assign INC = CW[7];
assign SELECT_ACC = CW[6];
assign LA = CW[5];
assign EA = CW[4];
assign SU = CW[3];
assign EU = CW[2];
assign LB = CW[1];
assign LO = CW[0];
endmodule

module ACC_8_MUX(input[7:0] a , input [7:0] b , input SELECT_ACC , output[7:0] ACC_INPUT);
assign ACC_INPUT = SELECT_ACC ? a : b;
endmodule

module ACC_8(input clk , input [7:0] ACC_IN  , input LA , input EA , output [7:0] ACC_OUT_ALU , output[7:0] ACC_OUT_BUS);
reg [7:0] ACC_OUT_r;
assign ACC_OUT_ALU = ACC_OUT_r;
assign ACC_OUT_BUS = EA ? ACC_OUT_r : 8'h00;
always@(posedge clk)
begin
if(~LA)
ACC_OUT_r <= ACC_IN;
end
endmodule

module B_REG_8(input clk , input [7:0] B_IN  , input LB , output [7:0] B_OUT);
reg [7:0] B_OUT_r;
assign B_OUT = B_OUT_r;
always@(posedge clk)
begin
if(~LB)
B_OUT_r <= B_IN;
end
endmodule

module OUT_REG_8(input clk , input [7:0] OUT_IN  , input LO , output [7:0]OUT_P );
reg [7:0] OUT_P_r;
assign OUT_P = OUT_P_r;
always@(posedge clk)
begin
if(~LO)
OUT_P_r<= OUT_IN;
end
endmodule

module ALU_8(input[7:0] ALU_A ,  input [7:0] ALU_B  , input SU , input EU ,  output [7:0]ALU_OUT);
wire [7:0] ALU_OUT_w;
assign ALU_OUT_w = SU ? ALU_A - ALU_B : ALU_A + ALU_B ;
assign ALU_OUT = EU ? ALU_OUT_w : 8'h00;
endmodule

