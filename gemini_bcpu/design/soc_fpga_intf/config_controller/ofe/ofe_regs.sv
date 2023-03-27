module ofe_regs #(
    parameter REGS_NUM = 1 ,
    parameter DWIDTH   = 32
) (
    input  logic                clk        ,
    input  logic                rst_n      ,
    // read apb_manager
    output logic                rack_o     ,
    output logic                rerr_o     ,
    output logic [  DWIDTH-1:0] rdat_o     ,
    input  logic [REGS_NUM-1:0] rreq_i     ,
    // write apb_manager
    output logic                wack_o     ,
    output logic                werr_o     ,
    input  logic [  DWIDTH-1:0] wdat_i     ,
    input  logic [REGS_NUM-1:0] wreq_i     ,
    input  logic [DWIDTH/8-1:0] wstr_i     ,
    // cfg status
    output logic                cfg_done   ,
    input  logic                pll3_status,
    input  logic                pll2_status,
    input  logic                pll1_status,
    input  logic                pll0_status,
    input  logic                icb_status ,
    input  logic                fcb_status
);

//*****************************************************************************
//              Declarations
//*****************************************************************************
logic [31:0] rg_rdat_mux  ;
logic [31:0] rg_rdat_mux_d;
logic [31:0] wstr_b       ;


logic rg_cfg_status_rreq  ;

logic rg_cfg_status_wreq;

logic [31:0] rg_cfg_status  ;

//*****************************************************************************
//              Registers Access logic
//*****************************************************************************
assign wstr_b = {
                {8{wstr_i[3]}},
                {8{wstr_i[2]}},
                {8{wstr_i[1]}},
                {8{wstr_i[0]}}
                };

//write req
assign rg_cfg_status_wreq = wreq_i[0];


//read req
assign rg_cfg_status_rreq = rreq_i[0];


//read data
assign rg_rdat_mux = (rg_cfg_status_rreq)? rg_cfg_status : 32'h0;


always @(posedge clk or negedge rst_n)
    if (!rst_n)       rg_rdat_mux_d <= 32'h0;
    else if (|rreq_i) rg_rdat_mux_d <= rg_rdat_mux;  

assign rdat_o = rg_rdat_mux_d;

always @ (posedge clk, negedge rst_n)
    if (!rst_n) rack_o <= 1'b0;
    else        rack_o <= |rreq_i;


always @ (posedge clk, negedge rst_n)
    if (!rst_n) wack_o <= 1'b0;
    else        wack_o <= |wreq_i;

assign rerr_o = 1'h0;
assign werr_o = 1'h0; //RO registers



//*****************************************************************************
//              Register cfg_status
//              offset   
//  Location    Attribute   Field Name
//
//  [31:8]     Rsvd  
//  [7]         R/W         cfg_done
//  [6]        Rsvd         
//  [5]         R/O         pll3_status
//  [4]         R/O         pll2_status
//  [3]         R/O         pll1_status
//  [2]         R/O         pll0_status
//  [1]         R/O         icb_status
//  [0]         R/O         fcb_status
//*****************************************************************************

assign rg_cfg_status = {
                       24'h0,
                       cfg_done,
                       1'b0,
                       pll3_status,
                       pll2_status,
                       pll1_status,
                       pll0_status,
                       icb_status,
                       fcb_status
                       }; 

always @(posedge clk or negedge rst_n)
    if (!rst_n)                              cfg_done  <= 'h0;
    else if (rg_cfg_status_rreq & wstr_b[7]) cfg_done  <= wdat_i[7];                       
endmodule                       