/**
 *  axi_interface for inteconnection with sys_mngr and uart in FPGA project
 *
 *  Copyright 2020 by Vyacheslav Gulyaev <v.gulyaev181@gmail.com>
 *
 *  Licensed under GNU General Public License 3.0 or later. 
 *  Some rights reserved. See COPYING, AUTHORS.
 *
 * @license GPL-3.0+ <http://spdx.org/licenses/GPL-3.0+>
 */

interface axi_interface();
    //write address channel
    logic [3:0]   awaddr;
    logic         awvalid;
    logic         awready;
    
    //write data channel
    logic [31:0]  wdata;
    logic [3:0]   wstrb;
    logic         wvalid;
    logic         wready;
    
    //write response channel
    logic [1:0]   bresp;
    logic         bvalid;
    logic         bready;
    
    //read address channel
    logic [3:0]   araddr;
    logic         arvalid;
    logic         arready;
    
    //read data channel
    logic [31:0]  rdata;
    logic [1:0]   rresp;
    logic         rvalid;
    logic         rready;
    
    
    modport master (
                        output awaddr,
                        output awvalid,
                        input  awready,
                        output wdata,
                        output wstrb,
                        output wvalid,
                        input  wready,
                        input  bresp,
                        input  bvalid,
                        output bready,
                        output araddr,
                        output arvalid,
                        input  arready,
                        input  rdata,
                        input  rresp,
                        input  rvalid,
                        output rready
                    );

endinterface
