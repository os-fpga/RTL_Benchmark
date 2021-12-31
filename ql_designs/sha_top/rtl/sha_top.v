module sha_top(clk_i, rst_i, text_i, text_o, cmd_i, cmd_w_i, cmd_o);
        input           clk_i;  // global clock input
        input           rst_i;  // global reset input , active high
        
        input   [31:0]  text_i; // text input 32bit
        output  [31:0]  text_o; // text output 32bit
        
        input   [3:0]   cmd_i;  // command input
        input           cmd_w_i;// command input write enable
        output  [4:0]   cmd_o;  // command output(status)

wire [31:0]text_I0;
wire [31:0]text_I1;
wire [31:0]text_I2;
wire [4:0]cmd_I0;
wire [4:0]cmd_I1;
wire [4:0]cmd_I2;

sha512 I0 (.clk_i(clk_i),.rst_i(rst_i),.text_i(text_i),.text_o(text_I0),.cmd_i(cmd_i), .cmd_w_i(cmd_w_i) ,.cmd_o(cmd_I0));
sha512 I1 (.clk_i(clk_i),.rst_i(rst_i),.text_i(text_I0),.text_o(text_I1),.cmd_i(cmd_I0[3:0]), .cmd_w_i(cmd_w_i), .cmd_o(cmd_I1));
sha512 I2 (.clk_i(clk_i),.rst_i(rst_i),.text_i(text_I1),.text_o(text_I2),.cmd_i(cmd_I1[3:0]), .cmd_w_i(cmd_w_i), .cmd_o(cmd_I2));
sha512 I3 (.clk_i(clk_i),.rst_i(rst_i),.text_i(text_I2),.text_o(text_o),.cmd_i(cmd_I2[3:0]), .cmd_w_i(cmd_w_i), .cmd_o(cmd_o));


//pragma attribute I0 resource_sharing false
//pragma attribute I1 resource_sharing false
//pragma attribute I2 resource_sharing false
//pragma attribute I3 resource_sharing false
endmodule
