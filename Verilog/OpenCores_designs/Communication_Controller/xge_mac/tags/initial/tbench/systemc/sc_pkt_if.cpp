//////////////////////////////////////////////////////////////////////
////                                                              ////
////  File name "sc_pkt_if.cpp"                                   ////
////                                                              ////
////  This file is part of the "10GE MAC" project                 ////
////  http://www.opencores.org/cores/xge_mac/                     ////
////                                                              ////
////  Author(s):                                                  ////
////      - A. Tanguay (antanguay@opencores.org)                  ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2008 AUTHORS. All rights reserved.             ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <iostream>
#include <sys/times.h>
#include <sys/stat.h>

#include "systemc.h"

#include "sc_pkt_if.h"

sc_fifo<packet_t*> * pkt_if::get_tx_fifo_ptr() {
    return &tx_fifo;
}

sc_fifo<packet_t*> * pkt_if::get_rx_fifo_ptr() {
    return &rx_fifo;
}

void pkt_if::init(void) {
    disable_rx = false;
    allow_rx_sop_err = false;
}

void pkt_if::connect_scoreboard(scoreboard *sbptr, scoreboard::sbSourceId sid) {
    sb = sbptr;
    sb_id = sid;
}

void pkt_if::transmit() {

    packet_t* pkt;

    while (true) {

        wait();

        if (tx_fifo.nb_read(pkt)) {

            pack(pkt);

            //cout << "Transmit PKT_IF packet:\n" << * pkt << endl;

            pkt_tx_val = 1;

            for (int i = 0; i < pkt->length; i += 8) {

                pkt_tx_data = pkt->data[i+7] << 56 |
                    pkt->data[i+6] << 48 |
                    pkt->data[i+5] << 40 |
                    pkt->data[i+4] << 32 |
                    pkt->data[i+3] << 24 |
                    pkt->data[i+2] << 16 |
                    pkt->data[i+1] << 8 |
                    pkt->data[i];

                if (i == 0) {
                    pkt_tx_sop = 1;
                }
                else {
                    pkt_tx_sop = 0;
                }

                if (i + 8 >= pkt->length) {
                    pkt_tx_eop = 0x1 << ((pkt->length - 1) % 8);
                }
                else {
                    pkt_tx_eop = 0;
                }

                wait();
            }

            pkt_tx_val = 0;


            //---
            // Pass packet to scoreboard

            sb->notify_packet_tx(sb_id, pkt);

            //---
            // Enforce minimum spacing between SOP's

            for (int i = (pkt->length+7)/8; i < 8; i++) {
                wait();
            }
        }
    }
};


void pkt_if::receive() {

    packet_t* pkt;

    sc_uint<64> data;

    wait();

    while (true) {

        if (pkt_rx_avail && !disable_rx) {

            pkt = new(packet_t);
            pkt->length = 0;

            // If reading already selected just keep going,
            // if not we must enable ren
            if (!pkt_rx_ren) {
                pkt_rx_ren = 1;
                wait();
            };

            while (true) {

                wait();

                if (!pkt_rx_val) {
                    continue;
                }

                // Check SOP

                if (pkt->length != 0 && pkt_rx_sop) {
                    if (allow_rx_sop_err) {
                        cout << "INFO: SOP errors allowed" << endl;
                        pkt->length = 0;
                        pkt->err_flags = 0;
                    }
                    else {
                        pkt->err_flags |= PKT_FLAG_ERR_SOP;
                    }
                }

                // Check error line

                if (pkt_rx_err) {
                    pkt->err_flags |= PKT_FLAG_ERR_SIG;
                }

                // Capture data

                data = pkt_rx_data;

                for (int lane = 0; lane < 8; lane++) {

                    pkt->data[pkt->length++] = (data >> (8 * lane)) & 0xff;

                    if (pkt->length >= 10000) {
                        cout << "ERROR: Packet too long" << endl;
                        sc_stop();
                    }

                    if ((pkt_rx_eop >> lane) & 0x1 == 1) {
                        break;
                    }
                }

                // Stop on EOP

                if (pkt_rx_eop) {
                    break;
                }
            }

            //---
            // Store packet

            unpack(pkt);
            //rx_fifo.write(pkt);

            //cout << "Receive PKT_IF packet:\n" << * pkt << endl;

            //---
            // Pass packet to scoreboard

            sb->notify_packet_rx(sb_id, pkt);

        }
        else {
            pkt_rx_ren = 0;
            wait();        
        }
    }
};
