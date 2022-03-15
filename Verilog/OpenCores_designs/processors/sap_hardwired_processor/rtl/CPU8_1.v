`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:57:26 08/26/2021 
// Design Name: 
// Module Name:    CPU8_1 
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
module CPU8_1(input clk , input rst , output [3:0] PC_OUT , output[5:0] T ,output [3:0] ADDR_out , output [7:0] DATA_OUT_1 , output [3:0] IR_OUT_w1 , output [3:0] IR_OUT_w2 , output [7:0] ALU_out , output LDA , output ADD , output SUB , output OUT , output HLT , output[7:0] DATA_OUT , output [7:0] ACC_OUT , output CP , output EP , output LM , output CE , output LI , output EI , output LA , output EA , output SU , output EU , output LB , output LO , output NOP);
wire CP_w , EP_w , LM_w , CE_w , LI_w , EI_w , LA_w , EA_w , SU_w , EU_w , LB_w , LO_w , NOP_w;
wire [3:0] ADDR_out_w , IR_OUT_1_w , IR_OUT_2_w;
wire [7:0] ALU_OUT_w , DATA_OUT_w1;
wire LDA_w1 , ADD_w2 , SUB_w3 , OUT_w4 , HLT_w5;
wire [3:0] bus_4;
wire [7:0] bus_8;
wire [7:0] bus_8_1;
wire [5:0] T_w;
wire [7:0] OR_w;
wire [7:0] ALU_A_w;
wire [7:0] ALU_B_w; 
wire [7:0] ACC_OUT_w;
assign PC_OUT = bus_4;
assign ADDR_out = ADDR_out_w;
assign IR_OUT_w1 = IR_OUT_1_w;
assign IR_OUT_w2 = bus_4;
assign T = T_w;
assign DATA_OUT_1 = bus_8;
assign ALU_out = bus_8_1;
assign DATA_OUT = DATA_OUT_w1;
assign ACC_OUT = ALU_A_w;
assign LDA = LDA_w1;
assign ADD = ADD_w2;
assign SUB = SUB_w3;
assign OUT = OUT_w4;
assign HLT = HLT_w5;
assign CP = CP_w;
assign EP = EP_w;
assign LM = LM_w;
assign CE = CE_w;
assign LI = LI_w;
assign EI = EI_w;
assign LA = LA_w;
assign EA = EA_w;
assign SU = SU_w;
assign EU = EU_w;
assign LB = LB_w;
assign LO = LO_w;
assign NOP = NOP_w;
RC_6 UUT1(.clk(clk) , .rst(rst) , .NOP(NOP_w) , .HLT(HLT_w5), .OUT(T_w));
CU_8 UUT2 (.LDA(LDA_w1) , .ADD(ADD_w2) , .SUB(SUB_w3) , .OUT(OUT_w4) ,.T(T_w) , .CP(CP_w) , .EP(EP_w) , .LM(LM_w) , .CE(CE_w) , .LI(LI_w) , .EI(EI_w) , .LA(LA_w) , .EA(EA_w) , .SU(SU_w) , .EU(EU_w) , .LB(LB_w) , .LO(LO_w) , .NOP(NOP_w));
PC_4 UUT3(.clk(clk) ,.rst(rst) , .CP(CP_w) , .EP(EP_w) , .PC_OUT(bus_4));
MAR_4 UUT4(.clk(clk) , .LM(LM_w) , .ADDR(bus_4),.ADDR_out(ADDR_out_w));
SRAM_8 UUT5(.clk(clk) , .ADDR(ADDR_out_w) , .CE(CE_w) , .DATA_OUT(bus_8));
IR_8 UUT6(.clk(clk) , .rst(rst) , .LI(LI_w) , .EI(EI_w) , .IR_IN(bus_8) , .IR_OUT_1(IR_OUT_1_w) , .IR_OUT_2(bus_4));
ID_8 UUT7(.INSTR(IR_OUT_1_w) , .LDA(LDA_w1) , .ADD(ADD_w2) , .SUB(SUB_w3) , .OUT(OUT_w4) , .HLT(HLT_w5));
ACC_8 UUT8(.clk(clk) , .LA(LA_w) , .EA(EA_w) , .ACC_IN(bus_8 | bus_8_1) , .ACC_OUT_ALU(ALU_A_w) , .ACC_OUT_W_BUS(OR_w));
ALU8_1 UUT9(.A(ALU_A_w) , .B(ALU_B_w) , .SU(SU_w) , .EU(EU_w) , .ALU_OUT(bus_8_1));
B_REG_1 UUT10(.clk(clk) , .DATA_IN(bus_8) , .LB(LB_w) , .DATA_OUT(ALU_B_w));
OR_1 UUT11(.clk(clk) , .DATA_IN(OR_w) , .LO(LO_w) , .DATA_OUT(DATA_OUT_w1));
endmodule

module PC_4(input clk , input rst , input CP , input EP , output[3:0] PC_OUT); // Module 1//
reg [3:0] PC_OUT_r;
assign PC_OUT = EP ? PC_OUT_r : 4'hZ; 
always@(posedge clk or posedge rst)
begin
if(rst)
PC_OUT_r <= 4'h0;
else if(CP)
PC_OUT_r <= PC_OUT_r + 1'b1;
end
endmodule

module MAR_4(input clk , input LM,input[3:0] ADDR,output[3:0] ADDR_out);
reg [3:0] ADDR_r;
assign ADDR_out = ADDR_r;
always@(posedge clk)
begin
if(~LM)
ADDR_r <= ADDR;
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
SRAM[3] <= 8'b00101011; // SUB 0B instruction - Subtract the contents of Accumulator that is obtained from previous instruction with the contents of memory location 0C and store the result in Accumulator
SRAM[4] <= 8'b11100000; // OUT instruction - To output the content of accumulator that is obtained from previous subtraction operation
SRAM[5] <= 8'b11110000; // HLT instruction - To stop the execution of instructions
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

module IR_8(input clk, input rst , input LI,input EI,input [7:0] IR_IN,output [3:0] IR_OUT_1,output [3:0] IR_OUT_2);
reg [7:0] IR_r ; // General way of declaring a register datatype is : reg [DATA_WIDTH-1:0] reg_name [DEPTH-1:0] ; DEPTH - number of registers , DATA_WIDTH - Data occupancy capacity of each register. The DATA-WIDTH and DEPTH are required when creating a memory. Otherwise both of them are mutually optional
//reg [7:0] AR; // AR is a single register of 8-bit in width
// reg AR[7:0] ; // AR is a memory [group of 8 1-bit registers].
//reg [7:0] AR [7:0] ; // AR is a memory consisting of 8-registers , with each register capable of holding 8-bit value//
assign IR_OUT_1 = IR_r[7:4]; //Opcode or Instruction Field given to Controller or Sequencer
assign IR_OUT_2 = (~EI) ? IR_r[3:0] : 4'hZ; // Address Field of IR.
// Any component whose output is connected to a bus , must have a tristate input control associated with it. Only when the tristate input control is activated , the output must be available on the bus. Otherwise it must be tri-stated[All 1s which indicate neither Logic 0 nor Logic 1 voltage levels]
always@(posedge clk or posedge rst)
begin
if(rst)
IR_r <= 8'h00;
else if(~LI)
IR_r <= IR_IN;
end
endmodule

module RC_6(input clk,input NOP , input HLT , input rst , output [5:0] OUT); // Also called as ONE HOT-STATE COUNTER ; Generates 6 States.
reg [5:0] OUT_r;
integer i;
assign OUT = OUT_r;
always@(posedge clk or posedge rst)
begin
if(rst)
OUT_r <= 6'b000001;
else if(NOP)
OUT_r <= 6'b000001;
else if(HLT)
OUT_r <= 6'b000000;
else
begin
OUT_r[0] <= OUT_r[5];
// Most Significant bit or Left Most bit is 5 ; Least Significant bit or Right Most bit is 0 ; The 1[Hot State] travels from Left to Right. The content of Lsb is fed to Msb.
for(i = 0 ; i < 5 ; i = i + 1) // This for LOOP Travels from RIGHT MOST BIT to LEFT MOST BIT. During this process, the contents of a LEFT BIT[ at index "i+1"] is assigned to a RIGHT BIT[ at index i]
begin
OUT_r[i+1] <= OUT_r[i];
end
end
end
endmodule

module ID_8(input [3:0] INSTR , output LDA , output ADD , output SUB , output OUT , output HLT); // This is the Instruction Decoder Module. It receives the Instruction or Opcode Field from Instruction Register and Generates a control signal associated with a instruction//
assign LDA = ~INSTR[3] & ~INSTR[2] & ~INSTR[1] & ~INSTR[0]; //0000 is the opcode of LDA instruction.
assign ADD = ~INSTR[3] & ~INSTR[2] & ~INSTR[1] & INSTR[0]; //0001 is the opcode of ADD instruction.
assign SUB =  ~INSTR[3] & ~INSTR[2] & INSTR[1] & ~INSTR[0]; //0010 is the opcode of SUB instruction.
assign OUT = INSTR[3] & INSTR[2] & INSTR[1] & ~INSTR[0]; //1110 is the opcode of OUT instruction.
assign HLT = INSTR[3] & INSTR[2] & INSTR[1] & INSTR[0]; //1111 is the opcode of HLT instruction.
endmodule

module CU_8(input LDA , input ADD , input SUB , input OUT , input [5:0] T , output CP , EP , LM , CE , LI , EI , LA , EA , SU , EU , LB , LO , NOP);
wire T1 , T2 , T3 , T4 , T5 , T6 ;
assign T1 = T[0];
assign T2 = T[1];
assign T3 = T[2];
assign T4 = T[3];
assign T5 = T[4];
assign T6 = T[5];
wire LDA_w , ADD_w , SUB_w , OUT_w;
assign LDA_w = LDA;
assign ADD_w = ADD;
assign SUB_w = SUB;
assign OUT_w = OUT;
assign CP = T2;
assign EP = T1;
assign LM = ~(T1 | (T4 & LDA_w) | (T4 & ADD_w) | (T4 & SUB_w));
assign CE = ~(T3  | (T5 & LDA_w) | (T5 & ADD_w) | (T5 & SUB_w)); 
assign LI = ~T3;
assign EI = ~((T4 & LDA_w) | (T4 & ADD_w) | (T4 & SUB_w));
assign LA = ~((T5 & LDA_w) | (T6 & ADD_w) | (T6 & SUB_w));
assign EA = T4 & OUT_w;
assign SU = T6 & SUB_w;
assign EU = (T6 & ADD_w) | (T6 & SUB_w);
assign LB = ~((T5 & ADD_w) | (T5 & SUB_w));
assign LO = ~(T4 & OUT_w);
assign NOP = (T6 & LDA_w) | (T6 & ADD_w) | (T6 & SUB_w) | (T5 & T6 & OUT_w);
endmodule



module ACC_8(input clk,input LA,input EA, input [7:0] ACC_IN,output [7:0] ACC_OUT_ALU , output [7:0] ACC_OUT_W_BUS);
reg [7:0] ACC_r;
assign ACC_OUT_ALU = ACC_r;
assign ACC_OUT_W_BUS = EA ? ACC_r : 8'hZZ;
always@(posedge clk) // Here clk and rst are asynchronous signals. When there is a single parameter in the sensitivity list of always block , the subsequent conditions are said to be synchronous to the single parameter mentioned in the sensitivity list. When there are multiple parameters separated by "or" keyword , then the parameters mentioned in the list are asynchronous with respect to each other//
begin 
if(~LA)
ACC_r <= ACC_IN;
end
endmodule


module B_REG_1(input clk,input [7:0] DATA_IN,input LB,output [7:0] DATA_OUT);
reg [7:0] B_REG;
assign DATA_OUT = B_REG;
always@(posedge clk)
begin
if(~LB)
B_REG <= DATA_IN;
end
endmodule

module ALU8_1(input [7:0] A,input [7:0] B, input SU,input EU , output [7:0] ALU_OUT);
wire [7:0] ALU_OUT_w = SU ? A-B : A+B; //Let X be a variable ; Prefixing a -(minus symbol) to a variable is equivalent to taking 2's complement of the variable.
assign ALU_OUT = EU ? ALU_OUT_w : 8'h00;
endmodule

module OR_1(input clk , input [7:0] DATA_IN , input LO , output [7:0] DATA_OUT);
reg [7:0] OR_r;
assign DATA_OUT = OR_r;
always@(posedge clk)
begin
if(~LO)
OR_r <= DATA_IN;
end
endmodule
