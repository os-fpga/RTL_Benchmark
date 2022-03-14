 /*                                                                      
 Copyright 2019 Blue Liang, liangkangnan@163.com
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
                                                                         
     http://www.apache.org/licenses/LICENSE-2.0                          
                                                                         
 Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */

`define CpuResetAddr 32'h0

`define RstEnable 1'b0
`define RstDisable 1'b1
`define ZeroWord 32'h0
`define ZeroReg 5'h0
`define WriteEnable 1'b1
`define WriteDisable 1'b0
`define ReadEnable 1'b1
`define ReadDisable 1'b0
`define True 1'b1
`define False 1'b0
`define ChipEnable 1'b1
`define ChipDisable 1'b0
`define JumpEnable 1'b1
`define JumpDisable 1'b0
`define DivResultNotReady 1'b0
`define DivResultReady 1'b1
`define DivStart 1'b1
`define DivStop 1'b0
`define HoldEnable 1'b1
`define HoldDisable 1'b0
`define Stop 1'b1
`define NoStop 1'b0
`define RIB_ACK 1'b1
`define RIB_NACK 1'b0
`define RIB_REQ 1'b1
`define RIB_NREQ 1'b0
`define INT_ASSERT 1'b1
`define INT_DEASSERT 1'b0

`define INT_BUS 7:0
`define INT_NONE 8'h0
`define INT_RET 8'hff
`define INT_TIMER0 8'b00000001
`define INT_TIMER0_ENTRY_ADDR 32'h4

`define Hold_Flag_Bus   2:0
`define Hold_None 3'b000
`define Hold_Pc   3'b001
`define Hold_If   3'b010
`define Hold_Id   3'b011

// I type inst
`define INST_TYPE_I 7'b0010011
`define INST_ADDI   3'b000
`define INST_SLTI   3'b010
`define INST_SLTIU  3'b011
`define INST_XORI   3'b100
`define INST_ORI    3'b110
`define INST_ANDI   3'b111
`define INST_SLLI   3'b001
`define INST_SRI    3'b101

// L type inst
`define INST_TYPE_L 7'b0000011
`define INST_LB     3'b000
`define INST_LH     3'b001
`define INST_LW     3'b010
`define INST_LBU    3'b100
`define INST_LHU    3'b101

// S type inst
`define INST_TYPE_S 7'b0100011
`define INST_SB     3'b000
`define INST_SH     3'b001
`define INST_SW     3'b010

// R and M type inst
`define INST_TYPE_R_M 7'b0110011
// R type inst
`define INST_ADD_SUB 3'b000
`define INST_SLL    3'b001
`define INST_SLT    3'b010
`define INST_SLTU   3'b011
`define INST_XOR    3'b100
`define INST_SR     3'b101
`define INST_OR     3'b110
`define INST_AND    3'b111
// M type inst
`define INST_MUL    3'b000
`define INST_MULH   3'b001
`define INST_MULHSU 3'b010
`define INST_MULHU  3'b011
`define INST_DIV    3'b100
`define INST_DIVU   3'b101
`define INST_REM    3'b110
`define INST_REMU   3'b111

// J type inst
`define INST_JAL    7'b1101111
`define INST_JALR   7'b1100111

`define INST_LUI    7'b0110111
`define INST_AUIPC  7'b0010111
`define INST_NOP    32'h00000001
`define INST_NOP_OP 7'b0000001
`define INST_MRET   32'h30200073
`define INST_RET    32'h00008067

`define INST_FENCE  7'b0001111
`define INST_ECALL  32'h73
`define INST_EBREAK 32'h00100073

// J type inst
`define INST_TYPE_B 7'b1100011
`define INST_BEQ    3'b000
`define INST_BNE    3'b001
`define INST_BLT    3'b100
`define INST_BGE    3'b101
`define INST_BLTU   3'b110
`define INST_BGEU   3'b111

// CSR inst
`define INST_CSR    7'b1110011
`define INST_CSRRW  3'b001
`define INST_CSRRS  3'b010
`define INST_CSRRC  3'b011
`define INST_CSRRWI 3'b101
`define INST_CSRRSI 3'b110
`define INST_CSRRCI 3'b111

// CSR reg addr
`define CSR_CYCLE   12'hc00
`define CSR_CYCLEH  12'hc80
`define CSR_MTVEC   12'h305
`define CSR_MCAUSE  12'h342
`define CSR_MEPC    12'h341
`define CSR_MIE     12'h304
`define CSR_MSTATUS 12'h300
`define CSR_MSCRATCH 12'h340

`define RomNum 4096  // rom depth(how many words)

`define MemNum 4096  // memory depth(how many words)
`define MemBus 31:0
`define MemAddrBus 31:0

`define InstBus 31:0
`define InstAddrBus 31:0

// common regs
`define RegAddrBus 4:0
`define RegBus 31:0
`define DoubleRegBus 63:0
`define RegWidth 32
`define RegNum 32        // reg num
`define RegNumLog2 5

module clint(

    input wire clk,
    input wire rst,

    // from core
    input wire[`INT_BUS] int_flag_i,         // ÖÐ¶ÏÊäÈëÐÅºÅ

    // from id
    input wire[`InstBus] inst_i,             // ÖžÁîÄÚÈÝ
    input wire[`InstAddrBus] inst_addr_i,    // ÖžÁîµØÖ·

    // from ex
    input wire jump_flag_i,
    input wire[`InstAddrBus] jump_addr_i,
    input wire div_started_i,

    // from ctrl
    input wire[`Hold_Flag_Bus] hold_flag_i,  // Á÷Ë®ÏßÔÝÍ£±êÖŸ

    // from csr_reg
    input wire[`RegBus] data_i,              // CSRŒÄŽæÆ÷ÊäÈëÊýŸÝ
    input wire[`RegBus] csr_mtvec,           // mtvecŒÄŽæÆ÷
    input wire[`RegBus] csr_mepc,            // mepcŒÄŽæÆ÷
    input wire[`RegBus] csr_mstatus,         // mstatusŒÄŽæÆ÷

    input wire global_int_en_i,              // È«ŸÖÖÐ¶ÏÊ¹ÄÜ±êÖŸ

    // to ctrl
    output wire hold_flag_o,                 // Á÷Ë®ÏßÔÝÍ£±êÖŸ

    // to csr_reg
    output reg we_o,                         // ÐŽCSRŒÄŽæÆ÷±êÖŸ
    output reg[`MemAddrBus] waddr_o,         // ÐŽCSRŒÄŽæÆ÷µØÖ·
    output reg[`MemAddrBus] raddr_o,         // ¶ÁCSRŒÄŽæÆ÷µØÖ·
    output reg[`RegBus] data_o,              // ÐŽCSRŒÄŽæÆ÷ÊýŸÝ

    // to ex
    output reg[`InstAddrBus] int_addr_o,     // ÖÐ¶ÏÈë¿ÚµØÖ·
    output reg int_assert_o                  // ÖÐ¶Ï±êÖŸ

    );


    // ÖÐ¶Ï×ŽÌ¬¶šÒå
    localparam S_INT_IDLE            = 4'b0001;
    localparam S_INT_SYNC_ASSERT     = 4'b0010;
    localparam S_INT_ASYNC_ASSERT    = 4'b0100;
    localparam S_INT_MRET            = 4'b1000;

    // ÐŽCSRŒÄŽæÆ÷×ŽÌ¬¶šÒå
    localparam S_CSR_IDLE            = 5'b00001;
    localparam S_CSR_MSTATUS         = 5'b00010;
    localparam S_CSR_MEPC            = 5'b00100;
    localparam S_CSR_MSTATUS_MRET    = 5'b01000;
    localparam S_CSR_MCAUSE          = 5'b10000;

    reg[3:0] int_state;
    reg[4:0] csr_state;
    reg[`InstAddrBus] inst_addr;
    reg[31:0] cause;


    assign hold_flag_o = ((int_state != S_INT_IDLE) | (csr_state != S_CSR_IDLE))? `HoldEnable: `HoldDisable;


    // ÖÐ¶ÏÖÙ²ÃÂßŒ­
    always @ (*) begin
        if (rst == `RstEnable) begin
            int_state = S_INT_IDLE;
        end else begin
            if (inst_i == `INST_ECALL || inst_i == `INST_EBREAK) begin
                // Èç¹ûÖŽÐÐœ×¶ÎµÄÖžÁîÎª³ý·šÖžÁî£¬ÔòÏÈ²»ŽŠÀíÍ¬²œÖÐ¶Ï£¬µÈ³ý·šÖžÁîÖŽÐÐÍêÔÙŽŠÀí
                if (div_started_i == `DivStop) begin
                    int_state = S_INT_SYNC_ASSERT;
                end else begin
                    int_state = S_INT_IDLE;
                end
            end else if (int_flag_i != `INT_NONE && global_int_en_i == `True) begin
                int_state = S_INT_ASYNC_ASSERT;
            end else if (inst_i == `INST_MRET) begin
                int_state = S_INT_MRET;
            end else begin
                int_state = S_INT_IDLE;
            end
        end
    end

    // ÐŽCSRŒÄŽæÆ÷×ŽÌ¬ÇÐ»»
    always @ (posedge clk) begin
        if (rst == `RstEnable) begin
            csr_state <= S_CSR_IDLE;
            cause <= `ZeroWord;
            inst_addr <= `ZeroWord;
        end else begin
            case (csr_state)
                S_CSR_IDLE: begin
                    // Í¬²œÖÐ¶Ï
                    if (int_state == S_INT_SYNC_ASSERT) begin
                        csr_state <= S_CSR_MEPC;
                        // ÔÚÖÐ¶ÏŽŠÀíº¯ÊýÀï»áœ«ÖÐ¶Ï·µ»ØµØÖ·ŒÓ4
                        if (jump_flag_i == `JumpEnable) begin
                            inst_addr <= jump_addr_i - 4'h4;
                        end else begin
                            inst_addr <= inst_addr_i;
                        end
                        case (inst_i)
                            `INST_ECALL: begin
                                cause <= 32'd11;
                            end
                            `INST_EBREAK: begin
                                cause <= 32'd3;
                            end
                            default: begin
                                cause <= 32'd10;
                            end
                        endcase
                    // Òì²œÖÐ¶Ï
                    end else if (int_state == S_INT_ASYNC_ASSERT) begin
                        // ¶šÊ±Æ÷ÖÐ¶Ï
                        cause <= 32'h80000004;
                        csr_state <= S_CSR_MEPC;
                        if (jump_flag_i == `JumpEnable) begin
                            inst_addr <= jump_addr_i;
                        // Òì²œÖÐ¶Ï¿ÉÒÔÖÐ¶Ï³ý·šÖžÁîµÄÖŽÐÐ£¬ÖÐ¶ÏŽŠÀíÍêÔÙÖØÐÂÖŽÐÐ³ý·šÖžÁî
                        end else if (div_started_i == `DivStart) begin
                            inst_addr <= inst_addr_i - 4'h4;
                        end else begin
                            inst_addr <= inst_addr_i;
                        end
                    // ÖÐ¶Ï·µ»Ø
                    end else if (int_state == S_INT_MRET) begin
                        csr_state <= S_CSR_MSTATUS_MRET;
                    end
                end
                S_CSR_MEPC: begin
                    csr_state <= S_CSR_MSTATUS;
                end
                S_CSR_MSTATUS: begin
                    csr_state <= S_CSR_MCAUSE;
                end
                S_CSR_MCAUSE: begin
                    csr_state <= S_CSR_IDLE;
                end
                S_CSR_MSTATUS_MRET: begin
                    csr_state <= S_CSR_IDLE;
                end
                default: begin
                    csr_state <= S_CSR_IDLE;
                end
            endcase
        end
    end

    // ·¢³öÖÐ¶ÏÐÅºÅÇ°£¬ÏÈÐŽŒžžöCSRŒÄŽæÆ÷
    always @ (posedge clk) begin
        if (rst == `RstEnable) begin
            we_o <= `WriteDisable;
            waddr_o <= `ZeroWord;
            data_o <= `ZeroWord;
        end else begin
            case (csr_state)
                // œ«mepcŒÄŽæÆ÷µÄÖµÉèÎªµ±Ç°ÖžÁîµØÖ·
                S_CSR_MEPC: begin
                    we_o <= `WriteEnable;
                    waddr_o <= {20'h0, `CSR_MEPC};
                    data_o <= inst_addr;
                end
                // ÐŽÖÐ¶Ï²úÉúµÄÔ­Òò
                S_CSR_MCAUSE: begin
                    we_o <= `WriteEnable;
                    waddr_o <= {20'h0, `CSR_MCAUSE};
                    data_o <= cause;
                end
                // ¹Ø±ÕÈ«ŸÖÖÐ¶Ï
                S_CSR_MSTATUS: begin
                    we_o <= `WriteEnable;
                    waddr_o <= {20'h0, `CSR_MSTATUS};
                    data_o <= {csr_mstatus[31:4], 1'b0, csr_mstatus[2:0]};
                end
                // ÖÐ¶Ï·µ»Ø
                S_CSR_MSTATUS_MRET: begin
                    we_o <= `WriteEnable;
                    waddr_o <= {20'h0, `CSR_MSTATUS};
                    data_o <= {csr_mstatus[31:4], csr_mstatus[7], csr_mstatus[2:0]};
                end
                default: begin
                    we_o <= `WriteDisable;
                    waddr_o <= `ZeroWord;
                    data_o <= `ZeroWord;
                end
            endcase
        end
    end

    // ·¢³öÖÐ¶ÏÐÅºÅžøexÄ£¿é
    always @ (posedge clk) begin
        if (rst == `RstEnable) begin
            int_assert_o <= `INT_DEASSERT;
            int_addr_o <= `ZeroWord;
        end else begin
            case (csr_state)
                // ·¢³öÖÐ¶ÏœøÈëÐÅºÅ.ÐŽÍêmcauseŒÄŽæÆ÷²ÅÄÜ·¢
                S_CSR_MCAUSE: begin
                    int_assert_o <= `INT_ASSERT;
                    int_addr_o <= csr_mtvec;
                end
                // ·¢³öÖÐ¶Ï·µ»ØÐÅºÅ
                S_CSR_MSTATUS_MRET: begin
                    int_assert_o <= `INT_ASSERT;
                    int_addr_o <= csr_mepc;
                end
                default: begin
                    int_assert_o <= `INT_DEASSERT;
                    int_addr_o <= `ZeroWord;
                end
            endcase
        end
    end

