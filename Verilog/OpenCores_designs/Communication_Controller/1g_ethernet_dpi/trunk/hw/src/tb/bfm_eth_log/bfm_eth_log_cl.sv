//////////////////////////////////////////////////////////////////////////////////
// Company:          
// Engineer:        IK
// 
// Create Date:     11:35:01 03/21/2013 
// Design Name:     
// Module Name:     bfm_eth_log_cl
// Project Name:    
// Target Devices:  
// Tool versions:   
// Description:     
//                  
//                  
// Revision: 
// Revision 0.01 - File Created, 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

typedef virtual interface rgmii_rx_if virt_rx_if_t;

class bfm_eth_log_cl;
//////////////////////////////////////////////////////////////////////////////////
    // 
    virt_rx_if_t    vif_rx;
    virt_rx_if_t    vif_tx;
    //
    string          name;
    bit             verbose;
    //
    int             fd, fd_idx;
    pcap_pkg::u_pcap_hdr_t      sv_pcap_hdr_u;
    pcap_pkg::u_pcaprec_hdr_t   sv_pcaprec_hdr_u;
    // 
    static int idx=0;
    
//////////////////////////////////////////////////////////////////////////////////

static function int next_id;
    next_id = idx++;
endfunction : next_id

function new (string name = "logger", virt_rx_if_t rx, virt_rx_if_t tx, bit i_verbose=0);
    string str;
    // name
    str.itoa(next_id());
    this.name = {name, "#" ,str};
    this.verbose = i_verbose;
    // 
    this.fd = 0; this.fd_idx = 0;
    // fill-in pcap_hdr
    sv_pcap_hdr_u.pcap_hdr.magic_number = 32'ha1b2c3d4;
    sv_pcap_hdr_u.pcap_hdr.version_major = 2;
    sv_pcap_hdr_u.pcap_hdr.version_minor = 4;
    sv_pcap_hdr_u.pcap_hdr.thiszone = 0;
    sv_pcap_hdr_u.pcap_hdr.sigfigs = 0;
    sv_pcap_hdr_u.pcap_hdr.snaplen = 256*1024; // 256KB
    sv_pcap_hdr_u.pcap_hdr.network = 1;
    // if
    this.vif_rx = rx;
    this.vif_tx = tx;
    // Final
endfunction : new

//////////////////////////////////////////////////////////////////////////////////

task init;
    vif_rx.init();
    vif_tx.init();
    $display("%s ready", this.name);
    // Final
endtask : init

task log_run;
    // dec var
    int rx_pkt_len, tx_pkt_len;
    // if we are in RUN
    if (fd_idx)
        begin   :   _RE
            $fclose(fd);
            $display("[%t]: %m: re-open PCAP, last frm can be dropped!", $time);
        end
    // pcap-open
    fd = $fopen($sformatf("%s_%02d.pcap", name, fd_idx++), "wb");
    // write pcap-hdr
    for (int i = 0; i < pcap_pkg::pcap_hdr_sz; i++)
        $fwrite(fd, "%c", 8'(sv_pcap_hdr_u.data[i]));
    // sta RX-LOG
    fork
        forever
            begin   :   LOG_RX
                // get ETH-pkt
                vif_rx.rx_pkt();
                // get pkt-id
                rx_pkt_len = vif_rx.rx_pkt_len();
                // prep-hdr
                sv_pcaprec_hdr_u.pcaprec_hdr.ts_sec     =   ($time/1_000_000);
                sv_pcaprec_hdr_u.pcaprec_hdr.ts_usec    =   ($time%1_000_000);
                sv_pcaprec_hdr_u.pcaprec_hdr.incl_len   =   rx_pkt_len;
                sv_pcaprec_hdr_u.pcaprec_hdr.orig_len   =   rx_pkt_len;
                // wr-hdr
                for (int i = 0; i < pcap_pkg::pcaprec_hdr_sz; i++)
                     $fwrite(fd, "%c", 8'(sv_pcaprec_hdr_u.data[i]));
                // wr-data
                for (int i = 0; i < rx_pkt_len; i++)
                    $fwrite(fd, "%c", 8'(vif_rx.rx_pkt_data(i)));
                // 
                if (verbose)
                    $display("[%t]: %m: rx-pkt_len=%h", $time, rx_pkt_len);
            end
    join_none
    // sta TX-LOG
    fork
        forever
            begin   :   LOG_TX
                // get ETH-pkt
                vif_tx.rx_pkt();
                // get pkt-id
                tx_pkt_len = vif_tx.rx_pkt_len();
                // prep-hdr
                sv_pcaprec_hdr_u.pcaprec_hdr.ts_sec     =   ($time/1_000_000);
                sv_pcaprec_hdr_u.pcaprec_hdr.ts_usec    =   ($time%1_000_000);
                sv_pcaprec_hdr_u.pcaprec_hdr.incl_len   =   tx_pkt_len;
                sv_pcaprec_hdr_u.pcaprec_hdr.orig_len   =   tx_pkt_len;
                // wr-hdr
                for (int i = 0; i < pcap_pkg::pcaprec_hdr_sz; i++)
                     $fwrite(fd, "%c", 8'(sv_pcaprec_hdr_u.data[i]));
                // wr-data
                for (int i = 0; i < tx_pkt_len; i++)
                    $fwrite(fd, "%c", 8'(vif_tx.rx_pkt_data(i)));
                // 
                if (verbose)
                    $display("[%t]: %m: tx-pkt_len=%h", $time, tx_pkt_len);
            end
    join_none
    // 
endtask : log_run

task log_stop;
    if (fd)
        begin   :   STOP_LOG
            // close pcap-file
            $fclose(fd); fd = 0;
            // fd=INVALID, so we must stop logging NOW
            disable log_run;
        end
endtask : log_stop
//////////////////////////////////////////////////////////////////////////////////
endclass : bfm_eth_log_cl
