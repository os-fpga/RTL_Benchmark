/**
 * Module aes128_ecb_fpga_wrap contains:
 *    - clkgen - IP Xilinx Clocking Wizard which creates system clock 100MHz from input 200 MHz clock
 *    - enc - aes-128-ecb encoder
 *    - uartlite - IP Xilinx UARTLITE operates on 100MHz system clock and 38400 UART Baud Rate
 *    - sys_mngr - System manager received commands and data via uart from external CPU and transmits ciphered data
 *
 *  Copyright 2020 by Vyacheslav Gulyaev <v.gulyaev181@gmail.com>
 *
 *  Licensed under GNU General Public License 3.0 or later. 
 *  Some rights reserved. See COPYING, AUTHORS.
 *
 * @license GPL-3.0+ <http://spdx.org/licenses/GPL-3.0+>
 */


module aes128_ecb_fpga_wrap(
                        input  CLK_IN_P,
                        input  CLK_IN_N,
                        input  rst_i,

                        output uart_tx,
                        input  uart_rx,
                        
                        output rst_o,
                        output clk_o,

                        output startup_pause_complete,
                        output key_set_complete_o
                        
                   );

    wire          sys_clk;
    wire          clk_locked;
    wire          rstn;
    
    wire [127:0]  plain_text_data;
    wire          plain_text_data_valid;
    wire [127:0]  key;
    
    wire [127:0]  cipher_data;
    wire          cipher_data_valid;
    
    wire          interrupt;
    
    logic [1:0]   clk_div;
    
    axi_interface axi_if();
    
    clk_gen clkgen
        (// Clock in ports
            .clk_in1_p        ( CLK_IN_P   ),    // IN
            .clk_in1_n        ( CLK_IN_N   ),    // IN
    
            // Clock out ports
            .clk_out1         ( sys_clk    ),     // OUT
    
            // Status and control signals
            .reset            ( rst_i      ),     // IN
            .locked           ( clk_locked )
        );

    assign rstn = ~rst_i & clk_locked;
    
    aes128_enc enc(
                    .clk_i    ( sys_clk               ),
                    .rstn_i   ( rstn                  ),
        
                    .data_i   ( plain_text_data       ),
                    .key_i    ( key                   ),
                    .valid_i  ( plain_text_data_valid ),
        
                    .data_o   ( cipher_data           ),
                    .valid_o  ( cipher_data_valid     )
        );
    
                           
    axi_uartlite_module uartlite (
                                     .s_axi_aclk       ( sys_clk        ),  // input wire s_axi_aclk
                                     .s_axi_aresetn    ( rstn           ),  // input wire s_axi_aresetn
                                     .interrupt        ( interrupt      ),  // output wire interrupt

                                     .s_axi_awaddr     ( axi_if.awaddr  ),  // input wire [3 : 0] s_axi_awaddr
                                     .s_axi_awvalid    ( axi_if.awvalid ),  // input wire s_axi_awvalid
                                     .s_axi_awready    ( axi_if.awready ),  // output wire s_axi_awready

                                     .s_axi_wdata      ( axi_if.wdata   ),  // input wire [31 : 0] s_axi_wdata
                                     .s_axi_wstrb      ( axi_if.wstrb   ),  // input wire [3 : 0] s_axi_wstrb
                                     .s_axi_wvalid     ( axi_if.wvalid  ),  // input wire s_axi_wvalid
                                     .s_axi_wready     ( axi_if.wready  ),  // output wire s_axi_wready

                                     .s_axi_bresp      ( axi_if.bresp   ),  // output wire [1 : 0] s_axi_bresp
                                     .s_axi_bvalid     ( axi_if.bvalid  ),  // output wire s_axi_bvalid
                                     .s_axi_bready     ( axi_if.bready  ),  // input wire s_axi_bready

                                     .s_axi_araddr     ( axi_if.araddr  ),  // input wire [3 : 0] s_axi_araddr
                                     .s_axi_arvalid    ( axi_if.arvalid ),  // input wire s_axi_arvalid
                                     .s_axi_arready    ( axi_if.arready ),  // output wire s_axi_arready

                                     .s_axi_rdata      ( axi_if.rdata   ),  // output wire [31 : 0] s_axi_rdata
                                     .s_axi_rresp      ( axi_if.rresp   ),  // output wire [1 : 0] s_axi_rresp
                                     .s_axi_rvalid     ( axi_if.rvalid  ),  // output wire s_axi_rvalid
                                     .s_axi_rready     ( axi_if.rready  ),  // input wire s_axi_rready

                                     .rx               ( uart_rx        ),  // input wire rx
                                     .tx               ( uart_tx        )   // output wire tx
                                   );
    
    
    system_manager sys_mngr(
                                .clk_i                        ( sys_clk               ),
                                .rstn_i                       ( rstn                  ),
                            
                                .plain_text_data_o            ( plain_text_data       ),
                                .plain_text_data_valid_o      ( plain_text_data_valid ),
                                .key_o                        ( key                   ),
                                
                                .startup_pause_complete       ( startup_pause_complete ),
                                .key_set_complete_o           ( key_set_complete_o    ),
                            
                                .cipher_data_i                ( cipher_data           ),
                                .cipher_data_valid_i          ( cipher_data_valid     ),
                                            
                                .interrupt_i                  ( interrupt             ),
                                
                                .m_axi                        ( axi_if                )
                            );
    
    assign rst_o = ~rstn;
    assign clk_o = clk_div[1];
    always @(posedge sys_clk or negedge rstn) begin
        if (~rstn) begin
            clk_div <= 2'b00;
        end else begin
            clk_div <= clk_div + 1;
        end
    end

endmodule
