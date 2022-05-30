`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2017 06:20:37 PM
// Design Name: 
// Module Name: simulate
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module simulate(

    );
    
    wire rst;
    reg _rst = 0;
    wire [7:0]data;
    reg [7:0]_datasend;
    reg [7:0]_datarec; 
    wire wr;
    reg _wr = 0;
    wire rd;
    reg _rd = 0;
    wire buffempty;
    wire sck;
    wire mosi;
    reg miso = 0;
    wire ss;
    wire senderr;
    reg res_senderr = 0;
    wire charreceived;
    
    
    wire busy;
    reg [2:0]clk = 3'b000;
    
    reg clk_in = 0;
    reg clk_out = 0;
    parameter tck = 2; ///< clock tick
    
    always #(tck/2) clk_in <= ~clk_in; // clocking device
    
    spi_master # (
    .WORD_LEN(8),/* Default 8 */
    .PRESCALLER_SIZE(8)/* Default 8 / Max 8*/
    )
    spi0 (
            .clk(clk[2]),
            .rst(rst),
            .data(data),
            .wr(wr),
            .rd(rd),
            .buffempty(buffempty),
            .prescaller(3'h0),
            .sck(sck),
            .mosi(mosi),
            .miso(miso),
            .ss(ss),
            .lsbfirst(1'b0),
            .mode(2'h1),
            .senderr(senderr),
            .res_senderr(res_senderr),
            .charreceived(charreceived)
    );
    
    
    initial begin
        _rst <= 1;
        #2;
         _rst <= 0;
        #2;
         miso <= 1'b1;
         /* Send first char */
        _datasend <= 8'h55;
        /* Wait half core clock for propagation*/
        #1;
        _wr <= 1'b1;
        #1;
        _wr <= 1'b0;
        #1;
        /* Wait until send buffer is transfered to shift register */
         wait(buffempty == 1'b1);
         /* Let 'miso' unchanged because first char has been transfered to shift reg, the second will be writed to send buffer */
         //miso <= 1'b1;
         /* Send second char */
        _datasend <= 8'hAA;
        /* Wait half core clock for propagation*/
        #1;
        _wr <= 1'b1;
        #1;
        _wr <= 1'b0;
        /* Wait some cicles */
        #10;
        /* Send another char with buffer full to see the returned 'senderr' */
        _datasend <= 8'h55;
        _wr <= 1'b1;
        #1;
        _wr <= 1'b0;
        /*If 'senderr' is asserted, reset it*/
        if(senderr)
        begin
            res_senderr <= 1'b1;
            #1;
            res_senderr <= 1'b0;
        end
        /* Wait until send buffer is transfered to shift register and send the third byte */
        /* Wait half 'clk_in' for internal timming */
        #1;
        /* Wait until first char has been received*/
        wait(charreceived == 1'b1);
        /* Put 'data' to tri state */
        _datasend = 8'bz;
        /* Wait half core clock */
        #1;
        /* Assert 'rd' */
        _rd = 1'b1;
        /* Wait half core clock for propagation */
        #1;
        /* Read data into '_datarec' register */
        _datarec = data;
        _rd = 1'b0;
        #1;
        /* Wait until interface is ready to rake the third character */
        wait(buffempty == 1'b1);
        /* Wait half 'clk_in' for internal timming */
        #1;
        /* If the buffer send register become empty */
        /* Send second char */
        miso <= 1'b0;
        _datasend <= 8'h55;
        #1;
        _wr <= 1'b1;
        #1;
        _wr <= 1'b0;
        #1;
        /* Wait until second char has been received*/
        wait(charreceived == 1'b1);
        /* Put 'data' to tri state */
        _datasend = 8'bz;
        /* Wait half core clock */
        #1;
        /* Assert 'rd' */
        _rd = 1'b1;
        /* Wait half core clock for propagation */
        #1;
        /* Read data into '_datarec' register */
        _datarec = data;
        _rd = 1'b0;
        miso <= 1'b1;
        /* Wait until second char has been received*/
        wait(charreceived == 1'b1);
        /* Put 'data' to tri state */
        _datasend = 8'bz;
        /* Wait half core clock */
        #1;
        /* Assert 'rd' */
        _rd = 1'b1;
        /* Wait half core clock for propagation */
        #1;
        /* Read data into '_datarec' register */
        _datarec = data;
        _rd = 1'b0;
        #10;
        $finish;
    end
    
    assign rst = _rst;
    assign wr = _wr;
    assign rd = _rd;
    assign data = _datasend;

always @ (posedge clk_in)
begin
    clk <= clk + 1;
end
endmodule
