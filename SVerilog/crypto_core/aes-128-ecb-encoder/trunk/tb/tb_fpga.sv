/**
 * Testbench for simulation of AES-128-ECB encoder in fpga system using Xilinx IP UARTLITE
 *
 *  Copyright 2020 by Vyacheslav Gulyaev <v.gulyaev181@gmail.com>
 *
 *  Licensed under GNU General Public License 3.0 or later. 
 *  Some rights reserved. See COPYING, AUTHORS.
 *
 * @license GPL-3.0+ <http://spdx.org/licenses/GPL-3.0+>
 */

module tb_fpga ();
    
    `ifndef __UART_DEFINES__
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
    `endif
    
    logic clk = 1'b0;
    logic uart_clk = 1'b0;
    logic rst = 1'b1;
    logic interrupt;
    
    logic uart_tx;
    logic uart_rx;
    
    logic [7:0] rddata;
    logic [127:0] ciph_data;
    logic [7:0] status;
    
    axi_interface axi_if();
    
    initial begin
        rst = 1'b1;
        init_axi_if();
        #(1us) rst = 1'b0;
        repeat (1000) @(posedge uart_clk);
        axi_wr(`CTRL_REG_ADDR, (1'b1 << `CTRL_REG_EnableIntrBit) | 
                               (1'b1 << `CTRL_REG_RstRxFifoBit)  | 
                               (1'b1 << `CTRL_REG_RstTxFifoBit)
              );
        
        set_key(128'h00112233445566778899aabbccddeeff);
        set_plain_text(128'h000102030405060708090a0b0c0d0e0f);
        get_received_data(ciph_data);
        get_status(status);
        #(50us);
        $stop;
    end
    
    always #(2500ps) clk = ~clk;
    
    always #(5000ps) uart_clk = ~uart_clk;

    
    `ifdef SDF_PATH    
        initial begin
            $sdf_annotate
                (
                                                
                    /*       "sdf_file" */ `SDF_PATH,
                    /*[module_instance] */ dut,
                    /*  ["config_file"] */ ,
                    /*     ["log_file"] */ "anno.log",
                    /*     ["mtm_spec"] */ ,// MINIMUM/MAXIMUM
                    /*["scale_factors"] */ ,
                    /*   ["scale_type"] */
                );
        end
    `endif
    
    aes128_ecb_fpga_wrap dut(
                                .CLK_IN_P    ( clk  ),
                                .CLK_IN_N    ( ~clk ),
                                .rst_i       ( rst  ),
                    
                                .uart_tx     ( uart_rx ),
                                .uart_rx     ( uart_tx )
                            );
    
    axi_uartlite_module_sim uartlite (
            .s_axi_aclk       ( uart_clk        ),  // input wire s_axi_aclk
            .s_axi_aresetn    ( ~rst            ),  // input wire s_axi_aresetn
            .interrupt        ( interrupt       ),  // output wire interrupt

            .s_axi_awaddr     ( axi_if.master.awaddr  ),  // input wire [3 : 0] s_axi_awaddr
            .s_axi_awvalid    ( axi_if.master.awvalid ),  // input wire s_axi_awvalid
            .s_axi_awready    ( axi_if.master.awready ),  // output wire s_axi_awready

            .s_axi_wdata      ( axi_if.master.wdata   ),  // input wire [31 : 0] s_axi_wdata
            .s_axi_wstrb      ( axi_if.master.wstrb   ),  // input wire [3 : 0] s_axi_wstrb
            .s_axi_wvalid     ( axi_if.master.wvalid  ),  // input wire s_axi_wvalid
            .s_axi_wready     ( axi_if.master.wready  ),  // output wire s_axi_wready

            .s_axi_bresp      ( axi_if.master.bresp   ),  // output wire [1 : 0] s_axi_bresp
            .s_axi_bvalid     ( axi_if.master.bvalid  ),  // output wire s_axi_bvalid
            .s_axi_bready     ( axi_if.master.bready  ),  // input wire s_axi_bready

            .s_axi_araddr     ( axi_if.master.araddr  ),  // input wire [3 : 0] s_axi_araddr
            .s_axi_arvalid    ( axi_if.master.arvalid ),  // input wire s_axi_arvalid
            .s_axi_arready    ( axi_if.master.arready ),  // output wire s_axi_arready

            .s_axi_rdata      ( axi_if.master.rdata   ),  // output wire [31 : 0] s_axi_rdata
            .s_axi_rresp      ( axi_if.master.rresp   ),  // output wire [1 : 0] s_axi_rresp
            .s_axi_rvalid     ( axi_if.master.rvalid  ),  // output wire s_axi_rvalid
            .s_axi_rready     ( axi_if.master.rready  ),  // input wire s_axi_rready

            .rx               ( uart_rx        ),  // input wire rx
            .tx               ( uart_tx        )   // output wire tx
        );
    
    
    task init_axi_if();
        axi_if.awaddr = 4'h0;
        axi_if.awvalid = 1'b0;
        axi_if.wdata = 32'h0;
        axi_if.wstrb = 4'h0;
        axi_if.wvalid = 1'b0;
        axi_if.bready = 1'b0;
        axi_if.araddr = 4'h0;
        axi_if.arvalid = 1'b0;
        axi_if.rready = 1'b0;
    endtask
    
    task set_key(input logic[127:0] key);
        axi_wr(`TxFIFO_ADDR, `CMD_SET_KEY);
        wait_tx_fifo_empty();
        for (int i=0; i<16; i++) begin
            axi_wr(`TxFIFO_ADDR, key[127:120]);
            key[127:0] = {key[120:0], 8'h00};
        end
        wait_tx_fifo_empty();
    endtask

    task set_plain_text(input logic[127:0] plain_text_data);
        axi_wr(`TxFIFO_ADDR, `CMD_ENC_DATA);
        wait_tx_fifo_empty();
        for (int i=0; i<16; i++) begin
            axi_wr(`TxFIFO_ADDR, plain_text_data[127:120]);
            plain_text_data[127:0] = {plain_text_data[120:0], 8'h00};
        end
        wait_tx_fifo_empty();
    endtask
    
    task get_received_data(output logic[127:0] cipher_data);
        logic [7:0] buff;
        wait_rx_fifo_full();
        cipher_data = 128'h0;
        for (int i=0; i<16; i++) begin
            axi_rd(`RxFIFO_ADDR, buff);
            cipher_data[127:0] = {cipher_data[120:0], buff};
        end
    endtask
    
    task get_status(output logic [7:0] status);
        axi_wr(`TxFIFO_ADDR, `CMD_GET_STAT);
        wait_rx_fifo_not_empty();
        axi_rd(`RxFIFO_ADDR, status);
    endtask
    
    task wait_tx_fifo_empty();
        axi_rd(`STAT_REG_ADDR, rddata);
        while (~rddata[`STAT_REG_TxFifoEmptyBit]) begin
            wait(interrupt);
            axi_rd(`STAT_REG_ADDR, rddata);
        end
    endtask

    task wait_rx_fifo_full();
        axi_rd(`STAT_REG_ADDR, rddata);
        while (~rddata[`STAT_REG_RxFifoFullBit]) begin
            //wait(interrupt);
            #200us;
            axi_rd(`STAT_REG_ADDR, rddata);
        end
    endtask

    task wait_rx_fifo_not_empty();
        axi_rd(`STAT_REG_ADDR, rddata);
        while (~rddata[`STAT_REG_RxFifoValidDataBit]) begin
            wait(interrupt);
            axi_rd(`STAT_REG_ADDR, rddata);
        end
    endtask

    task wait_rx_fifo_empty();
        axi_rd(`STAT_REG_ADDR, rddata);
        while (rddata[`STAT_REG_RxFifoValidDataBit]) begin
            axi_rd(`RxFIFO_ADDR, rddata);
            axi_rd(`STAT_REG_ADDR, rddata);
        end
    endtask
    
    task axi_wr(input logic [3:0] addr, input logic [7:0] data);
        @(posedge uart_clk);#(1ns);
        axi_if.awaddr = addr;
        axi_if.awvalid = 1'b1;
        axi_if.wdata = {24'h0, data};
        axi_if.wstrb = 4'hF;
        axi_if.wvalid = 1'b1;
        axi_if.bready = 1'b1;
        wait (axi_if.awready & axi_if.wready);
        @(posedge uart_clk); #(1ns);
        axi_if.awaddr = 4'h0;
        axi_if.awvalid = 1'b0;
        axi_if.wdata = 8'h0;
        axi_if.wstrb = 4'h0;
        axi_if.wvalid = 1'b0;
        wait (axi_if.master.bvalid && (axi_if.bresp==`AXI_RESP_OKAY));
        @(posedge uart_clk);#(1ns);
        axi_if.bready = 1'b0;
    endtask

    task axi_rd(input logic [3:0] addr, output logic [7:0] data);
        @(posedge uart_clk);#(1ns);
        axi_if.araddr = addr;
        axi_if.arvalid = 1'b1;
        axi_if.rready = 1'b1;
        wait (axi_if.arready);
        @(posedge uart_clk);#(1ns);
        axi_if.araddr = 4'h0;
        axi_if.arvalid = 1'b0;
        wait (axi_if.master.rvalid && (axi_if.rresp==`AXI_RESP_OKAY));
        @(posedge uart_clk);#(1ns);
        data = axi_if.rdata[7:0];
        axi_if.rready = 1'b0;
    endtask    
    
endmodule
