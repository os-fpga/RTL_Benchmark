onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group dut.SYS_CON /testcase/tb/dut/glbl_rst
add wave -noupdate -group dut.SYS_CON /testcase/tb/dut/sys_diff_clock_clk_n
add wave -noupdate -group dut.SYS_CON /testcase/tb/dut/sys_diff_clock_clk_p
add wave -noupdate -group dut.SYS_CON /testcase/tb/dut/u0/Clk
add wave -noupdate -group dut.SYS_CON /testcase/tb/dut/u0/reset
add wave -noupdate -group dut.RGMII /testcase/tb/dut/rgmii_txd
add wave -noupdate -group dut.RGMII /testcase/tb/dut/rgmii_tx_ctl
add wave -noupdate -group dut.RGMII /testcase/tb/dut/rgmii_txc
add wave -noupdate -group dut.RGMII /testcase/tb/dut/rgmii_rxd
add wave -noupdate -group dut.RGMII /testcase/tb/dut/rgmii_rx_ctl
add wave -noupdate -group dut.RGMII /testcase/tb/dut/rgmii_rxc
add wave -noupdate -group dut.MDIO /testcase/tb/dut/mdio
add wave -noupdate -group dut.MDIO /testcase/tb/dut/mdc
add wave -noupdate -divider {New Divider}
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_AWADDR
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_AWPROT
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_AWVALID
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_AWREADY
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_WDATA
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_WSTRB
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_WVALID
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_WREADY
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_BRESP
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_BVALID
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_BREADY
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_ARADDR
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_ARPROT
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_ARVALID
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_ARREADY
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_RDATA
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_RRESP
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_RVALID
add wave -noupdate -group u0.MB.AXIM.IF /testcase/tb/dut/u0/microblaze_0/M_AXI_DP_RREADY
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_aclk
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_resetn
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_awaddr
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_awvalid
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_awready
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_wdata
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_wvalid
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_wready
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_bresp
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_bvalid
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_bready
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_araddr
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_arvalid
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_arready
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_rdata
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_rresp
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_rvalid
add wave -noupdate -group u0.TMEMAC.AXIS.IF /testcase/tb/dut/u0/tri_mode_emac_0/s_axi_rready
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_araddr
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_arlen
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_arsize
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_arburst
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_arprot
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_arcache
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_arvalid
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_arready
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_rdata
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_rresp
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_rlast
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_rvalid
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_mm2s_rready
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIS-S.IF /testcase/tb/dut/u0/axi_dma_0/m_axis_mm2s_tdata
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIS-S.IF /testcase/tb/dut/u0/axi_dma_0/m_axis_mm2s_tkeep
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIS-S.IF /testcase/tb/dut/u0/axi_dma_0/m_axis_mm2s_tvalid
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIS-S.IF /testcase/tb/dut/u0/axi_dma_0/m_axis_mm2s_tready
add wave -noupdate -expand -group u0.AXIDMA -group MM2S.AXIS-S.IF /testcase/tb/dut/u0/axi_dma_0/m_axis_mm2s_tlast
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_awaddr
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_awlen
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_awsize
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_awburst
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_awprot
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_awcache
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_awvalid
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_awready
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_wdata
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_wstrb
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_wlast
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_wvalid
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_wready
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_bresp
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_bvalid
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIM.IF /testcase/tb/dut/u0/axi_dma_0/m_axi_s2mm_bready
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIS-S.IF /testcase/tb/dut/u0/axi_dma_0/s_axis_s2mm_tdata
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIS-S.IF /testcase/tb/dut/u0/axi_dma_0/s_axis_s2mm_tkeep
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIS-S.IF /testcase/tb/dut/u0/axi_dma_0/s_axis_s2mm_tvalid
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIS-S.IF /testcase/tb/dut/u0/axi_dma_0/s_axis_s2mm_tready
add wave -noupdate -expand -group u0.AXIDMA -group S2MM.AXIS-S.IF /testcase/tb/dut/u0/axi_dma_0/s_axis_s2mm_tlast
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_awid
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_awaddr
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_awlen
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_awsize
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_awburst
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_awlock
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_awcache
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_awprot
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_awvalid
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_awready
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_wdata
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_wstrb
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_wlast
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_wvalid
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_wready
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_bid
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_bresp
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_bvalid
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_bready
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_arid
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_araddr
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_arlen
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_arsize
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_arburst
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_arlock
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_arcache
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_arprot
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_arvalid
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_arready
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_rid
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_rdata
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_rresp
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_rlast
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_rvalid
add wave -noupdate -group u0.BRAM -group AXIS /testcase/tb/dut/u0/axi_bram_ctrl_0/s_axi_rready
add wave -noupdate -group u0.BRAM -group BRAM /testcase/tb/dut/u0/axi_bram_ctrl_0/bram_en_a
add wave -noupdate -group u0.BRAM -group BRAM /testcase/tb/dut/u0/axi_bram_ctrl_0/bram_we_a
add wave -noupdate -group u0.BRAM -group BRAM /testcase/tb/dut/u0/axi_bram_ctrl_0/bram_addr_a
add wave -noupdate -group u0.BRAM -group BRAM /testcase/tb/dut/u0/axi_bram_ctrl_0/bram_wrdata_a
add wave -noupdate -group u0.BRAM -group BRAM /testcase/tb/dut/u0/axi_bram_ctrl_0/bram_rddata_a
add wave -noupdate -group u0.BRAM -group BRAM /testcase/tb/dut/u0/axi_bram_ctrl_0/bram_en_b
add wave -noupdate -group u0.BRAM -group BRAM /testcase/tb/dut/u0/axi_bram_ctrl_0/bram_we_b
add wave -noupdate -group u0.BRAM -group BRAM /testcase/tb/dut/u0/axi_bram_ctrl_0/bram_addr_b
add wave -noupdate -group u0.BRAM -group BRAM /testcase/tb/dut/u0/axi_bram_ctrl_0/bram_wrdata_b
add wave -noupdate -group u0.BRAM -group BRAM /testcase/tb/dut/u0/axi_bram_ctrl_0/bram_rddata_b
add wave -noupdate -divider {New Divider}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {830667500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 421
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1154520675 ps}
