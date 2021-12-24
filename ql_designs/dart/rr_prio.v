`timescale 1ns / 1ps
/* Round-Robin Priority Encoder
 *
 * The bit selection logic is hard coded and works when prio is one-hot.
 * The module that instantiates rr_prio must guarantee this condition.
 */
module rr_prio #(
    parameter N = 4
)
(
    input   [N-1:0] ready,
    input   [N-1:0] prio,
    output  [N-1:0] select
);

    // psl ERROR_unsupported_rr_prio_size: assert always {N == 2 || N == 4};

    generate
        if (N == 2)
        begin
            assign select[0] = (prio[0] | (prio[1] & ~ready[0])) & ready[0];
            assign select[1] = ((prio[0] & ~ready[1]) | prio[1]) & ready[1];
        end
        else if (N == 4)
        begin
    
            assign select[0] = ( prio[0] |
                                (prio[1] & ~ready[1] & ~ready[2] & ~ready[3]) |
                                (prio[2] & ~ready[2] & ~ready[3]) |
                                (prio[3] & ~ready[3])
                               ) & ready[0];
                           
            assign select[1] = ((prio[0] & ~ready[0]) |
                                 prio[1] |
                                (prio[2] & ~ready[2] & ~ready[3] & ~ready[0]) |
                                (prio[3] & ~ready[3] & ~ready[0])
                               ) & ready[1];

            assign select[2] = ((prio[0] & ~ready[0] & ~ready[1]) |
                                (prio[1] & ~ready[1]) |
                                 prio[2] |
                                (prio[3] & ~ready[3] & ~ready[0] & ~ready[1])
                               ) & ready[2];

            assign select[3] = ((prio[0] & ~ready[0] & ~ready[1] & ~ready[2]) |
                                (prio[1] & ~ready[1] & ~ready[2]) |
                                (prio[2] & ~ready[2]) |
                                 prio[3]
                               ) & ready[3];
        end
        else
            assign select = 0;
    endgenerate
endmodule

