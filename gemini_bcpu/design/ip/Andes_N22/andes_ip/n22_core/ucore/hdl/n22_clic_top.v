
`include "global.inc"

`ifdef N22_HAS_CLIC
module n22_clic_top # (
    parameter CLIC_IRQ_NUM = 32,
    parameter CLICINTCTLBITS = 5
)(
    input   clk_aon,
    input   clk,
    input   rst_n,

    input                           msip,
    input                           mtip,
    input                           meip,
    input                           mip_imecci,
    input                           mip_bwei,
    input                           mip_pmovi,
    input [CLIC_IRQ_NUM-20:0]       clic_irq,

    input                           icb_cmd_valid,
    output                          icb_cmd_ready,
    input  [16-1:0]                 icb_cmd_addr,
    input  [`N22_XLEN_MW-1:0]      icb_cmd_wmask,
    input                           icb_cmd_read,
    input  [31:0]                   icb_cmd_wdata,

    output                          icb_rsp_valid,
    input                           icb_rsp_ready,
    output [31:0]                   icb_rsp_rdata,
    output                          icb_rsp_err,

    input                           clic_irq_taken,
    input                           core_in_int,
    input                           clic_int_mode,
    input                           mnxti_valid_taken,

    output                          clic_active,
    output                          clic_irq_o,
    output [9:0]                    clic_irq_id,
    output                          clic_irq_shv,
    input [7:0]                     mintstatus_mil_r,
    output [7:0]                    clic_irq_lvl,
    output                          clic_prio_gt_thod
);


    localparam CLIC_IRQ_NUM_LOG2 = `CLOG2(CLIC_IRQ_NUM);
    localparam VERSION = `N22_CLIC_VERSION;

    wire icb_cmd_hsked = icb_cmd_valid & icb_cmd_ready;
    wire icb_cmd_wr_hsked = icb_cmd_hsked & (~icb_cmd_read);
    wire icb_cmd_rd_hsked = icb_cmd_hsked & icb_cmd_read;

    wire                                icb_cmd_sel_cliccfg;
    wire                                icb_cmd_sel_clicinfo;
    wire                                icb_cmd_sel_mintthresh;

    wire [CLIC_IRQ_NUM-1:0]             icb_cmd_byte_sel_ip;
    wire [CLIC_IRQ_NUM-1:0]             icb_cmd_byte_sel_ie;
    wire [CLIC_IRQ_NUM-1:0]             icb_cmd_byte_sel_attr;
    wire [CLIC_IRQ_NUM-1:0]             icb_cmd_byte_sel_ctl;

    wire [CLIC_IRQ_NUM-1:0]             icb_cmd_word_sel_clicint;

    wire                                cliccfg_wen;
    wire                                mintthresh_mth_wen;
    wire [CLIC_IRQ_NUM-1:0]             clicintie_wen;
    wire [CLIC_IRQ_NUM-1:0]             clicintctl_wen;
    wire [CLIC_IRQ_NUM-1:0]             clicintattr_wen;

    wire [7:0]                          mintthresh_mth_nxt;
    wire [7:0]                          cliccfg_nxt;
    wire [7:0]                          clicintie_nxt[0:CLIC_IRQ_NUM-1];
    wire [7:0]                          clicintctl_nxt[0:CLIC_IRQ_NUM-1];
    wire [7:0]                          clicintattr_nxt[0:CLIC_IRQ_NUM-1];
    wire [31:0]                         rsp_rdata_cliccfg;
    wire [31:0]                         rsp_rdata_clicinfo;
    wire [31:0]                         rsp_rdata_mintthresh;
    reg [31:0]                          rsp_rdata_clicint;


    wire [7:0]                          cliccfg_r;
    wire [3:0]                          clic_nlbits = cliccfg_r[4:1];

    wire [7:0]                          mintthresh_mth_r;
    wire [7:0]                          clicintip_r[0:CLIC_IRQ_NUM-1];
    wire [7:0]                          clicintie_r[0:CLIC_IRQ_NUM-1];
    wire [7:0]                          clicintattr_r[0:CLIC_IRQ_NUM-1];
    wire                                clicintattr_shv_r[0:CLIC_IRQ_NUM-1];
    wire [7:0]                          clicintctl_r[0:CLIC_IRQ_NUM-1];
    wire [CLICINTCTLBITS:0]             irq_comb_prio_lvl_10[0:1024-1];
    wire [CLIC_IRQ_NUM_LOG2-1:0]        irq_id_lvl_10[0:1024-1];
    wire                                irq_shv_lvl_10[0:1024-1];
    wire [CLICINTCTLBITS:0]             irq_comb_prio_lvl_9[0:512-1];
    wire [CLIC_IRQ_NUM_LOG2-1:0]        irq_id_lvl_9[0:512-1];
    wire                                irq_shv_lvl_9[0:512-1];
    wire [CLICINTCTLBITS:0]             irq_comb_prio_lvl_8[0:256-1];
    wire [CLIC_IRQ_NUM_LOG2-1:0]        irq_id_lvl_8[0:256-1];
    wire                                irq_shv_lvl_8[0:256-1];
    wire  [CLICINTCTLBITS:0]            irq_comb_prio_lvl_7[0:128-1];
    wire [CLIC_IRQ_NUM_LOG2-1:0]        irq_id_lvl_7[0:128-1];
    wire                                irq_shv_lvl_7[0:128-1];
    wire [CLICINTCTLBITS:0]             irq_comb_prio_lvl_6[0:64-1];
    wire [CLIC_IRQ_NUM_LOG2-1:0]        irq_id_lvl_6[0:64-1];
    wire                                irq_shv_lvl_6[0:64-1];
    wire [CLICINTCTLBITS:0]             irq_comb_prio_lvl_5[0:32-1];
    wire [CLIC_IRQ_NUM_LOG2-1:0]        irq_id_lvl_5[0:32-1];
    wire                                irq_shv_lvl_5[0:32-1];
    wire [CLICINTCTLBITS:0]             irq_comb_prio_lvl_4[0:16-1];
    wire [CLIC_IRQ_NUM_LOG2-1:0]        irq_id_lvl_4[0:16-1];
    wire                                irq_shv_lvl_4[0:16-1];
    wire [CLICINTCTLBITS:0]             irq_comb_prio_lvl_3[0:8-1];
    wire [CLIC_IRQ_NUM_LOG2-1:0]        irq_id_lvl_3[0:8-1];
    wire                                irq_shv_lvl_3[0:8-1];
    wire [CLICINTCTLBITS:0]             irq_comb_prio_lvl_2[0:4-1];
    wire [CLIC_IRQ_NUM_LOG2-1:0]        irq_id_lvl_2[0:4-1];
    wire                                irq_shv_lvl_2[0:4-1];
    wire [CLICINTCTLBITS:0]             irq_comb_prio_lvl_1[0:2-1];
    wire [CLIC_IRQ_NUM_LOG2-1:0]        irq_id_lvl_1[0:2-1];
    wire                                irq_shv_lvl_1[0:2-1];
    wire [CLICINTCTLBITS-1:0]           irq_comb_prio_top;
    wire [CLIC_IRQ_NUM_LOG2-1:0]        irq_id_top;
    wire                                irq_ip_top;
    wire                                irq_shv_top;
    wire [CLICINTCTLBITS-1:0]           irq_comb_prio_top_r;
    wire [CLIC_IRQ_NUM_LOG2-1:0]        irq_id_top_r;
    wire                                irq_ip_top_r;
    wire                                irq_shv_top_r;
    wire [511:0]                        irq_comb_prio_lvl_9_lt;
    wire [255:0]                        irq_comb_prio_lvl_8_lt;
    wire [127:0]                        irq_comb_prio_lvl_7_lt;
    wire [63:0]                         irq_comb_prio_lvl_6_lt;
    wire [31:0]                         irq_comb_prio_lvl_5_lt;
    wire [15:0]                         irq_comb_prio_lvl_4_lt;
    wire [7:0]                          irq_comb_prio_lvl_3_lt;
    wire [3:0]                          irq_comb_prio_lvl_2_lt;
    wire [1:0]                          irq_comb_prio_lvl_1_lt;
    wire                                irq_comb_prio_top_lt;
    wire [CLIC_IRQ_NUM-1:0]             irq_prio_vld;
    wire                                edge_trig_ip_clr_en;
    `ifndef N22_HAS_CLIC_EDGE
    wire clic_lvl_trig_extirq_r[0:CLIC_IRQ_NUM-20];
    wire [7:0] clicintip_ext[0:CLIC_IRQ_NUM-20];
    `endif
    genvar i;
    integer ii;

    assign icb_cmd_sel_cliccfg  = (icb_cmd_addr[15:2] == 14'h0);
    assign icb_cmd_sel_clicinfo = (icb_cmd_addr[15:2] == 14'h1);
    assign icb_cmd_sel_mintthresh  = (icb_cmd_addr[15:2] == 14'h2);

    wire[CLIC_IRQ_NUM-1:0] clic_irq_i;
    assign clic_irq_i[2:0] = 3'b0;
    assign clic_irq_i[3] = msip;
    assign clic_irq_i[6:4] = 3'b0;
    assign clic_irq_i[7] = mtip;
    assign clic_irq_i[10:8] = 3'b0;
    assign clic_irq_i[11] = meip;
    assign clic_irq_i[15:12] = 4'b0;
    assign clic_irq_i[16] = mip_imecci    ;
    assign clic_irq_i[17] = mip_bwei    ;
    assign clic_irq_i[18] = mip_pmovi    ;

    generate
    for(i=19; i<CLIC_IRQ_NUM; i=i+1) begin:gen_clic_irq_id_lt_irqnum_ge_19
                assign clic_irq_i[i] = clic_irq[i-19];
    end
    endgenerate

    generate
    for(i=0; i<CLIC_IRQ_NUM; i=i+1) begin: gen_clicint_sel
        assign icb_cmd_word_sel_clicint[i]   = ({18'h0,icb_cmd_addr[15:2]} == (($unsigned(i)*4 + 32'h1000)>>2));
        assign icb_cmd_byte_sel_ip[i]    =  icb_cmd_word_sel_clicint[i] & icb_cmd_wmask[0];
        assign icb_cmd_byte_sel_ie[i]    =  icb_cmd_word_sel_clicint[i] & icb_cmd_wmask[1];
        assign icb_cmd_byte_sel_attr[i]  =  icb_cmd_word_sel_clicint[i] & icb_cmd_wmask[2];
        assign icb_cmd_byte_sel_ctl[i]  =  icb_cmd_word_sel_clicint[i] & icb_cmd_wmask[3];
    end
    endgenerate

    assign cliccfg_wen = icb_cmd_wr_hsked & icb_cmd_sel_cliccfg & icb_cmd_wmask[0];
    assign cliccfg_nxt = {3'b0,icb_cmd_wdata[4:1],1'b1};
    n22_gnrl_dfflr #(7) cliccfg_dfflr(cliccfg_wen,cliccfg_nxt[7:1],cliccfg_r[7:1],clk,rst_n);
    assign cliccfg_r[0] = 1'b1;

    assign mintthresh_mth_wen = icb_cmd_wr_hsked & icb_cmd_sel_mintthresh & icb_cmd_wmask[3];
    assign mintthresh_mth_nxt =  icb_cmd_wdata[31:24];
    n22_gnrl_dfflr #(8) mintthresh_mth_dfflr(mintthresh_mth_wen,mintthresh_mth_nxt,mintthresh_mth_r,clk,rst_n);


    generate
    for(i=0; i<CLIC_IRQ_NUM; i=i+1) begin:gen_clic_clicint_write
    if((i < 19) & (i!=3) & (i!=7) & (i!=11)
                & (i!=17)
            `ifdef N22_HAS_PMONITOR
                & (i!=18)
            `endif
    ) begin:gen_clic_clicintip_tie0
        assign clicintip_r[i] = 8'b0;
    end
    else if(i<19) begin:gen_internal_clicintip
        n22_clicintip_gen #(
            .INDEX(i),
            .IRQ_NUM_LOG2(CLIC_IRQ_NUM_LOG2)
        ) u_n22_internal_clicintip_gen(
            .clk_aon             (clk_aon),
            .rst_n               (rst_n),
            .clic_irq_i          (clic_irq_i[i]),
            .clicintattr_trig_r  (clicintattr_r[i][2:1]),
            .edge_trig_ip_clr_en           (edge_trig_ip_clr_en),
            .irq_id_top_r        (irq_id_top_r),
            .icb_cmd_byte_sel_ip (icb_cmd_byte_sel_ip[i]),
            .icb_cmd_wr_hsked    (icb_cmd_wr_hsked),
            .icb_cmd_wdata       (icb_cmd_wdata),
            .clicintip_r         (clicintip_r[i])
        );
    end
    else begin:gen_external_clicintip
    `ifdef N22_HAS_CLIC_EDGE
        n22_clicintip_gen #(
            .INDEX(i),
            .IRQ_NUM_LOG2(CLIC_IRQ_NUM_LOG2)
        ) u_n22_external_clicintip_gen(
            .clk_aon             (clk_aon),
            .rst_n               (rst_n),
            .clic_irq_i          (clic_irq_i[i]),
            .clicintattr_trig_r  (clicintattr_r[i][2:1]),
            .edge_trig_ip_clr_en           (edge_trig_ip_clr_en),
            .irq_id_top_r        (irq_id_top_r),
            .icb_cmd_byte_sel_ip (icb_cmd_byte_sel_ip[i]),
            .icb_cmd_wr_hsked    (icb_cmd_wr_hsked),
            .icb_cmd_wdata       (icb_cmd_wdata),
            .clicintip_r         (clicintip_r[i])
        );

    `else
        n22_gnrl_dffr #(1) n22_clic_int_extirq_dffr(clic_irq_i[i],clic_lvl_trig_extirq_r[i-19],clk_aon,rst_n);
        assign clicintip_ext[i-19] = {7'b0, clic_lvl_trig_extirq_r[i-19]};
        assign clicintip_r[i] = clicintip_ext[i-19];

    `endif
    end

    if((i < 19) & (i!=3) & (i!=7) & (i!=11)
                & (i!=17)
            `ifdef N22_HAS_PMONITOR
                & (i!=18)
            `endif
                ) begin:gen_clic_clicint_tie0
            assign clicintctl_nxt[i] = {{(CLICINTCTLBITS){1'b0}},{(8-CLICINTCTLBITS){1'b1}}};
            assign clicintattr_nxt[i] = {2'b11,6'b0};
            assign clicintie_nxt[i] = 8'b0;
    end
    else begin:gen_clic_clicint_write_nxt
        assign clicintie_nxt[i] = {7'b0,icb_cmd_wdata[8]};
        if(i>=19) begin:gen_external_clicintattr
        `ifdef N22_HAS_CLIC_EDGE
        assign clicintattr_nxt[i] = {2'b11,3'b0,icb_cmd_wdata[18:16]};
        `else
        assign clicintattr_nxt[i] = {2'b11,5'b0,icb_cmd_wdata[16]};
        `endif
        end
        else begin:gen_internal_clicintattr
        assign clicintattr_nxt[i] = {2'b11,3'b0,icb_cmd_wdata[18:16]};
        end
        assign clicintctl_nxt[i] = {icb_cmd_wdata[31 -: CLICINTCTLBITS], {(8-CLICINTCTLBITS){1'b1}}};
    end

        assign clicintctl_wen[i] = icb_cmd_wr_hsked & icb_cmd_byte_sel_ctl[i];
        assign clicintattr_wen[i] = icb_cmd_wr_hsked & icb_cmd_byte_sel_attr[i];
        assign clicintie_wen[i] = icb_cmd_wr_hsked & icb_cmd_byte_sel_ie[i];

        if(CLICINTCTLBITS>=8) begin:gen_clicintctl_dff_clicintctlbits_ge_8
        n22_gnrl_dfflr #(8) clicintctl_dfflr(clicintctl_wen[i],clicintctl_nxt[i][7:0],clicintctl_r[i][7:0],clk,rst_n);
        end
        else begin:gen_clicintctl_dff_clicintctlbits_lt_8
        n22_gnrl_dfflr #(CLICINTCTLBITS) clicintctl_msb_dfflr(clicintctl_wen[i],clicintctl_nxt[i][7-:CLICINTCTLBITS],clicintctl_r[i][7-:CLICINTCTLBITS],clk,rst_n);
        assign clicintctl_r[i][7-CLICINTCTLBITS:0] = {(8-CLICINTCTLBITS){1'b1}};
        end
        n22_gnrl_dfflr #(6) clicintattr_lsb_dfflr(clicintattr_wen[i],clicintattr_nxt[i][5:0],clicintattr_r[i][5:0],clk,rst_n);
        assign clicintattr_r[i][7:6] = 2'b11;
        n22_gnrl_dfflr #(8) clicintie_dfflr(clicintie_wen[i],clicintie_nxt[i],clicintie_r[i],clk,rst_n);
    end
    endgenerate




   assign rsp_rdata_cliccfg  = {32{icb_cmd_sel_cliccfg}} & {27'b0, clic_nlbits,1'b1};
   wire [3:0] clic_ctl_bits = CLICINTCTLBITS[3:0];
   wire [7:0] clic_version = VERSION[7:0];
   wire [12:0] clic_irqnum = CLIC_IRQ_NUM[12:0];
   assign rsp_rdata_clicinfo = {32{icb_cmd_sel_clicinfo}} & {7'b0,clic_ctl_bits,clic_version,clic_irqnum};
   assign rsp_rdata_mintthresh = {32{icb_cmd_sel_mintthresh}} & {mintthresh_mth_r,24'b0};
   always @* begin:gen_rdat_clicint
       rsp_rdata_clicint  = 32'b0;
       for(ii=0; ii<CLIC_IRQ_NUM; ii=ii+1) begin: gen_rsp_rdata
            rsp_rdata_clicint  =  rsp_rdata_clicint  | ({32{icb_cmd_word_sel_clicint[ii]}} &
                                                  {clicintctl_r[ii],
                                                   clicintattr_r[ii],
                                                   clicintie_r[ii],
                                                   clicintip_r[ii]}
                                                 );
       end
   end




    wire [`N22_XLEN-1:0] rsp_rdata = rsp_rdata_cliccfg
                                    | rsp_rdata_clicinfo
                                    | rsp_rdata_mintthresh
                                    | rsp_rdata_clicint;



   generate


    for(i=0; i<CLIC_IRQ_NUM; i=i+1) begin:gen_tie_input
        assign clicintattr_shv_r[i] = clicintattr_r[i][0];
        assign irq_prio_vld[i] = clicintie_r[i][0] & clicintip_r[i][0];
        assign irq_comb_prio_lvl_10[i] =  {irq_prio_vld[i], clicintctl_r[i][7 -: CLICINTCTLBITS]};
        assign irq_id_lvl_10[i] = i[CLIC_IRQ_NUM_LOG2-1:0];
        assign irq_shv_lvl_10[i] = clicintattr_shv_r[i];
    end

    for(i=CLIC_IRQ_NUM; i<1024; i=i+1) begin:gen_tie_unused_tozero
        assign irq_comb_prio_lvl_10[i] = {(CLICINTCTLBITS+1){1'b0}};
        assign irq_id_lvl_10[i] = {CLIC_IRQ_NUM_LOG2{1'b0}};
        assign irq_shv_lvl_10[i] = 1'b0;
    end


    for(i=0; i<512; i=i+1) begin: gen_lvl_9_comp_gen
        assign irq_comb_prio_lvl_9_lt[i] = (irq_comb_prio_lvl_10[(2*i) + 1] < irq_comb_prio_lvl_10[2*i]);
        assign irq_comb_prio_lvl_9[i] =  irq_comb_prio_lvl_9_lt[i] ? irq_comb_prio_lvl_10[2*i]:irq_comb_prio_lvl_10[(2*i) + 1];
        assign irq_id_lvl_9[i] =   irq_comb_prio_lvl_9_lt[i] ? irq_id_lvl_10[2*i] : irq_id_lvl_10[(2*i) + 1];
        assign irq_shv_lvl_9[i] =   irq_comb_prio_lvl_9_lt[i] ? irq_shv_lvl_10[2*i] : irq_shv_lvl_10[(2*i) + 1];
    end

    for(i=0; i<256; i=i+1) begin: gen_lvl_8_comp_gen
        assign irq_comb_prio_lvl_8_lt[i] = (irq_comb_prio_lvl_9[(2*i) + 1] < irq_comb_prio_lvl_9[2*i]);
        assign irq_comb_prio_lvl_8[i] =  irq_comb_prio_lvl_8_lt[i] ? irq_comb_prio_lvl_9[2*i]:irq_comb_prio_lvl_9[(2*i) + 1];
        assign irq_id_lvl_8[i] =   irq_comb_prio_lvl_8_lt[i] ? irq_id_lvl_9[2*i] : irq_id_lvl_9[(2*i) + 1];
        assign irq_shv_lvl_8[i] =   irq_comb_prio_lvl_8_lt[i] ? irq_shv_lvl_9[2*i] : irq_shv_lvl_9[(2*i) + 1];
    end

    for(i=0; i<128; i=i+1) begin: gen_lvl_7_comp_gen
        assign irq_comb_prio_lvl_7_lt[i] = (irq_comb_prio_lvl_8[(2*i) + 1] < irq_comb_prio_lvl_8[2*i]);
        assign irq_comb_prio_lvl_7[i] =  irq_comb_prio_lvl_7_lt[i] ? irq_comb_prio_lvl_8[2*i]:irq_comb_prio_lvl_8[(2*i) + 1];
        assign irq_id_lvl_7[i] =   irq_comb_prio_lvl_7_lt[i] ? irq_id_lvl_8[2*i] : irq_id_lvl_8[(2*i) + 1];
        assign irq_shv_lvl_7[i] =   irq_comb_prio_lvl_7_lt[i] ? irq_shv_lvl_8[2*i] : irq_shv_lvl_8[(2*i) + 1];
    end

    for(i=0; i<64; i=i+1) begin: gen_lvl_6_comp_gen
        assign irq_comb_prio_lvl_6_lt[i] = (irq_comb_prio_lvl_7[(2*i) + 1] < irq_comb_prio_lvl_7[2*i]);
        assign irq_comb_prio_lvl_6[i] =  irq_comb_prio_lvl_6_lt[i] ? irq_comb_prio_lvl_7[2*i]:irq_comb_prio_lvl_7[(2*i) + 1];
        assign irq_id_lvl_6[i] =   irq_comb_prio_lvl_6_lt[i] ? irq_id_lvl_7[2*i] : irq_id_lvl_7[(2*i) + 1];
        assign irq_shv_lvl_6[i] =   irq_comb_prio_lvl_6_lt[i] ? irq_shv_lvl_7[2*i] : irq_shv_lvl_7[(2*i) + 1];
    end

    for(i=0; i<32; i=i+1) begin: gen_lvl_5_comp_gen
        assign irq_comb_prio_lvl_5_lt[i] = (irq_comb_prio_lvl_6[(2*i) + 1] < irq_comb_prio_lvl_6[2*i]);
        assign irq_comb_prio_lvl_5[i] =  irq_comb_prio_lvl_5_lt[i] ? irq_comb_prio_lvl_6[2*i]:irq_comb_prio_lvl_6[(2*i) + 1];
        assign irq_id_lvl_5[i] =   irq_comb_prio_lvl_5_lt[i] ? irq_id_lvl_6[2*i] : irq_id_lvl_6[(2*i) + 1];
        assign irq_shv_lvl_5[i] =   irq_comb_prio_lvl_5_lt[i] ? irq_shv_lvl_6[2*i] : irq_shv_lvl_6[(2*i) + 1];
    end

    for(i=0; i<16; i=i+1) begin: gen_lvl_4_comp_gen
        assign irq_comb_prio_lvl_4_lt[i] = (irq_comb_prio_lvl_5[(2*i) + 1] < irq_comb_prio_lvl_5[2*i]);
        assign irq_comb_prio_lvl_4[i] =  irq_comb_prio_lvl_4_lt[i] ? irq_comb_prio_lvl_5[2*i]:irq_comb_prio_lvl_5[(2*i) + 1];
        assign irq_id_lvl_4[i] =   irq_comb_prio_lvl_4_lt[i] ? irq_id_lvl_5[2*i] : irq_id_lvl_5[(2*i) + 1];
        assign irq_shv_lvl_4[i] =   irq_comb_prio_lvl_4_lt[i] ? irq_shv_lvl_5[2*i] : irq_shv_lvl_5[(2*i) + 1];
    end

    for(i=0; i<8; i=i+1) begin: gen_lvl_3_comp_gen
        assign irq_comb_prio_lvl_3_lt[i] = (irq_comb_prio_lvl_4[(2*i) + 1] < irq_comb_prio_lvl_4[2*i]);
        assign irq_comb_prio_lvl_3[i] =  irq_comb_prio_lvl_3_lt[i] ? irq_comb_prio_lvl_4[2*i]:irq_comb_prio_lvl_4[(2*i) + 1];
        assign irq_id_lvl_3[i] =   irq_comb_prio_lvl_3_lt[i] ? irq_id_lvl_4[2*i] : irq_id_lvl_4[(2*i) + 1];
        assign irq_shv_lvl_3[i] =   irq_comb_prio_lvl_3_lt[i] ? irq_shv_lvl_4[2*i] : irq_shv_lvl_4[(2*i) + 1];
    end

    for(i=0; i<4; i=i+1) begin: gen_lvl_2_comp_gen
        assign irq_comb_prio_lvl_2_lt[i] = (irq_comb_prio_lvl_3[(2*i) + 1] < irq_comb_prio_lvl_3[2*i]);
        assign irq_comb_prio_lvl_2[i] =  irq_comb_prio_lvl_2_lt[i] ? irq_comb_prio_lvl_3[2*i]:irq_comb_prio_lvl_3[(2*i) + 1];
        assign irq_id_lvl_2[i] =   irq_comb_prio_lvl_2_lt[i] ? irq_id_lvl_3[2*i] : irq_id_lvl_3[(2*i) + 1];
        assign irq_shv_lvl_2[i] =   irq_comb_prio_lvl_2_lt[i] ? irq_shv_lvl_3[2*i] : irq_shv_lvl_3[(2*i) + 1];
    end

    for(i=0; i<2; i=i+1) begin: gen_lvl_1_comp_gen
        assign irq_comb_prio_lvl_1_lt[i] = (irq_comb_prio_lvl_2[(2*i) + 1] < irq_comb_prio_lvl_2[2*i]);
        assign irq_comb_prio_lvl_1[i] =  irq_comb_prio_lvl_1_lt[i] ? irq_comb_prio_lvl_2[2*i]:irq_comb_prio_lvl_2[(2*i) + 1];
        assign irq_id_lvl_1[i] =   irq_comb_prio_lvl_1_lt[i] ? irq_id_lvl_2[2*i] : irq_id_lvl_2[(2*i) + 1];
        assign irq_shv_lvl_1[i] =   irq_comb_prio_lvl_1_lt[i] ? irq_shv_lvl_2[2*i] : irq_shv_lvl_2[(2*i) + 1];
    end

    endgenerate

    assign irq_comb_prio_top_lt = (irq_comb_prio_lvl_1[1] < irq_comb_prio_lvl_1[0]);
    assign irq_ip_top           = irq_comb_prio_top_lt ? irq_comb_prio_lvl_1[0][CLICINTCTLBITS] :
                                                         irq_comb_prio_lvl_1[1][CLICINTCTLBITS];
    assign irq_comb_prio_top    = {CLICINTCTLBITS{irq_ip_top}} & (irq_comb_prio_top_lt ? irq_comb_prio_lvl_1[0][CLICINTCTLBITS-1:0] :
                                                                                         irq_comb_prio_lvl_1[1][CLICINTCTLBITS-1:0]);
    assign irq_id_top           = {CLIC_IRQ_NUM_LOG2{irq_ip_top}} & (irq_comb_prio_top_lt ? irq_id_lvl_1[0] :
                                                                       irq_id_lvl_1[1]);
    assign irq_shv_top          = irq_ip_top & (irq_comb_prio_top_lt ? irq_shv_lvl_1[0] :
                                                                       irq_shv_lvl_1[1]);

        assign irq_comb_prio_top_r = irq_comb_prio_top;
        assign irq_id_top_r = irq_id_top;
        assign irq_ip_top_r = irq_ip_top;
        assign irq_shv_top_r = irq_shv_top;


    wire [7:0] clic_top_lvl;
    wire clic_lvl_gt_mil   = core_in_int ? (clic_top_lvl > mintstatus_mil_r) : 1'b1;
    wire [7:0] clic_top_lvl_tmp = {irq_comb_prio_top_r,{{(8-CLICINTCTLBITS)}{1'b1}}};
    wire [7:0] trans_nlbit_tmp = 8'hff >> clic_nlbits;
    assign clic_top_lvl = {8{irq_ip_top_r}} & (trans_nlbit_tmp | clic_top_lvl_tmp);
    assign clic_prio_gt_thod = irq_ip_top_r & (clic_top_lvl[7:0] > mintthresh_mth_r[7:0]);

    assign edge_trig_ip_clr_en =  ((clic_irq_taken & clic_irq_shv) | mnxti_valid_taken);

        assign icb_rsp_rdata = rsp_rdata;
        assign icb_rsp_valid = icb_cmd_valid;
        assign icb_cmd_ready = icb_rsp_ready;


    assign icb_rsp_err   = 1'b0;
    assign clic_irq_o    = clic_int_mode & (clic_prio_gt_thod & clic_lvl_gt_mil);
    assign clic_irq_lvl  = clic_top_lvl;
    assign clic_irq_shv  = irq_shv_top_r;
    assign clic_irq_id   = {{(10-CLIC_IRQ_NUM_LOG2){1'b0}},irq_id_top_r};

    assign clic_active   = (|irq_prio_vld) | icb_cmd_valid | icb_rsp_valid;


endmodule
`endif
