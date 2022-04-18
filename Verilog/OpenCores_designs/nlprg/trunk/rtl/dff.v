module dff
(
   input d,
   input ck,
   input rst,
   output q

);
    reg state;

    assign q = state;

    always @ (posedge ck or posedge rst )
    begin
        if (rst)
            state <= 'h0;
        else
            state <= d;
    end

endmodule

