module bcpu_top (
output logic        hart_halted         , //?
input  logic        mtip                ,
input  logic [31:0] int_src             ,
input  logic        disable_ext_debugger, //?
output logic        hlock               ,
input  logic        hresp               ,
output logic [ 1:0] master              ,
input  logic [31:0] hrdata              ,
input  logic        hready              ,
output logic [31:0] haddr               ,
output logic [ 2:0] hburst              ,
output logic [ 3:0] hprot               ,
output logic [ 2:0] hsize               ,
output logic [ 1:0] htrans              ,
output logic [31:0] hwdata              ,
output logic        hwrite              ,
output logic        dbg_srst_req        , //?
input  logic        jtag_tck            ,
input  logic        jtag_tdi            ,
output logic        jtag_tdo            ,
input  logic        jtag_tms            ,
input  logic        clkgate_bypass      , //? 
output logic        core_sleep_value    , //?
input  logic        reset_bypass        , //?
input  logic        rx_evt              , //?
output logic        tx_evt              , //?
input  logic        meip                , //?
input  logic        por_rstn            , //?
input  logic        core_clk            ,
input  logic        core_reset_n        ,
output logic        core_wfi_mode       , //?
input  logic [31:0] reset_vector        , //?
input  logic        nmi                   //?
  );

logic        mtime_toggle_a      ;
logic        ppi_dmode           ;
logic [13:0] ppi_paddr           ;
logic        ppi_penable         ;
logic [ 2:0] ppi_pprot           ;
logic [31:0] ppi_prdata          ;
logic        ppi_pready          ;
logic        ppi_psel            ;
logic        ppi_pslverr         ;
logic [ 3:0] ppi_pstrobe         ;
logic [31:0] ppi_pwdata          ;
logic        ppi_pwrite          ;
// ROM inst TBD

//Core

// Timer toggle
always @ (posedge core_clk or negedge core_reset_n ) begin
      if (!core_reset_n) begin
            mtime_toggle_a <= 1'b0;
      end
      else begin
            mtime_toggle_a <= ~mtime_toggle_a;
      end
end

  n22_core_top n22_core_top
    (
      .hart_halted          (hart_halted),
      .mtime_toggle_a       (mtime_toggle_a),
      .int_src              (int_src),
      .hlock                (hlock),
      .hresp                (hresp),
      .master               (master),
      .hrdata               (hrdata),
      .hready               (hready),
      .haddr                (haddr),
      .hburst               (hburst),
      .hprot                (hprot),
      .hsize                (hsize),
      .htrans               (htrans),
      .hwdata               (hwdata),
      .hwrite               (hwrite),
      .dbg_srst_req         (dbg_srst_req),
      .disable_ext_debugger (1'b1),
      .ppi_dmode            (ppi_dmode),
      .ppi_paddr            (ppi_paddr),
      .ppi_penable          (ppi_penable),
      .ppi_pprot            (ppi_pprot),
      .ppi_prdata           (ppi_prdata),
      .ppi_pready           (ppi_pready),
      .ppi_psel             (ppi_psel),
      .ppi_pslverr          (ppi_pslverr),
      .ppi_pstrobe          (ppi_pstrobe),
      .ppi_pwdata           (ppi_pwdata),
      .ppi_pwrite           (ppi_pwrite),
      .jtag_tck             (jtag_tck),
      .jtag_tdi             (jtag_tdi),
      .jtag_tdo             (jtag_tdo),
      .jtag_tms             (jtag_tms),
      .clkgate_bypass       (1'b0),
      .core_sleep_value     (core_sleep_value),
      .hart_id              ('h0),
      .reset_bypass         (1'b0),
      .rx_evt               (1'b0),
      .tx_evt               (tx_evt),
      .meip                 (meip),
      .por_rstn             (por_rstn),
      .core_clk             (core_clk),
      .core_clk_aon         (core_clk),
      .core_reset_n         (core_reset_n),
      .core_wfi_mode        (core_wfi_mode),
      .reset_vector         (reset_vector),
      .nmi                  (nmi)
    );


endmodule