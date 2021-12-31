`timescale 1ns/100 ps   // time unit = 1ns; precision = 1/10 ns
/* Router
 * Router.v
 *
 * Single N-port Router. NPORTS x NVCS input ports, 1 output port
 *
 * Configuration path:
 *      config_in -> CreditCounter_0 -> ... -> CreditCounter_N (N = nports * nvc) -> config_out
 *      ram_config_in -> Input RouterPortLookup -> Output RouterPortLookup -> ram_config_out
 */
`include "const.v"
module InputVCState #(
    parameter VC_WIDTH = 1,
              NINPUTS = 10
)
(
    input                   clock,
    input                   reset,
    input   [VC_WIDTH-1:0]  allocated_vc,
    input                   allocate_enable,
    input   [NINPUTS-1:0]   ivc_sel,
    output  [VC_WIDTH-1:0]  assigned_vc
);
    `include "math.v"
    localparam LOG_NINPUTS = CLogB2(NINPUTS-1);
    
    // Assigned output VC for each input VC
    reg     [VC_WIDTH*NINPUTS-1:0]  assigned_ovc;
    
    genvar i;
    generate
        for (i = 0; i < NINPUTS; i = i + 1)
        begin : ivc
        
            always @(posedge clock)
            begin
                if (reset)
                begin
                    assigned_ovc[(i+1)*VC_WIDTH-1:i*VC_WIDTH] <= 0;
                end
                else if (allocate_enable & ivc_sel[i])
                begin
                    assigned_ovc[(i+1)*VC_WIDTH-1:i*VC_WIDTH] <= allocated_vc;
                end
            end
        end
    endgenerate
    
    // Select the output VC
    mux_Nto1_decoded #(.WIDTH(VC_WIDTH), .SIZE(NINPUTS)) vc_mux (
        .in (assigned_ovc),
        .sel (ivc_sel),
        .out (assigned_vc));
    
endmodule

