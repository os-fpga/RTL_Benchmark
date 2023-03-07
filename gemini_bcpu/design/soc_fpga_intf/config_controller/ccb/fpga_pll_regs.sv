module fpga_pll_regs #(
    parameter REGS_NUM = 5 ,
    parameter DWIDTH   = 32
) (
    input  logic                clk         ,
    input  logic                rst_n       ,
    // read apb_manager
    output logic                rack_o      ,
    output logic                rerr_o      ,
    output logic [  DWIDTH-1:0] rdat_o      ,
    input  logic [REGS_NUM-1:0] rreq_i      ,
    // write apb_manager
    output logic                wack_o      ,
    output logic                werr_o      ,
    input  logic [  DWIDTH-1:0] wdat_i      ,
    input  logic [REGS_NUM-1:0] wreq_i      ,
    input  logic [DWIDTH/8-1:0] wstr_i      ,
    // pll control
    output logic [        11:0] dskewcalin  ,
    output logic                pllen       ,
    output logic                dsmen       ,
    output logic                dskewfastcal,
    output logic                dskewcalen  ,
    output logic [         2:0] dskewcalcnt ,
    output logic                dskewcalbyp ,
    output logic                dacen       ,
    output logic [         5:0] refdiv      ,
    output logic                foutvcoen   ,
    output logic [         4:0] foutvcobyp  ,
    output logic [         3:0] fouten      ,
    output logic [        23:0] frac        ,
    output logic [        11:0] fbdiv       ,
    output logic [         3:0] postdiv3    ,
    output logic [         3:0] postdiv2    ,
    output logic [         3:0] postdiv1    ,
    output logic [         3:0] postdiv0    ,
    // pll status
    input  logic                lock        ,
    input  logic                dskewcallock,
    input  logic [        11:0] dskewcalout
);

//*****************************************************************************
//              Declarations
//*****************************************************************************
logic [31:0] rg_rdat_mux  ;
logic [31:0] rg_rdat_mux_d;
logic [31:0] wstr_b       ;

logic rg_pll_config_0_rreq;
logic rg_pll_config_1_rreq;
logic rg_pll_config_2_rreq;
logic rg_pll_config_3_rreq;
logic rg_pll_status_rreq  ;

logic rg_pll_config_0_wreq;
logic rg_pll_config_1_wreq;
logic rg_pll_config_2_wreq;
logic rg_pll_config_3_wreq;

logic [31:0] rg_pll_config_0;
logic [31:0] rg_pll_config_1;
logic [31:0] rg_pll_config_2;
logic [31:0] rg_pll_config_3;
logic [31:0] rg_pll_status  ;

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
assign rg_pll_config_0_wreq = wreq_i[0];
assign rg_pll_config_1_wreq = wreq_i[1];
assign rg_pll_config_2_wreq = wreq_i[2];
assign rg_pll_config_3_wreq = wreq_i[3];


//read req
assign rg_pll_config_0_rreq = rreq_i[0];
assign rg_pll_config_1_rreq = rreq_i[1];
assign rg_pll_config_2_rreq = rreq_i[2];
assign rg_pll_config_3_rreq = rreq_i[3];
assign rg_pll_status_rreq   = rreq_i[4];

//read data
assign rg_rdat_mux = (rg_pll_config_0_rreq)? rg_pll_config_0 :
                     (rg_pll_config_1_rreq)? rg_pll_config_1 :
                     (rg_pll_config_2_rreq)? rg_pll_config_2 :
                     (rg_pll_config_3_rreq)? rg_pll_config_3 :
                     (rg_pll_status_rreq)  ? rg_pll_status : 32'h0;


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
assign werr_o = wreq_i[4]; //RO registers
//*****************************************************************************
//              Register pll_config_0
//              offset   
//  Location    Attribute   Field Name
//
//  [31:28]     Rsvd             
//  [27:16]     R/W         DSKEWCALIN
//  [15: 9]     Rsvd    
//  [8]         R/W         PLLEN
//  [7]         R/W         DSMEN
//  [6]         R/W         DSKEWFASTCAL
//  [5]         R/W         DSKEWCALEN
//  [ 4: 2]     R/W         DSKEWCALCNT
//  [1]         R/W         DSKEWCALBYP
//  [0]         R/W         DACEN
//*****************************************************************************


assign rg_pll_config_0 = {
                         4'h0,
                         dskewcalin,
                         7'h0,
                         pllen,
                         dsmen,
                         dskewfastcal,
                         dskewcalen,
                         dskewcalcnt,
                         dskewcalbyp,
                         dacen
                         };      

always @(posedge clk or negedge rst_n)
    if (!rst_n)                             dskewcalin  <= 12'h0;
    else if (rg_pll_config_0_wreq & wstr_b[27]) dskewcalin  <= wdat_i[27:16];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                            pllen  <= 1'b1;
    else if (rg_pll_config_0_wreq & wstr_b[8]) pllen  <= wdat_i[8];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                            dsmen  <= 1'b1;
    else if (rg_pll_config_0_wreq & wstr_b[7]) dsmen  <= wdat_i[7];
            
