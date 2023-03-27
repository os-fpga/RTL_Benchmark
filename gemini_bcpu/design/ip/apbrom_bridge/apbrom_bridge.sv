module apbrom_bridge #(
  parameter AWIDTH = 8 ,
  parameter DWIDTH = 32
) (
  input  logic                clk      ,
  input  logic                rst_n    ,
  // APB
  input  logic [  AWIDTH-1:0] apb_addr ,
  input  logic                apb_sel  ,
  input  logic                apb_en   ,
  input  logic                apb_wr   ,
  output logic [  DWIDTH-1:0] apb_rdata,
  output logic                apb_ready,
  output logic                apb_err
);

logic [11:0] mem_addr     ;
logic        mem_cs       ;
logic [31:0] mem_dout     ;
logic        apb_ready_r  ;
logic        set_apb_ready;
logic        VDD          ;
logic        VSS          ;

always @ (posedge clk or negedge rst_n)
  if (!rst_n)             apb_ready_r <= 1'b0;
  else if (apb_ready_r)   apb_ready_r <= 1'b0;
  else if (set_apb_ready) apb_ready_r <= 1'b1;

assign set_apb_ready = apb_err | ~mem_cs;

assign apb_ready = apb_ready_r;
assign apb_err   = apb_sel & apb_en & apb_wr;
assign apb_rdata = mem_dout;
assign mem_addr  = apb_addr;
assign mem_cs    = ~(apb_sel & !apb_en & !apb_wr);  

  dti_rom_tm16ffcll_4096x32_t81xoe_m_a n22_rom (
    .VDD   (VDD     ),
    .VSS   (VSS     ),
    .DO    (mem_dout),
    .A     (mem_addr),
    .T_A   (12'h0   ),
    .T_BE_N(1'b1    ),
    .CE_N  (mem_cs  ),
    .T_CE_N(1'b1    ),
    .T_OE_N(1'b1    ),
    .OE_N  (1'b0    ),
    .T_RM  (3'b011  ), // TO BE REVIEWED AND ADJUSTED !!!!!
    .CLK   (clk     )
  );
endmodule