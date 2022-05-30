module FD (Q, C, D);

    parameter INIT = 1'b0;

    output Q;

    input  C, D;

    wire Q;
    reg q_out;







    always @(posedge C)
	        q_out <=  D;

    assign Q = q_out;

    specify
        (posedge C => (Q +: D)) = (100, 100);
    endspecify

endmodule 