always @(posedge clk or negedge rst_n)
    if (!rst_n)                            dskewfastcal  <= 1'b0;
    else if (rg_pll_config_0_wreq & wstr_b[6]) dskewfastcal  <= wdat_i[6];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                            dskewcalen  <= 1'b1;
    else if (rg_pll_config_0_wreq & wstr_b[5]) dskewcalen  <= wdat_i[5];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                            dskewcalcnt  <= 3'h2;
    else if (rg_pll_config_0_wreq & wstr_b[4]) dskewcalcnt  <= wdat_i[4:2];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                            dskewcalbyp  <= 1'b0;
    else if (rg_pll_config_0_wreq & wstr_b[1]) dskewcalbyp  <= wdat_i[1];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                            dacen  <= 1'b0;
    else if (rg_pll_config_0_wreq & wstr_b[0]) dacen  <= wdat_i[0];

//*****************************************************************************
//              Register pll_config_1
//              offset   
//  Location    Attribute   Field Name
//
//  [31:22]     Rsvd         
//  [21:16]     R/W         REFDIV
//  [15:14]     Rsvd        
//  [13]        R/W         FOUTVCOEN
//  [12: 8]     R/W         FOUTVCOBYP
//  [ 7: 4]     Rsvd        
//  [ 3: 0]     R/W         FOUTEN
//*****************************************************************************

assign rg_pll_config_1 = {
                         10'h0,
                         refdiv,
                         2'h0,
                         foutvcoen,
                         foutvcobyp,
                         4'h0,
                         fouten
                         }; 

always @(posedge clk or negedge rst_n)
    if (!rst_n)                             refdiv  <= 6'h1;
    else if (rg_pll_config_1_wreq & wstr_b[21]) refdiv  <= wdat_i[21:16];


always @(posedge clk or negedge rst_n)
    if (!rst_n)                             foutvcoen  <= 1'h0;
    else if (rg_pll_config_1_wreq & wstr_b[13]) foutvcoen  <= wdat_i[13];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                             foutvcobyp  <= 5'h0;
    else if (rg_pll_config_1_wreq & wstr_b[12]) foutvcobyp  <= wdat_i[12:8];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                            fouten  <= 4'h3;
    else if (rg_pll_config_1_wreq & wstr_b[3]) fouten  <= wdat_i[3:0];

//*****************************************************************************
//              Register pll_config_2
//              offset   
//  Location    Attribute   Field Name
//
//  [31:24]     Rsvd        
//  [23: 0]     R/W         FRAC
//*****************************************************************************

assign rg_pll_config_2 = {
                  8'h0,
                  frac
                  }; 

always @(posedge clk or negedge rst_n)
    if (!rst_n)                             frac  <= 24'h0;
    else if (rg_pll_config_2_wreq & wstr_b[23]) frac  <= wdat_i[23:0];


//*****************************************************************************
//              Register pll_config_3
//              offset   
//  Location    Attribute   Field Name
//
//  [31:28]     Rsvd         
//  [27:16]     R/W         FBDIV
//  [15:8]      Rsvd        
//  [ 7: 4]     R/W         POSTDIV1
//  [ 3: 0]     R/W         POSTDIV0
//*****************************************************************************


assign rg_pll_config_3 = {
                         4'h0,
                         fbdiv,
                         postdiv3,
                         postdiv2,
                         postdiv1,
                         postdiv0
                         }; 

always @(posedge clk or negedge rst_n)
    if (!rst_n)                             fbdiv  <= 12'd80;
    else if (rg_pll_config_3_wreq & wstr_b[27]) fbdiv  <= wdat_i[27:16];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                            postdiv3  <= 4'h2;
    else if (rg_pll_config_3_wreq & wstr_b[15]) postdiv3  <= wdat_i[15:12];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                            postdiv2  <= 4'h2;
    else if (rg_pll_config_3_wreq & wstr_b[11]) postdiv2  <= wdat_i[11:8];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                            postdiv1  <= 4'h2;
    else if (rg_pll_config_3_wreq & wstr_b[7]) postdiv1  <= wdat_i[7:4];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                            postdiv0  <= 4'h3;
    else if (rg_pll_config_3_wreq & wstr_b[3]) postdiv0  <= wdat_i[3:0];


//*****************************************************************************
//              Register pll_status
//              offset   
//  Location    Attribute   Field Name
//
//  [31:14]     Rsvd         
//  [13]        R/O         LOCK
//  [12]        R/O         DSKEWCALLOCK
//  [11: 0]     R/O         DSKEWCALOUT
//*****************************************************************************

assign rg_pll_status = {
                       18'h0,
                       lock,
                       dskewcallock,
                       dskewcalout
                       }; 

endmodule                       