//************************************************************************************** 
//*  STATEMENT OF USE                                                                    
//*  CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF PUFsecurity Technology Inc.           
//*  Copyright (c) 2022 PUFsecurity Technology Inc. All Rights Reserved.                 
//*                                                                                      
//*  This information contains confidential and proprietary information of PUFsecurity.  
//*  No part of this information may be reproduced, transmitted, transcribed,            
//*  stored in a retrieval system, or translated into any human or computer              
//*  language, in any form or by any means, electronic, mechanical, magnetic,            
//*  optical, chemical, manual, or otherwise, without the prior written permission       
//*  of PUFsecurity.  This information was prepared for informational purpose and is for 
//*  use by PUFsecurity's customers only.  PUFsecurity reserves the right to make changes
//*  in the information at any time and without notice.                                  
//***************************************************************************************
//*                                                                                      
//*  REVISION HISTORY:                                                                   
//*  v1.0    2022/06/09    Initial release
//***************************************************************************************

module EGP512X32UA016CW01 (

input                     VDD,      
input                     VDD2,     
input                     VSS,      
input        [38:0]       PPA,      
output                    PDET,     
input         [4:0]       PAIO,     
input        [31:0]       PDIN,     
output       [31:0]       PDOUT,    
output       [15:0]       PDOUT_DUMMY,
input                     PWE,      
input                     PPROG,    
input                     PCE,      
input                     PDSTB,    
input                     PENVDD2_VDD,
output        [3:0]       PAMS,     
output        [1:0]       PAM,      
input                     PENCLK,   
output                    PCLKOUT,  
output                    PVPRRDY,  
input                     PCLK,     
input                     PCLKIN,   
output                    PACREQ,   
input                     PACACK,   
input                     PACDAT,   
output                    PACSET,   
output                    PACCDE,   
input         [4:0]       PENFRE,   
output        [3:0]       PFRE      

);
wire                is_pgm;
wire                not_power_off;
wire          [8:0] pa;
wire                pa_rep;
wire                pas;
wire          [3:0] pen_osc;
wire                pgm_mode_related;
wire                pif;
wire          [1:0] pop_osc0;
wire          [1:0] pop_osc1;
wire          [1:0] pop_osc2;
wire          [1:0] pop_osc3;
wire          [3:0] posc_local;
wire                ptc;
wire          [3:0] ptm;
wire                ptr;
wire                puf;
wire                puforg;
wire                read_0_flag;
wire                read_err_flag;
wire                read_mode_related;
wire                read_x_flag;



reg notify_min_Tcyc;
reg notify_min_Tkh;
reg notify_min_Tkl;
reg notify_min_Tas;
reg notify_min_Tdhp;
reg notify_min_Tdsp;
reg notify_min_Tahp;
reg notify_min_Tasp;
reg notify_min_Tms;
reg notify_min_Tmh;


