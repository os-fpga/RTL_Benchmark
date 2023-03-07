/*
   Copyright (C) 2000-2022 Dolphin Technology, Inc.
   This verilog is proprietary and confidential information of
   Dolphin Technology, Inc. and can only be used or viewed
   under license or with written permission from Dolphin Technology, Inc.
*/

//`celldefine
module dti_16f_9t_96_and2hpx4  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_and2hp xdti_16f_9t_96_and2hp (Z, A, B, VDD, VSS);
  `else
    dti_and2hp xdti_16f_9t_96_and2hp (Z, A, B, VDD, VSS);
  `endif
`else
  dti_and2hp xdti_16f_9t_96_and2hp (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_and2x1  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
  `else
    dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_and2x16  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
  `else
    dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_and2x2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
  `else
    dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_and2x4  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
  `else
    dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_and2x8  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
  `else
    dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_and2 xdti_16f_9t_96_and2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_and3x1  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_and3 xdti_16f_9t_96_and3 (Z, A, B, C, VDD, VSS);
  `else
    dti_and3 xdti_16f_9t_96_and3 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_and3 xdti_16f_9t_96_and3 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_and3x2  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_and3 xdti_16f_9t_96_and3 (Z, A, B, C, VDD, VSS);
  `else
    dti_and3 xdti_16f_9t_96_and3 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_and3 xdti_16f_9t_96_and3 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_and4x1  (Z, A, B, C, D, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C, D;

`ifdef NEGDEL
  `ifdef RECREM
  dti_and4 xdti_16f_9t_96_and4 (Z, A, B, C, D, VDD, VSS);
  `else
    dti_and4 xdti_16f_9t_96_and4 (Z, A, B, C, D, VDD, VSS);
  `endif
`else
  dti_and4 xdti_16f_9t_96_and4 (Z, A, B, C, D, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_and6x1  (Z, A, B, C, D, E, F, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C, D, E, F;

`ifdef NEGDEL
  `ifdef RECREM
  dti_and6 xdti_16f_9t_96_and6 (Z, A, B, C, D, E, F, VDD, VSS);
  `else
    dti_and6 xdti_16f_9t_96_and6 (Z, A, B, C, D, E, F, VDD, VSS);
  `endif
`else
  dti_and6 xdti_16f_9t_96_and6 (Z, A, B, C, D, E, F, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_and8x1  (Z, A, B, C, D, E, F, G, H, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C, D, E, F, G, H;

`ifdef NEGDEL
  `ifdef RECREM
  dti_and8 xdti_16f_9t_96_and8 (Z, A, B, C, D, E, F, G, H, VDD, VSS);
  `else
    dti_and8 xdti_16f_9t_96_and8 (Z, A, B, C, D, E, F, G, H, VDD, VSS);
  `endif
`else
  dti_and8 xdti_16f_9t_96_and8 (Z, A, B, C, D, E, F, G, H, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ao112x1  (Z, A, B, C1, C2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B;
input  C1;
input  C2;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ao112 xdti_16f_9t_96_ao112 (Z, A, B, C1, C2, VDD, VSS);
  `else
    dti_ao112 xdti_16f_9t_96_ao112 (Z, A, B, C1, C2, VDD, VSS);
  `endif
`else
  dti_ao112 xdti_16f_9t_96_ao112 (Z, A, B, C1, C2, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ao12x1  (Z, A, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ao12 xdti_16f_9t_96_ao12 (Z, A, B1, B2, VDD, VSS);
  `else
    dti_ao12 xdti_16f_9t_96_ao12 (Z, A, B1, B2, VDD, VSS);
  `endif
`else
  dti_ao12 xdti_16f_9t_96_ao12 (Z, A, B1, B2, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ao12x2  (Z, A, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ao12 xdti_16f_9t_96_ao12 (Z, A, B1, B2, VDD, VSS);
  `else
    dti_ao12 xdti_16f_9t_96_ao12 (Z, A, B1, B2, VDD, VSS);
  `endif
`else
  dti_ao12 xdti_16f_9t_96_ao12 (Z, A, B1, B2, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ao13x1  (Z, A, B1, B2, B3, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;
input  B3;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ao13 xdti_16f_9t_96_ao13 (Z, A, B1, B2, B3, VDD, VSS);
  `else
    dti_ao13 xdti_16f_9t_96_ao13 (Z, A, B1, B2, B3, VDD, VSS);
  `endif
`else
  dti_ao13 xdti_16f_9t_96_ao13 (Z, A, B1, B2, B3, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ao222x1  (Z, A1, A2, B1, B2, C1, C2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A1;
input  A2;
input  B1;
input  B2;
input  C1;
input  C2;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ao222 xdti_16f_9t_96_ao222 (Z, A1, A2, B1, B2, C1, C2, VDD, VSS);
  `else
    dti_ao222 xdti_16f_9t_96_ao222 (Z, A1, A2, B1, B2, C1, C2, VDD, VSS);
  `endif
`else
  dti_ao222 xdti_16f_9t_96_ao222 (Z, A1, A2, B1, B2, C1, C2, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ao22x1  (Z, A1, A2, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A1;
input  A2;
input  B1;
input  B2;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ao22 xdti_16f_9t_96_ao22 (Z, A1, A2, B1, B2, VDD, VSS);
  `else
    dti_ao22 xdti_16f_9t_96_ao22 (Z, A1, A2, B1, B2, VDD, VSS);
  `endif
`else
  dti_ao22 xdti_16f_9t_96_ao22 (Z, A1, A2, B1, B2, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_aoi12x1  (Z, A, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;

`ifdef NEGDEL
  `ifdef RECREM
  dti_aoi12 xdti_16f_9t_96_aoi12 (Z, A, B1, B2, VDD, VSS);
  `else
    dti_aoi12 xdti_16f_9t_96_aoi12 (Z, A, B1, B2, VDD, VSS);
  `endif
`else
  dti_aoi12 xdti_16f_9t_96_aoi12 (Z, A, B1, B2, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_aoi12x2  (Z, A, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;

`ifdef NEGDEL
  `ifdef RECREM
  dti_aoi12 xdti_16f_9t_96_aoi12 (Z, A, B1, B2, VDD, VSS);
  `else
    dti_aoi12 xdti_16f_9t_96_aoi12 (Z, A, B1, B2, VDD, VSS);
  `endif
`else
  dti_aoi12 xdti_16f_9t_96_aoi12 (Z, A, B1, B2, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_aoi22x1  (Z, A1, A2, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A1;
input  A2;
input  B1;
input  B2;

`ifdef NEGDEL
  `ifdef RECREM
  dti_aoi22 xdti_16f_9t_96_aoi22 (Z, A1, A2, B1, B2, VDD, VSS);
  `else
    dti_aoi22 xdti_16f_9t_96_aoi22 (Z, A1, A2, B1, B2, VDD, VSS);
  `endif
`else
  dti_aoi22 xdti_16f_9t_96_aoi22 (Z, A1, A2, B1, B2, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_bufx1  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
  `else
    dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
  `endif
`else
  dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_bufx16  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
  `else
    dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
  `endif
`else
  dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_bufx2  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
  `else
    dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
  `endif
`else
  dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_bufx4  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
  `else
    dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
  `endif
`else
  dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_bufx8  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
  `else
    dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
  `endif
`else
  dti_buf xdti_16f_9t_96_buf (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckbufx1  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckbuf xdti_16f_9t_96_ckbuf (Z, A, VDD, VSS);
  `else
    dti_ckbuf xdti_16f_9t_96_ckbuf (Z, A, VDD, VSS);
  `endif
`else
  dti_ckbuf xdti_16f_9t_96_ckbuf (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckbufx2  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckbuf xdti_16f_9t_96_ckbuf (Z, A, VDD, VSS);
  `else
    dti_ckbuf xdti_16f_9t_96_ckbuf (Z, A, VDD, VSS);
  `endif
`else
  dti_ckbuf xdti_16f_9t_96_ckbuf (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckbufx4  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckbuf xdti_16f_9t_96_ckbuf (Z, A, VDD, VSS);
  `else
    dti_ckbuf xdti_16f_9t_96_ckbuf (Z, A, VDD, VSS);
  `endif
`else
  dti_ckbuf xdti_16f_9t_96_ckbuf (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckbufx8  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckbuf xdti_16f_9t_96_ckbuf (Z, A, VDD, VSS);
  `else
    dti_ckbuf xdti_16f_9t_96_ckbuf (Z, A, VDD, VSS);
  `endif
`else
  dti_ckbuf xdti_16f_9t_96_ckbuf (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckinvmdlyx8  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckinvmdly xdti_16f_9t_96_ckinvmdly (Z, A, VDD, VSS);
  `else
    dti_ckinvmdly xdti_16f_9t_96_ckinvmdly (Z, A, VDD, VSS);
  `endif
`else
  dti_ckinvmdly xdti_16f_9t_96_ckinvmdly (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckinvx1  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `else
    dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `endif
`else
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckinvx12  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `else
    dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `endif
`else
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckinvx16  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `else
    dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `endif
`else
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckinvx2  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `else
    dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `endif
`else
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckinvx20  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `else
    dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `endif
`else
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckinvx4  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `else
    dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `endif
`else
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckinvx6  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `else
    dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `endif
`else
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckinvx8  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `else
    dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
  `endif
`else
  dti_ckinv xdti_16f_9t_96_ckinv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckmux21x1  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0, D1, S;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckmux21 xdti_16f_9t_96_ckmux21 (Z, D0, D1, S, VDD, VSS);
  `else
    dti_ckmux21 xdti_16f_9t_96_ckmux21 (Z, D0, D1, S, VDD, VSS);
  `endif
`else
  dti_ckmux21 xdti_16f_9t_96_ckmux21 (Z, D0, D1, S, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckmux21x2  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0, D1, S;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckmux21 xdti_16f_9t_96_ckmux21 (Z, D0, D1, S, VDD, VSS);
  `else
    dti_ckmux21 xdti_16f_9t_96_ckmux21 (Z, D0, D1, S, VDD, VSS);
  `endif
`else
  dti_ckmux21 xdti_16f_9t_96_ckmux21 (Z, D0, D1, S, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckmux21x4  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0, D1, S;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckmux21 xdti_16f_9t_96_ckmux21 (Z, D0, D1, S, VDD, VSS);
  `else
    dti_ckmux21 xdti_16f_9t_96_ckmux21 (Z, D0, D1, S, VDD, VSS);
  `endif
`else
  dti_ckmux21 xdti_16f_9t_96_ckmux21 (Z, D0, D1, S, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckmux21x8  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0, D1, S;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckmux21 xdti_16f_9t_96_ckmux21 (Z, D0, D1, S, VDD, VSS);
  `else
    dti_ckmux21 xdti_16f_9t_96_ckmux21 (Z, D0, D1, S, VDD, VSS);
  `endif
`else
  dti_ckmux21 xdti_16f_9t_96_ckmux21 (Z, D0, D1, S, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckmuxi21x4  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0, D1, S;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckmuxi21 xdti_16f_9t_96_ckmuxi21 (Z, D0, D1, S, VDD, VSS);
  `else
    dti_ckmuxi21 xdti_16f_9t_96_ckmuxi21 (Z, D0, D1, S, VDD, VSS);
  `endif
`else
  dti_ckmuxi21 xdti_16f_9t_96_ckmuxi21 (Z, D0, D1, S, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckmuxihs21x4  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0, D1, S;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckmuxihs21 xdti_16f_9t_96_ckmuxihs21 (Z, D0, D1, S, VDD, VSS);
  `else
    dti_ckmuxihs21 xdti_16f_9t_96_ckmuxihs21 (Z, D0, D1, S, VDD, VSS);
  `endif
`else
  dti_ckmuxihs21 xdti_16f_9t_96_ckmuxihs21 (Z, D0, D1, S, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ckxor2x1  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ckxor2 xdti_16f_9t_96_ckxor2 (Z, A, B, VDD, VSS);
  `else
    dti_ckxor2 xdti_16f_9t_96_ckxor2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_ckxor2 xdti_16f_9t_96_ckxor2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_clktcx2  (Z, ZX, A, VDD, VSS);
input VDD;
input VSS;
output Z, ZX;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_clktc xdti_16f_9t_96_clktc (Z, ZX, A, VDD, VSS);
  `else
    dti_clktc xdti_16f_9t_96_clktc (Z, ZX, A, VDD, VSS);
  `endif
`else
  dti_clktc xdti_16f_9t_96_clktc (Z, ZX, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_dcapx1  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `else
    dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `endif
`else
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_dcapx12  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `else
    dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `endif
`else
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_dcapx16  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `else
    dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `endif
`else
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_dcapx2  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `else
    dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `endif
`else
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_dcapx3  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `else
    dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `endif
`else
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_dcapx4  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `else
    dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `endif
`else
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_dcapx5  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `else
    dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `endif
`else
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_dcapx6  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `else
    dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `endif
`else
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_dcapx8  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `else
    dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
  `endif
`else
  dti_dcap xdti_16f_9t_96_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_eco_dcapx1  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `else
    dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `endif
`else
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_eco_dcapx10  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `else
    dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `endif
`else
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_eco_dcapx12  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `else
    dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `endif
`else
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_eco_dcapx16  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `else
    dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `endif
`else
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_eco_dcapx2  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `else
    dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `endif
`else
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_eco_dcapx3  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `else
    dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `endif
`else
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_eco_dcapx32  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `else
    dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `endif
`else
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_eco_dcapx4  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `else
    dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `endif
`else
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_eco_dcapx48  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `else
    dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `endif
`else
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_eco_dcapx64  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `else
    dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `endif
`else
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_eco_dcapx8  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `else
    dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
  `endif
`else
  dti_eco_dcap xdti_16f_9t_96_eco_dcap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fadderex1  (CO, SUM, A, B, CIN, VDD, VSS);
input VDD;
input VSS;
output CO;
output SUM;
input  A;
input  B;
input  CIN;

`ifdef NEGDEL
  `ifdef RECREM
  dti_faddere xdti_16f_9t_96_faddere (CO, SUM, A, B, CIN, VDD, VSS);
  `else
    dti_faddere xdti_16f_9t_96_faddere (CO, SUM, A, B, CIN, VDD, VSS);
  `endif
`else
  dti_faddere xdti_16f_9t_96_faddere (CO, SUM, A, B, CIN, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fadderox1  (CON, SUM, A, B, CI, VDD, VSS);
input VDD;
input VSS;
output CON;
output SUM;
input  A;
input  B;
input  CI;

`ifdef NEGDEL
  `ifdef RECREM
  dti_faddero xdti_16f_9t_96_faddero (CON, SUM, A, B, CI, VDD, VSS);
  `else
    dti_faddero xdti_16f_9t_96_faddero (CON, SUM, A, B, CI, VDD, VSS);
  `endif
`else
  dti_faddero xdti_16f_9t_96_faddero (CON, SUM, A, B, CI, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fadderx1  (CO, SUM, A, B, CI, VDD, VSS);
input VDD;
input VSS;
output CO;
output SUM;
input  A;
input  B;
input  CI;

`ifdef NEGDEL
  `ifdef RECREM
  dti_fadder xdti_16f_9t_96_fadder (CO, SUM, A, B, CI, VDD, VSS);
  `else
    dti_fadder xdti_16f_9t_96_fadder (CO, SUM, A, B, CI, VDD, VSS);
  `endif
`else
  dti_fadder xdti_16f_9t_96_fadder (CO, SUM, A, B, CI, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ffnqa10x1  (Q, CKN, D, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CKN, D, SN;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ffnqa10 xdti_16f_9t_96_ffnqa10 (Q, CKN, D, SN, notifier, VDD, VSS);
  `else
    dti_ffnqa10 xdti_16f_9t_96_ffnqa10 (Q, CKN, D, SN, notifier, VDD, VSS);
  `endif
`else
  dti_ffnqa10 xdti_16f_9t_96_ffnqa10 (Q, CKN, D, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ffnqbckx1  (Q, CKN, D, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CKN, D;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ffnqbck xdti_16f_9t_96_ffnqbck (Q, CKN, D, notifier, VDD, VSS);
  `else
    dti_ffnqbck xdti_16f_9t_96_ffnqbck (Q, CKN, D, notifier, VDD, VSS);
  `endif
`else
  dti_ffnqbck xdti_16f_9t_96_ffnqbck (Q, CKN, D, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ffnqx1  (Q, CKN, D, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CKN, D;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ffnq xdti_16f_9t_96_ffnq (Q, CKN, D, notifier, VDD, VSS);
  `else
    dti_ffnq xdti_16f_9t_96_ffnq (Q, CKN, D, notifier, VDD, VSS);
  `endif
`else
  dti_ffnq xdti_16f_9t_96_ffnq (Q, CKN, D, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ffqa01x1  (Q, CK, D, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, RN;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ffqa01 xdti_16f_9t_96_ffqa01 (Q, CK, D, RN, notifier, VDD, VSS);
  `else
    dti_ffqa01 xdti_16f_9t_96_ffqa01 (Q, CK, D, RN, notifier, VDD, VSS);
  `endif
`else
  dti_ffqa01 xdti_16f_9t_96_ffqa01 (Q, CK, D, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ffqa01x2  (Q, CK, D, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, RN;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ffqa01 xdti_16f_9t_96_ffqa01 (Q, CK, D, RN, notifier, VDD, VSS);
  `else
    dti_ffqa01 xdti_16f_9t_96_ffqa01 (Q, CK, D, RN, notifier, VDD, VSS);
  `endif
`else
  dti_ffqa01 xdti_16f_9t_96_ffqa01 (Q, CK, D, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ffqa01x4  (Q, CK, D, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, RN;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ffqa01 xdti_16f_9t_96_ffqa01 (Q, CK, D, RN, notifier, VDD, VSS);
  `else
    dti_ffqa01 xdti_16f_9t_96_ffqa01 (Q, CK, D, RN, notifier, VDD, VSS);
  `endif
`else
  dti_ffqa01 xdti_16f_9t_96_ffqa01 (Q, CK, D, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ffqa10x1  (Q, CK, D, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SN;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ffqa10 xdti_16f_9t_96_ffqa10 (Q, CK, D, SN, notifier, VDD, VSS);
  `else
    dti_ffqa10 xdti_16f_9t_96_ffqa10 (Q, CK, D, SN, notifier, VDD, VSS);
  `endif
`else
  dti_ffqa10 xdti_16f_9t_96_ffqa10 (Q, CK, D, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ffqa10x2  (Q, CK, D, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SN;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ffqa10 xdti_16f_9t_96_ffqa10 (Q, CK, D, SN, notifier, VDD, VSS);
  `else
    dti_ffqa10 xdti_16f_9t_96_ffqa10 (Q, CK, D, SN, notifier, VDD, VSS);
  `endif
`else
  dti_ffqa10 xdti_16f_9t_96_ffqa10 (Q, CK, D, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ffqbckx1  (Q, CK, D, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ffqbck xdti_16f_9t_96_ffqbck (Q, CK, D, notifier, VDD, VSS);
  `else
    dti_ffqbck xdti_16f_9t_96_ffqbck (Q, CK, D, notifier, VDD, VSS);
  `endif
`else
  dti_ffqbck xdti_16f_9t_96_ffqbck (Q, CK, D, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ffqx1  (Q, CK, D, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ffq xdti_16f_9t_96_ffq (Q, CK, D, notifier, VDD, VSS);
  `else
    dti_ffq xdti_16f_9t_96_ffq (Q, CK, D, notifier, VDD, VSS);
  `endif
`else
  dti_ffq xdti_16f_9t_96_ffq (Q, CK, D, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ffqx2  (Q, CK, D, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ffq xdti_16f_9t_96_ffq (Q, CK, D, notifier, VDD, VSS);
  `else
    dti_ffq xdti_16f_9t_96_ffq (Q, CK, D, notifier, VDD, VSS);
  `endif
`else
  dti_ffq xdti_16f_9t_96_ffq (Q, CK, D, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ffqx4  (Q, CK, D, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ffq xdti_16f_9t_96_ffq (Q, CK, D, notifier, VDD, VSS);
  `else
    dti_ffq xdti_16f_9t_96_ffq (Q, CK, D, notifier, VDD, VSS);
  `endif
`else
  dti_ffq xdti_16f_9t_96_ffq (Q, CK, D, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx1  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx12  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx128  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx16  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx2  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx20  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx24  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx3  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx32  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx4  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx48  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx5  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx6  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx64  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_fillerx8  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `else
    dti_filler xdti_16f_9t_96_filler (VDD, VSS);
  `endif
`else
  dti_filler xdti_16f_9t_96_filler (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_gckbufx2  (CKOUT, CK, EN, VDD, VSS);
input VDD;
input VSS;
output CKOUT;
input  CK;
input  EN;

`ifdef NEGDEL
  `ifdef RECREM
  dti_gckbuf xdti_16f_9t_96_gckbuf (CKOUT, CK, EN, VDD, VSS);
  `else
    dti_gckbuf xdti_16f_9t_96_gckbuf (CKOUT, CK, EN, VDD, VSS);
  `endif
`else
  dti_gckbuf xdti_16f_9t_96_gckbuf (CKOUT, CK, EN, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_gckbufx4  (CKOUT, CK, EN, VDD, VSS);
input VDD;
input VSS;
output CKOUT;
input  CK;
input  EN;

`ifdef NEGDEL
  `ifdef RECREM
  dti_gckbuf xdti_16f_9t_96_gckbuf (CKOUT, CK, EN, VDD, VSS);
  `else
    dti_gckbuf xdti_16f_9t_96_gckbuf (CKOUT, CK, EN, VDD, VSS);
  `endif
`else
  dti_gckbuf xdti_16f_9t_96_gckbuf (CKOUT, CK, EN, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_gcklbufsx2  (CKOUT, CK, EN, SE, VDD, VSS);
input VDD;
input VSS;
output CKOUT;
input  CK, EN, SE;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_gcklbufs xdti_16f_9t_96_gcklbufs (CKOUT, CK, EN, SE, notifier, VDD, VSS);
  `else
    dti_gcklbufs xdti_16f_9t_96_gcklbufs (CKOUT, CK, EN, SE, notifier, VDD, VSS);
  `endif
`else
  dti_gcklbufs xdti_16f_9t_96_gcklbufs (CKOUT, CK, EN, SE, notifier, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_gcklbufsx4  (CKOUT, CK, EN, SE, VDD, VSS);
input VDD;
input VSS;
output CKOUT;
input  CK, EN, SE;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_gcklbufs xdti_16f_9t_96_gcklbufs (CKOUT, CK, EN, SE, notifier, VDD, VSS);
  `else
    dti_gcklbufs xdti_16f_9t_96_gcklbufs (CKOUT, CK, EN, SE, notifier, VDD, VSS);
  `endif
`else
  dti_gcklbufs xdti_16f_9t_96_gcklbufs (CKOUT, CK, EN, SE, notifier, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_gcklbufx1  (CKOUT, CK, EN, VDD, VSS);
input VDD;
input VSS;
output CKOUT;
input  CK, EN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_gcklbuf xdti_16f_9t_96_gcklbuf (CKOUT, CK, EN, notifier, VDD, VSS);
  `else
    dti_gcklbuf xdti_16f_9t_96_gcklbuf (CKOUT, CK, EN, notifier, VDD, VSS);
  `endif
`else
  dti_gcklbuf xdti_16f_9t_96_gcklbuf (CKOUT, CK, EN, notifier, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_gcklbufx4  (CKOUT, CK, EN, VDD, VSS);
input VDD;
input VSS;
output CKOUT;
input  CK, EN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_gcklbuf xdti_16f_9t_96_gcklbuf (CKOUT, CK, EN, notifier, VDD, VSS);
  `else
    dti_gcklbuf xdti_16f_9t_96_gcklbuf (CKOUT, CK, EN, notifier, VDD, VSS);
  `endif
`else
  dti_gcklbuf xdti_16f_9t_96_gcklbuf (CKOUT, CK, EN, notifier, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_hadderx1  (CO, SUM, A, B, VDD, VSS);
input VDD;
input VSS;
output CO;
output SUM;
input  A;
input  B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_hadder xdti_16f_9t_96_hadder (CO, SUM, A, B, VDD, VSS);
  `else
    dti_hadder xdti_16f_9t_96_hadder (CO, SUM, A, B, VDD, VSS);
  `endif
`else
  dti_hadder xdti_16f_9t_96_hadder (CO, SUM, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_invx1  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
  `else
    dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
  `endif
`else
  dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_invx2  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
  `else
    dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
  `endif
`else
  dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_invx4  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
  `else
    dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
  `endif
`else
  dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_invx8  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
  `else
    dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
  `endif
`else
  dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_invxp5  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
  `else
    dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
  `endif
`else
  dti_inv xdti_16f_9t_96_inv (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_leftedgeboundaryx1  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_leftedgeboundary xdti_16f_9t_96_leftedgeboundary (VDD, VSS);
  `else
    dti_leftedgeboundary xdti_16f_9t_96_leftedgeboundary (VDD, VSS);
  `endif
`else
  dti_leftedgeboundary xdti_16f_9t_96_leftedgeboundary (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_llqx1  (Q, CPN, D, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CPN, D;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_llq xdti_16f_9t_96_llq (Q, CPN, D, notifier, VDD, VSS);
  `else
    dti_llq xdti_16f_9t_96_llq (Q, CPN, D, notifier, VDD, VSS);
  `endif
`else
  dti_llq xdti_16f_9t_96_llq (Q, CPN, D, notifier, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_lqx1  (Q, CP, D, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CP, D;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_lq xdti_16f_9t_96_lq (Q, CP, D, notifier, VDD, VSS);
  `else
    dti_lq xdti_16f_9t_96_lq (Q, CP, D, notifier, VDD, VSS);
  `endif
`else
  dti_lq xdti_16f_9t_96_lq (Q, CP, D, notifier, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_lqx4  (Q, CP, D, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CP, D;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_lq xdti_16f_9t_96_lq (Q, CP, D, notifier, VDD, VSS);
  `else
    dti_lq xdti_16f_9t_96_lq (Q, CP, D, notifier, VDD, VSS);
  `endif
`else
  dti_lq xdti_16f_9t_96_lq (Q, CP, D, notifier, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_minbuf100x1  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

`ifdef NEGDEL
  `ifdef RECREM
  dti_minbuf100 xdti_16f_9t_96_minbuf100 (Z, A, VDD, VSS);
  `else
    dti_minbuf100 xdti_16f_9t_96_minbuf100 (Z, A, VDD, VSS);
  `endif
`else
  dti_minbuf100 xdti_16f_9t_96_minbuf100 (Z, A, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_mux21x1  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0;
input  D1;
input  S;

`ifdef NEGDEL
  `ifdef RECREM
  dti_mux21 xdti_16f_9t_96_mux21 (Z, D0, D1, S, VDD, VSS);
  `else
    dti_mux21 xdti_16f_9t_96_mux21 (Z, D0, D1, S, VDD, VSS);
  `endif
`else
  dti_mux21 xdti_16f_9t_96_mux21 (Z, D0, D1, S, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_mux21x2  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0;
input  D1;
input  S;

`ifdef NEGDEL
  `ifdef RECREM
  dti_mux21 xdti_16f_9t_96_mux21 (Z, D0, D1, S, VDD, VSS);
  `else
    dti_mux21 xdti_16f_9t_96_mux21 (Z, D0, D1, S, VDD, VSS);
  `endif
`else
  dti_mux21 xdti_16f_9t_96_mux21 (Z, D0, D1, S, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_mux41x1  (Z, D0, D1, D2, D3, S0, S1, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0;
input  D1;
input  D2;
input  D3;
input  S0;
input  S1;

`ifdef NEGDEL
  `ifdef RECREM
  dti_mux41 xdti_16f_9t_96_mux41 (Z, D0, D1, D2, D3, S0, S1, VDD, VSS);
  `else
    dti_mux41 xdti_16f_9t_96_mux41 (Z, D0, D1, D2, D3, S0, S1, VDD, VSS);
  `endif
`else
  dti_mux41 xdti_16f_9t_96_mux41 (Z, D0, D1, D2, D3, S0, S1, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_muxi21x1  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0;
input  D1;
input  S;

`ifdef NEGDEL
  `ifdef RECREM
  dti_muxi21 xdti_16f_9t_96_muxi21 (Z, D0, D1, S, VDD, VSS);
  `else
    dti_muxi21 xdti_16f_9t_96_muxi21 (Z, D0, D1, S, VDD, VSS);
  `endif
`else
  dti_muxi21 xdti_16f_9t_96_muxi21 (Z, D0, D1, S, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_muxi21x2  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0;
input  D1;
input  S;

`ifdef NEGDEL
  `ifdef RECREM
  dti_muxi21 xdti_16f_9t_96_muxi21 (Z, D0, D1, S, VDD, VSS);
  `else
    dti_muxi21 xdti_16f_9t_96_muxi21 (Z, D0, D1, S, VDD, VSS);
  `endif
`else
  dti_muxi21 xdti_16f_9t_96_muxi21 (Z, D0, D1, S, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nand2i1x1  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nand2i1 xdti_16f_9t_96_nand2i1 (Z, A, B, VDD, VSS);
  `else
    dti_nand2i1 xdti_16f_9t_96_nand2i1 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_nand2i1 xdti_16f_9t_96_nand2i1 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nand2i1x2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nand2i1 xdti_16f_9t_96_nand2i1 (Z, A, B, VDD, VSS);
  `else
    dti_nand2i1 xdti_16f_9t_96_nand2i1 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_nand2i1 xdti_16f_9t_96_nand2i1 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nand2x1  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nand2 xdti_16f_9t_96_nand2 (Z, A, B, VDD, VSS);
  `else
    dti_nand2 xdti_16f_9t_96_nand2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_nand2 xdti_16f_9t_96_nand2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nand2x2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nand2 xdti_16f_9t_96_nand2 (Z, A, B, VDD, VSS);
  `else
    dti_nand2 xdti_16f_9t_96_nand2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_nand2 xdti_16f_9t_96_nand2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nand2x6  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nand2 xdti_16f_9t_96_nand2 (Z, A, B, VDD, VSS);
  `else
    dti_nand2 xdti_16f_9t_96_nand2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_nand2 xdti_16f_9t_96_nand2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nand3i1x1  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B;
input  C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nand3i1 xdti_16f_9t_96_nand3i1 (Z, A, B, C, VDD, VSS);
  `else
    dti_nand3i1 xdti_16f_9t_96_nand3i1 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_nand3i1 xdti_16f_9t_96_nand3i1 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nand3x1  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nand3 xdti_16f_9t_96_nand3 (Z, A, B, C, VDD, VSS);
  `else
    dti_nand3 xdti_16f_9t_96_nand3 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_nand3 xdti_16f_9t_96_nand3 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nand3x2  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nand3 xdti_16f_9t_96_nand3 (Z, A, B, C, VDD, VSS);
  `else
    dti_nand3 xdti_16f_9t_96_nand3 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_nand3 xdti_16f_9t_96_nand3 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nendcapx1  (VSS);
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nendcap xdti_16f_9t_96_nendcap (VSS);
  `else
    dti_nendcap xdti_16f_9t_96_nendcap (VSS);
  `endif
`else
  dti_nendcap xdti_16f_9t_96_nendcap (VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nleftendcapx1  (VSS);
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nleftendcap xdti_16f_9t_96_nleftendcap (VSS);
  `else
    dti_nleftendcap xdti_16f_9t_96_nleftendcap (VSS);
  `endif
`else
  dti_nleftendcap xdti_16f_9t_96_nleftendcap (VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nor2i1x1  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nor2i1 xdti_16f_9t_96_nor2i1 (Z, A, B, VDD, VSS);
  `else
    dti_nor2i1 xdti_16f_9t_96_nor2i1 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_nor2i1 xdti_16f_9t_96_nor2i1 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nor2i1x2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nor2i1 xdti_16f_9t_96_nor2i1 (Z, A, B, VDD, VSS);
  `else
    dti_nor2i1 xdti_16f_9t_96_nor2i1 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_nor2i1 xdti_16f_9t_96_nor2i1 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nor2x1  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nor2 xdti_16f_9t_96_nor2 (Z, A, B, VDD, VSS);
  `else
    dti_nor2 xdti_16f_9t_96_nor2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_nor2 xdti_16f_9t_96_nor2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nor2x2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nor2 xdti_16f_9t_96_nor2 (Z, A, B, VDD, VSS);
  `else
    dti_nor2 xdti_16f_9t_96_nor2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_nor2 xdti_16f_9t_96_nor2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nor2x4  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nor2 xdti_16f_9t_96_nor2 (Z, A, B, VDD, VSS);
  `else
    dti_nor2 xdti_16f_9t_96_nor2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_nor2 xdti_16f_9t_96_nor2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nor3i1x1  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B;
input  C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nor3i1 xdti_16f_9t_96_nor3i1 (Z, A, B, C, VDD, VSS);
  `else
    dti_nor3i1 xdti_16f_9t_96_nor3i1 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_nor3i1 xdti_16f_9t_96_nor3i1 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nor3i2x1  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B;
input  C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nor3i2 xdti_16f_9t_96_nor3i2 (Z, A, B, C, VDD, VSS);
  `else
    dti_nor3i2 xdti_16f_9t_96_nor3i2 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_nor3i2 xdti_16f_9t_96_nor3i2 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nor3x1  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nor3 xdti_16f_9t_96_nor3 (Z, A, B, C, VDD, VSS);
  `else
    dti_nor3 xdti_16f_9t_96_nor3 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_nor3 xdti_16f_9t_96_nor3 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nor3x2  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nor3 xdti_16f_9t_96_nor3 (Z, A, B, C, VDD, VSS);
  `else
    dti_nor3 xdti_16f_9t_96_nor3 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_nor3 xdti_16f_9t_96_nor3 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_nrightendcapx1  (VSS);
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_nrightendcap xdti_16f_9t_96_nrightendcap (VSS);
  `else
    dti_nrightendcap xdti_16f_9t_96_nrightendcap (VSS);
  `endif
`else
  dti_nrightendcap xdti_16f_9t_96_nrightendcap (VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_oa12x1  (Z, A, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;

`ifdef NEGDEL
  `ifdef RECREM
  dti_oa12 xdti_16f_9t_96_oa12 (Z, A, B1, B2, VDD, VSS);
  `else
    dti_oa12 xdti_16f_9t_96_oa12 (Z, A, B1, B2, VDD, VSS);
  `endif
`else
  dti_oa12 xdti_16f_9t_96_oa12 (Z, A, B1, B2, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_oa12x2  (Z, A, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;

`ifdef NEGDEL
  `ifdef RECREM
  dti_oa12 xdti_16f_9t_96_oa12 (Z, A, B1, B2, VDD, VSS);
  `else
    dti_oa12 xdti_16f_9t_96_oa12 (Z, A, B1, B2, VDD, VSS);
  `endif
`else
  dti_oa12 xdti_16f_9t_96_oa12 (Z, A, B1, B2, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_oa13x1  (Z, A, B1, B2, B3, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;
input  B3;

`ifdef NEGDEL
  `ifdef RECREM
  dti_oa13 xdti_16f_9t_96_oa13 (Z, A, B1, B2, B3, VDD, VSS);
  `else
    dti_oa13 xdti_16f_9t_96_oa13 (Z, A, B1, B2, B3, VDD, VSS);
  `endif
`else
  dti_oa13 xdti_16f_9t_96_oa13 (Z, A, B1, B2, B3, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_oai12x1  (Z, A, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;

`ifdef NEGDEL
  `ifdef RECREM
  dti_oai12 xdti_16f_9t_96_oai12 (Z, A, B1, B2, VDD, VSS);
  `else
    dti_oai12 xdti_16f_9t_96_oai12 (Z, A, B1, B2, VDD, VSS);
  `endif
`else
  dti_oai12 xdti_16f_9t_96_oai12 (Z, A, B1, B2, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_or2x1  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_or2 xdti_16f_9t_96_or2 (Z, A, B, VDD, VSS);
  `else
    dti_or2 xdti_16f_9t_96_or2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_or2 xdti_16f_9t_96_or2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_or2x16  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_or2 xdti_16f_9t_96_or2 (Z, A, B, VDD, VSS);
  `else
    dti_or2 xdti_16f_9t_96_or2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_or2 xdti_16f_9t_96_or2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_or2x2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_or2 xdti_16f_9t_96_or2 (Z, A, B, VDD, VSS);
  `else
    dti_or2 xdti_16f_9t_96_or2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_or2 xdti_16f_9t_96_or2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_or2x4  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_or2 xdti_16f_9t_96_or2 (Z, A, B, VDD, VSS);
  `else
    dti_or2 xdti_16f_9t_96_or2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_or2 xdti_16f_9t_96_or2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_or3x1  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_or3 xdti_16f_9t_96_or3 (Z, A, B, C, VDD, VSS);
  `else
    dti_or3 xdti_16f_9t_96_or3 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_or3 xdti_16f_9t_96_or3 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_or3x2  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_or3 xdti_16f_9t_96_or3 (Z, A, B, C, VDD, VSS);
  `else
    dti_or3 xdti_16f_9t_96_or3 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_or3 xdti_16f_9t_96_or3 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_or3x8  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_or3 xdti_16f_9t_96_or3 (Z, A, B, C, VDD, VSS);
  `else
    dti_or3 xdti_16f_9t_96_or3 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_or3 xdti_16f_9t_96_or3 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_or4x1  (Z, A, B, C, D, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C, D;

`ifdef NEGDEL
  `ifdef RECREM
  dti_or4 xdti_16f_9t_96_or4 (Z, A, B, C, D, VDD, VSS);
  `else
    dti_or4 xdti_16f_9t_96_or4 (Z, A, B, C, D, VDD, VSS);
  `endif
`else
  dti_or4 xdti_16f_9t_96_or4 (Z, A, B, C, D, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_or8x1  (Z, A, B, C, D, E, F, G, H, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C, D, E, F, G, H;

`ifdef NEGDEL
  `ifdef RECREM
  dti_or8 xdti_16f_9t_96_or8 (Z, A, B, C, D, E, F, G, H, VDD, VSS);
  `else
    dti_or8 xdti_16f_9t_96_or8 (Z, A, B, C, D, E, F, G, H, VDD, VSS);
  `endif
`else
  dti_or8 xdti_16f_9t_96_or8 (Z, A, B, C, D, E, F, G, H, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_pendcapx1  (VDD);
input VDD;

`ifdef NEGDEL
  `ifdef RECREM
  dti_pendcap xdti_16f_9t_96_pendcap (VDD);
  `else
    dti_pendcap xdti_16f_9t_96_pendcap (VDD);
  `endif
`else
  dti_pendcap xdti_16f_9t_96_pendcap (VDD);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_pleftendcapx1  (VDD);
input VDD;

`ifdef NEGDEL
  `ifdef RECREM
  dti_pleftendcap xdti_16f_9t_96_pleftendcap (VDD);
  `else
    dti_pleftendcap xdti_16f_9t_96_pleftendcap (VDD);
  `endif
`else
  dti_pleftendcap xdti_16f_9t_96_pleftendcap (VDD);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_prightendcapx1  (VDD);
input VDD;

`ifdef NEGDEL
  `ifdef RECREM
  dti_prightendcap xdti_16f_9t_96_prightendcap (VDD);
  `else
    dti_prightendcap xdti_16f_9t_96_prightendcap (VDD);
  `endif
`else
  dti_prightendcap xdti_16f_9t_96_prightendcap (VDD);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_rightedgeboundaryx1  (VDD, VSS);
input VDD;
input VSS;

`ifdef NEGDEL
  `ifdef RECREM
  dti_rightedgeboundary xdti_16f_9t_96_rightedgeboundary (VDD, VSS);
  `else
    dti_rightedgeboundary xdti_16f_9t_96_rightedgeboundary (VDD, VSS);
  `endif
`else
  dti_rightedgeboundary xdti_16f_9t_96_rightedgeboundary (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_saffqa01dhx1  (Q, CK, D, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, RN;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_saffqa01 xdti_16f_9t_96_saffqa01dh (Q, CK, D, RN, notifier, VDD, VSS);
  `else
    dti_saffqa01 xdti_16f_9t_96_saffqa01dh (Q, CK, D, RN, notifier, VDD, VSS);
  `endif
`else
  dti_saffqa01 xdti_16f_9t_96_saffqa01dh (Q, CK, D, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_saffqa10dhx1  (Q, CK, D, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SN;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_saffqa10 xdti_16f_9t_96_saffqa10dh (Q, CK, D, SN, notifier, VDD, VSS);
  `else
    dti_saffqa10 xdti_16f_9t_96_saffqa10dh (Q, CK, D, SN, notifier, VDD, VSS);
  `endif
`else
  dti_saffqa10 xdti_16f_9t_96_saffqa10dh (Q, CK, D, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sffnqa10x1  (Q, CKN, D, SD, SE, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CKN, D, SD, SE, SN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sffnqa10 xdti_16f_9t_96_sffnqa10 (Q, CKN, D, SD, SE, SN, notifier, VDD, VSS);
  `else
    dti_sffnqa10 xdti_16f_9t_96_sffnqa10 (Q, CKN, D, SD, SE, SN, notifier, VDD, VSS);
  `endif
`else
  dti_sffnqa10 xdti_16f_9t_96_sffnqa10 (Q, CKN, D, SD, SE, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sffnqbckx1  (Q, CKN, D, SD, SE, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CKN, D, SD, SE;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sffnqbck xdti_16f_9t_96_sffnqbck (Q, CKN, D, SD, SE, notifier, VDD, VSS);
  `else
    dti_sffnqbck xdti_16f_9t_96_sffnqbck (Q, CKN, D, SD, SE, notifier, VDD, VSS);
  `endif
`else
  dti_sffnqbck xdti_16f_9t_96_sffnqbck (Q, CKN, D, SD, SE, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sffnqx1  (Q, CKN, D, SD, SE, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CKN, D, SD, SE;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sffnq xdti_16f_9t_96_sffnq (Q, CKN, D, SD, SE, notifier, VDD, VSS);
  `else
    dti_sffnq xdti_16f_9t_96_sffnq (Q, CKN, D, SD, SE, notifier, VDD, VSS);
  `endif
`else
  dti_sffnq xdti_16f_9t_96_sffnq (Q, CKN, D, SD, SE, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sffqa01dhx1  (Q, CK, D, SD, SE, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, RN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sffqa01 xdti_16f_9t_96_sffqa01dh (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `else
    dti_sffqa01 xdti_16f_9t_96_sffqa01dh (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `endif
`else
  dti_sffqa01 xdti_16f_9t_96_sffqa01dh (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sffqa01dhx2  (Q, CK, D, SD, SE, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, RN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sffqa01 xdti_16f_9t_96_sffqa01dh (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `else
    dti_sffqa01 xdti_16f_9t_96_sffqa01dh (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `endif
`else
  dti_sffqa01 xdti_16f_9t_96_sffqa01dh (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sffqa01x1  (Q, CK, D, SD, SE, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, RN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sffqa01 xdti_16f_9t_96_sffqa01 (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `else
    dti_sffqa01 xdti_16f_9t_96_sffqa01 (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `endif
`else
  dti_sffqa01 xdti_16f_9t_96_sffqa01 (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sffqa01x2  (Q, CK, D, SD, SE, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, RN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sffqa01 xdti_16f_9t_96_sffqa01 (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `else
    dti_sffqa01 xdti_16f_9t_96_sffqa01 (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `endif
`else
  dti_sffqa01 xdti_16f_9t_96_sffqa01 (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sffqa10x1  (Q, CK, D, SD, SE, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, SN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sffqa10 xdti_16f_9t_96_sffqa10 (Q, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `else
    dti_sffqa10 xdti_16f_9t_96_sffqa10 (Q, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `endif
`else
  dti_sffqa10 xdti_16f_9t_96_sffqa10 (Q, CK, D, SD, SE, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sffqa10x2  (Q, CK, D, SD, SE, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, SN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sffqa10 xdti_16f_9t_96_sffqa10 (Q, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `else
    dti_sffqa10 xdti_16f_9t_96_sffqa10 (Q, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `endif
`else
  dti_sffqa10 xdti_16f_9t_96_sffqa10 (Q, CK, D, SD, SE, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sffqbckx1  (Q, CK, D, SD, SE, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sffqbck xdti_16f_9t_96_sffqbck (Q, CK, D, SD, SE, notifier, VDD, VSS);
  `else
    dti_sffqbck xdti_16f_9t_96_sffqbck (Q, CK, D, SD, SE, notifier, VDD, VSS);
  `endif
`else
  dti_sffqbck xdti_16f_9t_96_sffqbck (Q, CK, D, SD, SE, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sffqx1  (Q, CK, D, SD, SE, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sffq xdti_16f_9t_96_sffq (Q, CK, D, SD, SE, notifier, VDD, VSS);
  `else
    dti_sffq xdti_16f_9t_96_sffq (Q, CK, D, SD, SE, notifier, VDD, VSS);
  `endif
`else
  dti_sffq xdti_16f_9t_96_sffq (Q, CK, D, SD, SE, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sffqx2  (Q, CK, D, SD, SE, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sffq xdti_16f_9t_96_sffq (Q, CK, D, SD, SE, notifier, VDD, VSS);
  `else
    dti_sffq xdti_16f_9t_96_sffq (Q, CK, D, SD, SE, notifier, VDD, VSS);
  `endif
`else
  dti_sffq xdti_16f_9t_96_sffq (Q, CK, D, SD, SE, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_soffnqbcka01x1  (Q, SO, CKN, D, SD, SE, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CKN, D, SD, SE, RN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_soffnqbcka01 xdti_16f_9t_96_soffnqbcka01 (Q, SO, CKN, D, SD, SE, RN, notifier, VDD, VSS);
  `else
    dti_soffnqbcka01 xdti_16f_9t_96_soffnqbcka01 (Q, SO, CKN, D, SD, SE, RN, notifier, VDD, VSS);
  `endif
`else
  dti_soffnqbcka01 xdti_16f_9t_96_soffnqbcka01 (Q, SO, CKN, D, SD, SE, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_soffnqbcka01x2  (Q, SO, CKN, D, SD, SE, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CKN, D, SD, SE, RN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_soffnqbcka01 xdti_16f_9t_96_soffnqbcka01 (Q, SO, CKN, D, SD, SE, RN, notifier, VDD, VSS);
  `else
    dti_soffnqbcka01 xdti_16f_9t_96_soffnqbcka01 (Q, SO, CKN, D, SD, SE, RN, notifier, VDD, VSS);
  `endif
`else
  dti_soffnqbcka01 xdti_16f_9t_96_soffnqbcka01 (Q, SO, CKN, D, SD, SE, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_soffqa10x1  (Q, SO, CK, D, SD, SE, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, SN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_soffqa10 xdti_16f_9t_96_soffqa10 (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `else
    dti_soffqa10 xdti_16f_9t_96_soffqa10 (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `endif
`else
  dti_soffqa10 xdti_16f_9t_96_soffqa10 (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_soffqa10x2  (Q, SO, CK, D, SD, SE, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, SN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_soffqa10 xdti_16f_9t_96_soffqa10 (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `else
    dti_soffqa10 xdti_16f_9t_96_soffqa10 (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `endif
`else
  dti_soffqa10 xdti_16f_9t_96_soffqa10 (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_soffqbcka01fox4  (Q, SO, CK, D, SD, SE, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_soffqbcka01fo xdti_16f_9t_96_soffqbcka01fo (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `else
    dti_soffqbcka01fo xdti_16f_9t_96_soffqbcka01fo (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `endif
`else
  dti_soffqbcka01fo xdti_16f_9t_96_soffqbcka01fo (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_soffqbcka01x1  (Q, SO, CK, D, SD, SE, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_soffqbcka01 xdti_16f_9t_96_soffqbcka01 (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `else
    dti_soffqbcka01 xdti_16f_9t_96_soffqbcka01 (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `endif
`else
  dti_soffqbcka01 xdti_16f_9t_96_soffqbcka01 (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_soffqbcka01x2  (Q, SO, CK, D, SD, SE, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_soffqbcka01 xdti_16f_9t_96_soffqbcka01 (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `else
    dti_soffqbcka01 xdti_16f_9t_96_soffqbcka01 (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `endif
`else
  dti_soffqbcka01 xdti_16f_9t_96_soffqbcka01 (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_soffqbcka10x1  (Q, SO, CK, D, SD, SE, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, SN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_soffqbcka10 xdti_16f_9t_96_soffqbcka10 (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `else
    dti_soffqbcka10 xdti_16f_9t_96_soffqbcka10 (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `endif
`else
  dti_soffqbcka10 xdti_16f_9t_96_soffqbcka10 (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_soffqbcka11x1  (Q, SO, CK, D, SD, SE, RN, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, SN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_soffqbcka11 xdti_16f_9t_96_soffqbcka11 (Q, SO, CK, D, SD, SE, RN, SN, notifier, VDD, VSS);
  `else
    dti_soffqbcka11 xdti_16f_9t_96_soffqbcka11 (Q, SO, CK, D, SD, SE, RN, SN, notifier, VDD, VSS);
  `endif
`else
  dti_soffqbcka11 xdti_16f_9t_96_soffqbcka11 (Q, SO, CK, D, SD, SE, RN, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_soffqbckena01x1  (Q, SO, CK, CE, D, SD, SE, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, CE, D, SD, SE, RN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_soffqbckena01 xdti_16f_9t_96_soffqbckena01 (Q, SO, CK, CE, D, SD, SE, RN, notifier, VDD, VSS);
  `else
    dti_soffqbckena01 xdti_16f_9t_96_soffqbckena01 (Q, SO, CK, CE, D, SD, SE, RN, notifier, VDD, VSS);
  `endif
`else
  dti_soffqbckena01 xdti_16f_9t_96_soffqbckena01 (Q, SO, CK, CE, D, SD, SE, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_soffqbckena10x1  (Q, SO, CK, CE, D, SD, SE, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, CE, D, SD, SE, SN;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSE;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_soffqbckena10 xdti_16f_9t_96_soffqbckena10 (Q, SO, CK, CE, D, SD, SE, SN, notifier, VDD, VSS);
  `else
    dti_soffqbckena10 xdti_16f_9t_96_soffqbckena10 (Q, SO, CK, CE, D, SD, SE, SN, notifier, VDD, VSS);
  `endif
`else
  dti_soffqbckena10 xdti_16f_9t_96_soffqbckena10 (Q, SO, CK, CE, D, SD, SE, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanSE, SandR, SE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanSE, SandR, SE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_soffqbckx1  (Q, SO, CK, D, SE, SD, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SE, SD;
wire SEnot;
wire RanSEnot;
wire SandR;
wire SandRanSEnot;
wire SandRanCE;
wire SandRanCEanSE;
wire SandRanCEanSEnot;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_soffqbck xdti_16f_9t_96_soffqbck (Q, SO, CK, D, SE, SD, notifier, VDD, VSS);
  `else
    dti_soffqbck xdti_16f_9t_96_soffqbck (Q, SO, CK, D, SE, SD, notifier, VDD, VSS);
  `endif
`else
  dti_soffqbck xdti_16f_9t_96_soffqbck (Q, SO, CK, D, SE, SD, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);

    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `else
    and (SandR, SN, RN);
    and (SandRanCE, SandR, CE);
    and (SandRanCEanSE, SandRanCE, SE);
    not (SEnot, SE);
    and (RanSEnot, RN, SEnot);
    and (SandRanSEnot, SandR, SEnot);
    and (SandRanCEanSEnot, SandRanCE, SEnot);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);
  and (SandRanCEanSE, SandRanCE, SE);
  not (SEnot, SE);
  and (RanSEnot, RN, SEnot);
  and (SandRanSEnot, SandR, SEnot);
  and (SandRanCEanSEnot, SandRanCE, SEnot);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sosaffqa01dhx1  (Q, SO, CK, D, SD, SE, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sosaffqa01 xdti_16f_9t_96_sosaffqa01dh (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `else
    dti_sosaffqa01 xdti_16f_9t_96_sosaffqa01dh (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `endif
`else
  dti_sosaffqa01 xdti_16f_9t_96_sosaffqa01dh (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_sosaffqa10dhx1  (Q, SO, CK, D, SD, SE, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, SN;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_sosaffqa10 xdti_16f_9t_96_sosaffqa10dh (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `else
    dti_sosaffqa10 xdti_16f_9t_96_sosaffqa10dh (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `endif
`else
  dti_sosaffqa10 xdti_16f_9t_96_sosaffqa10dh (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ssaffqa01dhx1  (Q, CK, D, SD, SE, RN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, RN;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ssaffqa01 xdti_16f_9t_96_ssaffqa01dh (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `else
    dti_ssaffqa01 xdti_16f_9t_96_ssaffqa01dh (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
  `endif
`else
  dti_ssaffqa01 xdti_16f_9t_96_ssaffqa01dh (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ssaffqa10dhx1  (Q, CK, D, SD, SE, SN, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, SN;
wire SandR;
wire SandRanCE;
//supply1 CE;
supply1 CE;
//supply1 RN;
supply1 RN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ssaffqa10 xdti_16f_9t_96_ssaffqa10dh (Q, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `else
    dti_ssaffqa10 xdti_16f_9t_96_ssaffqa10dh (Q, CK, D, SD, SE, SN, notifier, VDD, VSS);
  `endif
`else
  dti_ssaffqa10 xdti_16f_9t_96_ssaffqa10dh (Q, CK, D, SD, SE, SN, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_ssaffqendhx1  (Q, CK, D, CE, SE, SD, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, CE, SE, SD;
wire SandR;
wire SandRanCE;
//supply1 RN;
supply1 RN;
//supply1 SN;
supply1 SN;
reg notifier;

`ifdef NEGDEL
  `ifdef RECREM
  dti_ssaffqen xdti_16f_9t_96_ssaffqendh (Q, CK, D, CE, SE, SD, notifier, VDD, VSS);
  `else
    dti_ssaffqen xdti_16f_9t_96_ssaffqendh (Q, CK, D, CE, SE, SD, notifier, VDD, VSS);
  `endif
`else
  dti_ssaffqen xdti_16f_9t_96_ssaffqendh (Q, CK, D, CE, SE, SD, notifier, VDD, VSS);
`endif

`ifdef NEGDEL
  `ifdef RECREM
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `else
   and (SandR, SN, RN);
   and (SandRanCE, SandR, CE);

  `endif
`else
  and (SandR, SN, RN);
  and (SandRanCE, SandR, CE);

`endif
//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_tapx1  (VDD, VSS);
input VSS;
input VDD;

`ifdef NEGDEL
  `ifdef RECREM
  dti_tap xdti_16f_9t_96_tap (VDD, VSS);
  `else
    dti_tap xdti_16f_9t_96_tap (VDD, VSS);
  `endif
`else
  dti_tap xdti_16f_9t_96_tap (VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_tiehix1  (HI, VDD, VSS);
input VDD;
input VSS;
output HI;

`ifdef NEGDEL
  `ifdef RECREM
  dti_tiehi xdti_16f_9t_96_tiehi (HI, VDD, VSS);
  `else
    dti_tiehi xdti_16f_9t_96_tiehi (HI, VDD, VSS);
  `endif
`else
  dti_tiehi xdti_16f_9t_96_tiehi (HI, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_tielox1  (LO, VDD, VSS);
input VDD;
input VSS;
output LO;

`ifdef NEGDEL
  `ifdef RECREM
  dti_tielo xdti_16f_9t_96_tielo (LO, VDD, VSS);
  `else
    dti_tielo xdti_16f_9t_96_tielo (LO, VDD, VSS);
  `endif
`else
  dti_tielo xdti_16f_9t_96_tielo (LO, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_tierailx1  (HI, LO, VDD, VSS);
input VDD;
input VSS;
output HI;
output LO;

`ifdef NEGDEL
  `ifdef RECREM
  dti_tierail xdti_16f_9t_96_tierail (HI, LO, VDD, VSS);
  `else
    dti_tierail xdti_16f_9t_96_tierail (HI, LO, VDD, VSS);
  `endif
`else
  dti_tierail xdti_16f_9t_96_tierail (HI, LO, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_xnor2x1  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_xnor2 xdti_16f_9t_96_xnor2 (Z, A, B, VDD, VSS);
  `else
    dti_xnor2 xdti_16f_9t_96_xnor2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_xnor2 xdti_16f_9t_96_xnor2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_xnor2xp5  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_xnor2 xdti_16f_9t_96_xnor2 (Z, A, B, VDD, VSS);
  `else
    dti_xnor2 xdti_16f_9t_96_xnor2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_xnor2 xdti_16f_9t_96_xnor2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_xnor3x1  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_xnor3 xdti_16f_9t_96_xnor3 (Z, A, B, C, VDD, VSS);
  `else
    dti_xnor3 xdti_16f_9t_96_xnor3 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_xnor3 xdti_16f_9t_96_xnor3 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_xor2x1  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_xor2 xdti_16f_9t_96_xor2 (Z, A, B, VDD, VSS);
  `else
    dti_xor2 xdti_16f_9t_96_xor2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_xor2 xdti_16f_9t_96_xor2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_xor2x2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

`ifdef NEGDEL
  `ifdef RECREM
  dti_xor2 xdti_16f_9t_96_xor2 (Z, A, B, VDD, VSS);
  `else
    dti_xor2 xdti_16f_9t_96_xor2 (Z, A, B, VDD, VSS);
  `endif
`else
  dti_xor2 xdti_16f_9t_96_xor2 (Z, A, B, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//`celldefine
module dti_16f_9t_96_xor3x1  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

`ifdef NEGDEL
  `ifdef RECREM
  dti_xor3 xdti_16f_9t_96_xor3 (Z, A, B, C, VDD, VSS);
  `else
    dti_xor3 xdti_16f_9t_96_xor3 (Z, A, B, C, VDD, VSS);
  `endif
`else
  dti_xor3 xdti_16f_9t_96_xor3 (Z, A, B, C, VDD, VSS);
`endif

//specify 
//
//endspecify 

endmodule
//`endcelldefine


//BEGIN GENERIC CELLS

//`celldefine
module dti_flop_asyn_soff_top  (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, CE, SN;
input notifier;
wire CE_D;
wire m;
  

  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (m, CE_D, SD, SE);
  dti_udp_dff g2 (Q, CK, m, RN, SE, SN, notifier);
  buf g3 (SO, Q);


endmodule 
//`endcelldefine


//`celldefine
module dti_flop_syn_soff_top  (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, CE, SN;
input notifier;
wire CE_D; 
wire SN_D;
wire RN_SN_D;
wire m;

  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (SN_D, 1'b1, CE_D, SN);
  dti_udp_mux g2 (RN_SN_D, 1'b0, SN_D, RN);
  dti_udp_mux g3 (m, RN_SN_D, SD, SE);
  dti_udp_dff g4 (Q, CK, m, 1'b1, 1'b1, 1'b1, notifier);
  buf g5 (SO, Q);
  

endmodule
//`endcelldefine

//`celldefine
module dti_flop_asyn_soffa_sn_top  (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, CE, SN;
input notifier;
wire CE_D;
wire m;


  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (m, CE_D, SD, SE);
  dti_udp_dffa_sn g2 (Q, CK, m, RN, SN, notifier);
  buf g3 (SO, Q);


endmodule
//`endcelldefine


//`celldefine
module dti_flop_asyn_soffa_top  (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, CE, SN;
input notifier;
wire CE_D;
wire m;


  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (m, CE_D, SD, SE);
  dti_udp_dffa g2 (Q, CK, m, RN, SN, notifier);
  buf g3 (SO, Q);


endmodule
//`endcelldefine

//`celldefine
module dti_flop_syn_soeff_top  (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, CE, SN;
input notifier;
wire CE_D; 
wire SN_D;
wire RN_SN_D;
wire m;

  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (SN_D, 1'b1, CE_D, SN);
  dti_udp_mux g2 (RN_SN_D, 1'b0, SN_D, RN);
  dti_udp_mux g3 (m, RN_SN_D, SD, SE);
  dti_udp_dff g4 (Q, CK, m, 1'b1, 1'b1, 1'b1, notifier);
  and g5 (SO, Q, SE);
  

endmodule
//`endcelldefine

//`celldefine
module dti_flop_asyn_soeffa_sn_top  (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, CE, SN;
input notifier;
wire CE_D;
wire m;


  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (m, CE_D, SD, SE);
  dti_udp_dffa_sn g2 (Q, CK, m, RN, SN, notifier);
  and g5 (SO, Q, SE);


endmodule
//`endcelldefine


//`celldefine
module dti_flop_asyn_soeffa_top  (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, CE, SN;
input notifier;
wire CE_D;
wire m;


  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (m, CE_D, SD, SE);
  dti_udp_dffa g2 (Q, CK, m, RN, SN, notifier);
  and g5 (SO, Q, SE);


endmodule
//`endcelldefine

//`celldefine
module dti_flop_asyn_soeff_top  (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, CE, SN ;
input notifier;
wire CE_D;
wire m;
  

  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (m, CE_D, SD, SE);
  dti_udp_dff g2 (Q, CK, m, RN, SE, SN, notifier);
  and g5 (SO, Q, SE);


endmodule 
//`endcelldefine


//`celldefine
module dti_flop_syn_soeeff_top  (Q, SO, CK, CE, D, SD, SE, SOE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, CE, SN, SOE;
input notifier;
wire CE_D; 
wire SN_D;
wire RN_SN_D;
wire m;

  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (SN_D, 1'b1, CE_D, SN);
  dti_udp_mux g2 (RN_SN_D, 1'b0, SN_D, RN);
  dti_udp_mux g3 (m, RN_SN_D, SD, SE);
  dti_udp_dff g4 (Q, CK, m, 1'b1, 1'b1, 1'b1, notifier);
  and g5 (SO, Q, SOE);
  

endmodule
//`endcelldefine

//`celldefine
module dti_flop_asyn_soeeffa_top  (Q, SO, CK, CE, D, SD, SE, SOE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, CE, SN, SOE;
input notifier;
wire CE_D;
wire m;


  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (m, CE_D, SD, SE);
  dti_udp_dffa g2 (Q, CK, m, RN, SN, notifier);
  and g5 (SO, Q, SOE);


endmodule
//`endcelldefine

//`celldefine
module dti_flop_asyn_soeeff_top  (Q, SO, CK, CE, D, SD, SE, SOE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, CE, SN , SOE;
input notifier;
wire CE_D;
wire m;
  

  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (m, CE_D, SD, SE);
  dti_udp_dff g2 (Q, CK, m, RN, SE, SN, notifier);
  and g5 (SO, Q, SOE);


endmodule 
//`endcelldefine

primitive dti_udp_dff_sn (q, clk, m, rn, se, sn, notifier);
output q;
reg q;
input clk, m,  rn, se, sn, notifier;

table
//      clk     m       rn      se      sn      notifier                state           q
         ?      ?       ?       0       0          ?            :        ?      :       1;   // se = 0, rn = 0, so output = 0, edge on ck makes no difference
         ?      ?       *       0       1          ?            :        0      :       0;   // rn changed but previous state was 0 so output = 0
         ?      ?       1       0       *          ?            :        1      :       1;   // sn changed but previous state was 1 so output = 1
         r      0       1       0       1          ?            :        ?      :       0;   // rising edge of clock, m = 0 , so q = 0
         r      1       1       0       1          ?            :        ?      :       1;   // rising edge of clock, m = 1 , so q = 1
         r      0       ?       1       ?          ?            :        ?      :       0;   // se = 1 , m = 0, so output = 0
         r      1       ?       1       ?          ?            :        ?      :       1;   // se = 1 , m = 1, so output = 1
       //f      ?       ?       ?       ?          ?            :        ?      :       -;   // falling edge of clock, so no change in output
         b      *       ?       ?       ?          ?            :        ?      :       -;   // maintain state
         ?      ?       ?       ?       ?          *            :        ?      :       x;   // final case
        (?0)    ?       ?       ?       ?          ?            :        ?      :       -;   // falling edge of clock, so no change in output
        (1x)    ?       ?       ?       ?          ?            :        ?      :       -;   // falling edge of clock, so no change in output
        (0x)    0       ?       1       1          ?            :        0      :       -;   // maintain state for clock going to x for input same as previous state
        (0x)    1       1       1       ?          ?            :        1      :       -;   // maintain state for clock going to x for input same as previous state
        (?1)    0       ?       ?       1          ?            :        0      :       -;   // maintain state for fake transitions
        (?1)    1       1       ?       ?          ?            :        1      :       -;   // maintain state for fake transitions
         x      *       ?       ?       1          ?            :        0      :       -;   // maintain state for clk=x on certain condition
         x      *       1       ?       ?          ?            :        1      :       -;   // maintain state for clk=x on certain condition
         ?      ?       *       1       ?          ?            :        ?      :       -;   // se = 1, edge on rn makes no difference
         ?      ?       ?       1       *          ?            :        ?      :       -;   // se = 1, edge on sn makes no difference
         ?      *       ?       1       ?          ?            :        ?      :       -;   // se = 1, clock is steady, edge on m  makes no difference
         ?      ?       ?       *       ?          ?            :        ?      :       -;   // edge on se  makes no difference as everything is stable
       //?      ?       1       *       ?          ?            :        1      :       -;   // se = 1, clock is steady, edge on m  makes no difference

endtable
endprimitive


primitive dti_udp_dff (q, clk, m, rn, se, sn, notifier);
output q;
reg q;
input clk, m,  rn, se, sn, notifier;

table
//      clk     m       rn      se      sn      notifier                state           q
	 ?      ?       0       0       ?          ?            :        ?      :       0;   // se = 0, rn = 0, so output = 0, edge on ck makes no difference 
	 ?      ?       *       0       1          ?            :        0      :       0;   // rn changed but previous state was 0 so output = 0 
         ?      ?       1       0       0          ?            :        ?      :       1;   // se = 0, sn = 0, so output = 1, edge on ck makes no difference 
         ?      ?       1       0       *          ?            :        1      :       1;   // sn changed but previous state was 1 so output = 1 
         r      0       1       0       1          ?            :        ?      :       0;   // rising edge of clock, m = 0 , so q = 0 
         r      1       1       0       1          ?            :        ?      :       1;   // rising edge of clock, m = 1 , so q = 1 
         r      0       ?       1       ?          ?            :        ?      :       0;   // se = 1 , m = 0, so output = 0
         r      1       ?       1       ?          ?            :        ?      :       1;   // se = 1 , m = 1, so output = 1
         //f      ?       ?       ?       ?          ?            :        ?      :       -;   // falling edge of clock, so no change in output 
         b      *       ?       ?       ?          ?            :        ?      :       -;   // maintain state
         ?      ?       ?       ?       ?          *            :        ?      :       x;   // final case 
        (?0)    ?       ?       ?       ?          ?            :        ?      :       -;   // falling edge of clock, so no change in output 
        (1x)    ?       ?       ?       ?          ?            :        ?      :       -;   // falling edge of clock, so no change in output 
        (0x)    0       ?       1	1          ?            :        0      :       -;   // maintain state for clock going to x for input same as previous state 
        (0x)    1       1       1	?          ?            :        1      :       -;   // maintain state for clock going to x for input same as previous state
        (?1)    0       ?       ?       1          ?            :        0      :       -;   // maintain state for fake transitions 
        (?1)    1       1       ?       ?          ?            :        1      :       -;   // maintain state for fake transitions 
         x      *       ?       ?       1          ?            :        0      :       -;   // maintain state for clk=x on certain condition 
         x      *       1       ?       ?          ?            :        1      :       -;   // maintain state for clk=x on certain condition 
         ?      ?       *       1       ?          ?            :        ?      :       -;   // se = 1, edge on rn makes no difference 
         ?      ?       ?       1       *          ?            :        ?      :       -;   // se = 1, edge on sn makes no difference 
         ?      *       ?       1       ?          ?            :        ?      :       -;   // se = 1, clock is steady, edge on m  makes no difference 
         ?      ?       ?       *       ?          ?            :        ?      :       -;   // edge on se  makes no difference as everything is stable
         //?      ?       1       *       ?          ?            :        1      :       -;   // se = 1, clock is steady, edge on m  makes no difference 
endtable
endprimitive

primitive dti_udp_dffa (q, clk, m, rn, sn, notifier);
output q;
reg q;
input clk, m,  rn, sn, notifier;

table
//      clk     m       rn      sn      notifier                state           q
         ?      ?       0       ?          ?            :        ?      :       0;   // rn = 0, so edge on sn doesnt make a difference, output = 0 
	 ?      ?       *       1          ?            :        0      :       0;   // rn changed but previous state was 0 so output = 0 
         ?      ?       1       0          ?            :        ?      :       1;   // sn = 0, so edge on ck doesnt make a difference, output = 0 
         ?      ?       1       *          ?            :        1      :       1;   // sn changed but previous state was 1 so output = 1 
         r      0       1       1          ?            :        ?      :       0;   // rising edge of clock, m = 0 , so q = 0 
         r      1       1       1          ?            :        ?      :       1;   // rising edge of clock, m = 1 , so q = 1 
         //f      ?       ?       ?          ?            :        ?      :       -;   // falling edge of clock, so no change in output 
         b      *       ?       ?          ?            :        ?      :       -;   // maintain state
         ?      ?       ?       ?          *            :        ?      :       x;   // final case 
        (?0)    ?       ?       ?          ?            :        ?      :       -;   // falling edge of clock, so no change in output 
        (1x)    ?       ?       ?          ?            :        ?      :       -;   // falling edge of clock, so no change in output 
        (0x)    0       ?       1          ?            :        0      :       -;   // maintain state for clock going to x for input same as previous state
        (0x)    1       1       ?          ?            :        1      :       -;   // maintain state for clock going to x for input same as previous state
        (?1)    0       ?       1          ?            :        0      :       -;   // maintain state for fake transitions 
        (?1)    1       1       ?          ?            :        1      :       -;   // maintain state for fake transitions 
         x      *       ?       1          ?            :        0      :       -;   // maintain state for clk=x on certain condition 
         x      *       1       ?          ?            :        1      :       -;   // maintain state for clk=x on certain condition 
endtable
endprimitive

primitive dti_udp_dffa_sn (q, clk, m, rn, sn, notifier);
output q;
reg q;
input clk, m,  rn, sn, notifier;

table
         //clk     m       rn      sn      notifier                state           q
         ?      ?       ?       0          ?            :        ?      :       1;   // sn = 0, so edge on rn doesnt make a difference, output = 1
         ?      ?       0       1          ?            :        ?      :       0;   // rn = 0, sn = 1, so output = 0
         ?      ?       1       *          ?            :        1      :       1;   // sn changed but previous state was 1 so output = 1
         r      0       1       1          ?            :        ?      :       0;   // rising edge of clock, m = 0 , so q = 0
         r      1       1       1          ?            :        ?      :       1;   // rising edge of clock, m = 1 , so q = 1
         //f      ?       ?       ?          ?            :        ?      :       -;   // falling edge of clock, so no change in output
         b      *       ?       ?          ?            :        ?      :       -;   // maintain state
         ?      ?       ?       ?          *            :        ?      :       x;   // final case
        (?0)    ?       ?       ?          ?            :        ?      :       -;   // falling edge of clock, so no change in output
        (1x)    ?       ?       ?          ?            :        ?      :       -;   // falling edge of clock, so no change in output
        (0x)    0       ?       1          ?            :        0      :       -;   // maintain state for clock going to x for input same as previous state
        (0x)    1       1       ?          ?            :        1      :       -;   // maintain state for clock going to x for input same as previous state
        (?1)    0       ?       1          ?            :        0      :       -;   // maintain state for fake transitions
        (?1)    1       1       ?          ?            :        1      :       -;   // maintain state for fake transitions
         x      *       ?       1          ?            :        0      :       -;   // maintain state for clk=x on certain condition
         x      *       1       ?          ?            :        1      :       -;   // maintain state for clk=x on certain condition

endtable
endprimitive

primitive dti_udp_mux (z, a, b, sel);
output z;
input a, b, sel;

table
//	a	b	sel	:	z
	0	?	0	:	0;
	1	?	0	:	1;
	?	0	1	:	0;
	?	1	1	:	1;
	0 	0	x	:	0;
	1 	1	x	:	1;
endtable
endprimitive	


//`celldefine
module dti_flop_asyn_sff_top  (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, RN, CE, SN;
input notifier;
wire CE_D;
wire m;
  

  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (m, CE_D, SD, SE);
  dti_udp_dff g2 (Q, CK, m, RN, SE, SN, notifier);


endmodule 
//`endcelldefine


//`celldefine
module dti_flop_syn_sff_top  (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, RN, CE, SN;
input notifier;
wire CE_D; 
wire SN_D;
wire RN_SN_D;
wire m;

  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (SN_D, 1'b1, CE_D, SN);
  dti_udp_mux g2 (RN_SN_D, 1'b0, SN_D, RN);
  dti_udp_mux g3 (m, RN_SN_D, SD, SE);
  dti_udp_dff g4 (Q, CK, m, 1'b1, 1'b1, 1'b1, notifier);
  

endmodule
//`endcelldefine

//`celldefine
module dti_flop_asyn_sffa_top  (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, RN, CE, SN;
input notifier;
wire CE_D;
wire m;


  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (m, CE_D, SD, SE);
  dti_udp_dffa g2 (Q, CK, m, RN, SN, notifier);


endmodule
//`endcelldefine

//`celldefine
module dti_flop_asyn_sffa_sn_top  (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, RN, CE, SN;
input notifier;
wire CE_D;
wire m;


  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (m, CE_D, SD, SE);
  dti_udp_dffa_sn g2 (Q, CK, m, RN, SN, notifier);


endmodule
//`endcelldefine

//`celldefine
module dti_flop_asyn_ff_top  (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, RN, CE, SN;
input notifier;
wire m;
  

  dti_udp_mux g0 (m, Q, D, CE);
  dti_udp_dff g2 (Q, CK, m, RN, 1'b0, SN, notifier);


endmodule 
//`endcelldefine

//`celldefine
module dti_flop_asyn_ff_sn_top  (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, RN, CE, SN;
input notifier;
wire m;


  dti_udp_mux g0 (m, Q, D, CE);
  dti_udp_dff_sn g2 (Q, CK, m, RN, 1'b0, SN, notifier);


endmodule
//`endcelldefine


//`celldefine
module dti_asyn_latch_top  (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, RN, CE, SN;
input notifier;
wire m;


  dti_udp_mux g0 (m, Q, D, CE);
  dti_udp_dlat11 g2 (Q, CK, m, RN, SN, notifier);


endmodule
//`endcelldefine


//`celldefine
module dti_flop_syn_ff_top  (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, RN, CE, SN;
input notifier;
wire CE_D; 
wire SN_D;
wire m;

  dti_udp_mux g0 (CE_D, Q, D, CE);
  dti_udp_mux g1 (SN_D, 1'b1, CE_D, SN);
  dti_udp_mux g2 (m, 1'b0, SN_D, RN);
  dti_udp_dff g4 (Q, CK, m, 1'b1, 1'b0, 1'b1, notifier);
  

endmodule
//`endcelldefine

//`celldefine
module dti_latch_top  (Q, CP, D, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CP, D;
input notifier;
  

  dti_udp_dlat g0 (Q, CP, D, notifier);


endmodule 
//`endcelldefine

primitive dti_udp_dlat (q, clk, m, notifier);
output q;
reg q;
input clk, m, notifier;

table
//     clk     m       notifier                state           q
	0      0          ?            :        ?      :       0;   // clk = 0, data = 0, so output = 0
	0      1          ?            :        ?      :       1;   // clk = 0, data = 1 so output = 1
	1      ?          ?            :        ?      :       -;   // clk = 1, so no change in output 
	?      ?          *            :        ?      :       x;   // cover all condition 
//Now covering clock x condition
	x      0          ?            :        0      :       0;   // removing pessimism 
	x      1          ?            :        1      :       1;   // removing pessimism 

endtable
endprimitive

primitive dti_udp_lqa11 (q, d, cp, rn, sn, notifier);
output q;
reg q;
input d, cp, rn, sn, notifier;
table
// d  cp  rn  sn  n     state q
   1  0   1   ?   ?   : ?  :  1  ; // cp = 0, data = 1 so output = 1
   0  0   ?   1   ?   : ?  :  0  ; // cp = 0, data = 0 so output = 0
   ?  1   1   1   ?   : ?  :  -  ; // no change in output
   ?  ?   ?   0   ?   : ?  :  1  ; // preset to 1
   ?  1   1   *   ?   : 1  :  1  ; 
   1  ?   1   *   ?   : 1  :  1  ;
   1  *   1   ?   ?   : 1  :  1  ;
   ?  ?   0   1   ?   : ?  :  0  ; // reset to 0
   ?  1   *   1   ?   : 0  :  0  ;
   0  ?   *   1   ?   : 0  :  0  ;
   0  *   ?   1   ?   : 0  :  0  ;
   ?  ?   ?   ?   *   : ?  :  x  ; // toggle notifier
endtable
endprimitive

primitive dti_udp_dlat11 (q, cp, d, rn, sn, notifier);


//dti_udp_dlat11 g2 (Q, CK, m, RN, 1'b0, SN, notifier);
output q;
reg q;
input d, cp, rn, sn, notifier;
table
// d  cp  rn  sn  n     state q
   1  0   1   ?   ?   : ?  :  1  ; // cp = 0, data = 1 so output = 1
   0  0   ?   1   ?   : ?  :  0  ; // cp = 0, data = 0 so output = 0
   ?  1   1   1   ?   : ?  :  -  ; // no change in output
   ?  ?   ?   0   ?   : ?  :  1  ; // preset to 1
   ?  1   1   *   ?   : 1  :  1  ;
   1  ?   1   *   ?   : 1  :  1  ;
   1  *   1   ?   ?   : 1  :  1  ;
   ?  ?   0   1   ?   : ?  :  0  ; // reset to 0
   ?  1   *   1   ?   : 0  :  0  ;
   0  ?   *   1   ?   : 0  :  0  ;
   0  *   ?   1   ?   : 0  :  0  ;
   ?  ?   ?   ?   *   : ?  :  x  ; // toggle notifier
endtable
endprimitive

primitive dti_udp_ffqa11 (q, d, ck, rn, sn, notifier);
output q;
input d, ck, rn, sn, notifier;
reg q;
table
//  d   ck  rn  sn  n   s   q
    ?   ?   ?   0   ? : ? : 1 ; // SN dominates RN Sn=0 Q=1
    ?   ?   0   1   ? : ? : 0 ; // RN=0 Q=0
    ?   ?   1   x   ? : 1 : 1 ; // Pessimism reduction
    ?   ?   x   1   ? : 0 : 0 ; // Pessimism reduction
    0   r   ?   1   ? : ? : 0 ; // rising edge of clk d=0 q=0 sn=1 
    1   r   1   ?   ? : ? : 1 ; // rising edge of clk d=1 q=1 rn=1
    0  (0x) ?   1   ? : 0 : - ; // maintain state 
    1  (0x) 1   ?   ? : 1 : - ; 
    0   0   ?   1   ? : 0 : - ; 
    1   0   1   ?   ? : 1 : - ; 
    ?   ? (?1)  1   ? : ? : - ;
    ?   ?   1 (?1)  ? : ? : - ;
    ? (1?)  1   1   ? : ? : - ; // ignore falling edge of clock
    *   ?   1   1   ? : ? : - ; 
    ?   0   1   1   ? : ? : - ; // ignore low-level clock
    ?   ?   ?   ?   * : ? : x ; // timing check violation
endtable
endprimitive

primitive dti_udp_muxd (z, a, b, sel);
output z;
input a, b, sel;

table
//      a       b       sel     :       z
        0       ?       0       :       0;
        1       ?       0       :       1;
        ?       0       1       :       0;
        ?       1       1       :       1;
        0       0       x       :       0;
        1       1       x       :       1;
endtable
endprimitive


module dti_and8  (Z, A, B, C, D, E, F, G, H, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C, D, E, F, G, H;

  and (Z, A, B, C, D, E, F, G, H);

endmodule


module dti_soffqbcka01fo  (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN;
supply1 CE;
supply1 SN;

input notifier;

dti_flop_asyn_soffa_top xdti_soffqbcka01fo (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_oa13  (Z, A, B1, B2, B3, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;
input  B3;

assign Z = A & ( B1 | B2 | B3 );

endmodule


module dti_leftedgeboundary  (VDD, VSS);
input VDD;
input VSS;
endmodule


module dti_soffqbck  (Q, SO, CK, D, SE, SD, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SE, SD;
supply1 CE;
supply1 RN;
supply1 SN;

input notifier;

dti_flop_syn_soff_top xdti_soffqbck (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);



endmodule


module dti_soffqbcka10  (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, SN;
supply1 CE;
supply1 RN;

input notifier;

dti_flop_asyn_soffa_top xdti_soffqbcka10 (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_sffnqbck  (Q, CKN, D, SD, SE, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CKN, D, SD, SE;
supply1 CE;
supply1 RN;
supply1 SN;

input notifier;

wire CK;
not(CK, CKN);

dti_flop_syn_sff_top xdti_sffnqbck (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_soffnqbcka01  (Q, SO, CKN, D, SD, SE, RN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CKN, D, SD, SE, RN;
supply1 CE;
supply1 SN;

input notifier;

wire CK;
not (CK, CKN);

dti_flop_asyn_soffa_top xdti_soffnqbcka01 (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_nor3  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

  nor (Z, A, B, C);

endmodule


module dti_ckinv  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

not (Z, A);

endmodule


module dti_and3  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

  and (Z, A, B, C);

endmodule


module dti_sffq  (Q, CK, D, SD, SE, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE;
supply1 CE;
supply1 RN;
supply1 SN;

input notifier;

dti_flop_syn_sff_top xdti_sffq (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_sffqbck  (Q, CK, D, SD, SE, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE;
supply1 CE;
supply1 RN;
supply1 SN;

input notifier;

dti_flop_syn_sff_top xdti_sffqbck (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_sffnq  (Q, CKN, D, SD, SE, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CKN, D, SD, SE;
supply1 CE;
supply1 RN;
supply1 SN;

input notifier;

wire CK;
not(CK, CKN);

dti_flop_syn_sff_top xdti_sffq (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_fadder  (CO, SUM, A, B, CI, VDD, VSS);
input VDD;
input VSS;
output CO;
output SUM;
input  A;
input  B;
input  CI;

 xor (SUM, A, B, CI);
 assign CO = A&B | B&CI | CI&A;

endmodule 


module dti_ao22  (Z, A1, A2, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A1;
input  A2;
input  B1;
input  B2;


assign Z = (A1 & A2) | (B1 & B2);

endmodule


module dti_nor3i1  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B;
input  C;

wire   AX;

not  (AX, A);
nor  (Z, AX, B, C);

endmodule


module dti_xnor2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

  xnor (Z, A, B);

endmodule


module dti_ffqa10  (Q, CK, D, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SN;
supply1 CE;
supply1 RN;

input notifier;

dti_flop_asyn_ff_top xdti_ffqa10 (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);


endmodule


module dti_nleftendcap  (VSS);
input VSS;
endmodule


module dti_ffqa01  (Q, CK, D, RN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, RN;
supply1 CE;
supply1 SN;

input notifier;

dti_flop_asyn_ff_top xdti_ffqa01 (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);


endmodule


module dti_oa12  (Z, A, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;

assign Z = A & ( B1 | B2 );

endmodule


module dti_nor2i1  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B;

wire   AX;

not  (AX, A);
nor  (Z, AX, B);

endmodule


module dti_ffnqbck  (Q, CKN, D, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CKN, D;
supply1 CE;
supply1 RN;
supply1 SN;

input notifier;

wire CK;
not (CK, CKN);

dti_flop_syn_ff_top xdti_ffnqbck (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);


endmodule


module dti_xnor3  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

  xnor (Z, A, B, C);

endmodule


module dti_filler  (VDD, VSS);
input VDD;
input VSS;
endmodule


module dti_or8  (Z, A, B, C, D, E, F, G, H, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C, D, E, F, G, H;

  or (Z, A, B, C, D, E, F, G, H);

endmodule


module dti_xor3  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

  xor (Z, A, B, C);

endmodule


module dti_or2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

  or (Z, A, B);

endmodule


module dti_gcklbuf  (CKOUT, CK, EN, notifier, VDD, VSS);
input VDD;
input VSS;
output CKOUT;
input  CK, EN;
input notifier;

wire   ENL;

dti_latch_top xdti_lq (ENL, CK, EN, notifier, VDD, VSS);
and(CKOUT, CK, ENL);

endmodule


module dti_ckmuxi21  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0, D1, S;

  dti_muxi21 xmuxi21 (Z, D0, D1, S, VDD, VSS);

endmodule


module dti_minbuf100  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

  buf (Z, A);

endmodule


module dti_ao13  (Z, A, B1, B2, B3, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;
input  B3;


assign Z = A | (B1 & B2 & B3);

endmodule


module dti_ckbuf  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

buf (Z, A);

endmodule


module dti_soffqbckena10  (Q, SO, CK, CE, D, SD, SE, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, CE, D, SD, SE, SN;
supply1 RN;

input notifier;

dti_flop_asyn_soffa_top xdti_soffqbckena10 (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_sffqa10  (Q, CK, D, SD, SE, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, SN;
supply1 CE;
supply1 RN;

input notifier;

dti_flop_asyn_sffa_top xdti_sffqa10 (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_ao112  (Z, A, B, C1, C2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B;
input  C1;
input  C2;

assign Z = A | B | (C1 & C2 );

endmodule


module dti_and2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

  and (Z, A, B);

endmodule


module dti_tierail  (HI, LO, VDD, VSS);
input VDD;
input VSS;
output HI;
output LO;

  buf (HI, 1'b1);
  buf (LO, 1'b0);
     
endmodule


module dti_mux41  (Z, D0, D1, D2, D3, S0, S1, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0;
input  D1;
input  D2;
input  D3;
input  S0;
input  S1;

wire   mux10;
wire   mux32;

assign mux10 = S0 ? D1 : D0;
assign mux32 = S0 ? D3 : D2;

assign Z = S1 ? mux32 : mux10;

endmodule


module dti_sffqa01  (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, RN;
supply1 CE;
supply1 SN;

input notifier;

dti_flop_asyn_sffa_top xdti_sffqa01 (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_sffnqa10  (Q, CKN, D, SD, SE, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CKN, D, SD, SE, SN;
supply1 CE;
supply1 RN;

input notifier;

wire CK;
not (CK, CKN);

dti_flop_asyn_sffa_top xdti_sffqa10 (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_sosaffqa10  (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, SN;
supply1 CE;
supply1 RN;
input notifier;

dti_flop_asyn_soffa_top xdti_sosaffqa10 (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_tap  (VDD, VSS);
input VSS;
input VDD;
endmodule


module dti_nand3i1  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B;
input  C;

wire   AX;

not  (AX, A);
nand (Z, AX, B, C);

endmodule


module dti_gckbuf  (CKOUT, CK, EN, VDD, VSS);
input VDD;
input VSS;
output CKOUT;
input  CK;
input  EN;

and (CKOUT, CK, EN);

endmodule


module dti_ckxor2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

  xor (Z, A, B);

endmodule


module dti_ao12  (Z, A, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;

assign Z = A | (B1 & B2);

endmodule


module dti_ssaffqen  (Q, CK, D, CE, SE, SD, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, CE, SE, SD;
supply1 RN;
supply1 SN;
input notifier;

dti_flop_asyn_sff_top xdti_ssaffqen (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);

endmodule


module dti_soffqbckena01  (Q, SO, CK, CE, D, SD, SE, RN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, CE, D, SD, SE, RN;
supply1 SN;

input notifier;

dti_flop_asyn_soffa_top xdti_soffqbckena01 (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_tiehi  (HI, VDD, VSS);
input VDD;
input VSS;
output HI;

buf (HI, 1'b1);
//specify
//
//endspecify

endmodule


module dti_or3  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

  or (Z, A, B, C);

endmodule


module dti_faddero  (CON, SUM, A, B, CI, VDD, VSS);
input VDD;
input VSS;
output CON;
output SUM;
input  A;
input  B;
input  CI;

 xor (SUM, A, B, CI);
 assign CON = ~(A&B | B&CI | CI&A);

endmodule 


module dti_xor2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

  xor (Z, A, B);

endmodule


module dti_faddere  (CO, SUM, A, B, CIN, VDD, VSS);
input VDD;
input VSS;
output CO;
output SUM;
input  A;
input  B;
input  CIN;

 wire CI;
 not (CI, CIN);
 xor (SUM, A, B, CI);
 assign CO = A&B | B&CI | CI&A;

endmodule 


module dti_soffqa10  (Q, SO, CK, D, SD, SE, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, SN;
supply1 CE;
supply1 RN;

input notifier;

dti_flop_asyn_soffa_top xdti_soffqa10 (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_ckinvmdly  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

not (Z, A);

endmodule


module dti_nand3  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C;

  nand (Z, A, B, C);

endmodule


module dti_or4  (Z, A, B, C, D, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C, D;

  or (Z, A, B, C, D);

endmodule


module dti_ckmuxihs21  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0, D1, S;

  dti_muxihs21 xmuxihs21 (Z, D0, D1, S, VDD, VSS);

endmodule


module dti_mux21  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0;
input  D1;
input  S;

assign Z = S ? D1 : D0;
endmodule


module dti_ffq  (Q, CK, D, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D;
supply1 CE;
supply1 RN;
supply1 SN;

input notifier;

dti_flop_syn_ff_top xdti_ffq (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);


endmodule


module dti_saffqa01  (Q, CK, D, RN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, RN;
supply1 CE;
supply1 SN;
input notifier;

dti_flop_asyn_ff_top xdti_saffqa01 (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);

endmodule


module dti_rightedgeboundary  (VDD, VSS);
input VDD;
input VSS;
endmodule


module dti_aoi22  (Z, A1, A2, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A1;
input  A2;
input  B1;
input  B2;

assign Z = !((A1 & A2) | (B1 & B2)) ;

endmodule


module dti_ssaffqa01  (Q, CK, D, SD, SE, RN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, RN;
supply1 CE;
supply1 SN;
wire Q_FLOP;
input notifier;

dti_flop_asyn_sffa_top xdti_ssaffqa01 (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);

endmodule


module dti_aoi12  (Z, A, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;


assign Z = !(A | (B1 & B2)) ;

endmodule


module dti_inv  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

  not (Z, A);

endmodule


module dti_nor2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

  nor (Z, A, B);

endmodule


module dti_nor3i2  (Z, A, B, C, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B;
input  C;

wire   AX, BX;

not  (AX, A);
not  (BX, B);
nor  (Z, AX, BX, C);

endmodule


module dti_nand2i1  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
wire AX;
input  A, B;
  not (AX, A);
  nand (Z, AX, B);

endmodule


module dti_gcklbufs  (CKOUT, CK, EN, SE, notifier, VDD, VSS);
input VDD;
input VSS;
output CKOUT;
input  CK, EN, SE;
input notifier;

wire   ENL;
wire   SE_or_EN;

or(SE_or_EN, SE, EN);
dti_latch_top xdti_lq (ENL, CK, SE_or_EN, notifier, VDD, VSS);
and(CKOUT, CK, ENL);

endmodule


module dti_nendcap  (VSS);
input VSS;
endmodule


module dti_ffqbck  (Q, CK, D, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D;
supply1 CE;
supply1 RN;
supply1 SN;

input notifier;

dti_flop_syn_ff_top xdti_ffqbck (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);


endmodule


module dti_llq  (Q, CPN, D, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CPN, D;
wire CPN;
wire D;

input notifier;

wire CP;
not (CP, CPN);
dti_latch_top xdti_llq (Q, CP, D, notifier, VDD, VSS);


endmodule


module dti_eco_dcap  (VDD, VSS);
input VDD;
input VSS;
endmodule


module dti_oai12  (Z, A, B1, B2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;
input  B1;
input  B2;

assign Z = !(A  &  (B1 | B2) );

endmodule


module dti_and6  (Z, A, B, C, D, E, F, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C, D, E, F;

  and (Z, A, B, C, D, E, F);

endmodule


module dti_nrightendcap  (VSS);
input VSS;
endmodule


module dti_tielo  (LO, VDD, VSS);
input VDD;
input VSS;
output LO;

buf (LO, 1'b0);
//specify
//
//endspecify

endmodule


module dti_lq  (Q, CP, D, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CP, D;
wire CP;
wire D;

input notifier;

dti_latch_top xdti_lq (Q, CP, D, notifier, VDD, VSS);


endmodule


module dti_soffqbcka01  (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN;
supply1 CE;
supply1 SN;

input notifier;

dti_flop_asyn_soffa_top xdti_soffqbcka01 (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_ckmux21  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0, D1, S;
 
  dti_mux21 xmux21 (Z, D0, D1, S, VDD, VSS);
 
endmodule  


module dti_ffnqa10  (Q, CKN, D, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CKN, D, SN;
supply1 CE;
supply1 RN;

input notifier;

wire CK;
not(CK, CKN);

dti_flop_asyn_ff_top xdti_ffqa10 (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);


endmodule


module dti_and2hp  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

  and (Z, A, B);

endmodule


module dti_ssaffqa10  (Q, CK, D, SD, SE, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SD, SE, SN;
supply1 CE;
supply1 RN;
input notifier;

dti_flop_asyn_sffa_top xdti_ssaffqa10 (Q, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);

endmodule


module dti_soffqbcka11  (Q, SO, CK, D, SD, SE, RN, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN, SN;
supply1 CE;

input notifier;

dti_flop_asyn_soffa_top xdti_soffqbcka11 (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);


endmodule


module dti_ao222  (Z, A1, A2, B1, B2, C1, C2, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A1;
input  A2;
input  B1;
input  B2;
input  C1;
input  C2;


assign Z = (A1 & A2) | (B1 & B2) | (C1 & C2);

endmodule


module dti_ffnq  (Q, CKN, D, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CKN, D;
supply1 CE;
supply1 RN;
supply1 SN;

input notifier;

wire CK;
not (CK, CKN);

dti_flop_syn_ff_top xdti_ffq (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);


endmodule


module dti_clktc  (Z, ZX, A, VDD, VSS);
input VDD;
input VSS;
output Z, ZX;
input  A;

  not (ZX, A);
  buf (Z, A);

endmodule


module dti_pendcap  (VDD);
input VDD;
endmodule


module dti_pleftendcap  (VDD);
input VDD;
endmodule


module dti_dcap  (VDD, VSS);
input VDD;
input VSS;
endmodule


module dti_muxi21  (Z, D0, D1, S, VDD, VSS);
input VDD;
input VSS;
output Z;
input  D0;
input  D1;
input  S;

assign Z = S ? ~D1 : ~D0;

endmodule


module dti_sosaffqa01  (Q, SO, CK, D, SD, SE, RN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
output SO;
input  CK, D, SD, SE, RN;
supply1 CE;
supply1 SN;
input notifier;

dti_flop_asyn_soffa_top xdti_sosaffqa01 (Q, SO, CK, CE, D, SD, SE, RN, SN, notifier, VDD, VSS);

endmodule


module dti_saffqa10  (Q, CK, D, SN, notifier, VDD, VSS);
input VDD;
input VSS;
output Q;
input  CK, D, SN;
supply1 CE;
supply1 RN;
input notifier;

dti_flop_asyn_ff_top xdti_saffqa10 (Q, CK, CE, D, RN, SN, notifier, VDD, VSS);

endmodule


module dti_hadder  (CO, SUM, A, B, VDD, VSS);
input VDD;
input VSS;
output CO;
output SUM;
input  A;
input  B;

 xor (SUM, A, B);
 and (CO,  A, B); 

endmodule 


module dti_nand2  (Z, A, B, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B;

  nand (Z, A, B);

endmodule


module dti_buf  (Z, A, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A;

  buf (Z, A);

endmodule


module dti_prightendcap  (VDD);
input VDD;
endmodule


module dti_and4  (Z, A, B, C, D, VDD, VSS);
input VDD;
input VSS;
output Z;
input  A, B, C, D;

  and (Z, A, B, C, D);

endmodule


