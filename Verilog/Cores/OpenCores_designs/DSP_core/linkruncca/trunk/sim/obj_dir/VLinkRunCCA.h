// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _VLinkRunCCA_H_
#define _VLinkRunCCA_H_

#include "verilated.h"
#include "VLinkRunCCA__Inlines.h"
class VLinkRunCCA__Syms;

//----------

VL_MODULE(VLinkRunCCA) {
  public:
    // CELLS
    // Public to allow access to /*verilator_public*/ items;
    // otherwise the application code can consider these internals.
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(clk,0,0);
    VL_IN8(rst,0,0);
    VL_IN8(datavalid,0,0);
    VL_IN8(pix_in,0,0);
    VL_OUT8(datavalid_out,0,0);
    //char	__VpadToAlign5[3];
    VL_OUT64(box_out,35,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    VL_SIG8(v__DOT__n_waddr,7,0);
    VL_SIG8(v__DOT__n_wdata,7,0);
    VL_SIG8(v__DOT__n_rdata,7,0);
    VL_SIG8(v__DOT__h_waddr,7,0);
    VL_SIG8(v__DOT__h_wdata,7,0);
    VL_SIG8(v__DOT__h_rdata,7,0);
    VL_SIG8(v__DOT__t_waddr,7,0);
    VL_SIG8(v__DOT__t_wdata,7,0);
    VL_SIG8(v__DOT__t_raddr,7,0);
    VL_SIG8(v__DOT__t_rdata,7,0);
    VL_SIG8(v__DOT__d_waddr,7,0);
    VL_SIG8(v__DOT__n_we,0,0);
    VL_SIG8(v__DOT__h_we,0,0);
    VL_SIG8(v__DOT__t_we,0,0);
    VL_SIG8(v__DOT__d_we,0,0);
    VL_SIG8(v__DOT__A,0,0);
    VL_SIG8(v__DOT__B,0,0);
    VL_SIG8(v__DOT__C,0,0);
    VL_SIG8(v__DOT__D,0,0);
    VL_SIG8(v__DOT__fp,0,0);
    VL_SIG8(v__DOT__fn,0,0);
    VL_SIG8(v__DOT__O,0,0);
    VL_SIG8(v__DOT__HCN,0,0);
    VL_SIG8(v__DOT__DMG,0,0);
    VL_SIG8(v__DOT__EOC,0,0);
    VL_SIG8(v__DOT__p,7,0);
    VL_SIG8(v__DOT__hp,7,0);
    VL_SIG8(v__DOT__tp,7,0);
    VL_SIG8(v__DOT__np,7,0);
    VL_SIG8(v__DOT__left,0,0);
    VL_SIG8(v__DOT__Next_Table__DOT__read_addr_reg,7,0);
    VL_SIG8(v__DOT__Head_Table__DOT__read_addr_reg,7,0);
    VL_SIG8(v__DOT__Tail_Table__DOT__read_addr_reg,7,0);
    VL_SIG8(v__DOT__Data_Table__DOT__read_addr_reg,7,0);
    VL_SIG8(v__DOT__HF__DOT__top,0,0);
    VL_SIG8(v__DOT__HF__DOT__x,0,0);
    VL_SIG8(v__DOT__HF__DOT__right,0,0);
    VL_SIG8(v__DOT__TR__DOT__Rtp,7,0);
    VL_SIG8(v__DOT__TR__DOT__pc,7,0);
    VL_SIG8(v__DOT__ES__DOT__cc,7,0);
    VL_SIG8(v__DOT__ES__DOT__h,7,0);
    VL_SIG8(v__DOT__ES__DOT__f,0,0);
    VL_SIG8(v__DOT__ES__DOT__HBF,0,0);
    VL_SIG8(v__DOT__ES__DOT__Ec,0,0);
    VL_SIG16(v__DOT__FA__DOT__x,8,0);
    VL_SIG16(v__DOT__FA__DOT__y,8,0);
    VL_SIG16(v__DOT__FA__DOT__minx1,8,0);
    VL_SIG16(v__DOT__FA__DOT__maxx1,8,0);
    VL_SIG16(v__DOT__FA__DOT__miny1,8,0);
    VL_SIG16(v__DOT__FA__DOT__maxy1,8,0);
    //char	__VpadToAlign76[4];
    VL_SIGW(v__DOT__RBHF__DOT__R,509,0,16);
    VL_SIGW(v__DOT__RB__DOT__R,509,0,16);
    VL_SIG64(v__DOT__d_rdata,35,0);
    VL_SIG64(v__DOT__d_wdata,35,0);
    VL_SIG64(v__DOT__d,35,0);
    VL_SIG64(v__DOT__dp,35,0);
    VL_SIG64(v__DOT__TR__DOT__Rdp,35,0);
    VL_SIG8(v__DOT__Next_Table__DOT__ram[256],7,0);
    VL_SIG8(v__DOT__Head_Table__DOT__ram[256],7,0);
    VL_SIG8(v__DOT__Tail_Table__DOT__ram[256],7,0);
    VL_SIG64(v__DOT__Data_Table__DOT__ram[256],35,0);
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    VL_SIG8(__Vdly__v__DOT__B,0,0);
    VL_SIG8(__Vclklast__TOP__clk,0,0);
    VL_SIG8(__Vclklast__TOP__rst,0,0);
    //char	__VpadToAlign3071[1];
    VL_SIGW(__Vdly__v__DOT__RB__DOT__R,509,0,16);
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    //char	__VpadToAlign3140[4];
    VLinkRunCCA__Syms*	__VlSymsp;		// Symbol table
    
    // PARAMETERS
    // Parameters marked /*verilator public*/ for use by application code
    
    // CONSTRUCTORS
  private:
    VLinkRunCCA& operator= (const VLinkRunCCA&);	///< Copying not allowed
    VLinkRunCCA(const VLinkRunCCA&);	///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible WRT DPI scope names.
    VLinkRunCCA(const char* name="TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~VLinkRunCCA();
    
    // USER METHODS
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval();
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(VLinkRunCCA__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(VLinkRunCCA__Syms* symsp, bool first);
  private:
    static IData	_change_request(VLinkRunCCA__Syms* __restrict vlSymsp);
  public:
    static void	_eval(VLinkRunCCA__Syms* __restrict vlSymsp);
    static void	_eval_initial(VLinkRunCCA__Syms* __restrict vlSymsp);
    static void	_eval_settle(VLinkRunCCA__Syms* __restrict vlSymsp);
    static void	_sequent__TOP__1(VLinkRunCCA__Syms* __restrict vlSymsp);
    static void	_sequent__TOP__2(VLinkRunCCA__Syms* __restrict vlSymsp);
    static void	_sequent__TOP__4(VLinkRunCCA__Syms* __restrict vlSymsp);
    static void	_sequent__TOP__5(VLinkRunCCA__Syms* __restrict vlSymsp);
    static void	_sequent__TOP__7(VLinkRunCCA__Syms* __restrict vlSymsp);
    static void	_sequent__TOP__9(VLinkRunCCA__Syms* __restrict vlSymsp);
    static void	_settle__TOP__3(VLinkRunCCA__Syms* __restrict vlSymsp);
    static void	_settle__TOP__6(VLinkRunCCA__Syms* __restrict vlSymsp);
    static void	_settle__TOP__8(VLinkRunCCA__Syms* __restrict vlSymsp);
} VL_ATTR_ALIGNED(64);

#endif  /*guard*/