endmodule

module csr_reg(

    input wire clk,
    input wire rst,

    // form ex
    input wire we_i,                        // ex模块写寄存器标志
    input wire[`MemAddrBus] raddr_i,        // ex模块读寄存器地址
    input wire[`MemAddrBus] waddr_i,        // ex模块写寄存器地址
    input wire[`RegBus] data_i,             // ex模块写寄存器数据

    // from clint
    input wire clint_we_i,                  // clint模块写寄存器标志
    input wire[`MemAddrBus] clint_raddr_i,  // clint模块读寄存器地址
    input wire[`MemAddrBus] clint_waddr_i,  // clint模块写寄存器地址
    input wire[`RegBus] clint_data_i,       // clint模块写寄存器数据

    output wire global_int_en_o,            // 全局中断使能标志

    // to clint
    output reg[`RegBus] clint_data_o,       // clint模块读寄存器数据
    output wire[`RegBus] clint_csr_mtvec,   // mtvec
    output wire[`RegBus] clint_csr_mepc,    // mepc
    output wire[`RegBus] clint_csr_mstatus, // mstatus

    // to ex
    output reg[`RegBus] data_o              // ex模块读寄存器数据

    );

    reg[`DoubleRegBus] cycle;
    reg[`RegBus] mtvec;
    reg[`RegBus] mcause;
    reg[`RegBus] mepc;
    reg[`RegBus] mie;
    reg[`RegBus] mstatus;
    reg[`RegBus] mscratch;

    assign global_int_en_o = (mstatus[3] == 1'b1)? `True: `False;

    assign clint_csr_mtvec = mtvec;
    assign clint_csr_mepc = mepc;
    assign clint_csr_mstatus = mstatus;

    // cycle counter
    // 复位撤销后就一直计数
    always @ (posedge clk) begin
        if (rst == `RstEnable) begin
            cycle <= {`ZeroWord, `ZeroWord};
        end else begin
            cycle <= cycle + 1'b1;
        end
    end

    // write reg
    // 写寄存器操作
    always @ (posedge clk) begin
        if (rst == `RstEnable) begin
            mtvec <= `ZeroWord;
            mcause <= `ZeroWord;
            mepc <= `ZeroWord;
            mie <= `ZeroWord;
            mstatus <= `ZeroWord;
            mscratch <= `ZeroWord;
        end else begin
            // 优先响应ex模块的写操作
            if (we_i == `WriteEnable) begin
                case (waddr_i[11:0])
                    `CSR_MTVEC: begin
                        mtvec <= data_i;
                    end
                    `CSR_MCAUSE: begin
                        mcause <= data_i;
                    end
                    `CSR_MEPC: begin
                        mepc <= data_i;
                    end
                    `CSR_MIE: begin
                        mie <= data_i;
                    end
                    `CSR_MSTATUS: begin
                        mstatus <= data_i;
                    end
                    `CSR_MSCRATCH: begin
                        mscratch <= data_i;
                    end
                    default: begin

                    end
                endcase
            // clint模块写操作
            end else if (clint_we_i == `WriteEnable) begin
                case (clint_waddr_i[11:0])
                    `CSR_MTVEC: begin
                        mtvec <= clint_data_i;
                    end
                    `CSR_MCAUSE: begin
                        mcause <= clint_data_i;
                    end
                    `CSR_MEPC: begin
                        mepc <= clint_data_i;
                    end
                    `CSR_MIE: begin
                        mie <= clint_data_i;
                    end
                    `CSR_MSTATUS: begin
                        mstatus <= clint_data_i;
                    end
                    `CSR_MSCRATCH: begin
                        mscratch <= clint_data_i;
                    end
                    default: begin

                    end
                endcase
            end
        end
    end

    // read reg
    // ex模块读CSR寄存器
    always @ (*) begin
        if ((waddr_i[11:0] == raddr_i[11:0]) && (we_i == `WriteEnable)) begin
            data_o = data_i;
        end else begin
            case (raddr_i[11:0])
                `CSR_CYCLE: begin
                    data_o = cycle[31:0];
                end
                `CSR_CYCLEH: begin
                    data_o = cycle[63:32];
                end
                `CSR_MTVEC: begin
                    data_o = mtvec;
                end
                `CSR_MCAUSE: begin
                    data_o = mcause;
                end
                `CSR_MEPC: begin
                    data_o = mepc;
                end
                `CSR_MIE: begin
                    data_o = mie;
                end
                `CSR_MSTATUS: begin
                    data_o = mstatus;
                end
                `CSR_MSCRATCH: begin
                    data_o = mscratch;
                end
                default: begin
                    data_o = `ZeroWord;
                end
            endcase
        end
    end

    // read reg
    // clint模块读CSR寄存器
    always @ (*) begin
        if ((clint_waddr_i[11:0] == clint_raddr_i[11:0]) && (clint_we_i == `WriteEnable)) begin
            clint_data_o = clint_data_i;
        end else begin
            case (clint_raddr_i[11:0])
                `CSR_CYCLE: begin
                    clint_data_o = cycle[31:0];
                end
                `CSR_CYCLEH: begin
                    clint_data_o = cycle[63:32];
                end
                `CSR_MTVEC: begin
                    clint_data_o = mtvec;
                end
                `CSR_MCAUSE: begin
                    clint_data_o = mcause;
                end
                `CSR_MEPC: begin
                    clint_data_o = mepc;
                end
                `CSR_MIE: begin
                    clint_data_o = mie;
                end
                `CSR_MSTATUS: begin
                    clint_data_o = mstatus;
                end
                `CSR_MSCRATCH: begin
                    clint_data_o = mscratch;
                end
                default: begin
                    clint_data_o = `ZeroWord;
                end
            endcase
        end
    end

endmodule

module ctrl(

    input wire rst,

    // from ex
    input wire jump_flag_i,
    input wire[`InstAddrBus] jump_addr_i,
    input wire hold_flag_ex_i,

    // from rib
    input wire hold_flag_rib_i,

    // from jtag
    input wire jtag_halt_flag_i,

    // from clint
    input wire hold_flag_clint_i,

    output reg[`Hold_Flag_Bus] hold_flag_o,

    // to pc_reg
    output reg jump_flag_o,
    output reg[`InstAddrBus] jump_addr_o

    );


    always @ (*) begin
        jump_addr_o = jump_addr_i;
        jump_flag_o = jump_flag_i;
        // 默认不暂停
        hold_flag_o = `Hold_None;
        // 按优先级处理不同模块的请求
        if (jump_flag_i == `JumpEnable || hold_flag_ex_i == `HoldEnable || hold_flag_clint_i == `HoldEnable) begin
            // 暂停整条流水线
            hold_flag_o = `Hold_Id;
        end else if (hold_flag_rib_i == `HoldEnable) begin
            // 暂停PC，即取指地址不变
            hold_flag_o = `Hold_Pc;
        end else if (jtag_halt_flag_i == `HoldEnable) begin
            // 暂停整条流水线
            hold_flag_o = `Hold_Id;
        end else begin
            hold_flag_o = `Hold_None;
        end
    end

endmodule

module div(

    input wire clk,
    input wire rst,

    // from ex
    input wire[`RegBus] dividend_i,      // 被除数
    input wire[`RegBus] divisor_i,       // 除数
    input wire start_i,                  // 开始信号，运算期间这个信号需要一直保持有效
    input wire[2:0] op_i,                // 具体是哪一条指令
    input wire[`RegAddrBus] reg_waddr_i, // 运算结束后需要写的寄存器

    // to ex
    output reg[`RegBus] result_o,        // 除法结果，高32位是余数，低32位是商
    output reg ready_o,                  // 运算结束信号
    output reg busy_o,                  // 正在运算信号
    output reg[`RegAddrBus] reg_waddr_o  // 运算结束后需要写的寄存器

    );

    // 状态定义
    localparam STATE_IDLE  = 4'b0001;
    localparam STATE_START = 4'b0010;
    localparam STATE_CALC  = 4'b0100;
    localparam STATE_END   = 4'b1000;

    reg[`RegBus] dividend_r;
    reg[`RegBus] divisor_r;
    reg[2:0] op_r;
    reg[3:0] state;
    reg[31:0] count;
    reg[`RegBus] div_result;
    reg[`RegBus] div_remain;
    reg[`RegBus] minuend;
    reg invert_result;

    wire op_div = (op_r == `INST_DIV);
    wire op_divu = (op_r == `INST_DIVU);
    wire op_rem = (op_r == `INST_REM);
    wire op_remu = (op_r == `INST_REMU);

    wire[31:0] dividend_invert = (-dividend_r);
    wire[31:0] divisor_invert = (-divisor_r);
    wire minuend_ge_divisor = minuend >= divisor_r;
    wire[31:0] minuend_sub_res = minuend - divisor_r;
    wire[31:0] div_result_tmp = minuend_ge_divisor? ({div_result[30:0], 1'b1}): ({div_result[30:0], 1'b0});
    wire[31:0] minuend_tmp = minuend_ge_divisor? minuend_sub_res[30:0]: minuend[30:0];

    // 状态机实现
    always @ (posedge clk) begin
        if (rst == `RstEnable) begin
            state <= STATE_IDLE;
            ready_o <= `DivResultNotReady;
            result_o <= `ZeroWord;
            div_result <= `ZeroWord;
            div_remain <= `ZeroWord;
            op_r <= 3'h0;
            reg_waddr_o <= `ZeroWord;
            dividend_r <= `ZeroWord;
            divisor_r <= `ZeroWord;
            minuend <= `ZeroWord;
            invert_result <= 1'b0;
            busy_o <= `False;
            count <= `ZeroWord;
        end else begin
            case (state)
                STATE_IDLE: begin
                    if (start_i == `DivStart) begin
                        op_r <= op_i;
                        dividend_r <= dividend_i;
                        divisor_r <= divisor_i;
                        reg_waddr_o <= reg_waddr_i;
                        state <= STATE_START;
                        busy_o <= `True;
                    end else begin
                        op_r <= 3'h0;
                        reg_waddr_o <= `ZeroWord;
                        dividend_r <= `ZeroWord;
                        divisor_r <= `ZeroWord;
                        ready_o <= `DivResultNotReady;
                        result_o <= `ZeroWord;
                        busy_o <= `False;
                    end
                end

                STATE_START: begin
                    if (start_i == `DivStart) begin
                        // 除数为0
                        if (divisor_r == `ZeroWord) begin
                            if (op_div | op_divu) begin
                                result_o <= 32'hffffffff;
                            end else begin
                                result_o <= dividend_r;
                            end
                            ready_o <= `DivResultReady;
                            state <= STATE_IDLE;
                            busy_o <= `False;
                        // 除数不为0
                        end else begin
                            busy_o <= `True;
                            count <= 32'h40000000;
                            state <= STATE_CALC;
                            div_result <= `ZeroWord;
                            div_remain <= `ZeroWord;

                            // DIV和REM这两条指令是有符号数运算指令
                            if (op_div | op_rem) begin
                                // 被除数求补码
                                if (dividend_r[31] == 1'b1) begin
                                    dividend_r <= dividend_invert;
                                    minuend <= dividend_invert[31];
                                end else begin
                                    minuend <= dividend_r[31];
                                end
                                // 除数求补码
                                if (divisor_r[31] == 1'b1) begin
                                    divisor_r <= divisor_invert;
                                end
                            end else begin
                                minuend <= dividend_r[31];
                            end

                            // 运算结束后是否要对结果取补码
                            if ((op_div && (dividend_r[31] ^ divisor_r[31] == 1'b1))
                                || (op_rem && (dividend_r[31] == 1'b1))) begin
                                invert_result <= 1'b1;
                            end else begin
                                invert_result <= 1'b0;
                            end
                        end
                    end else begin
                        state <= STATE_IDLE;
                        result_o <= `ZeroWord;
                        ready_o <= `DivResultNotReady;
                        busy_o <= `False;
                    end
                end

                STATE_CALC: begin
                    if (start_i == `DivStart) begin
                        dividend_r <= {dividend_r[30:0], 1'b0};
                        div_result <= div_result_tmp;
                        count <= {1'b0, count[31:1]};
                        if (|count) begin
                            minuend <= {minuend_tmp[30:0], dividend_r[30]};
                        end else begin
                            state <= STATE_END;
                            if (minuend_ge_divisor) begin
                                div_remain <= minuend_sub_res;
                            end else begin
                                div_remain <= minuend;
                            end
                        end
                    end else begin
                        state <= STATE_IDLE;
                        result_o <= `ZeroWord;
                        ready_o <= `DivResultNotReady;
                        busy_o <= `False;
                    end
                end

                STATE_END: begin
                    if (start_i == `DivStart) begin
                        ready_o <= `DivResultReady;
                        state <= STATE_IDLE;
                        busy_o <= `False;
                        if (op_div | op_divu) begin
                            if (invert_result) begin
                                result_o <= (-div_result);
                            end else begin
                                result_o <= div_result;
                            end
                        end else begin
                            if (invert_result) begin
                                result_o <= (-div_remain);
                            end else begin
                                result_o <= div_remain;
                            end
                        end
                    end else begin
                        state <= STATE_IDLE;
                        result_o <= `ZeroWord;
                        ready_o <= `DivResultNotReady;
                        busy_o <= `False;
                    end
                end

            endcase
        end
    end

endmodule

module ex(

    input wire rst,

    // from id
    input wire[`InstBus] inst_i,            // 指令内容
    input wire[`InstAddrBus] inst_addr_i,   // 指令地址
    input wire reg_we_i,                    // 是否写通用寄存器
    input wire[`RegAddrBus] reg_waddr_i,    // 写通用寄存器地址
    input wire[`RegBus] reg1_rdata_i,       // 通用寄存器1输入数据
    input wire[`RegBus] reg2_rdata_i,       // 通用寄存器2输入数据
    input wire csr_we_i,                    // 是否写CSR寄存器
    input wire[`MemAddrBus] csr_waddr_i,    // 写CSR寄存器地址
    input wire[`RegBus] csr_rdata_i,        // CSR寄存器输入数据
    input wire int_assert_i,                // 中断发生标志
    input wire[`InstAddrBus] int_addr_i,    // 中断跳转地址
    input wire[`MemAddrBus] op1_i,
    input wire[`MemAddrBus] op2_i,
    input wire[`MemAddrBus] op1_jump_i,
    input wire[`MemAddrBus] op2_jump_i,

    // from mem
    input wire[`MemBus] mem_rdata_i,        // 内存输入数据

    // from div
    input wire div_ready_i,                 // 除法运算完成标志
    input wire[`RegBus] div_result_i,       // 除法运算结果
    input wire div_busy_i,                  // 除法运算忙标志
    input wire[`RegAddrBus] div_reg_waddr_i,// 除法运算结束后要写的寄存器地址

    // to mem
    output reg[`MemBus] mem_wdata_o,        // 写内存数据
    output reg[`MemAddrBus] mem_raddr_o,    // 读内存地址
    output reg[`MemAddrBus] mem_waddr_o,    // 写内存地址
    output wire mem_we_o,                   // 是否要写内存
    output wire mem_req_o,                  // 请求访问内存标志

    // to regs
    output wire[`RegBus] reg_wdata_o,       // 写寄存器数据
    output wire reg_we_o,                   // 是否要写通用寄存器
    output wire[`RegAddrBus] reg_waddr_o,   // 写通用寄存器地址

    // to csr reg
    output reg[`RegBus] csr_wdata_o,        // 写CSR寄存器数据
    output wire csr_we_o,                   // 是否要写CSR寄存器
    output wire[`MemAddrBus] csr_waddr_o,   // 写CSR寄存器地址

    // to div
    output wire div_start_o,                // 开始除法运算标志
    output reg[`RegBus] div_dividend_o,     // 被除数
    output reg[`RegBus] div_divisor_o,      // 除数
    output reg[2:0] div_op_o,               // 具体是哪一条除法指令
    output reg[`RegAddrBus] div_reg_waddr_o,// 除法运算结束后要写的寄存器地址

    // to ctrl
    output wire hold_flag_o,                // 是否暂停标志
    output wire jump_flag_o,                // 是否跳转标志
    output wire[`InstAddrBus] jump_addr_o   // 跳转目的地址

    );

    wire[1:0] mem_raddr_index;
    wire[1:0] mem_waddr_index;
    wire[`DoubleRegBus] mul_temp;
    wire[`DoubleRegBus] mul_temp_invert;
    wire[31:0] sr_shift;
    wire[31:0] sri_shift;
    wire[31:0] sr_shift_mask;
    wire[31:0] sri_shift_mask;
    wire[31:0] op1_add_op2_res;
    wire[31:0] op1_jump_add_op2_jump_res;
    wire[31:0] reg1_data_invert;
    wire[31:0] reg2_data_invert;
    wire op1_ge_op2_signed;
    wire op1_ge_op2_unsigned;
    wire op1_eq_op2;
    reg[`RegBus] mul_op1;
    reg[`RegBus] mul_op2;
    wire[6:0] opcode;
    wire[2:0] funct3;
    wire[6:0] funct7;
    wire[4:0] rd;
    wire[4:0] uimm;
    reg[`RegBus] reg_wdata;
    reg reg_we;
    reg[`RegAddrBus] reg_waddr;
    reg[`RegBus] div_wdata;
    reg div_we;
    reg[`RegAddrBus] div_waddr;
    reg div_hold_flag;
    reg div_jump_flag;
    reg[`InstAddrBus] div_jump_addr;
    reg hold_flag;
    reg jump_flag;
    reg[`InstAddrBus] jump_addr;
    reg mem_we;
    reg mem_req;
    reg div_start;

    assign opcode = inst_i[6:0];
    assign funct3 = inst_i[14:12];
    assign funct7 = inst_i[31:25];
    assign rd = inst_i[11:7];
    assign uimm = inst_i[19:15];

    assign sr_shift = reg1_rdata_i >> reg2_rdata_i[4:0];
    assign sri_shift = reg1_rdata_i >> inst_i[24:20];
    assign sr_shift_mask = 32'hffffffff >> reg2_rdata_i[4:0];
    assign sri_shift_mask = 32'hffffffff >> inst_i[24:20];

    assign op1_add_op2_res = op1_i + op2_i;
    assign op1_jump_add_op2_jump_res = op1_jump_i + op2_jump_i;

    assign reg1_data_invert = ~reg1_rdata_i + 1;
    assign reg2_data_invert = ~reg2_rdata_i + 1;

    // 有符号数比较
    assign op1_ge_op2_signed = $signed(op1_i) >= $signed(op2_i);
    // 无符号数比较
    assign op1_ge_op2_unsigned = op1_i >= op2_i;
    assign op1_eq_op2 = (op1_i == op2_i);

    assign mul_temp = mul_op1 * mul_op2;
    assign mul_temp_invert = ~mul_temp + 1;

    assign mem_raddr_index = (reg1_rdata_i + {{20{inst_i[31]}}, inst_i[31:20]}) & 2'b11;
    assign mem_waddr_index = (reg1_rdata_i + {{20{inst_i[31]}}, inst_i[31:25], inst_i[11:7]}) & 2'b11;

    assign div_start_o = (int_assert_i == `INT_ASSERT)? `DivStop: div_start;

    assign reg_wdata_o = reg_wdata | div_wdata;
    // 响应中断时不写通用寄存器
    assign reg_we_o = (int_assert_i == `INT_ASSERT)? `WriteDisable: (reg_we || div_we);
    assign reg_waddr_o = reg_waddr | div_waddr;

    // 响应中断时不写内存
    assign mem_we_o = (int_assert_i == `INT_ASSERT)? `WriteDisable: mem_we;

    // 响应中断时不向总线请求访问内存
    assign mem_req_o = (int_assert_i == `INT_ASSERT)? `RIB_NREQ: mem_req;

    assign hold_flag_o = hold_flag || div_hold_flag;
    assign jump_flag_o = jump_flag || div_jump_flag || ((int_assert_i == `INT_ASSERT)? `JumpEnable: `JumpDisable);
    assign jump_addr_o = (int_assert_i == `INT_ASSERT)? int_addr_i: (jump_addr | div_jump_addr);

    // 响应中断时不写CSR寄存器
    assign csr_we_o = (int_assert_i == `INT_ASSERT)? `WriteDisable: csr_we_i;
    assign csr_waddr_o = csr_waddr_i;


    // 处理乘法指令
    always @ (*) begin
        if ((opcode == `INST_TYPE_R_M) && (funct7 == 7'b0000001)) begin
            case (funct3)
                `INST_MUL, `INST_MULHU: begin
                    mul_op1 = reg1_rdata_i;
                    mul_op2 = reg2_rdata_i;
                end
                `INST_MULHSU: begin
                    mul_op1 = (reg1_rdata_i[31] == 1'b1)? (reg1_data_invert): reg1_rdata_i;
                    mul_op2 = reg2_rdata_i;
                end
                `INST_MULH: begin
                    mul_op1 = (reg1_rdata_i[31] == 1'b1)? (reg1_data_invert): reg1_rdata_i;
                    mul_op2 = (reg2_rdata_i[31] == 1'b1)? (reg2_data_invert): reg2_rdata_i;
                end
                default: begin
                    mul_op1 = reg1_rdata_i;
                    mul_op2 = reg2_rdata_i;
                end
            endcase
        end else begin
            mul_op1 = reg1_rdata_i;
            mul_op2 = reg2_rdata_i;
        end
    end

    // 处理除法指令
    always @ (*) begin
        div_dividend_o = reg1_rdata_i;
        div_divisor_o = reg2_rdata_i;
        div_op_o = funct3;
        div_reg_waddr_o = reg_waddr_i;
        if ((opcode == `INST_TYPE_R_M) && (funct7 == 7'b0000001)) begin
            div_we = `WriteDisable;
            div_wdata = `ZeroWord;
            div_waddr = `ZeroWord;
            case (funct3)
                `INST_DIV, `INST_DIVU, `INST_REM, `INST_REMU: begin
                    div_start = `DivStart;
                    div_jump_flag = `JumpEnable;
                    div_hold_flag = `HoldEnable;
                    div_jump_addr = op1_jump_add_op2_jump_res;
                end
                default: begin
                    div_start = `DivStop;
                    div_jump_flag = `JumpDisable;
                    div_hold_flag = `HoldDisable;
                    div_jump_addr = `ZeroWord;
                end
            endcase
        end else begin
            div_jump_flag = `JumpDisable;
            div_jump_addr = `ZeroWord;
            if (div_busy_i == `True) begin
                div_start = `DivStart;
                div_we = `WriteDisable;
                div_wdata = `ZeroWord;
                div_waddr = `ZeroWord;
                div_hold_flag = `HoldEnable;
            end else begin
                div_start = `DivStop;
                div_hold_flag = `HoldDisable;
                if (div_ready_i == `DivResultReady) begin
                    div_wdata = div_result_i;
                    div_waddr = div_reg_waddr_i;
                    div_we = `WriteEnable;
                end else begin
                    div_we = `WriteDisable;
                    div_wdata = `ZeroWord;
                    div_waddr = `ZeroWord;
                end
            end
        end
    end

    // 执行
    always @ (*) begin
        reg_we = reg_we_i;
        reg_waddr = reg_waddr_i;
        mem_req = `RIB_NREQ;
        csr_wdata_o = `ZeroWord;

        case (opcode)
            `INST_TYPE_I: begin
                case (funct3)
                    `INST_ADDI: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = op1_add_op2_res;
                    end
                    `INST_SLTI: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = {32{(~op1_ge_op2_signed)}} & 32'h1;
                    end
                    `INST_SLTIU: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = {32{(~op1_ge_op2_unsigned)}} & 32'h1;
                    end
                    `INST_XORI: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = op1_i ^ op2_i;
                    end
                    `INST_ORI: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = op1_i | op2_i;
                    end
                    `INST_ANDI: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = op1_i & op2_i;
                    end
                    `INST_SLLI: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = reg1_rdata_i << inst_i[24:20];
                    end
                    `INST_SRI: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        if (inst_i[30] == 1'b1) begin
                            reg_wdata = (sri_shift & sri_shift_mask) | ({32{reg1_rdata_i[31]}} & (~sri_shift_mask));
                        end else begin
                            reg_wdata = reg1_rdata_i >> inst_i[24:20];
                        end
                    end
                    default: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = `ZeroWord;
                    end
                endcase
            end
            `INST_TYPE_R_M: begin
                if ((funct7 == 7'b0000000) || (funct7 == 7'b0100000)) begin
                    case (funct3)
                        `INST_ADD_SUB: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            if (inst_i[30] == 1'b0) begin
                                reg_wdata = op1_add_op2_res;
                            end else begin
                                reg_wdata = op1_i - op2_i;
                            end
                        end
                        `INST_SLL: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            reg_wdata = op1_i << op2_i[4:0];
                        end
                        `INST_SLT: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            reg_wdata = {32{(~op1_ge_op2_signed)}} & 32'h1;
                        end
                        `INST_SLTU: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            reg_wdata = {32{(~op1_ge_op2_unsigned)}} & 32'h1;
                        end
                        `INST_XOR: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            reg_wdata = op1_i ^ op2_i;
                        end
                        `INST_SR: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            if (inst_i[30] == 1'b1) begin
                                reg_wdata = (sr_shift & sr_shift_mask) | ({32{reg1_rdata_i[31]}} & (~sr_shift_mask));
                            end else begin
                                reg_wdata = reg1_rdata_i >> reg2_rdata_i[4:0];
                            end
                        end
                        `INST_OR: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            reg_wdata = op1_i | op2_i;
                        end
                        `INST_AND: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            reg_wdata = op1_i & op2_i;
                        end
                        default: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            reg_wdata = `ZeroWord;
                        end
                    endcase
                end else if (funct7 == 7'b0000001) begin
                    case (funct3)
                        `INST_MUL: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            reg_wdata = mul_temp[31:0];
                        end
                        `INST_MULHU: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            reg_wdata = mul_temp[63:32];
                        end
                        `INST_MULH: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            case ({reg1_rdata_i[31], reg2_rdata_i[31]})
                                2'b00: begin
                                    reg_wdata = mul_temp[63:32];
                                end
                                2'b11: begin
                                    reg_wdata = mul_temp[63:32];
                                end
                                2'b10: begin
                                    reg_wdata = mul_temp_invert[63:32];
                                end
                                default: begin
                                    reg_wdata = mul_temp_invert[63:32];
                                end
                            endcase
                        end
                        `INST_MULHSU: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            if (reg1_rdata_i[31] == 1'b1) begin
                                reg_wdata = mul_temp_invert[63:32];
                            end else begin
                                reg_wdata = mul_temp[63:32];
                            end
                        end
                        default: begin
                            jump_flag = `JumpDisable;
                            hold_flag = `HoldDisable;
                            jump_addr = `ZeroWord;
                            mem_wdata_o = `ZeroWord;
                            mem_raddr_o = `ZeroWord;
                            mem_waddr_o = `ZeroWord;
                            mem_we = `WriteDisable;
                            reg_wdata = `ZeroWord;
                        end
                    endcase
                end else begin
                    jump_flag = `JumpDisable;
                    hold_flag = `HoldDisable;
                    jump_addr = `ZeroWord;
                    mem_wdata_o = `ZeroWord;
                    mem_raddr_o = `ZeroWord;
                    mem_waddr_o = `ZeroWord;
                    mem_we = `WriteDisable;
                    reg_wdata = `ZeroWord;
                end
            end
            `INST_TYPE_L: begin
                case (funct3)
                    `INST_LB: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        mem_req = `RIB_REQ;
                        mem_raddr_o = op1_add_op2_res;
                        case (mem_raddr_index)
                            2'b00: begin
                                reg_wdata = {{24{mem_rdata_i[7]}}, mem_rdata_i[7:0]};
                            end
                            2'b01: begin
                                reg_wdata = {{24{mem_rdata_i[15]}}, mem_rdata_i[15:8]};
                            end
                            2'b10: begin
                                reg_wdata = {{24{mem_rdata_i[23]}}, mem_rdata_i[23:16]};
                            end
                            default: begin
                                reg_wdata = {{24{mem_rdata_i[31]}}, mem_rdata_i[31:24]};
                            end
                        endcase
                    end
                    `INST_LH: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        mem_req = `RIB_REQ;
                        mem_raddr_o = op1_add_op2_res;
                        if (mem_raddr_index == 2'b0) begin
                            reg_wdata = {{16{mem_rdata_i[15]}}, mem_rdata_i[15:0]};
                        end else begin
                            reg_wdata = {{16{mem_rdata_i[31]}}, mem_rdata_i[31:16]};
                        end
                    end
                    `INST_LW: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        mem_req = `RIB_REQ;
                        mem_raddr_o = op1_add_op2_res;
                        reg_wdata = mem_rdata_i;
                    end
                    `INST_LBU: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        mem_req = `RIB_REQ;
                        mem_raddr_o = op1_add_op2_res;
                        case (mem_raddr_index)
                            2'b00: begin
                                reg_wdata = {24'h0, mem_rdata_i[7:0]};
                            end
                            2'b01: begin
                                reg_wdata = {24'h0, mem_rdata_i[15:8]};
                            end
                            2'b10: begin
                                reg_wdata = {24'h0, mem_rdata_i[23:16]};
                            end
                            default: begin
                                reg_wdata = {24'h0, mem_rdata_i[31:24]};
                            end
                        endcase
                    end
                    `INST_LHU: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        mem_req = `RIB_REQ;
                        mem_raddr_o = op1_add_op2_res;
                        if (mem_raddr_index == 2'b0) begin
                            reg_wdata = {16'h0, mem_rdata_i[15:0]};
                        end else begin
                            reg_wdata = {16'h0, mem_rdata_i[31:16]};
                        end
                    end
                    default: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = `ZeroWord;
                    end
                endcase
            end
            `INST_TYPE_S: begin
                case (funct3)
                    `INST_SB: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        reg_wdata = `ZeroWord;
                        mem_we = `WriteEnable;
                        mem_req = `RIB_REQ;
                        mem_waddr_o = op1_add_op2_res;
                        mem_raddr_o = op1_add_op2_res;
                        case (mem_waddr_index)
                            2'b00: begin
                                mem_wdata_o = {mem_rdata_i[31:8], reg2_rdata_i[7:0]};
                            end
                            2'b01: begin
                                mem_wdata_o = {mem_rdata_i[31:16], reg2_rdata_i[7:0], mem_rdata_i[7:0]};
                            end
                            2'b10: begin
                                mem_wdata_o = {mem_rdata_i[31:24], reg2_rdata_i[7:0], mem_rdata_i[15:0]};
                            end
                            default: begin
                                mem_wdata_o = {reg2_rdata_i[7:0], mem_rdata_i[23:0]};
                            end
                        endcase
                    end
                    `INST_SH: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        reg_wdata = `ZeroWord;
                        mem_we = `WriteEnable;
                        mem_req = `RIB_REQ;
                        mem_waddr_o = op1_add_op2_res;
                        mem_raddr_o = op1_add_op2_res;
                        if (mem_waddr_index == 2'b00) begin
                            mem_wdata_o = {mem_rdata_i[31:16], reg2_rdata_i[15:0]};
                        end else begin
                            mem_wdata_o = {reg2_rdata_i[15:0], mem_rdata_i[15:0]};
                        end
                    end
                    `INST_SW: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        reg_wdata = `ZeroWord;
                        mem_we = `WriteEnable;
                        mem_req = `RIB_REQ;
                        mem_waddr_o = op1_add_op2_res;
                        mem_raddr_o = op1_add_op2_res;
                        mem_wdata_o = reg2_rdata_i;
                    end
                    default: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = `ZeroWord;
                    end
                endcase
            end
            `INST_TYPE_B: begin
                case (funct3)
                    `INST_BEQ: begin
                        hold_flag = `HoldDisable;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = `ZeroWord;
                        jump_flag = op1_eq_op2 & `JumpEnable;
                        jump_addr = {32{op1_eq_op2}} & op1_jump_add_op2_jump_res;
                    end
                    `INST_BNE: begin
                        hold_flag = `HoldDisable;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = `ZeroWord;
                        jump_flag = (~op1_eq_op2) & `JumpEnable;
                        jump_addr = {32{(~op1_eq_op2)}} & op1_jump_add_op2_jump_res;
                    end
                    `INST_BLT: begin
                        hold_flag = `HoldDisable;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = `ZeroWord;
                        jump_flag = (~op1_ge_op2_signed) & `JumpEnable;
                        jump_addr = {32{(~op1_ge_op2_signed)}} & op1_jump_add_op2_jump_res;
                    end
                    `INST_BGE: begin
                        hold_flag = `HoldDisable;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = `ZeroWord;
                        jump_flag = (op1_ge_op2_signed) & `JumpEnable;
                        jump_addr = {32{(op1_ge_op2_signed)}} & op1_jump_add_op2_jump_res;
                    end
                    `INST_BLTU: begin
                        hold_flag = `HoldDisable;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = `ZeroWord;
                        jump_flag = (~op1_ge_op2_unsigned) & `JumpEnable;
                        jump_addr = {32{(~op1_ge_op2_unsigned)}} & op1_jump_add_op2_jump_res;
                    end
                    `INST_BGEU: begin
                        hold_flag = `HoldDisable;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = `ZeroWord;
                        jump_flag = (op1_ge_op2_unsigned) & `JumpEnable;
                        jump_addr = {32{(op1_ge_op2_unsigned)}} & op1_jump_add_op2_jump_res;
                    end
                    default: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = `ZeroWord;
                    end
                endcase
            end
            `INST_JAL, `INST_JALR: begin
                hold_flag = `HoldDisable;
                mem_wdata_o = `ZeroWord;
                mem_raddr_o = `ZeroWord;
                mem_waddr_o = `ZeroWord;
                mem_we = `WriteDisable;
                jump_flag = `JumpEnable;
                jump_addr = op1_jump_add_op2_jump_res;
                reg_wdata = op1_add_op2_res;
            end
            `INST_LUI, `INST_AUIPC: begin
                hold_flag = `HoldDisable;
                mem_wdata_o = `ZeroWord;
                mem_raddr_o = `ZeroWord;
                mem_waddr_o = `ZeroWord;
                mem_we = `WriteDisable;
                jump_addr = `ZeroWord;
                jump_flag = `JumpDisable;
                reg_wdata = op1_add_op2_res;
            end
            `INST_NOP_OP: begin
                jump_flag = `JumpDisable;
                hold_flag = `HoldDisable;
                jump_addr = `ZeroWord;
                mem_wdata_o = `ZeroWord;
                mem_raddr_o = `ZeroWord;
                mem_waddr_o = `ZeroWord;
                mem_we = `WriteDisable;
                reg_wdata = `ZeroWord;
            end
            `INST_FENCE: begin
                hold_flag = `HoldDisable;
                mem_wdata_o = `ZeroWord;
                mem_raddr_o = `ZeroWord;
                mem_waddr_o = `ZeroWord;
                mem_we = `WriteDisable;
                reg_wdata = `ZeroWord;
                jump_flag = `JumpEnable;
                jump_addr = op1_jump_add_op2_jump_res;
            end
            `INST_CSR: begin
                jump_flag = `JumpDisable;
                hold_flag = `HoldDisable;
                jump_addr = `ZeroWord;
                mem_wdata_o = `ZeroWord;
                mem_raddr_o = `ZeroWord;
                mem_waddr_o = `ZeroWord;
                mem_we = `WriteDisable;
                case (funct3)
                    `INST_CSRRW: begin
                        csr_wdata_o = reg1_rdata_i;
                        reg_wdata = csr_rdata_i;
                    end
                    `INST_CSRRS: begin
                        csr_wdata_o = reg1_rdata_i | csr_rdata_i;
                        reg_wdata = csr_rdata_i;
                    end
                    `INST_CSRRC: begin
                        csr_wdata_o = csr_rdata_i & (~reg1_rdata_i);
                        reg_wdata = csr_rdata_i;
                    end
                    `INST_CSRRWI: begin
                        csr_wdata_o = {27'h0, uimm};
                        reg_wdata = csr_rdata_i;
                    end
                    `INST_CSRRSI: begin
                        csr_wdata_o = {27'h0, uimm} | csr_rdata_i;
                        reg_wdata = csr_rdata_i;
                    end
                    `INST_CSRRCI: begin
                        csr_wdata_o = (~{27'h0, uimm}) & csr_rdata_i;
                        reg_wdata = csr_rdata_i;
                    end
                    default: begin
                        jump_flag = `JumpDisable;
                        hold_flag = `HoldDisable;
                        jump_addr = `ZeroWord;
                        mem_wdata_o = `ZeroWord;
                        mem_raddr_o = `ZeroWord;
                        mem_waddr_o = `ZeroWord;
                        mem_we = `WriteDisable;
                        reg_wdata = `ZeroWord;
                    end
                endcase
            end
            default: begin
                jump_flag = `JumpDisable;
                hold_flag = `HoldDisable;
                jump_addr = `ZeroWord;
                mem_wdata_o = `ZeroWord;
                mem_raddr_o = `ZeroWord;
                mem_waddr_o = `ZeroWord;
                mem_we = `WriteDisable;
                reg_wdata = `ZeroWord;
            end
        endcase
    end

endmodule

module id(

	input wire rst,

    // from if_id
    input wire[`InstBus] inst_i,             // 指令内容
    input wire[`InstAddrBus] inst_addr_i,    // 指令地址

    // from regs
    input wire[`RegBus] reg1_rdata_i,        // 通用寄存器1输入数据
    input wire[`RegBus] reg2_rdata_i,        // 通用寄存器2输入数据

    // from csr reg
    input wire[`RegBus] csr_rdata_i,         // CSR寄存器输入数据

    // from ex
    input wire ex_jump_flag_i,               // 跳转标志

    // to regs
    output reg[`RegAddrBus] reg1_raddr_o,    // 读通用寄存器1地址
    output reg[`RegAddrBus] reg2_raddr_o,    // 读通用寄存器2地址

    // to csr reg
    output reg[`MemAddrBus] csr_raddr_o,     // 读CSR寄存器地址

    // to ex
    output reg[`MemAddrBus] op1_o,
    output reg[`MemAddrBus] op2_o,
    output reg[`MemAddrBus] op1_jump_o,
    output reg[`MemAddrBus] op2_jump_o,
    output reg[`InstBus] inst_o,             // 指令内容
    output reg[`InstAddrBus] inst_addr_o,    // 指令地址
    output reg[`RegBus] reg1_rdata_o,        // 通用寄存器1数据
    output reg[`RegBus] reg2_rdata_o,        // 通用寄存器2数据
    output reg reg_we_o,                     // 写通用寄存器标志
    output reg[`RegAddrBus] reg_waddr_o,     // 写通用寄存器地址
    output reg csr_we_o,                     // 写CSR寄存器标志
    output reg[`RegBus] csr_rdata_o,         // CSR寄存器数据
    output reg[`MemAddrBus] csr_waddr_o      // 写CSR寄存器地址

    );

    wire[6:0] opcode = inst_i[6:0];
    wire[2:0] funct3 = inst_i[14:12];
    wire[6:0] funct7 = inst_i[31:25];
    wire[4:0] rd = inst_i[11:7];
    wire[4:0] rs1 = inst_i[19:15];
    wire[4:0] rs2 = inst_i[24:20];


    always @ (*) begin
        inst_o = inst_i;
        inst_addr_o = inst_addr_i;
        reg1_rdata_o = reg1_rdata_i;
        reg2_rdata_o = reg2_rdata_i;
        csr_rdata_o = csr_rdata_i;
        csr_raddr_o = `ZeroWord;
        csr_waddr_o = `ZeroWord;
        csr_we_o = `WriteDisable;
        op1_o = `ZeroWord;
        op2_o = `ZeroWord;
        op1_jump_o = `ZeroWord;
        op2_jump_o = `ZeroWord;

        case (opcode)
            `INST_TYPE_I: begin
                case (funct3)
                    `INST_ADDI, `INST_SLTI, `INST_SLTIU, `INST_XORI, `INST_ORI, `INST_ANDI, `INST_SLLI, `INST_SRI: begin
                        reg_we_o = `WriteEnable;
                        reg_waddr_o = rd;
                        reg1_raddr_o = rs1;
                        reg2_raddr_o = `ZeroReg;
                        op1_o = reg1_rdata_i;
                        op2_o = {{20{inst_i[31]}}, inst_i[31:20]};
                    end
                    default: begin
                        reg_we_o = `WriteDisable;
                        reg_waddr_o = `ZeroReg;
                        reg1_raddr_o = `ZeroReg;
                        reg2_raddr_o = `ZeroReg;
                    end
                endcase
            end
            `INST_TYPE_R_M: begin
                if ((funct7 == 7'b0000000) || (funct7 == 7'b0100000)) begin
                    case (funct3)
                        `INST_ADD_SUB, `INST_SLL, `INST_SLT, `INST_SLTU, `INST_XOR, `INST_SR, `INST_OR, `INST_AND: begin
                            reg_we_o = `WriteEnable;
                            reg_waddr_o = rd;
                            reg1_raddr_o = rs1;
                            reg2_raddr_o = rs2;
                            op1_o = reg1_rdata_i;
                            op2_o = reg2_rdata_i;
                        end
                        default: begin
                            reg_we_o = `WriteDisable;
                            reg_waddr_o = `ZeroReg;
                            reg1_raddr_o = `ZeroReg;
                            reg2_raddr_o = `ZeroReg;
                        end
                    endcase
                end else if (funct7 == 7'b0000001) begin
                    case (funct3)
                        `INST_MUL, `INST_MULHU, `INST_MULH, `INST_MULHSU: begin
                            reg_we_o = `WriteEnable;
                            reg_waddr_o = rd;
                            reg1_raddr_o = rs1;
                            reg2_raddr_o = rs2;
                            op1_o = reg1_rdata_i;
                            op2_o = reg2_rdata_i;
                        end
                        `INST_DIV, `INST_DIVU, `INST_REM, `INST_REMU: begin
                            reg_we_o = `WriteDisable;
                            reg_waddr_o = rd;
                            reg1_raddr_o = rs1;
                            reg2_raddr_o = rs2;
                            op1_o = reg1_rdata_i;
                            op2_o = reg2_rdata_i;
                            op1_jump_o = inst_addr_i;
                            op2_jump_o = 32'h4;
                        end
                        default: begin
                            reg_we_o = `WriteDisable;
                            reg_waddr_o = `ZeroReg;
                            reg1_raddr_o = `ZeroReg;
                            reg2_raddr_o = `ZeroReg;
                        end
                    endcase
                end else begin
                    reg_we_o = `WriteDisable;
                    reg_waddr_o = `ZeroReg;
                    reg1_raddr_o = `ZeroReg;
                    reg2_raddr_o = `ZeroReg;
                end
            end
            `INST_TYPE_L: begin
                case (funct3)
                    `INST_LB, `INST_LH, `INST_LW, `INST_LBU, `INST_LHU: begin
                        reg1_raddr_o = rs1;
                        reg2_raddr_o = `ZeroReg;
                        reg_we_o = `WriteEnable;
                        reg_waddr_o = rd;
                        op1_o = reg1_rdata_i;
                        op2_o = {{20{inst_i[31]}}, inst_i[31:20]};
                    end
                    default: begin
                        reg1_raddr_o = `ZeroReg;
                        reg2_raddr_o = `ZeroReg;
                        reg_we_o = `WriteDisable;
                        reg_waddr_o = `ZeroReg;
                    end
                endcase
            end
            `INST_TYPE_S: begin
                case (funct3)
                    `INST_SB, `INST_SW, `INST_SH: begin
                        reg1_raddr_o = rs1;
                        reg2_raddr_o = rs2;
                        reg_we_o = `WriteDisable;
                        reg_waddr_o = `ZeroReg;
                        op1_o = reg1_rdata_i;
                        op2_o = {{20{inst_i[31]}}, inst_i[31:25], inst_i[11:7]};
                    end
                    default: begin
                        reg1_raddr_o = `ZeroReg;
                        reg2_raddr_o = `ZeroReg;
                        reg_we_o = `WriteDisable;
                        reg_waddr_o = `ZeroReg;
                    end
                endcase
            end
            `INST_TYPE_B: begin
                case (funct3)
                    `INST_BEQ, `INST_BNE, `INST_BLT, `INST_BGE, `INST_BLTU, `INST_BGEU: begin
                        reg1_raddr_o = rs1;
                        reg2_raddr_o = rs2;
                        reg_we_o = `WriteDisable;
                        reg_waddr_o = `ZeroReg;
                        op1_o = reg1_rdata_i;
                        op2_o = reg2_rdata_i;
                        op1_jump_o = inst_addr_i;
                        op2_jump_o = {{20{inst_i[31]}}, inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0};
                    end
                    default: begin
                        reg1_raddr_o = `ZeroReg;
                        reg2_raddr_o = `ZeroReg;
                        reg_we_o = `WriteDisable;
                        reg_waddr_o = `ZeroReg;
                    end
                endcase
            end
            `INST_JAL: begin
                reg_we_o = `WriteEnable;
                reg_waddr_o = rd;
                reg1_raddr_o = `ZeroReg;
                reg2_raddr_o = `ZeroReg;
                op1_o = inst_addr_i;
                op2_o = 32'h4;
                op1_jump_o = inst_addr_i;
                op2_jump_o = {{12{inst_i[31]}}, inst_i[19:12], inst_i[20], inst_i[30:21], 1'b0};
            end
            `INST_JALR: begin
                reg_we_o = `WriteEnable;
                reg1_raddr_o = rs1;
                reg2_raddr_o = `ZeroReg;
                reg_waddr_o = rd;
                op1_o = inst_addr_i;
                op2_o = 32'h4;
                op1_jump_o = reg1_rdata_i;
                op2_jump_o = {{20{inst_i[31]}}, inst_i[31:20]};
            end
            `INST_LUI: begin
                reg_we_o = `WriteEnable;
                reg_waddr_o = rd;
                reg1_raddr_o = `ZeroReg;
                reg2_raddr_o = `ZeroReg;
                op1_o = {inst_i[31:12], 12'b0};
                op2_o = `ZeroWord;
            end
            `INST_AUIPC: begin
                reg_we_o = `WriteEnable;
                reg_waddr_o = rd;
                reg1_raddr_o = `ZeroReg;
                reg2_raddr_o = `ZeroReg;
                op1_o = inst_addr_i;
                op2_o = {inst_i[31:12], 12'b0};
            end
            `INST_NOP_OP: begin
                reg_we_o = `WriteDisable;
                reg_waddr_o = `ZeroReg;
                reg1_raddr_o = `ZeroReg;
                reg2_raddr_o = `ZeroReg;
            end
            `INST_FENCE: begin
                reg_we_o = `WriteDisable;
                reg_waddr_o = `ZeroReg;
                reg1_raddr_o = `ZeroReg;
                reg2_raddr_o = `ZeroReg;
                op1_jump_o = inst_addr_i;
                op2_jump_o = 32'h4;
            end
            `INST_CSR: begin
                reg_we_o = `WriteDisable;
                reg_waddr_o = `ZeroReg;
                reg1_raddr_o = `ZeroReg;
                reg2_raddr_o = `ZeroReg;
                csr_raddr_o = {20'h0, inst_i[31:20]};
                csr_waddr_o = {20'h0, inst_i[31:20]};
                case (funct3)
                    `INST_CSRRW, `INST_CSRRS, `INST_CSRRC: begin
                        reg1_raddr_o = rs1;
                        reg2_raddr_o = `ZeroReg;
                        reg_we_o = `WriteEnable;
                        reg_waddr_o = rd;
                        csr_we_o = `WriteEnable;
                    end
                    `INST_CSRRWI, `INST_CSRRSI, `INST_CSRRCI: begin
                        reg1_raddr_o = `ZeroReg;
                        reg2_raddr_o = `ZeroReg;
                        reg_we_o = `WriteEnable;
                        reg_waddr_o = rd;
                        csr_we_o = `WriteEnable;
                    end
                    default: begin
                        reg_we_o = `WriteDisable;
                        reg_waddr_o = `ZeroReg;
                        reg1_raddr_o = `ZeroReg;
                        reg2_raddr_o = `ZeroReg;
                        csr_we_o = `WriteDisable;
                    end
                endcase
            end
            default: begin
                reg_we_o = `WriteDisable;
                reg_waddr_o = `ZeroReg;
                reg1_raddr_o = `ZeroReg;
                reg2_raddr_o = `ZeroReg;
            end
        endcase
    end

endmodule

module id_ex(

    input wire clk,
    input wire rst,

    input wire[`InstBus] inst_i,            // 指令内容
    input wire[`InstAddrBus] inst_addr_i,   // 指令地址
    input wire reg_we_i,                    // 写通用寄存器标志
    input wire[`RegAddrBus] reg_waddr_i,    // 写通用寄存器地址
    input wire[`RegBus] reg1_rdata_i,       // 通用寄存器1读数据
    input wire[`RegBus] reg2_rdata_i,       // 通用寄存器2读数据
    input wire csr_we_i,                    // 写CSR寄存器标志
    input wire[`MemAddrBus] csr_waddr_i,    // 写CSR寄存器地址
    input wire[`RegBus] csr_rdata_i,        // CSR寄存器读数据
    input wire[`MemAddrBus] op1_i,
    input wire[`MemAddrBus] op2_i,
    input wire[`MemAddrBus] op1_jump_i,
    input wire[`MemAddrBus] op2_jump_i,

    input wire[`Hold_Flag_Bus] hold_flag_i, // 流水线暂停标志

    output wire[`MemAddrBus] op1_o,
    output wire[`MemAddrBus] op2_o,
    output wire[`MemAddrBus] op1_jump_o,
    output wire[`MemAddrBus] op2_jump_o,
    output wire[`InstBus] inst_o,            // 指令内容
    output wire[`InstAddrBus] inst_addr_o,   // 指令地址
    output wire reg_we_o,                    // 写通用寄存器标志
    output wire[`RegAddrBus] reg_waddr_o,    // 写通用寄存器地址
    output wire[`RegBus] reg1_rdata_o,       // 通用寄存器1读数据
    output wire[`RegBus] reg2_rdata_o,       // 通用寄存器2读数据
    output wire csr_we_o,                    // 写CSR寄存器标志
    output wire[`MemAddrBus] csr_waddr_o,    // 写CSR寄存器地址
    output wire[`RegBus] csr_rdata_o         // CSR寄存器读数据

    );

    wire hold_en = (hold_flag_i >= `Hold_Id);

    wire[`InstBus] inst;
    gen_pipe_dff #(32) inst_ff(clk, rst, hold_en, `INST_NOP, inst_i, inst);
    assign inst_o = inst;

    wire[`InstAddrBus] inst_addr;
    gen_pipe_dff #(32) inst_addr_ff(clk, rst, hold_en, `ZeroWord, inst_addr_i, inst_addr);
    assign inst_addr_o = inst_addr;

    wire reg_we;
    gen_pipe_dff #(1) reg_we_ff(clk, rst, hold_en, `WriteDisable, reg_we_i, reg_we);
    assign reg_we_o = reg_we;

    wire[`RegAddrBus] reg_waddr;
    gen_pipe_dff #(5) reg_waddr_ff(clk, rst, hold_en, `ZeroReg, reg_waddr_i, reg_waddr);
    assign reg_waddr_o = reg_waddr;

    wire[`RegBus] reg1_rdata;
    gen_pipe_dff #(32) reg1_rdata_ff(clk, rst, hold_en, `ZeroWord, reg1_rdata_i, reg1_rdata);
    assign reg1_rdata_o = reg1_rdata;

    wire[`RegBus] reg2_rdata;
    gen_pipe_dff #(32) reg2_rdata_ff(clk, rst, hold_en, `ZeroWord, reg2_rdata_i, reg2_rdata);
    assign reg2_rdata_o = reg2_rdata;

    wire csr_we;
    gen_pipe_dff #(1) csr_we_ff(clk, rst, hold_en, `WriteDisable, csr_we_i, csr_we);
    assign csr_we_o = csr_we;

    wire[`MemAddrBus] csr_waddr;
    gen_pipe_dff #(32) csr_waddr_ff(clk, rst, hold_en, `ZeroWord, csr_waddr_i, csr_waddr);
    assign csr_waddr_o = csr_waddr;

    wire[`RegBus] csr_rdata;
    gen_pipe_dff #(32) csr_rdata_ff(clk, rst, hold_en, `ZeroWord, csr_rdata_i, csr_rdata);
    assign csr_rdata_o = csr_rdata;

    wire[`MemAddrBus] op1;
    gen_pipe_dff #(32) op1_ff(clk, rst, hold_en, `ZeroWord, op1_i, op1);
    assign op1_o = op1;

    wire[`MemAddrBus] op2;
    gen_pipe_dff #(32) op2_ff(clk, rst, hold_en, `ZeroWord, op2_i, op2);
    assign op2_o = op2;

    wire[`MemAddrBus] op1_jump;
    gen_pipe_dff #(32) op1_jump_ff(clk, rst, hold_en, `ZeroWord, op1_jump_i, op1_jump);
    assign op1_jump_o = op1_jump;

    wire[`MemAddrBus] op2_jump;
    gen_pipe_dff #(32) op2_jump_ff(clk, rst, hold_en, `ZeroWord, op2_jump_i, op2_jump);
    assign op2_jump_o = op2_jump;

endmodule

module if_id(

    input wire clk,
    input wire rst,

    input wire[`InstBus] inst_i,            // 指令内容
    input wire[`InstAddrBus] inst_addr_i,   // 指令地址

    input wire[`Hold_Flag_Bus] hold_flag_i, // 流水线暂停标志

    input wire[`INT_BUS] int_flag_i,        // 外设中断输入信号
    output wire[`INT_BUS] int_flag_o,

    output wire[`InstBus] inst_o,           // 指令内容
    output wire[`InstAddrBus] inst_addr_o   // 指令地址

    );

    wire hold_en = (hold_flag_i >= `Hold_If);

    wire[`InstBus] inst;
    gen_pipe_dff #(32) inst_ff(clk, rst, hold_en, `INST_NOP, inst_i, inst);
    assign inst_o = inst;

    wire[`InstAddrBus] inst_addr;
    gen_pipe_dff #(32) inst_addr_ff(clk, rst, hold_en, `ZeroWord, inst_addr_i, inst_addr);
    assign inst_addr_o = inst_addr;

    wire[`INT_BUS] int_flag;
    gen_pipe_dff #(8) int_ff(clk, rst, hold_en, `INT_NONE, int_flag_i, int_flag);
    assign int_flag_o = int_flag;

endmodule

module pc_reg(

    input wire clk,
    input wire rst,

    input wire jump_flag_i,                 // 跳转标志
    input wire[`InstAddrBus] jump_addr_i,   // 跳转地址
    input wire[`Hold_Flag_Bus] hold_flag_i, // 流水线暂停标志
    input wire jtag_reset_flag_i,           // 复位标志

    output reg[`InstAddrBus] pc_o           // PC指针

    );


    always @ (posedge clk) begin
        // 复位
        if (rst == `RstEnable || jtag_reset_flag_i == 1'b1) begin
            pc_o <= `CpuResetAddr;
        // 跳转
        end else if (jump_flag_i == `JumpEnable) begin
            pc_o <= jump_addr_i;
        // 暂停
        end else if (hold_flag_i >= `Hold_Pc) begin
            pc_o <= pc_o;
        // 地址加4
        end else begin
            pc_o <= pc_o + 4'h4;
        end
    end

endmodule

module regs(

    input wire clk,
    input wire rst,

    // from ex
    input wire we_i,                      // 写寄存器标志
    input wire[`RegAddrBus] waddr_i,      // 写寄存器地址
    input wire[`RegBus] wdata_i,          // 写寄存器数据

    // from jtag
    input wire jtag_we_i,                 // 写寄存器标志
    input wire[`RegAddrBus] jtag_addr_i,  // 读、写寄存器地址
    input wire[`RegBus] jtag_data_i,      // 写寄存器数据

    // from id
    input wire[`RegAddrBus] raddr1_i,     // 读寄存器1地址

    // to id
    output reg[`RegBus] rdata1_o,         // 读寄存器1数据

    // from id
    input wire[`RegAddrBus] raddr2_i,     // 读寄存器2地址

    // to id
    output reg[`RegBus] rdata2_o,         // 读寄存器2数据

    // to jtag
    output reg[`RegBus] jtag_data_o       // 读寄存器数据

    );

    reg[`RegBus] regs[0:`RegNum - 1];

    // 写寄存器
    always @ (posedge clk) begin
        if (rst == `RstDisable) begin
            // 优先ex模块写操作
            if ((we_i == `WriteEnable) && (waddr_i != `ZeroReg)) begin
                regs[waddr_i] <= wdata_i;
            end else if ((jtag_we_i == `WriteEnable) && (jtag_addr_i != `ZeroReg)) begin
                regs[jtag_addr_i] <= jtag_data_i;
            end
        end
    end

    // 读寄存器1
    always @ (*) begin
        if (raddr1_i == `ZeroReg) begin
            rdata1_o = `ZeroWord;
        // 如果读地址等于写地址，并且正在写操作，则直接返回写数据
        end else if (raddr1_i == waddr_i && we_i == `WriteEnable) begin
            rdata1_o = wdata_i;
        end else begin
            rdata1_o = regs[raddr1_i];
        end
    end

    // 读寄存器2
    always @ (*) begin
        if (raddr2_i == `ZeroReg) begin
            rdata2_o = `ZeroWord;
        // 如果读地址等于写地址，并且正在写操作，则直接返回写数据
        end else if (raddr2_i == waddr_i && we_i == `WriteEnable) begin
            rdata2_o = wdata_i;
        end else begin
            rdata2_o = regs[raddr2_i];
        end
    end

    // jtag读寄存器
    always @ (*) begin
        if (jtag_addr_i == `ZeroReg) begin
            jtag_data_o = `ZeroWord;
        end else begin
            jtag_data_o = regs[jtag_addr_i];
        end
    end

endmodule

module rib(

    input wire clk,
    input wire rst,

    // master 0 interface
    input wire[`MemAddrBus] m0_addr_i,     // 主设备0读、写地址
    input wire[`MemBus] m0_data_i,         // 主设备0写数据
    output reg[`MemBus] m0_data_o,         // 主设备0读取到的数据
    input wire m0_req_i,                   // 主设备0访问请求标志
    input wire m0_we_i,                    // 主设备0写标志

    // master 1 interface
    input wire[`MemAddrBus] m1_addr_i,     // 主设备1读、写地址
    input wire[`MemBus] m1_data_i,         // 主设备1写数据
    output reg[`MemBus] m1_data_o,         // 主设备1读取到的数据
    input wire m1_req_i,                   // 主设备1访问请求标志
    input wire m1_we_i,                    // 主设备1写标志

    // master 2 interface
    input wire[`MemAddrBus] m2_addr_i,     // 主设备2读、写地址
    input wire[`MemBus] m2_data_i,         // 主设备2写数据
    output reg[`MemBus] m2_data_o,         // 主设备2读取到的数据
    input wire m2_req_i,                   // 主设备2访问请求标志
    input wire m2_we_i,                    // 主设备2写标志

    // master 3 interface
    input wire[`MemAddrBus] m3_addr_i,     // 主设备3读、写地址
    input wire[`MemBus] m3_data_i,         // 主设备3写数据
    output reg[`MemBus] m3_data_o,         // 主设备3读取到的数据
    input wire m3_req_i,                   // 主设备3访问请求标志
    input wire m3_we_i,                    // 主设备3写标志

    // slave 0 interface
    output reg[`MemAddrBus] s0_addr_o,     // 从设备0读、写地址
    output reg[`MemBus] s0_data_o,         // 从设备0写数据
    input wire[`MemBus] s0_data_i,         // 从设备0读取到的数据
    output reg s0_we_o,                    // 从设备0写标志

    // slave 1 interface
    output reg[`MemAddrBus] s1_addr_o,     // 从设备1读、写地址
    output reg[`MemBus] s1_data_o,         // 从设备1写数据
    input wire[`MemBus] s1_data_i,         // 从设备1读取到的数据
    output reg s1_we_o,                    // 从设备1写标志

    // slave 2 interface
    output reg[`MemAddrBus] s2_addr_o,     // 从设备2读、写地址
    output reg[`MemBus] s2_data_o,         // 从设备2写数据
    input wire[`MemBus] s2_data_i,         // 从设备2读取到的数据
    output reg s2_we_o,                    // 从设备2写标志

    // slave 3 interface
    output reg[`MemAddrBus] s3_addr_o,     // 从设备3读、写地址
    output reg[`MemBus] s3_data_o,         // 从设备3写数据
    input wire[`MemBus] s3_data_i,         // 从设备3读取到的数据
    output reg s3_we_o,                    // 从设备3写标志

    // slave 4 interface
    output reg[`MemAddrBus] s4_addr_o,     // 从设备4读、写地址
    output reg[`MemBus] s4_data_o,         // 从设备4写数据
    input wire[`MemBus] s4_data_i,         // 从设备4读取到的数据
    output reg s4_we_o,                    // 从设备4写标志

    // slave 5 interface
    output reg[`MemAddrBus] s5_addr_o,     // 从设备5读、写地址
    output reg[`MemBus] s5_data_o,         // 从设备5写数据
    input wire[`MemBus] s5_data_i,         // 从设备5读取到的数据
    output reg s5_we_o,                    // 从设备5写标志

    output reg hold_flag_o                 // 暂停流水线标志

    );


    // 访问地址的最高4位决定要访问的是哪一个从设备
    // 因此最多支持16个从设备
    parameter [3:0]slave_0 = 4'b0000;
    parameter [3:0]slave_1 = 4'b0001;
    parameter [3:0]slave_2 = 4'b0010;
    parameter [3:0]slave_3 = 4'b0011;
    parameter [3:0]slave_4 = 4'b0100;
    parameter [3:0]slave_5 = 4'b0101;

    parameter [1:0]grant0 = 2'h0;
    parameter [1:0]grant1 = 2'h1;
    parameter [1:0]grant2 = 2'h2;
    parameter [1:0]grant3 = 2'h3;

    wire[3:0] req;
    reg[1:0] grant;


    // 主设备请求信号
    assign req = {m3_req_i, m2_req_i, m1_req_i, m0_req_i};

    // 仲裁逻辑
    // 固定优先级仲裁机制
    // 优先级由高到低：主设备3，主设备0，主设备2，主设备1
    always @ (*) begin
        if (req[3]) begin
            grant = grant3;
            hold_flag_o = `HoldEnable;
        end else if (req[0]) begin
            grant = grant0;
            hold_flag_o = `HoldEnable;
        end else if (req[2]) begin
            grant = grant2;
            hold_flag_o = `HoldEnable;
        end else begin
            grant = grant1;
            hold_flag_o = `HoldDisable;
        end
    end

    // 根据仲裁结果，选择(访问)对应的从设备
    always @ (*) begin
        m0_data_o = `ZeroWord;
        m1_data_o = `INST_NOP;
        m2_data_o = `ZeroWord;
        m3_data_o = `ZeroWord;

        s0_addr_o = `ZeroWord;
        s1_addr_o = `ZeroWord;
        s2_addr_o = `ZeroWord;
        s3_addr_o = `ZeroWord;
        s4_addr_o = `ZeroWord;
        s5_addr_o = `ZeroWord;
        s0_data_o = `ZeroWord;
        s1_data_o = `ZeroWord;
        s2_data_o = `ZeroWord;
        s3_data_o = `ZeroWord;
        s4_data_o = `ZeroWord;
        s5_data_o = `ZeroWord;
        s0_we_o = `WriteDisable;
        s1_we_o = `WriteDisable;
        s2_we_o = `WriteDisable;
        s3_we_o = `WriteDisable;
        s4_we_o = `WriteDisable;
        s5_we_o = `WriteDisable;

        case (grant)
            grant0: begin
                case (m0_addr_i[31:28])
                    slave_0: begin
                        s0_we_o = m0_we_i;
                        s0_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s0_data_o = m0_data_i;
                        m0_data_o = s0_data_i;
                    end
                    slave_1: begin
                        s1_we_o = m0_we_i;
                        s1_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s1_data_o = m0_data_i;
                        m0_data_o = s1_data_i;
                    end
                    slave_2: begin
                        s2_we_o = m0_we_i;
                        s2_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s2_data_o = m0_data_i;
                        m0_data_o = s2_data_i;
                    end
                    slave_3: begin
                        s3_we_o = m0_we_i;
                        s3_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s3_data_o = m0_data_i;
                        m0_data_o = s3_data_i;
                    end
                    slave_4: begin
                        s4_we_o = m0_we_i;
                        s4_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s4_data_o = m0_data_i;
                        m0_data_o = s4_data_i;
                    end
                    slave_5: begin
                        s5_we_o = m0_we_i;
                        s5_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s5_data_o = m0_data_i;
                        m0_data_o = s5_data_i;
                    end
                    default: begin

                    end
                endcase
            end
            grant1: begin
                case (m1_addr_i[31:28])
                    slave_0: begin
                        s0_we_o = m1_we_i;
                        s0_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s0_data_o = m1_data_i;
                        m1_data_o = s0_data_i;
                    end
                    slave_1: begin
                        s1_we_o = m1_we_i;
                        s1_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s1_data_o = m1_data_i;
                        m1_data_o = s1_data_i;
                    end
                    slave_2: begin
                        s2_we_o = m1_we_i;
                        s2_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s2_data_o = m1_data_i;
                        m1_data_o = s2_data_i;
                    end
                    slave_3: begin
                        s3_we_o = m1_we_i;
                        s3_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s3_data_o = m1_data_i;
                        m1_data_o = s3_data_i;
                    end
                    slave_4: begin
                        s4_we_o = m1_we_i;
                        s4_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s4_data_o = m1_data_i;
                        m1_data_o = s4_data_i;
                    end
                    slave_5: begin
                        s5_we_o = m1_we_i;
                        s5_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s5_data_o = m1_data_i;
                        m1_data_o = s5_data_i;
                    end
                    default: begin

                    end
                endcase
            end
            grant2: begin
                case (m2_addr_i[31:28])
                    slave_0: begin
                        s0_we_o = m2_we_i;
                        s0_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s0_data_o = m2_data_i;
                        m2_data_o = s0_data_i;
                    end
                    slave_1: begin
                        s1_we_o = m2_we_i;
                        s1_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s1_data_o = m2_data_i;
                        m2_data_o = s1_data_i;
                    end
                    slave_2: begin
                        s2_we_o = m2_we_i;
                        s2_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s2_data_o = m2_data_i;
                        m2_data_o = s2_data_i;
                    end
                    slave_3: begin
                        s3_we_o = m2_we_i;
                        s3_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s3_data_o = m2_data_i;
                        m2_data_o = s3_data_i;
                    end
                    slave_4: begin
                        s4_we_o = m2_we_i;
                        s4_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s4_data_o = m2_data_i;
                        m2_data_o = s4_data_i;
                    end
                    slave_5: begin
                        s5_we_o = m2_we_i;
                        s5_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s5_data_o = m2_data_i;
                        m2_data_o = s5_data_i;
                    end
                    default: begin

                    end
                endcase
            end
            grant3: begin
                case (m3_addr_i[31:28])
                    slave_0: begin
                        s0_we_o = m3_we_i;
                        s0_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s0_data_o = m3_data_i;
                        m3_data_o = s0_data_i;
                    end
                    slave_1: begin
                        s1_we_o = m3_we_i;
                        s1_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s1_data_o = m3_data_i;
                        m3_data_o = s1_data_i;
                    end
                    slave_2: begin
                        s2_we_o = m3_we_i;
                        s2_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s2_data_o = m3_data_i;
                        m3_data_o = s2_data_i;
                    end
                    slave_3: begin
                        s3_we_o = m3_we_i;
                        s3_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s3_data_o = m3_data_i;
                        m3_data_o = s3_data_i;
                    end
                    slave_4: begin
                        s4_we_o = m3_we_i;
                        s4_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s4_data_o = m3_data_i;
                        m3_data_o = s4_data_i;
                    end
                    slave_5: begin
                        s5_we_o = m3_we_i;
                        s5_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s5_data_o = m3_data_i;
                        m3_data_o = s5_data_i;
                    end
                    default: begin

                    end
                endcase
            end
            default: begin

            end
        endcase
    end

endmodule

module gen_pipe_dff #(
    parameter DW = 32)(

    input wire clk,
    input wire rst,
    input wire hold_en,

    input wire[DW-1:0] def_val,
    input wire[DW-1:0] din,
    output wire[DW-1:0] qout

    );

    reg[DW-1:0] qout_r;

    always @ (posedge clk) begin
        if (!rst | hold_en) begin
            qout_r <= def_val;
        end else begin
            qout_r <= din;
        end
    end

    assign qout = qout_r;

endmodule

// 复位后输出为0的触发器
module gen_rst_0_dff #(
    parameter DW = 32)(

    input wire clk,
    input wire rst,

    input wire[DW-1:0] din,
    output wire[DW-1:0] qout

    );

    reg[DW-1:0] qout_r;

    always @ (posedge clk) begin
        if (!rst) begin
            qout_r <= {DW{1'b0}};
        end else begin                  
            qout_r <= din;
        end
    end

    assign qout = qout_r;

endmodule

// 复位后输出为1的触发器
module gen_rst_1_dff #(
    parameter DW = 32)(

    input wire clk,
    input wire rst,

    input wire[DW-1:0] din,
    output wire[DW-1:0] qout

    );

    reg[DW-1:0] qout_r;

    always @ (posedge clk) begin
        if (!rst) begin
            qout_r <= {DW{1'b1}};
        end else begin                  
            qout_r <= din;
        end
    end

    assign qout = qout_r;

endmodule

// 复位后输出为默认值的触发器
module gen_rst_def_dff #(
    parameter DW = 32)(

    input wire clk,
    input wire rst,
    input wire[DW-1:0] def_val,

    input wire[DW-1:0] din,
    output wire[DW-1:0] qout

    );

    reg[DW-1:0] qout_r;

    always @ (posedge clk) begin
        if (!rst) begin
            qout_r <= def_val;
        end else begin                  
            qout_r <= din;
        end
    end

    assign qout = qout_r;

endmodule

// 带使能端、复位后输出为0的触发器
module gen_en_dff #(
    parameter DW = 32)(

    input wire clk,
    input wire rst,

    input wire en,
    input wire[DW-1:0] din,
    output wire[DW-1:0] qout

    );

    reg[DW-1:0] qout_r;

    always @ (posedge clk) begin
        if (!rst) begin
            qout_r <= {DW{1'b0}};
        end else if (en == 1'b1) begin
            qout_r <= din;
        end
    end

    assign qout = qout_r;

endmodule

// tinyriscv
module tinyriscv(

    input wire clk,
    input wire rst,

    output wire[`MemAddrBus] rib_ex_addr_o,    // 读、写外设的地址
    input wire[`MemBus] rib_ex_data_i,         // 从外设读取的数据
    output wire[`MemBus] rib_ex_data_o,        // 写入外设的数据
    output wire rib_ex_req_o,                  // 访问外设请求
    output wire rib_ex_we_o,                   // 写外设标志

    output wire[`MemAddrBus] rib_pc_addr_o,    // 取指地址
    input wire[`MemBus] rib_pc_data_i,         // 取到的指令内容

    input wire[`RegAddrBus] jtag_reg_addr_i,   // jtag模块读、写寄存器的地址
    input wire[`RegBus] jtag_reg_data_i,       // jtag模块写寄存器数据
    input wire jtag_reg_we_i,                  // jtag模块写寄存器标志
    output wire[`RegBus] jtag_reg_data_o,      // jtag模块读取到的寄存器数据

    input wire rib_hold_flag_i,                // 总线暂停标志
    input wire jtag_halt_flag_i,               // jtag暂停标志
    input wire jtag_reset_flag_i,              // jtag复位PC标志

    input wire[`INT_BUS] int_i                 // 中断信号

    );

    // pc_reg模块输出信号
	wire[`InstAddrBus] pc_pc_o;

    // if_id模块输出信号
	wire[`InstBus] if_inst_o;
    wire[`InstAddrBus] if_inst_addr_o;
    wire[`INT_BUS] if_int_flag_o;

    // id模块输出信号
    wire[`RegAddrBus] id_reg1_raddr_o;
    wire[`RegAddrBus] id_reg2_raddr_o;
    wire[`InstBus] id_inst_o;
    wire[`InstAddrBus] id_inst_addr_o;
    wire[`RegBus] id_reg1_rdata_o;
    wire[`RegBus] id_reg2_rdata_o;
    wire id_reg_we_o;
    wire[`RegAddrBus] id_reg_waddr_o;
    wire[`MemAddrBus] id_csr_raddr_o;
    wire id_csr_we_o;
    wire[`RegBus] id_csr_rdata_o;
    wire[`MemAddrBus] id_csr_waddr_o;
    wire[`MemAddrBus] id_op1_o;
    wire[`MemAddrBus] id_op2_o;
    wire[`MemAddrBus] id_op1_jump_o;
    wire[`MemAddrBus] id_op2_jump_o;

    // id_ex模块输出信号
    wire[`InstBus] ie_inst_o;
    wire[`InstAddrBus] ie_inst_addr_o;
    wire ie_reg_we_o;
    wire[`RegAddrBus] ie_reg_waddr_o;
    wire[`RegBus] ie_reg1_rdata_o;
    wire[`RegBus] ie_reg2_rdata_o;
    wire ie_csr_we_o;
    wire[`MemAddrBus] ie_csr_waddr_o;
    wire[`RegBus] ie_csr_rdata_o;
    wire[`MemAddrBus] ie_op1_o;
    wire[`MemAddrBus] ie_op2_o;
    wire[`MemAddrBus] ie_op1_jump_o;
    wire[`MemAddrBus] ie_op2_jump_o;

    // ex模块输出信号
    wire[`MemBus] ex_mem_wdata_o;
    wire[`MemAddrBus] ex_mem_raddr_o;
    wire[`MemAddrBus] ex_mem_waddr_o;
    wire ex_mem_we_o;
    wire ex_mem_req_o;
    wire[`RegBus] ex_reg_wdata_o;
    wire ex_reg_we_o;
    wire[`RegAddrBus] ex_reg_waddr_o;
    wire ex_hold_flag_o;
    wire ex_jump_flag_o;
    wire[`InstAddrBus] ex_jump_addr_o;
    wire ex_div_start_o;
    wire[`RegBus] ex_div_dividend_o;
    wire[`RegBus] ex_div_divisor_o;
    wire[2:0] ex_div_op_o;
    wire[`RegAddrBus] ex_div_reg_waddr_o;
    wire[`RegBus] ex_csr_wdata_o;
    wire ex_csr_we_o;
    wire[`MemAddrBus] ex_csr_waddr_o;

    // regs模块输出信号
    wire[`RegBus] regs_rdata1_o;
    wire[`RegBus] regs_rdata2_o;

    // csr_reg模块输出信号
    wire[`RegBus] csr_data_o;
    wire[`RegBus] csr_clint_data_o;
    wire csr_global_int_en_o;
    wire[`RegBus] csr_clint_csr_mtvec;
    wire[`RegBus] csr_clint_csr_mepc;
    wire[`RegBus] csr_clint_csr_mstatus;

    // ctrl模块输出信号
    wire[`Hold_Flag_Bus] ctrl_hold_flag_o;
    wire ctrl_jump_flag_o;
    wire[`InstAddrBus] ctrl_jump_addr_o;

    // div模块输出信号
    wire[`RegBus] div_result_o;
	wire div_ready_o;
    wire div_busy_o;
    wire[`RegAddrBus] div_reg_waddr_o;

    // clint模块输出信号
    wire clint_we_o;
    wire[`MemAddrBus] clint_waddr_o;
    wire[`MemAddrBus] clint_raddr_o;
    wire[`RegBus] clint_data_o;
    wire[`InstAddrBus] clint_int_addr_o;
    wire clint_int_assert_o;
    wire clint_hold_flag_o;


    assign rib_ex_addr_o = (ex_mem_we_o == `WriteEnable)? ex_mem_waddr_o: ex_mem_raddr_o;
    assign rib_ex_data_o = ex_mem_wdata_o;
    assign rib_ex_req_o = ex_mem_req_o;
    assign rib_ex_we_o = ex_mem_we_o;

    assign rib_pc_addr_o = pc_pc_o;


    // pc_reg模块例化
    pc_reg u_pc_reg(
        .clk(clk),
        .rst(rst),
        .jtag_reset_flag_i(jtag_reset_flag_i),
        .pc_o(pc_pc_o),
        .hold_flag_i(ctrl_hold_flag_o),
        .jump_flag_i(ctrl_jump_flag_o),
        .jump_addr_i(ctrl_jump_addr_o)
    );

    // ctrl模块例化
    ctrl u_ctrl(
        .rst(rst),
        .jump_flag_i(ex_jump_flag_o),
        .jump_addr_i(ex_jump_addr_o),
        .hold_flag_ex_i(ex_hold_flag_o),
        .hold_flag_rib_i(rib_hold_flag_i),
        .hold_flag_o(ctrl_hold_flag_o),
        .hold_flag_clint_i(clint_hold_flag_o),
        .jump_flag_o(ctrl_jump_flag_o),
        .jump_addr_o(ctrl_jump_addr_o),
        .jtag_halt_flag_i(jtag_halt_flag_i)
    );

    // regs模块例化
    regs u_regs(
        .clk(clk),
        .rst(rst),
        .we_i(ex_reg_we_o),
        .waddr_i(ex_reg_waddr_o),
        .wdata_i(ex_reg_wdata_o),
        .raddr1_i(id_reg1_raddr_o),
        .rdata1_o(regs_rdata1_o),
        .raddr2_i(id_reg2_raddr_o),
        .rdata2_o(regs_rdata2_o),
        .jtag_we_i(jtag_reg_we_i),
        .jtag_addr_i(jtag_reg_addr_i),
        .jtag_data_i(jtag_reg_data_i),
        .jtag_data_o(jtag_reg_data_o)
    );

    // csr_reg模块例化
    csr_reg u_csr_reg(
        .clk(clk),
        .rst(rst),
        .we_i(ex_csr_we_o),
        .raddr_i(id_csr_raddr_o),
        .waddr_i(ex_csr_waddr_o),
        .data_i(ex_csr_wdata_o),
        .data_o(csr_data_o),
        .global_int_en_o(csr_global_int_en_o),
        .clint_we_i(clint_we_o),
        .clint_raddr_i(clint_raddr_o),
        .clint_waddr_i(clint_waddr_o),
        .clint_data_i(clint_data_o),
        .clint_data_o(csr_clint_data_o),
        .clint_csr_mtvec(csr_clint_csr_mtvec),
        .clint_csr_mepc(csr_clint_csr_mepc),
        .clint_csr_mstatus(csr_clint_csr_mstatus)
    );

    // if_id模块例化
    if_id u_if_id(
        .clk(clk),
        .rst(rst),
        .inst_i(rib_pc_data_i),
        .inst_addr_i(pc_pc_o),
        .int_flag_i(int_i),
        .int_flag_o(if_int_flag_o),
        .hold_flag_i(ctrl_hold_flag_o),
        .inst_o(if_inst_o),
        .inst_addr_o(if_inst_addr_o)
    );

    // id模块例化
    id u_id(
        .rst(rst),
        .inst_i(if_inst_o),
        .inst_addr_i(if_inst_addr_o),
        .reg1_rdata_i(regs_rdata1_o),
        .reg2_rdata_i(regs_rdata2_o),
        .ex_jump_flag_i(ex_jump_flag_o),
        .reg1_raddr_o(id_reg1_raddr_o),
        .reg2_raddr_o(id_reg2_raddr_o),
        .inst_o(id_inst_o),
        .inst_addr_o(id_inst_addr_o),
        .reg1_rdata_o(id_reg1_rdata_o),
        .reg2_rdata_o(id_reg2_rdata_o),
        .reg_we_o(id_reg_we_o),
        .reg_waddr_o(id_reg_waddr_o),
        .op1_o(id_op1_o),
        .op2_o(id_op2_o),
        .op1_jump_o(id_op1_jump_o),
        .op2_jump_o(id_op2_jump_o),
        .csr_rdata_i(csr_data_o),
        .csr_raddr_o(id_csr_raddr_o),
        .csr_we_o(id_csr_we_o),
        .csr_rdata_o(id_csr_rdata_o),
        .csr_waddr_o(id_csr_waddr_o)
    );

    // id_ex模块例化
    id_ex u_id_ex(
        .clk(clk),
        .rst(rst),
        .inst_i(id_inst_o),
        .inst_addr_i(id_inst_addr_o),
        .reg_we_i(id_reg_we_o),
        .reg_waddr_i(id_reg_waddr_o),
        .reg1_rdata_i(id_reg1_rdata_o),
        .reg2_rdata_i(id_reg2_rdata_o),
        .hold_flag_i(ctrl_hold_flag_o),
        .inst_o(ie_inst_o),
        .inst_addr_o(ie_inst_addr_o),
        .reg_we_o(ie_reg_we_o),
        .reg_waddr_o(ie_reg_waddr_o),
        .reg1_rdata_o(ie_reg1_rdata_o),
        .reg2_rdata_o(ie_reg2_rdata_o),
        .op1_i(id_op1_o),
        .op2_i(id_op2_o),
        .op1_jump_i(id_op1_jump_o),
        .op2_jump_i(id_op2_jump_o),
        .op1_o(ie_op1_o),
        .op2_o(ie_op2_o),
        .op1_jump_o(ie_op1_jump_o),
        .op2_jump_o(ie_op2_jump_o),
        .csr_we_i(id_csr_we_o),
        .csr_waddr_i(id_csr_waddr_o),
        .csr_rdata_i(id_csr_rdata_o),
        .csr_we_o(ie_csr_we_o),
        .csr_waddr_o(ie_csr_waddr_o),
        .csr_rdata_o(ie_csr_rdata_o)
    );

    // ex模块例化
    ex u_ex(
        .rst(rst),
        .inst_i(ie_inst_o),
        .inst_addr_i(ie_inst_addr_o),
        .reg_we_i(ie_reg_we_o),
        .reg_waddr_i(ie_reg_waddr_o),
        .reg1_rdata_i(ie_reg1_rdata_o),
        .reg2_rdata_i(ie_reg2_rdata_o),
        .op1_i(ie_op1_o),
        .op2_i(ie_op2_o),
        .op1_jump_i(ie_op1_jump_o),
        .op2_jump_i(ie_op2_jump_o),
        .mem_rdata_i(rib_ex_data_i),
        .mem_wdata_o(ex_mem_wdata_o),
        .mem_raddr_o(ex_mem_raddr_o),
        .mem_waddr_o(ex_mem_waddr_o),
        .mem_we_o(ex_mem_we_o),
        .mem_req_o(ex_mem_req_o),
        .reg_wdata_o(ex_reg_wdata_o),
        .reg_we_o(ex_reg_we_o),
        .reg_waddr_o(ex_reg_waddr_o),
        .hold_flag_o(ex_hold_flag_o),
        .jump_flag_o(ex_jump_flag_o),
        .jump_addr_o(ex_jump_addr_o),
        .int_assert_i(clint_int_assert_o),
        .int_addr_i(clint_int_addr_o),
        .div_ready_i(div_ready_o),
        .div_result_i(div_result_o),
        .div_busy_i(div_busy_o),
        .div_reg_waddr_i(div_reg_waddr_o),
        .div_start_o(ex_div_start_o),
        .div_dividend_o(ex_div_dividend_o),
        .div_divisor_o(ex_div_divisor_o),
        .div_op_o(ex_div_op_o),
        .div_reg_waddr_o(ex_div_reg_waddr_o),
        .csr_we_i(ie_csr_we_o),
        .csr_waddr_i(ie_csr_waddr_o),
        .csr_rdata_i(ie_csr_rdata_o),
        .csr_wdata_o(ex_csr_wdata_o),
        .csr_we_o(ex_csr_we_o),
        .csr_waddr_o(ex_csr_waddr_o)
    );

    // div模块例化
    div u_div(
        .clk(clk),
        .rst(rst),
        .dividend_i(ex_div_dividend_o),
        .divisor_i(ex_div_divisor_o),
        .start_i(ex_div_start_o),
        .op_i(ex_div_op_o),
        .reg_waddr_i(ex_div_reg_waddr_o),
        .result_o(div_result_o),
        .ready_o(div_ready_o),
        .busy_o(div_busy_o),
        .reg_waddr_o(div_reg_waddr_o)
    );

    // clint模块例化
    clint u_clint(
        .clk(clk),
        .rst(rst),
        .int_flag_i(if_int_flag_o),
        .inst_i(id_inst_o),
        .inst_addr_i(id_inst_addr_o),
        .jump_flag_i(ex_jump_flag_o),
        .jump_addr_i(ex_jump_addr_o),
        .hold_flag_i(ctrl_hold_flag_o),
        .div_started_i(ex_div_start_o),
        .data_i(csr_clint_data_o),
        .csr_mtvec(csr_clint_csr_mtvec),
        .csr_mepc(csr_clint_csr_mepc),
        .csr_mstatus(csr_clint_csr_mstatus),
        .we_o(clint_we_o),
        .waddr_o(clint_waddr_o),
        .raddr_o(clint_raddr_o),
        .data_o(clint_data_o),
        .hold_flag_o(clint_hold_flag_o),
        .global_int_en_i(csr_global_int_en_o),
        .int_addr_o(clint_int_addr_o),
        .int_assert_o(clint_int_assert_o)
    );

endmodule