`ifdef USE_BVD
pufrt_hmc_peri I_HMC_PERI
(
   .VP              (1'b1),
   .VG              (1'b0),
`else
pufrt_hmc_peri#(
   .EMTC_NUMADDR        (9),
   .EMTC_NUMPAS         (1),
   .EMTC_NUMPTM         (4)
)       I_HMC_PERI
(
`endif
   .PPA                 (PPA),        
   .PTM                 (ptm),        
   .PUF                 (puf),        
   .PUFORG              (puforg),     
   .PIF                 (pif),        
   .PA_REP              (pa_rep),     
   .PTR                 (ptr),        
   .PTC                 (ptc),        
   .PA                  (pa),         
   .PAS                 (pas),        
   .PDET                (PDET),       
   .PENFRE              (PENFRE),     
   .POSC                (posc_local), 
   .PFRE                (PFRE),       
   .PEN_OSC             (pen_osc),    
   .POP_OSC3            (pop_osc3),   
   .POP_OSC2            (pop_osc2),   
   .POP_OSC1            (pop_osc1),   
   .POP_OSC0            (pop_osc0),   
   .PACREQ              (PACREQ),     
   .PACACK              (PACACK),     
   .PACDAT              (PACDAT),     
   .PACSET              (PACSET),     
   .PACCDE              (PACCDE),     
   .PCLKIN              (PCLKIN),     
   .POR_N               (PENVDD2_VDD) 
);

EGP512X32  I_HMC_CORE (
                             .VDD         (VDD),
                             .VDD2        (VDD2),
                             .VSS         (VSS),
                             .PA          (pa),
                             .PAS         (pas),
                             .PDIN        (PDIN),
                             .PTM         (ptm),
                             .PWE         (PWE),
                             .PPROG       (PPROG),
                             .PCLK        (PCLK),
                             .POP_OSC0 (pop_osc0),
                             .POP_OSC1 (pop_osc1),
                             .POP_OSC2 (pop_osc2),
                             .POP_OSC3 (pop_osc3),
                             .PEN_OSC (pen_osc),
                             .POSC (posc_local),
                             .PUFORG      (puforg),
                             .PCE         (PCE),
                             .PTC         (ptc),
                             .PTR         (ptr),
                             .PDSTB       (PDSTB),
                             .PIF         (pif),
                             .PA_REP      (pa_rep),
                             .PAIO        (PAIO),
                             .PENVDD2_VDD (PENVDD2_VDD),
                             .PUF         (puf),
                             .PENCLK      (PENCLK),
                             .PDOUT       (PDOUT),
                             .PDOUT_DUMMY (PDOUT_DUMMY),
                             .PVPRRDY     (PVPRRDY),
                             .PAMS        (PAMS),
                             .PAM         (PAM),
                             .PCLKOUT           (PCLKOUT),
                             .read_x_flag       (read_x_flag),
                             .read_err_flag     (read_err_flag),
                             .read_0_flag       (read_0_flag),
                             .read_mode_related (read_mode_related),
                             .pgm_mode_related  (pgm_mode_related),
                             .is_pgm            (is_pgm),
                             .not_power_off     (not_power_off),
                             .notify_min_Tcyc(notify_min_Tcyc),
                             .notify_min_Tkh(notify_min_Tkh),
                             .notify_min_Tkl(notify_min_Tkl),
                             .notify_min_Tas(notify_min_Tas),
                             .notify_min_Tdhp(notify_min_Tdhp),
                             .notify_min_Tdsp(notify_min_Tdsp),
                             .notify_min_Tahp(notify_min_Tahp),
                             .notify_min_Tasp(notify_min_Tasp),
                             .notify_min_Tms(notify_min_Tms),
                             .notify_min_Tmh(notify_min_Tmh)
                          );

    specify
    `ifdef EMTC_Timing_Tcd_IMG_Max
        if (is_exclude_ini_read) (posedge PCLK *> (PDOUT:1'bx)) = `EMTC_Timing_Tcd_Max;
        (posedge PCLK   *> (PDOUT_DUMMY:1'bx))  = `EMTC_Timing_Tcd_Max;
        (posedge PCLKIN *> (PACREQ:1'bx)) = 2.000;   
        (posedge PCLKIN *> (PACSET:1'bx)) = 2.000;   
        (posedge PCLKIN *> (PACCDE:1'bx)) = 2.000;   
        (posedge PCLKIN *> (PFRE:1'bx)) = 2.000;
        if (is_ini_margin_read)  (posedge PCLK *> (PDOUT:1'bx)) = `EMTC_Timing_Tcd_IMG_Max;
        (posedge PCLK   *> (PDOUT_DUMMY:1'bx))  = `EMTC_Timing_Tcd_Max;
        (posedge PCLKIN *> (PACREQ:1'bx)) = 2.000;   
        (posedge PCLKIN *> (PACSET:1'bx)) = 2.000;   
        (posedge PCLKIN *> (PACCDE:1'bx)) = 2.000;   
        (posedge PCLKIN *> (PFRE:1'bx)) = 2.000;
    `else
        (posedge PCLK *> (PDOUT:1'bx)) = `EMTC_Timing_Tcd_Max;
        (posedge PCLK   *> (PDOUT_DUMMY:1'bx))  = `EMTC_Timing_Tcd_Max;
        (posedge PCLKIN *> (PACREQ:1'bx)) = 2.000;   
        (posedge PCLKIN *> (PACSET:1'bx)) = 2.000;   
        (posedge PCLKIN *> (PACCDE:1'bx)) = 2.000;   
        (posedge PCLKIN *> (PFRE:1'bx)) = 2.000;
    `endif
        if (read_x_flag == 1)   (PCLK *> PDOUT) = 0;
        if (read_err_flag == 1) (PCLK *> PDOUT) = 0;
    `ifdef EMTC_Timing_Tsas_Min
        if (read_0_flag == 1)   (PCLK *> PDOUT) = 0;
    `endif
        if (PCE === 1'b1)     (PCE *> PAMS) = `EMTC_Timing_Ts_det_Max;
        if (PCE === 1'b0)     (PCE *> PAMS) = `EMTC_Timing_Th_det_Min;
        if (PCE === 1'b1)     (PCE *> PAM)  = `EMTC_Timing_Ts_det_Max;
        if (PCE === 1'b0)     (PCE *> PAM)  = `EMTC_Timing_Th_det_Min;
    `ifdef EMTC_Timing_Tcyc_IMG_Min
        $period(posedge PCLK &&& is_exclude_ini_read, `EMTC_Timing_Tcyc_Min,     notify_min_Tcyc);
        $period(posedge PCLK &&& is_ini_margin_read,  `EMTC_Timing_Tcyc_IMG_Min, notify_min_Tcyc);
    `else
        $period(posedge PCLK &&& read_mode_related, `EMTC_Timing_Tcyc_Min,  notify_min_Tcyc);
    `endif
        $width (posedge PCLK &&& read_mode_related, `EMTC_Timing_Tkh_Min,0,  notify_min_Tkh);
        $width (negedge PCLK &&& read_mode_related, `EMTC_Timing_Tkl_Min,0,  notify_min_Tkl);
        // address & data
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[20], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[0], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[2], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[8], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[9], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[24], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[5], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[27], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[4], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[20], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[0], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[2], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[8], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[9], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[24], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[5], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[27], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[4], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
    `ifdef EMTC_Density_TestCol_Size
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[31], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[31], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
    `endif
    `ifdef EMTC_Density_TestRow_Size
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[22], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[22], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
    `endif
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[19], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[19], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[11], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[11], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[1], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[1], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[21], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[21], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[20], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[0], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[2], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[8], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[9], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[24], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[5], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[27], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[4], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[20], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[0], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[2], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[8], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[9], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[24], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[5], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[27], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[4], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
    `ifdef EMTC_Pin_PAIO_Length
        $setuphold ( posedge PWE &&& is_pgm, posedge PAIO, `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PAIO, `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
    `endif
    `ifdef EMTC_Pin_PAS_Length
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[23], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[23], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
    `endif
    `ifdef EMTC_Density_TestCol_Size
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[31], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[31], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
    `endif
    `ifdef EMTC_Density_TestRow_Size
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[22], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[22], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
    `endif
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[19], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[19], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[11], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[11], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[1], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[1], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[21], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[21], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[20], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[0], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[2], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[8], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[9], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[24], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[5], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[27], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[4], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[20], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[0], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[2], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[8], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[9], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[24], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[5], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[27], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[4], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
    `ifdef EMTC_Pin_PAIO_Length
        $setuphold ( negedge PWE &&& is_pgm, posedge PAIO, 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PAIO, 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
    `endif
    `ifdef EMTC_Pin_PAS_Length
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[23], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[23], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
    `endif
    `ifdef EMTC_Density_TestCol_Size
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[31], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[31], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
    `endif
    `ifdef EMTC_Density_TestRow_Size
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[22], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[22], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
    `endif
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[19], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[19], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[11], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[11], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[1], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[1], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[21], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[21], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);
        $setuphold ( posedge PWE &&& is_pgm, posedge PDIN, `EMTC_Timing_Tdsp_Min, 0, notify_min_Tdsp);
        $setuphold ( posedge PWE &&& is_pgm, negedge PDIN, `EMTC_Timing_Tdsp_Min, 0, notify_min_Tdsp);
        $setuphold ( negedge PWE &&& is_pgm, posedge PDIN, 0, `EMTC_Timing_Tdhp_Min, notify_min_Tdhp);
        $setuphold ( negedge PWE &&& is_pgm, negedge PDIN, 0, `EMTC_Timing_Tdhp_Min, notify_min_Tdhp);
        $setuphold ( posedge PCE &&& not_power_off, posedge PPA[38], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, posedge PPA[28], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, posedge PPA[33], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, posedge PPA[12], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, negedge PPA[38], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, negedge PPA[28], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, negedge PPA[33], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, negedge PPA[12], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( negedge PCE &&& not_power_off, posedge PPA[38], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, posedge PPA[28], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, posedge PPA[33], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, posedge PPA[12], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, negedge PPA[38], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, negedge PPA[28], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, negedge PPA[33], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, negedge PPA[12], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        //internal clock
        $period(posedge PCLKIN &&& PENCLK,  30);
        $width (posedge PCLKIN &&& PENCLK,  10,0);
        $width (negedge PCLKIN &&& PENCLK,  10,0);

        //zptm
        $setuphold ( posedge PCE &&& not_power_off, posedge PPA[ 6], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, posedge PPA[32], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, posedge PPA[ 3], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, posedge PPA[ 7], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, negedge PPA[ 6], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, negedge PPA[32], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, negedge PPA[ 3], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);
        $setuphold ( posedge PCE &&& not_power_off, negedge PPA[ 7], `EMTC_Timing_Tms_Min, 0, notify_min_Tms);

        $setuphold ( negedge PCE &&& not_power_off, posedge PPA[ 6], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, posedge PPA[32], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, posedge PPA[ 3], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, posedge PPA[ 7], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, negedge PPA[ 6], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, negedge PPA[32], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, negedge PPA[ 3], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);
        $setuphold ( negedge PCE &&& not_power_off, negedge PPA[ 7], 0, `EMTC_Timing_Tmh_Min, notify_min_Tmh);

        //zpuf
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[34], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);//zpuf
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[34], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);//zpuf
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[34], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);//zpuf
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[34], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);//zpuf
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[34], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);//zpuf
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[34], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);//zpuf

        //zpuforg
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[17], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);//zpuforg
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[17], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);//zpuforg
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[17], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);//zpuforg
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[17], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);//zpuforg
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[17], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);//zpuforg
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[17], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);//zpuforg

        //zpif
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[25], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);//zpif
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[25], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);//zpif
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[25], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);//zpif
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[25], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);//zpif
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[25], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);//zpif
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[25], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);//zpif

        //zpa_rep
        $setuphold ( posedge PCLK &&& read_mode_related, posedge PPA[37], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);//zpa_rep
        $setuphold ( posedge PCLK &&& read_mode_related, negedge PPA[37], `EMTC_Timing_Tas_Min, `EMTC_Timing_Tah_Min, notify_min_Tas);//zpa_rep
        $setuphold ( posedge PWE &&& is_pgm, posedge PPA[37], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);//zpa_rep
        $setuphold ( posedge PWE &&& is_pgm, negedge PPA[37], `EMTC_Timing_Tasp_Min, 0, notify_min_Tasp);//zpa_rep
        $setuphold ( negedge PWE &&& is_pgm, posedge PPA[37], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);//zpa_rep
        $setuphold ( negedge PWE &&& is_pgm, negedge PPA[37], 0, `EMTC_Timing_Tahp_Min, notify_min_Tahp);//zpa_rep

       //auth_ack auth_dat
        $setuphold ( negedge PCLKIN &&& PENVDD2_VDD, posedge PACACK &&& PENVDD2_VDD, 6, 2 );
        $setuphold ( negedge PCLKIN &&& PENVDD2_VDD, negedge PACACK &&& PENVDD2_VDD, 6, 2 );
        $setuphold ( negedge PCLKIN &&& PENVDD2_VDD, posedge PACDAT &&& PENVDD2_VDD, 6, 2 );
        $setuphold ( negedge PCLKIN &&& PENVDD2_VDD, negedge PACDAT &&& PENVDD2_VDD, 6, 2 );
    endspecify
endmodule
