module d_ff
        #(
          parameter DATA_WIDTH = 28
        )
        (input wire clk,
        input wire reset,
        input wire [DATA_WIDTH-1:0] D,
        output reg [DATA_WIDTH-1:0]   Q
        );
    
    always@ (posedge clk or posedge reset) begin
        if (reset)
          Q <= 0;
        else
          Q <= D;
    end
    
endmodule
