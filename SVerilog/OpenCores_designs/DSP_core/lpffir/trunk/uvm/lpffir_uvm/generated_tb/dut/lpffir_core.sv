module lpffir_core (
                    input               clk_i,
                    input               rstn_i,
                    input               en_i,
                    input [15:0]        x_i,
                    output logic [15:0] y_o
                    );

   reg [15:0]                           x1;
   reg [15:0]                           x2;
   reg [15:0]                           x3;
   reg [15:0]                           x4;
   reg [15:0]                           x5;

   logic [15:0]                         h0;
   logic [15:0]                         h1;
   logic [15:0]                         h2;
   logic [15:0]                         h01;

   logic                                co0;
   logic                                co1;
   logic                                co2;
   logic                                co3;
   logic                                co4;

   // Linear-phase FIR structure
  rca rca_inst0 (.a(x_i),.b(x5),.ci(1'b0),.co(co0),.s(h0));
  rca rca_inst1 (.a(x1),.b(x4),.ci(1'b0),.co(co1),.s(h1));
  rca rca_inst2 (.a(x2),.b(x3),.ci(1'b0),.co(co2),.s(h2));
  rca rca_inst3 (.a(h0),.b(h1),.ci(1'b0),.co(co3),.s(h01));
  rca rca_inst4 (.a(h01),.b(h2),.ci(1'b0),.co(co4),.s(y_o));

   always_ff @(posedge clk_i or posedge rstn_i)
     if(!rstn_i)
       begin
          x1 <= 0;
          x2 <= 0;
          x3 <= 0;
          x4 <= 0;
          x5 <= 0;
       end
     else if (en_i)
       begin
          x1 <= x_i;
          x2 <= x1;
          x3 <= x2;
          x4 <= x3;
          x5 <= x4;
       end

endmodule