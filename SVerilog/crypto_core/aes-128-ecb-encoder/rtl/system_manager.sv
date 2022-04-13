/**
 *  Module system_manager. 
 *    Functions: 
 *        - Receive data(key and plainText) and commands from Xilinx IP UARTLITE
 *        - Send recieved data to aes-128-ecb encoder
 *        - Receive ciphered data from encoder
 *        - Send ciphered data to UARTLITE
 *
 *  Copyright 2020 by Vyacheslav Gulyaev <v.gulyaev181@gmail.com>
 *
 *  Licensed under GNU General Public License 3.0 or later. 
 *  Some rights reserved. See COPYING, AUTHORS.
 *
 * @license GPL-3.0+ <http://spdx.org/licenses/GPL-3.0+>
 */

module system_manager(
                        input           clk_i,
                        input           rstn_i,
        
                        output logic  [127:0]   plain_text_data_o,
                        output logic            plain_text_data_valid_o,
                        output logic  [127:0]   key_o,
        
                        input         [127:0]   cipher_data_i,
                        input                   cipher_data_valid_i,

                        output logic            key_set_complete_o,
                        output logic            startup_pause_complete,
                        
                        
                        input                   interrupt_i,
                        
                        axi_interface.master    m_axi
                   );

    `define __UART_DEFINES__
    
    `define CMD_SET_KEY    8'hF0
    `define CMD_ENC_DATA   8'hE1
    `define CMD_GET_STAT   8'hD2
    
    `define RxFIFO_ADDR    4'h0
    `define TxFIFO_ADDR    4'h4
    `define STAT_REG_ADDR  4'h8
    `define CTRL_REG_ADDR  4'hC
    
    `define STAT_REG_RxFifoValidDataBit        0
    `define STAT_REG_RxFifoFullBit             1
    `define STAT_REG_TxFifoEmptyBit            2
    `define STAT_REG_TxFifoFullBit             3
    `define STAT_REG_IntrEnabledBit            4
    `define STAT_REG_OverrunErrorBit           5
    `define STAT_REG_FrameErrorBit             6
    `define STAT_REG_ParityErrorBit            7
    
    `define CTRL_REG_RstTxFifoBit              0
    `define CTRL_REG_RstRxFifoBit              1
    `define CTRL_REG_EnableIntrBit             4
    
    `define AXI_RESP_OKAY                      2'b00
    `define AXI_RESP_EXOKAY                    2'b01
    `define AXI_RESP_SLVERR                    2'b10
    `define AXI_RESP_DECERR                    2'b11

    localparam STARTUP_PAUSE_DUTY =            100; //1us = 100 * 10ns(100MHz)

    logic          start_axi_wr;
    logic          start_axi_wr_reg;
    logic  [7:0]   axi_data_wr;
    logic  [7:0]   axi_data_wr_reg;
    logic  [3:0]   addr;
    logic  [3:0]   addr_reg;
    logic          start_axi_rd;
    logic          start_axi_rd_reg;
    logic          uart_init_complete;
    logic          uart_init_complete_reg;
    logic  [7:0]   rd_data;
    logic  [7:0]   rd_data_reg;
    logic          rx_fifo_valid_data;
    logic          rx_fifo_full;
    logic          tx_fifo_empty;
    logic          tx_fifo_full;
    logic          rx_fifo_valid_data_reg;
    logic          rx_fifo_full_reg;
    logic          tx_fifo_empty_reg;
    logic          tx_fifo_full_reg;
    logic          check_stat;
    logic          check_stat_reg;
    logic          key_set_complete;
    logic          key_set_complete_reg;
    logic          key_set_in_progress;
    logic          key_set_in_progress_reg;
    logic          plain_text_set_in_progress;
    logic          plain_text_set_in_progress_reg;
    logic  [3:0]   data_counter;
    logic  [3:0]   data_counter_reg;
    logic  [127:0] plain_text_data;
    logic          plain_text_data_valid;
    logic  [127:0] key;
    
    logic  [127:0] cipher_data;
    logic  [127:0] cipher_data_reg;
    logic          transmit_in_progress;
    logic          transmit_in_progress_reg;
    logic          wait_tx_fifo_empty;
    logic          wait_tx_fifo_empty_reg;
    logic          get_stat;
    logic          get_stat_reg;
    logic  [7:0]   cur_stat;
    logic  [7:0]   cur_stat_reg;
    logic          send_stat;
    logic          send_stat_reg;
    
    logic [31:0]  startup_pause_cnt;
//    logic         startup_pause_complete;

    typedef enum {  SYS_IDLE,
                    INIT_UART_CTRL_REG,
                    RD_UART_STAT_REG,
                    RD_RX_FIFO,
                    WR_TX_FIFO
                } sys_state_t;
    sys_state_t sys_state;
    sys_state_t sys_next_state;
    
    
    //write address channel
    logic  [3:0]   m_axi_awaddr;
    logic          m_axi_awvalid;
                    
    //write data channel
    logic  [7:0]   m_axi_wdata;
    logic  [3:0]   m_axi_wstrb;
    logic          m_axi_wvalid;
                    
    //write response channel
    logic          m_axi_bready;
                    
    //read address channel
    logic  [3:0]   m_axi_araddr;
    logic          m_axi_arvalid;
                    
    //read data channel
    logic          m_axi_rready;
    
    wire         axi_wr_ok;
    wire         axi_rd_ok;
    
    typedef enum {  AXI_IDLE, 
                    AXI_WAIT_WREADY,
                    AXI_WAIT_BRESP,
                    AXI_WAIT_RREADY,
                    AXI_WAIT_RDATA
                  } axi_state_t;
    axi_state_t axi_state;
    axi_state_t axi_next_state;
    
    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            startup_pause_cnt <= 32'h0;
        end else if (~startup_pause_complete) begin
            startup_pause_cnt <= startup_pause_cnt + 1;
        end
    end
    assign startup_pause_complete = (startup_pause_cnt==STARTUP_PAUSE_DUTY) ? 1'b1 : 1'b0;
    
    
    //sys manager registering
    always @(posedge clk_i or negedge rstn_i) begin
        if (~rstn_i) begin
            start_axi_wr_reg <= 1'b0;
            axi_data_wr_reg  <= 8'h0;
            addr_reg <= 4'h0;
            start_axi_rd_reg <= 1'b0;
            uart_init_complete_reg <= 1'b0;
            rd_data_reg <= 8'h0;
            rx_fifo_valid_data_reg <= 1'b0;
            rx_fifo_full_reg <= 1'b0;
            tx_fifo_empty_reg <= 1'b0;
            tx_fifo_full_reg <= 1'b0;
            check_stat_reg <= 1'b0;
            key_set_complete_reg <= 1'b0;
            key_set_in_progress_reg <= 1'b0;
            plain_text_set_in_progress_reg <= 1'b0;
            data_counter_reg <= 4'h0;
            plain_text_data_o <= 128'h0;
            plain_text_data_valid_o <= 1'b0;
            key_o <= 128'h0;
            cipher_data_reg <= 128'h0;
            transmit_in_progress_reg <= 1'b0;
            wait_tx_fifo_empty_reg <= 1'b0;
            get_stat_reg <= 1'b0;
            cur_stat_reg <= 8'h0;
            send_stat_reg <= 1'b0;

            sys_state <= SYS_IDLE;
        end else begin
            start_axi_wr_reg <= start_axi_wr;
            axi_data_wr_reg  <= axi_data_wr;
            addr_reg <= addr;
            start_axi_rd_reg <= start_axi_rd;
            uart_init_complete_reg <= uart_init_complete;
            rd_data_reg <= rd_data;
            rx_fifo_valid_data_reg <= rx_fifo_valid_data;
            rx_fifo_full_reg <= rx_fifo_full;
            tx_fifo_empty_reg <= tx_fifo_empty;
            tx_fifo_full_reg <= tx_fifo_full;
            check_stat_reg <= check_stat;
            key_set_complete_reg <= key_set_complete;
            key_set_in_progress_reg <= key_set_in_progress;
            plain_text_set_in_progress_reg <= plain_text_set_in_progress;
            data_counter_reg <= data_counter;
            plain_text_data_o <= plain_text_data;
            plain_text_data_valid_o <= plain_text_data_valid;
            key_o <= key;
            cipher_data_reg <= cipher_data;
            transmit_in_progress_reg <= transmit_in_progress;
            wait_tx_fifo_empty_reg <= wait_tx_fifo_empty;
            get_stat_reg <= get_stat;
            cur_stat_reg <= cur_stat;
            send_stat_reg <= send_stat;
    
            sys_state <= sys_next_state;
        end
    end
    
    //sys manager state handling
    always @(*) begin
        sys_next_state = sys_state;
        case (sys_state)
            SYS_IDLE: begin
                if (~uart_init_complete_reg & startup_pause_complete) begin
                    sys_next_state = INIT_UART_CTRL_REG;
                end else if (interrupt_i | check_stat_reg | get_stat_reg) begin
                    sys_next_state = RD_UART_STAT_REG;
                end else if (rx_fifo_valid_data_reg) begin
                    sys_next_state = RD_RX_FIFO;
                end else if (cipher_data_valid_i | transmit_in_progress_reg | send_stat_reg) begin
                    sys_next_state = WR_TX_FIFO;
                end
            end

            INIT_UART_CTRL_REG, WR_TX_FIFO: begin
                if (axi_wr_ok) begin
                    sys_next_state = SYS_IDLE;
                end
            end

            RD_UART_STAT_REG, RD_RX_FIFO: begin
                if (axi_rd_ok) begin
                    sys_next_state = SYS_IDLE;
                end
            end
        endcase
    end
    
    //sys manager fsm
    always @(*) begin
        start_axi_wr = start_axi_wr_reg;
        axi_data_wr = axi_data_wr_reg;
        addr = addr_reg;
        start_axi_rd = start_axi_rd_reg;
        uart_init_complete = uart_init_complete_reg;
        rd_data = rd_data_reg;
        rx_fifo_valid_data = rx_fifo_valid_data_reg;
        rx_fifo_full = rx_fifo_full_reg;
        tx_fifo_empty = tx_fifo_empty_reg;
        tx_fifo_full = tx_fifo_full_reg;
        check_stat = check_stat_reg;
        key_set_complete = key_set_complete_reg;
        key_set_in_progress = key_set_in_progress_reg;
        plain_text_set_in_progress = plain_text_set_in_progress_reg;
        data_counter = data_counter_reg;
        plain_text_data = plain_text_set_in_progress_reg ? plain_text_data_o : 128'h0;
        plain_text_data_valid = 1'b0;
        key = key_o;
        cipher_data = cipher_data_reg;
        transmit_in_progress = transmit_in_progress_reg;
        wait_tx_fifo_empty = wait_tx_fifo_empty_reg;
        get_stat = get_stat_reg;
        cur_stat = cur_stat_reg;
        send_stat = send_stat_reg;
        
        case (sys_state)
            SYS_IDLE: begin
                if (~uart_init_complete_reg & startup_pause_complete) begin
                    start_axi_wr = 1'b1;
                    axi_data_wr[`CTRL_REG_RstTxFifoBit] = 1'b1;
                    axi_data_wr[`CTRL_REG_RstRxFifoBit] = 1'b1;
                    axi_data_wr[`CTRL_REG_EnableIntrBit] = 1'b1;
                    addr = `CTRL_REG_ADDR;
                end else if (interrupt_i | check_stat_reg | get_stat_reg) begin
                    start_axi_rd = 1'b1;
                    addr = `STAT_REG_ADDR;
                end else if (rx_fifo_valid_data_reg & ~wait_tx_fifo_empty_reg) begin
                    start_axi_rd = 1'b1;
                    addr = `RxFIFO_ADDR;
                end else if (cipher_data_valid_i) begin
                    start_axi_wr = 1'b1;
                    axi_data_wr[7:0] = cipher_data_i[127:120];
                    addr = `TxFIFO_ADDR;
                    cipher_data[127:0] = cipher_data_i[127:0];
                    transmit_in_progress <= 1'b1;
                end else if (transmit_in_progress_reg) begin
                    start_axi_wr = 1'b1;
                    axi_data_wr[7:0] = cipher_data_reg[127:120];
                    addr = `TxFIFO_ADDR;
                end else if (send_stat_reg) begin
                    start_axi_wr = 1'b1;
                    axi_data_wr[7:0] = cur_stat;
                    addr = `TxFIFO_ADDR;
                end
            end
            
            INIT_UART_CTRL_REG: begin
                start_axi_wr = 1'b0;
                axi_data_wr = 8'h0;
                addr = 4'h0;
                if (axi_wr_ok) begin
                    uart_init_complete = 1'b1;
                end
            end
            
            RD_UART_STAT_REG: begin
                start_axi_rd = 1'b0;
                addr = 4'h0;
                check_stat = 1'b0;
                if (axi_rd_ok) begin
                    rx_fifo_valid_data = m_axi.rdata[`STAT_REG_RxFifoValidDataBit];
                    rx_fifo_full = m_axi.rdata[`STAT_REG_RxFifoFullBit];
                    tx_fifo_empty = m_axi.rdata[`STAT_REG_TxFifoEmptyBit];
                    tx_fifo_full = m_axi.rdata[`STAT_REG_TxFifoFullBit];
                    if (wait_tx_fifo_empty_reg) begin
                        wait_tx_fifo_empty = tx_fifo_empty ? 1'b0 : 1'b1;
                    end
                    cur_stat = m_axi.rdata[7:0];
                    if (get_stat_reg) begin
                        get_stat = 1'b0;
                        send_stat = 1'b1;
                    end
                end
            end
            
            RD_RX_FIFO: begin
                start_axi_rd = 1'b0;
                addr = 4'h0;
                check_stat = 1'b1;
                if (axi_rd_ok) begin
                    rd_data = m_axi.rdata[7:0];
                    if (~key_set_in_progress_reg & ~plain_text_set_in_progress_reg) begin
                        case (rd_data)
                            `CMD_SET_KEY: begin
                                key_set_complete = 1'b0;
                                key_set_in_progress = 1'b1;
                                data_counter = 4'h0;
                                key = 128'h0;
                            end
                            `CMD_ENC_DATA: begin
                                plain_text_set_in_progress = 1'b1;
                                data_counter = 4'h0;
                                plain_text_data = 128'h0;
                            end
                            `CMD_GET_STAT: begin
                                get_stat = 1'b1;
                            end
                        endcase
                    end else if (key_set_in_progress_reg) begin
                        key[127:0] = {key_o[120:0], rd_data};
                        if (data_counter==4'hF) begin
                            key_set_in_progress = 1'b0;
                            key_set_complete = 1'b1;
                            data_counter = 4'h0;
                        end else begin
                            data_counter = data_counter + 1;
                        end
                    end else if (plain_text_set_in_progress_reg) begin
                        plain_text_data[127:0] = {plain_text_data_o[120:0], rd_data};
                        if (data_counter==4'hF) begin
                            plain_text_set_in_progress = 1'b0;
                            plain_text_data_valid = 1'b1;
                            data_counter = 4'h0;
                        end else begin
                            data_counter = data_counter + 1;
                        end
                    end
                end
            end
            
            WR_TX_FIFO: begin
                start_axi_wr = 1'b0;
                axi_data_wr = 8'h0;
                addr = 4'h0;
                if (axi_wr_ok) begin
                    if (send_stat_reg) begin
                        send_stat = 1'b0;
                    end else if (data_counter==4'hF) begin
                        transmit_in_progress = 1'b0;
                        data_counter = 4'h0;
                        wait_tx_fifo_empty = 1'b1;
                    end else begin
                        cipher_data[127:0] = {cipher_data_reg[120:0], 8'h0};
                        data_counter = data_counter + 1;
                    end
                end
            end
            
        endcase
    end
    
    //axi-lite registering
    always @(posedge clk_i or negedge rstn_i) begin
        if (~rstn_i) begin
            m_axi.awaddr  <= 4'h0;
            m_axi.awvalid <= 1'b0;
            m_axi.wdata   <= 32'h0;
            m_axi.wstrb   <= 4'h0;
            m_axi.wvalid  <= 1'b0;
            m_axi.bready  <= 1'b0;
            m_axi.araddr  <= 4'h0;
            m_axi.arvalid <= 1'b0;
            m_axi.rready  <= 1'b0;
            
            axi_state <= axi_next_state;
        end else begin
            m_axi.awaddr  <= m_axi_awaddr;
            m_axi.awvalid <= m_axi_awvalid;
            m_axi.wdata   <= m_axi_wdata;
            m_axi.wstrb   <= m_axi_wstrb;
            m_axi.wvalid  <= m_axi_wvalid;
            m_axi.bready  <= m_axi_bready;
            m_axi.araddr  <= m_axi_araddr;
            m_axi.arvalid <= m_axi_arvalid;
            m_axi.rready  <= m_axi_rready;
            
            axi_state <= axi_next_state;
        end
    end
    
    
    assign axi_wr_ok = (m_axi.bvalid && (m_axi.bresp==`AXI_RESP_OKAY));
    assign axi_rd_ok = (m_axi.rvalid && (m_axi.rresp==`AXI_RESP_OKAY));
    
    //axi-lite master fsm next state driving
    always @(*) begin
        axi_next_state = axi_state;
        case (axi_state)
            
            AXI_IDLE: begin
                if (start_axi_wr_reg) begin
                    axi_next_state = AXI_WAIT_WREADY;
                end
                if (start_axi_rd_reg) begin
                    axi_next_state = AXI_WAIT_RREADY;
                end
            end
            
            AXI_WAIT_WREADY: begin
                if (m_axi.awready & m_axi.wready) begin
                    axi_next_state = AXI_WAIT_BRESP;
                end
            end
            
            AXI_WAIT_BRESP: begin
                if (axi_wr_ok) begin
                    axi_next_state = AXI_IDLE;
                end
            end
            
            AXI_WAIT_RREADY: begin
                if (m_axi.arready) begin
                    axi_next_state = AXI_WAIT_RDATA;
                end
            end
            
            AXI_WAIT_RDATA: begin
                if (axi_rd_ok) begin
                    axi_next_state = AXI_IDLE;
                end
            end
        endcase
    end

    //axi-lite fsm axi signal driving
    always @(*) begin
        m_axi_awaddr  = m_axi.awaddr ;
        m_axi_awvalid = m_axi.awvalid;
        m_axi_wdata   = m_axi.wdata  ;
        m_axi_wstrb   = m_axi.wstrb  ;
        m_axi_wvalid  = m_axi.wvalid ;
        m_axi_bready  = m_axi.bready ;
        m_axi_araddr  = m_axi.araddr ;
        m_axi_arvalid = m_axi.arvalid;
        m_axi_rready  = m_axi.rready ;
        
        case (axi_state)
            
            AXI_IDLE: begin
                if (start_axi_wr_reg) begin
                    m_axi_awaddr = addr_reg;
                    m_axi_awvalid = 1'b1;
                    m_axi_wdata   = {24'h0, axi_data_wr_reg};
                    m_axi_wstrb   = 4'hF;
                    m_axi_wvalid  = 1'b1;
                    m_axi_bready  = 1'b1;
                end
                if (start_axi_rd_reg) begin
                    m_axi_araddr  <= addr_reg;
                    m_axi_arvalid <= 1'b1;
                    m_axi_rready  <= 1'b1;
                end
            end
            
            AXI_WAIT_WREADY: begin
                if (m_axi.awready & m_axi.wready) begin
                    m_axi_awaddr  = 4'h0;
                    m_axi_awvalid = 1'b0;
                    m_axi_wdata   = 32'h0;
                    m_axi_wstrb   = 4'h0;
                    m_axi_wvalid  = 1'b0;
                end
            end
            
            AXI_WAIT_BRESP: begin
                if (axi_wr_ok) begin
                    m_axi_bready  = 1'b0;
                end
            end
            
            AXI_WAIT_RREADY: begin
                if (m_axi.arready) begin
                    m_axi_araddr  <= 4'h0;
                    m_axi_arvalid <= 1'b0;
                end
            end
            
            AXI_WAIT_RDATA: begin
                if (axi_rd_ok) begin
                    m_axi_rready  <= 1'b0;
                end
            end
        endcase
    end
    
    assign key_set_complete_o = key_set_complete_reg;
    
endmodule
