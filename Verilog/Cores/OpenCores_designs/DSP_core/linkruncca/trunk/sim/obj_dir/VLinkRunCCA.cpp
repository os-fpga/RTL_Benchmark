// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VLinkRunCCA.h for the primary calling header

#include "VLinkRunCCA.h"       // For This
#include "VLinkRunCCA__Syms.h"

//--------------------
// STATIC VARIABLES


//--------------------

VL_CTOR_IMP(VLinkRunCCA) {
    VLinkRunCCA__Syms* __restrict vlSymsp = __VlSymsp = new VLinkRunCCA__Syms(this, name());
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    clk = VL_RAND_RESET_I(1);
    rst = VL_RAND_RESET_I(1);
    datavalid = VL_RAND_RESET_I(1);
    pix_in = VL_RAND_RESET_I(1);
    datavalid_out = VL_RAND_RESET_I(1);
    box_out = VL_RAND_RESET_Q(36);
    v__DOT__n_waddr = VL_RAND_RESET_I(8);
    v__DOT__n_wdata = VL_RAND_RESET_I(8);
    v__DOT__n_rdata = VL_RAND_RESET_I(8);
    v__DOT__h_waddr = VL_RAND_RESET_I(8);
    v__DOT__h_wdata = VL_RAND_RESET_I(8);
    v__DOT__h_rdata = VL_RAND_RESET_I(8);
    v__DOT__t_waddr = VL_RAND_RESET_I(8);
    v__DOT__t_wdata = VL_RAND_RESET_I(8);
    v__DOT__t_raddr = VL_RAND_RESET_I(8);
    v__DOT__t_rdata = VL_RAND_RESET_I(8);
    v__DOT__d_waddr = VL_RAND_RESET_I(8);
    v__DOT__d_rdata = VL_RAND_RESET_Q(36);
    v__DOT__d_wdata = VL_RAND_RESET_Q(36);
    v__DOT__n_we = VL_RAND_RESET_I(1);
    v__DOT__h_we = VL_RAND_RESET_I(1);
    v__DOT__t_we = VL_RAND_RESET_I(1);
    v__DOT__d_we = VL_RAND_RESET_I(1);
    v__DOT__A = VL_RAND_RESET_I(1);
    v__DOT__B = VL_RAND_RESET_I(1);
    v__DOT__C = VL_RAND_RESET_I(1);
    v__DOT__D = VL_RAND_RESET_I(1);
    v__DOT__fp = VL_RAND_RESET_I(1);
    v__DOT__fn = VL_RAND_RESET_I(1);
    v__DOT__O = VL_RAND_RESET_I(1);
    v__DOT__HCN = VL_RAND_RESET_I(1);
    v__DOT__DMG = VL_RAND_RESET_I(1);
    v__DOT__EOC = VL_RAND_RESET_I(1);
    v__DOT__p = VL_RAND_RESET_I(8);
    v__DOT__hp = VL_RAND_RESET_I(8);
    v__DOT__tp = VL_RAND_RESET_I(8);
    v__DOT__np = VL_RAND_RESET_I(8);
    v__DOT__d = VL_RAND_RESET_Q(36);
    v__DOT__dp = VL_RAND_RESET_Q(36);
    v__DOT__left = VL_RAND_RESET_I(1);
    { int __Vi0=0; for (; __Vi0<256; ++__Vi0) {
	    v__DOT__Next_Table__DOT__ram[__Vi0] = VL_RAND_RESET_I(8);
    }}
    v__DOT__Next_Table__DOT__read_addr_reg = VL_RAND_RESET_I(8);
    { int __Vi0=0; for (; __Vi0<256; ++__Vi0) {
	    v__DOT__Head_Table__DOT__ram[__Vi0] = VL_RAND_RESET_I(8);
    }}
    v__DOT__Head_Table__DOT__read_addr_reg = VL_RAND_RESET_I(8);
    { int __Vi0=0; for (; __Vi0<256; ++__Vi0) {
	    v__DOT__Tail_Table__DOT__ram[__Vi0] = VL_RAND_RESET_I(8);
    }}
    v__DOT__Tail_Table__DOT__read_addr_reg = VL_RAND_RESET_I(8);
    { int __Vi0=0; for (; __Vi0<256; ++__Vi0) {
	    v__DOT__Data_Table__DOT__ram[__Vi0] = VL_RAND_RESET_Q(36);
    }}
    v__DOT__Data_Table__DOT__read_addr_reg = VL_RAND_RESET_I(8);
    v__DOT__HF__DOT__top = VL_RAND_RESET_I(1);
    v__DOT__HF__DOT__x = VL_RAND_RESET_I(1);
    v__DOT__HF__DOT__right = VL_RAND_RESET_I(1);
    VL_RAND_RESET_W(510,v__DOT__RBHF__DOT__R);
    VL_RAND_RESET_W(510,v__DOT__RB__DOT__R);
    v__DOT__TR__DOT__Rtp = VL_RAND_RESET_I(8);
    v__DOT__TR__DOT__Rdp = VL_RAND_RESET_Q(36);
    v__DOT__TR__DOT__pc = VL_RAND_RESET_I(8);
    v__DOT__ES__DOT__cc = VL_RAND_RESET_I(8);
    v__DOT__ES__DOT__h = VL_RAND_RESET_I(8);
    v__DOT__ES__DOT__f = VL_RAND_RESET_I(1);
    v__DOT__ES__DOT__HBF = VL_RAND_RESET_I(1);
    v__DOT__ES__DOT__Ec = VL_RAND_RESET_I(1);
    v__DOT__FA__DOT__x = VL_RAND_RESET_I(9);
    v__DOT__FA__DOT__y = VL_RAND_RESET_I(9);
    v__DOT__FA__DOT__minx1 = VL_RAND_RESET_I(9);
    v__DOT__FA__DOT__maxx1 = VL_RAND_RESET_I(9);
    v__DOT__FA__DOT__miny1 = VL_RAND_RESET_I(9);
    v__DOT__FA__DOT__maxy1 = VL_RAND_RESET_I(9);
    __Vdly__v__DOT__B = VL_RAND_RESET_I(1);
    VL_RAND_RESET_W(510,__Vdly__v__DOT__RB__DOT__R);
    __Vclklast__TOP__clk = VL_RAND_RESET_I(1);
    __Vclklast__TOP__rst = VL_RAND_RESET_I(1);
}

void VLinkRunCCA::__Vconfigure(VLinkRunCCA__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

VLinkRunCCA::~VLinkRunCCA() {
    delete __VlSymsp; __VlSymsp=NULL;
}

//--------------------


void VLinkRunCCA::eval() {
    VLinkRunCCA__Syms* __restrict vlSymsp = this->__VlSymsp; // Setup global symbol table
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    VL_DEBUG_IF(VL_PRINTF("\n----TOP Evaluate VLinkRunCCA::eval\n"); );
    int __VclockLoop = 0;
    IData __Vchange=1;
    while (VL_LIKELY(__Vchange)) {
	VL_DEBUG_IF(VL_PRINTF(" Clock loop\n"););
	vlSymsp->__Vm_activity = true;
	_eval(vlSymsp);
	__Vchange = _change_request(vlSymsp);
	if (++__VclockLoop > 100) vl_fatal(__FILE__,__LINE__,__FILE__,"Verilated model didn't converge");
    }
}

void VLinkRunCCA::_eval_initial_loop(VLinkRunCCA__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    vlSymsp->__Vm_activity = true;
    int __VclockLoop = 0;
    IData __Vchange=1;
    while (VL_LIKELY(__Vchange)) {
	_eval_settle(vlSymsp);
	_eval(vlSymsp);
	__Vchange = _change_request(vlSymsp);
	if (++__VclockLoop > 100) vl_fatal(__FILE__,__LINE__,__FILE__,"Verilated model didn't DC converge");
    }
}

//--------------------
// Internal Methods

void VLinkRunCCA::_sequent__TOP__1(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_sequent__TOP__1\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    VL_SIG8(__Vdly__v__DOT__HF__DOT__x,0,0);
    VL_SIG8(__Vdly__v__DOT__HF__DOT__right,0,0);
    VL_SIG8(__Vdly__v__DOT__D,0,0);
    //char	__VpadToAlign7[1];
    VL_SIGW(__Vdly__v__DOT__RBHF__DOT__R,509,0,16);
    // Body
    __Vdly__v__DOT__HF__DOT__right = vlTOPp->v__DOT__HF__DOT__right;
    __Vdly__v__DOT__HF__DOT__x = vlTOPp->v__DOT__HF__DOT__x;
    __Vdly__v__DOT__RBHF__DOT__R[0] = vlTOPp->v__DOT__RBHF__DOT__R[0];
    __Vdly__v__DOT__RBHF__DOT__R[1] = vlTOPp->v__DOT__RBHF__DOT__R[1];
    __Vdly__v__DOT__RBHF__DOT__R[2] = vlTOPp->v__DOT__RBHF__DOT__R[2];
    __Vdly__v__DOT__RBHF__DOT__R[3] = vlTOPp->v__DOT__RBHF__DOT__R[3];
    __Vdly__v__DOT__RBHF__DOT__R[4] = vlTOPp->v__DOT__RBHF__DOT__R[4];
    __Vdly__v__DOT__RBHF__DOT__R[5] = vlTOPp->v__DOT__RBHF__DOT__R[5];
    __Vdly__v__DOT__RBHF__DOT__R[6] = vlTOPp->v__DOT__RBHF__DOT__R[6];
    __Vdly__v__DOT__RBHF__DOT__R[7] = vlTOPp->v__DOT__RBHF__DOT__R[7];
    __Vdly__v__DOT__RBHF__DOT__R[8] = vlTOPp->v__DOT__RBHF__DOT__R[8];
    __Vdly__v__DOT__RBHF__DOT__R[9] = vlTOPp->v__DOT__RBHF__DOT__R[9];
    __Vdly__v__DOT__RBHF__DOT__R[0xa] = vlTOPp->v__DOT__RBHF__DOT__R[0xa];
    __Vdly__v__DOT__RBHF__DOT__R[0xb] = vlTOPp->v__DOT__RBHF__DOT__R[0xb];
    __Vdly__v__DOT__RBHF__DOT__R[0xc] = vlTOPp->v__DOT__RBHF__DOT__R[0xc];
    __Vdly__v__DOT__RBHF__DOT__R[0xd] = vlTOPp->v__DOT__RBHF__DOT__R[0xd];
    __Vdly__v__DOT__RBHF__DOT__R[0xe] = vlTOPp->v__DOT__RBHF__DOT__R[0xe];
    __Vdly__v__DOT__RBHF__DOT__R[0xf] = vlTOPp->v__DOT__RBHF__DOT__R[0xf];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[0] = vlTOPp->v__DOT__RB__DOT__R[0];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[1] = vlTOPp->v__DOT__RB__DOT__R[1];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[2] = vlTOPp->v__DOT__RB__DOT__R[2];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[3] = vlTOPp->v__DOT__RB__DOT__R[3];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[4] = vlTOPp->v__DOT__RB__DOT__R[4];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[5] = vlTOPp->v__DOT__RB__DOT__R[5];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[6] = vlTOPp->v__DOT__RB__DOT__R[6];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[7] = vlTOPp->v__DOT__RB__DOT__R[7];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[8] = vlTOPp->v__DOT__RB__DOT__R[8];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[9] = vlTOPp->v__DOT__RB__DOT__R[9];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xa] = vlTOPp->v__DOT__RB__DOT__R[0xa];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xb] = vlTOPp->v__DOT__RB__DOT__R[0xb];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xc] = vlTOPp->v__DOT__RB__DOT__R[0xc];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xd] = vlTOPp->v__DOT__RB__DOT__R[0xd];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xe] = vlTOPp->v__DOT__RB__DOT__R[0xe];
    vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xf] = vlTOPp->v__DOT__RB__DOT__R[0xf];
    __Vdly__v__DOT__D = vlTOPp->v__DOT__D;
    vlTOPp->__Vdly__v__DOT__B = vlTOPp->v__DOT__B;
    // ALWAYS at ../src/table_ram.v:21
    vlTOPp->v__DOT__Next_Table__DOT__read_addr_reg 
	= vlTOPp->v__DOT__TR__DOT__pc;
    // ALWAYS at ../src/table_ram.v:21
    vlTOPp->v__DOT__Head_Table__DOT__read_addr_reg 
	= vlTOPp->v__DOT__TR__DOT__pc;
    // ALWAYS at ../src/table_ram.v:23
    if (((IData)(vlTOPp->v__DOT__n_we) & (IData)(vlTOPp->datavalid))) {
	vlTOPp->v__DOT__Next_Table__DOT__ram[(IData)(vlTOPp->v__DOT__n_waddr)] 
	    = vlTOPp->v__DOT__n_wdata;
    }
    // ALWAYS at ../src/table_ram.v:23
    if (((IData)(vlTOPp->v__DOT__h_we) & (IData)(vlTOPp->datavalid))) {
	vlTOPp->v__DOT__Head_Table__DOT__ram[(IData)(vlTOPp->v__DOT__h_waddr)] 
	    = vlTOPp->v__DOT__h_wdata;
    }
    // ALWAYS at ../src/table_ram.v:21
    vlTOPp->v__DOT__Tail_Table__DOT__read_addr_reg 
	= vlTOPp->v__DOT__t_raddr;
    // ALWAYS at ../src/table_ram.v:21
    vlTOPp->v__DOT__Data_Table__DOT__read_addr_reg 
	= ((IData)(vlTOPp->v__DOT__HCN) ? (IData)(vlTOPp->v__DOT__h_wdata)
	    : (IData)(vlTOPp->v__DOT__h_rdata));
    // ALWAYS at ../src/table_ram.v:23
    if (((IData)(vlTOPp->v__DOT__t_we) & (IData)(vlTOPp->datavalid))) {
	vlTOPp->v__DOT__Tail_Table__DOT__ram[(IData)(vlTOPp->v__DOT__t_waddr)] 
	    = vlTOPp->v__DOT__t_wdata;
    }
    // ALWAYS at ../src/table_ram.v:23
    if (((IData)(vlTOPp->v__DOT__d_we) & (IData)(vlTOPp->datavalid))) {
	vlTOPp->v__DOT__Data_Table__DOT__ram[(IData)(vlTOPp->v__DOT__d_waddr)] 
	    = vlTOPp->v__DOT__d_wdata;
    }
    // ALWAYS at ../src/row_buf.v:42
    if (vlTOPp->datavalid) {
	__Vdly__v__DOT__RBHF__DOT__R[0] = ((0xfffffffe 
					    & (vlTOPp->v__DOT__RBHF__DOT__R[0] 
					       << 1)) 
					   | (IData)(vlTOPp->v__DOT__left));
	__Vdly__v__DOT__RBHF__DOT__R[1] = ((1 & (vlTOPp->v__DOT__RBHF__DOT__R[0] 
						 >> 0x1f)) 
					   | (0xfffffffe 
					      & (vlTOPp->v__DOT__RBHF__DOT__R[1] 
						 << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[2] = ((1 & (vlTOPp->v__DOT__RBHF__DOT__R[1] 
						 >> 0x1f)) 
					   | (0xfffffffe 
					      & (vlTOPp->v__DOT__RBHF__DOT__R[2] 
						 << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[3] = ((1 & (vlTOPp->v__DOT__RBHF__DOT__R[2] 
						 >> 0x1f)) 
					   | (0xfffffffe 
					      & (vlTOPp->v__DOT__RBHF__DOT__R[3] 
						 << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[4] = ((1 & (vlTOPp->v__DOT__RBHF__DOT__R[3] 
						 >> 0x1f)) 
					   | (0xfffffffe 
					      & (vlTOPp->v__DOT__RBHF__DOT__R[4] 
						 << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[5] = ((1 & (vlTOPp->v__DOT__RBHF__DOT__R[4] 
						 >> 0x1f)) 
					   | (0xfffffffe 
					      & (vlTOPp->v__DOT__RBHF__DOT__R[5] 
						 << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[6] = ((1 & (vlTOPp->v__DOT__RBHF__DOT__R[5] 
						 >> 0x1f)) 
					   | (0xfffffffe 
					      & (vlTOPp->v__DOT__RBHF__DOT__R[6] 
						 << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[7] = ((1 & (vlTOPp->v__DOT__RBHF__DOT__R[6] 
						 >> 0x1f)) 
					   | (0xfffffffe 
					      & (vlTOPp->v__DOT__RBHF__DOT__R[7] 
						 << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[8] = ((1 & (vlTOPp->v__DOT__RBHF__DOT__R[7] 
						 >> 0x1f)) 
					   | (0xfffffffe 
					      & (vlTOPp->v__DOT__RBHF__DOT__R[8] 
						 << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[9] = ((1 & (vlTOPp->v__DOT__RBHF__DOT__R[8] 
						 >> 0x1f)) 
					   | (0xfffffffe 
					      & (vlTOPp->v__DOT__RBHF__DOT__R[9] 
						 << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[0xa] = ((1 & (
						   vlTOPp->v__DOT__RBHF__DOT__R[9] 
						   >> 0x1f)) 
					     | (0xfffffffe 
						& (vlTOPp->v__DOT__RBHF__DOT__R[0xa] 
						   << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[0xb] = ((1 & (
						   vlTOPp->v__DOT__RBHF__DOT__R[0xa] 
						   >> 0x1f)) 
					     | (0xfffffffe 
						& (vlTOPp->v__DOT__RBHF__DOT__R[0xb] 
						   << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[0xc] = ((1 & (
						   vlTOPp->v__DOT__RBHF__DOT__R[0xb] 
						   >> 0x1f)) 
					     | (0xfffffffe 
						& (vlTOPp->v__DOT__RBHF__DOT__R[0xc] 
						   << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[0xd] = ((1 & (
						   vlTOPp->v__DOT__RBHF__DOT__R[0xc] 
						   >> 0x1f)) 
					     | (0xfffffffe 
						& (vlTOPp->v__DOT__RBHF__DOT__R[0xd] 
						   << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[0xe] = ((1 & (
						   vlTOPp->v__DOT__RBHF__DOT__R[0xd] 
						   >> 0x1f)) 
					     | (0xfffffffe 
						& (vlTOPp->v__DOT__RBHF__DOT__R[0xe] 
						   << 1)));
	__Vdly__v__DOT__RBHF__DOT__R[0xf] = ((1 & (
						   vlTOPp->v__DOT__RBHF__DOT__R[0xe] 
						   >> 0x1f)) 
					     | (0x3ffffffe 
						& (vlTOPp->v__DOT__RBHF__DOT__R[0xf] 
						   << 1)));
    }
    // ALWAYS at ../src/row_buf.v:42
    if (vlTOPp->datavalid) {
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[0] = ((0xfffffffe 
						  & (vlTOPp->v__DOT__RB__DOT__R[0] 
						     << 1)) 
						 | (IData)(vlTOPp->v__DOT__C));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[1] = ((1 
						  & (vlTOPp->v__DOT__RB__DOT__R[0] 
						     >> 0x1f)) 
						 | (0xfffffffe 
						    & (vlTOPp->v__DOT__RB__DOT__R[1] 
						       << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[2] = ((1 
						  & (vlTOPp->v__DOT__RB__DOT__R[1] 
						     >> 0x1f)) 
						 | (0xfffffffe 
						    & (vlTOPp->v__DOT__RB__DOT__R[2] 
						       << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[3] = ((1 
						  & (vlTOPp->v__DOT__RB__DOT__R[2] 
						     >> 0x1f)) 
						 | (0xfffffffe 
						    & (vlTOPp->v__DOT__RB__DOT__R[3] 
						       << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[4] = ((1 
						  & (vlTOPp->v__DOT__RB__DOT__R[3] 
						     >> 0x1f)) 
						 | (0xfffffffe 
						    & (vlTOPp->v__DOT__RB__DOT__R[4] 
						       << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[5] = ((1 
						  & (vlTOPp->v__DOT__RB__DOT__R[4] 
						     >> 0x1f)) 
						 | (0xfffffffe 
						    & (vlTOPp->v__DOT__RB__DOT__R[5] 
						       << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[6] = ((1 
						  & (vlTOPp->v__DOT__RB__DOT__R[5] 
						     >> 0x1f)) 
						 | (0xfffffffe 
						    & (vlTOPp->v__DOT__RB__DOT__R[6] 
						       << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[7] = ((1 
						  & (vlTOPp->v__DOT__RB__DOT__R[6] 
						     >> 0x1f)) 
						 | (0xfffffffe 
						    & (vlTOPp->v__DOT__RB__DOT__R[7] 
						       << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[8] = ((1 
						  & (vlTOPp->v__DOT__RB__DOT__R[7] 
						     >> 0x1f)) 
						 | (0xfffffffe 
						    & (vlTOPp->v__DOT__RB__DOT__R[8] 
						       << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[9] = ((1 
						  & (vlTOPp->v__DOT__RB__DOT__R[8] 
						     >> 0x1f)) 
						 | (0xfffffffe 
						    & (vlTOPp->v__DOT__RB__DOT__R[9] 
						       << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xa] = (
						   (1 
						    & (vlTOPp->v__DOT__RB__DOT__R[9] 
						       >> 0x1f)) 
						   | (0xfffffffe 
						      & (vlTOPp->v__DOT__RB__DOT__R[0xa] 
							 << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xb] = (
						   (1 
						    & (vlTOPp->v__DOT__RB__DOT__R[0xa] 
						       >> 0x1f)) 
						   | (0xfffffffe 
						      & (vlTOPp->v__DOT__RB__DOT__R[0xb] 
							 << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xc] = (
						   (1 
						    & (vlTOPp->v__DOT__RB__DOT__R[0xb] 
						       >> 0x1f)) 
						   | (0xfffffffe 
						      & (vlTOPp->v__DOT__RB__DOT__R[0xc] 
							 << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xd] = (
						   (1 
						    & (vlTOPp->v__DOT__RB__DOT__R[0xc] 
						       >> 0x1f)) 
						   | (0xfffffffe 
						      & (vlTOPp->v__DOT__RB__DOT__R[0xd] 
							 << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xe] = (
						   (1 
						    & (vlTOPp->v__DOT__RB__DOT__R[0xd] 
						       >> 0x1f)) 
						   | (0xfffffffe 
						      & (vlTOPp->v__DOT__RB__DOT__R[0xe] 
							 << 1)));
	vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xf] = (
						   (1 
						    & (vlTOPp->v__DOT__RB__DOT__R[0xe] 
						       >> 0x1f)) 
						   | (0x3ffffffe 
						      & (vlTOPp->v__DOT__RB__DOT__R[0xf] 
							 << 1)));
    }
    vlTOPp->v__DOT__h_rdata = (IData)(vlTOPp->v__DOT__Head_Table__DOT__ram)
	[(IData)(vlTOPp->v__DOT__Head_Table__DOT__read_addr_reg)];
    vlTOPp->v__DOT__t_rdata = (IData)(vlTOPp->v__DOT__Tail_Table__DOT__ram)
	[(IData)(vlTOPp->v__DOT__Tail_Table__DOT__read_addr_reg)];
    vlTOPp->v__DOT__d_rdata = vlTOPp->v__DOT__Data_Table__DOT__ram
	[(IData)(vlTOPp->v__DOT__Data_Table__DOT__read_addr_reg)];
    // ALWAYS at ../src/window.v:38
    if (vlTOPp->datavalid) {
	vlTOPp->v__DOT__A = vlTOPp->v__DOT__B;
	vlTOPp->v__DOT__C = vlTOPp->v__DOT__D;
	vlTOPp->__Vdly__v__DOT__B = (1 & (vlTOPp->v__DOT__RB__DOT__R[0xf] 
					  >> 0x1d));
	__Vdly__v__DOT__D = (((IData)(vlTOPp->v__DOT__HF__DOT__top) 
			      & ((IData)(vlTOPp->v__DOT__left) 
				 | (IData)(vlTOPp->v__DOT__HF__DOT__right))) 
			     | (IData)(vlTOPp->v__DOT__HF__DOT__x));
    }
    vlTOPp->v__DOT__D = __Vdly__v__DOT__D;
    // ALWAYS at ../src/holes_filler.v:43
    if (vlTOPp->datavalid) {
	vlTOPp->v__DOT__HF__DOT__top = (1 & (vlTOPp->v__DOT__RBHF__DOT__R[0xf] 
					     >> 0x1d));
	vlTOPp->v__DOT__left = vlTOPp->v__DOT__HF__DOT__x;
	__Vdly__v__DOT__HF__DOT__x = vlTOPp->v__DOT__HF__DOT__right;
	__Vdly__v__DOT__HF__DOT__right = vlTOPp->pix_in;
    }
    vlTOPp->v__DOT__RBHF__DOT__R[0] = __Vdly__v__DOT__RBHF__DOT__R[0];
    vlTOPp->v__DOT__RBHF__DOT__R[1] = __Vdly__v__DOT__RBHF__DOT__R[1];
    vlTOPp->v__DOT__RBHF__DOT__R[2] = __Vdly__v__DOT__RBHF__DOT__R[2];
    vlTOPp->v__DOT__RBHF__DOT__R[3] = __Vdly__v__DOT__RBHF__DOT__R[3];
    vlTOPp->v__DOT__RBHF__DOT__R[4] = __Vdly__v__DOT__RBHF__DOT__R[4];
    vlTOPp->v__DOT__RBHF__DOT__R[5] = __Vdly__v__DOT__RBHF__DOT__R[5];
    vlTOPp->v__DOT__RBHF__DOT__R[6] = __Vdly__v__DOT__RBHF__DOT__R[6];
    vlTOPp->v__DOT__RBHF__DOT__R[7] = __Vdly__v__DOT__RBHF__DOT__R[7];
    vlTOPp->v__DOT__RBHF__DOT__R[8] = __Vdly__v__DOT__RBHF__DOT__R[8];
    vlTOPp->v__DOT__RBHF__DOT__R[9] = __Vdly__v__DOT__RBHF__DOT__R[9];
    vlTOPp->v__DOT__RBHF__DOT__R[0xa] = __Vdly__v__DOT__RBHF__DOT__R[0xa];
    vlTOPp->v__DOT__RBHF__DOT__R[0xb] = __Vdly__v__DOT__RBHF__DOT__R[0xb];
    vlTOPp->v__DOT__RBHF__DOT__R[0xc] = __Vdly__v__DOT__RBHF__DOT__R[0xc];
    vlTOPp->v__DOT__RBHF__DOT__R[0xd] = __Vdly__v__DOT__RBHF__DOT__R[0xd];
    vlTOPp->v__DOT__RBHF__DOT__R[0xe] = __Vdly__v__DOT__RBHF__DOT__R[0xe];
    vlTOPp->v__DOT__RBHF__DOT__R[0xf] = __Vdly__v__DOT__RBHF__DOT__R[0xf];
    vlTOPp->v__DOT__HF__DOT__x = __Vdly__v__DOT__HF__DOT__x;
    vlTOPp->v__DOT__HF__DOT__right = __Vdly__v__DOT__HF__DOT__right;
}

void VLinkRunCCA::_sequent__TOP__2(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_sequent__TOP__2\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    VL_SIG8(__Vdly__v__DOT__TR__DOT__pc,7,0);
    VL_SIG8(__Vdly__v__DOT__hp,7,0);
    VL_SIG8(__Vdly__v__DOT__ES__DOT__cc,7,0);
    //char	__VpadToAlign95[1];
    VL_SIG16(__Vdly__v__DOT__FA__DOT__x,8,0);
    VL_SIG16(__Vdly__v__DOT__FA__DOT__y,8,0);
    // Body
    __Vdly__v__DOT__TR__DOT__pc = vlTOPp->v__DOT__TR__DOT__pc;
    __Vdly__v__DOT__FA__DOT__y = vlTOPp->v__DOT__FA__DOT__y;
    __Vdly__v__DOT__FA__DOT__x = vlTOPp->v__DOT__FA__DOT__x;
    __Vdly__v__DOT__ES__DOT__cc = vlTOPp->v__DOT__ES__DOT__cc;
    __Vdly__v__DOT__hp = vlTOPp->v__DOT__hp;
    // ALWAYS at ../src/feature_accumulator.v:54
    if (vlTOPp->rst) {
	__Vdly__v__DOT__FA__DOT__x = 0x1fd;
	__Vdly__v__DOT__FA__DOT__y = 0x1ff;
    } else {
	if (vlTOPp->datavalid) {
	    if ((0x1ff == (IData)(vlTOPp->v__DOT__FA__DOT__x))) {
		__Vdly__v__DOT__FA__DOT__y = (0x1ff 
					      & ((0x1ff 
						  == (IData)(vlTOPp->v__DOT__FA__DOT__y))
						  ? 0
						  : 
						 ((IData)(1) 
						  + (IData)(vlTOPp->v__DOT__FA__DOT__y))));
		__Vdly__v__DOT__FA__DOT__x = 0;
	    } else {
		__Vdly__v__DOT__FA__DOT__x = (0x1ff 
					      & ((IData)(1) 
						 + (IData)(vlTOPp->v__DOT__FA__DOT__x)));
	    }
	}
    }
    // ALWAYS at ../src/../src/LinkRunCCA.v:119
    if (vlTOPp->rst) {
	vlTOPp->datavalid_out = 0;
    } else {
	if (vlTOPp->datavalid) {
	    vlTOPp->datavalid_out = 0;
	    vlTOPp->box_out = vlTOPp->v__DOT__dp;
	    if (vlTOPp->v__DOT__EOC) {
		vlTOPp->datavalid_out = 1;
	    }
	}
    }
    // ALWAYS at ../src/equivalence_resolver.v:71
    if (vlTOPp->rst) {
	__Vdly__v__DOT__ES__DOT__cc = 0;
	vlTOPp->v__DOT__ES__DOT__h = 0;
	vlTOPp->v__DOT__ES__DOT__f = 0;
    } else {
	if (vlTOPp->datavalid) {
	    if (vlTOPp->v__DOT__ES__DOT__Ec) {
		__Vdly__v__DOT__ES__DOT__cc = (0xff 
					       & ((IData)(1) 
						  + (IData)(vlTOPp->v__DOT__ES__DOT__cc)));
		vlTOPp->v__DOT__ES__DOT__f = 0;
	    } else {
		if (vlTOPp->v__DOT__O) {
		    vlTOPp->v__DOT__ES__DOT__h = vlTOPp->v__DOT__h_wdata;
		    vlTOPp->v__DOT__ES__DOT__f = 1;
		}
	    }
	}
    }
    // ALWAYS at ../src/table_reader.v:83
    if (vlTOPp->rst) {
	vlTOPp->v__DOT__np = 0;
	__Vdly__v__DOT__hp = 0;
	vlTOPp->v__DOT__fp = 0;
	vlTOPp->v__DOT__fn = 0;
	vlTOPp->v__DOT__TR__DOT__Rtp = 0;
	vlTOPp->v__DOT__TR__DOT__Rdp = VL_ULL(0);
    } else {
	if (vlTOPp->datavalid) {
	    vlTOPp->v__DOT__TR__DOT__Rtp = vlTOPp->v__DOT__tp;
	    vlTOPp->v__DOT__TR__DOT__Rdp = vlTOPp->v__DOT__dp;
	    if (((IData)(vlTOPp->v__DOT__d_we) & ((IData)(vlTOPp->v__DOT__d_waddr) 
						  == (IData)(vlTOPp->v__DOT__hp)))) {
		vlTOPp->v__DOT__TR__DOT__Rdp = vlTOPp->v__DOT__d;
	    }
	    if ((1 & ((~ (IData)(vlTOPp->v__DOT__B)) 
		      & (vlTOPp->v__DOT__RB__DOT__R[0xf] 
			 >> 0x1d)))) {
		__Vdly__v__DOT__hp = vlTOPp->v__DOT__t_raddr;
		vlTOPp->v__DOT__fp = ((IData)(vlTOPp->v__DOT__t_raddr) 
				      != (IData)(vlTOPp->v__DOT__p));
		vlTOPp->v__DOT__np = vlTOPp->v__DOT__n_rdata;
		vlTOPp->v__DOT__fn = ((IData)(vlTOPp->v__DOT__n_rdata) 
				      == (IData)(vlTOPp->v__DOT__p));
	    } else {
		if (vlTOPp->v__DOT__O) {
		    vlTOPp->v__DOT__TR__DOT__Rtp = vlTOPp->v__DOT__t_wdata;
		    vlTOPp->v__DOT__fp = 1;
		    __Vdly__v__DOT__hp = vlTOPp->v__DOT__h_wdata;
		}
	    }
	}
    }
    vlTOPp->v__DOT__FA__DOT__x = __Vdly__v__DOT__FA__DOT__x;
    vlTOPp->v__DOT__FA__DOT__y = __Vdly__v__DOT__FA__DOT__y;
    vlTOPp->v__DOT__ES__DOT__cc = __Vdly__v__DOT__ES__DOT__cc;
    vlTOPp->v__DOT__hp = __Vdly__v__DOT__hp;
    // ALWAYS at ../src/table_reader.v:58
    if (vlTOPp->rst) {
	__Vdly__v__DOT__TR__DOT__pc = 0;
	vlTOPp->v__DOT__p = 0;
    } else {
	if (vlTOPp->datavalid) {
	    vlTOPp->v__DOT__p = vlTOPp->v__DOT__TR__DOT__pc;
	    if ((1 & ((vlTOPp->v__DOT__RB__DOT__R[0xf] 
		       >> 0x1d) & (~ (vlTOPp->v__DOT__RB__DOT__R[0xf] 
				      >> 0x1c))))) {
		__Vdly__v__DOT__TR__DOT__pc = (0xff 
					       & ((IData)(1) 
						  + (IData)(vlTOPp->v__DOT__TR__DOT__pc)));
	    }
	}
    }
    // ALWAYS at ../src/feature_accumulator.v:82
    if (vlTOPp->rst) {
	vlTOPp->v__DOT__d = VL_ULL(0xff803fe00);
    } else {
	if (vlTOPp->datavalid) {
	    vlTOPp->v__DOT__d = ((IData)(vlTOPp->v__DOT__ES__DOT__Ec)
				  ? VL_ULL(0xff803fe00)
				  : (((QData)((IData)(
						      (0x1ff 
						       & (((IData)(vlTOPp->v__DOT__DMG) 
							   & ((0x1ff 
							       & (IData)(
									 (vlTOPp->v__DOT__dp 
									  >> 0x1b))) 
							      < (IData)(vlTOPp->v__DOT__FA__DOT__minx1)))
							   ? (IData)(
								     (vlTOPp->v__DOT__dp 
								      >> 0x1b))
							   : (IData)(vlTOPp->v__DOT__FA__DOT__minx1))))) 
				      << 0x1b) | (QData)((IData)(
								 ((0x7fc0000 
								   & ((((IData)(vlTOPp->v__DOT__DMG) 
									& ((0x1ff 
									    & (IData)(
										(vlTOPp->v__DOT__dp 
										>> 0x12))) 
									   > (IData)(vlTOPp->v__DOT__FA__DOT__maxx1)))
								        ? (IData)(
										(vlTOPp->v__DOT__dp 
										>> 0x12))
								        : (IData)(vlTOPp->v__DOT__FA__DOT__maxx1)) 
								      << 0x12)) 
								  | ((0x3fe00 
								      & ((((IData)(vlTOPp->v__DOT__DMG) 
									   & ((0x1ff 
									       & (IData)(
										(vlTOPp->v__DOT__dp 
										>> 9))) 
									      < (IData)(vlTOPp->v__DOT__FA__DOT__miny1)))
									   ? (IData)(
										(vlTOPp->v__DOT__dp 
										>> 9))
									   : (IData)(vlTOPp->v__DOT__FA__DOT__miny1)) 
									 << 9)) 
								     | (0x1ff 
									& (((IData)(vlTOPp->v__DOT__DMG) 
									    & ((0x1ff 
										& (IData)(vlTOPp->v__DOT__dp)) 
									       > (IData)(vlTOPp->v__DOT__FA__DOT__maxy1)))
									    ? (IData)(vlTOPp->v__DOT__dp)
									    : (IData)(vlTOPp->v__DOT__FA__DOT__maxy1)))))))));
	}
    }
    vlTOPp->v__DOT__TR__DOT__pc = __Vdly__v__DOT__TR__DOT__pc;
    vlTOPp->v__DOT__FA__DOT__minx1 = (0x1ff & (((IData)(vlTOPp->v__DOT__D) 
						& ((IData)(vlTOPp->v__DOT__FA__DOT__x) 
						   < 
						   (0x1ff 
						    & (IData)(
							      (vlTOPp->v__DOT__d 
							       >> 0x1b)))))
					        ? (IData)(vlTOPp->v__DOT__FA__DOT__x)
					        : (IData)(
							  (vlTOPp->v__DOT__d 
							   >> 0x1b))));
    vlTOPp->v__DOT__FA__DOT__maxx1 = (0x1ff & (((IData)(vlTOPp->v__DOT__D) 
						& ((IData)(vlTOPp->v__DOT__FA__DOT__x) 
						   > 
						   (0x1ff 
						    & (IData)(
							      (vlTOPp->v__DOT__d 
							       >> 0x12)))))
					        ? (IData)(vlTOPp->v__DOT__FA__DOT__x)
					        : (IData)(
							  (vlTOPp->v__DOT__d 
							   >> 0x12))));
    vlTOPp->v__DOT__FA__DOT__miny1 = (0x1ff & (((IData)(vlTOPp->v__DOT__D) 
						& ((IData)(vlTOPp->v__DOT__FA__DOT__y) 
						   < 
						   (0x1ff 
						    & (IData)(
							      (vlTOPp->v__DOT__d 
							       >> 9)))))
					        ? (IData)(vlTOPp->v__DOT__FA__DOT__y)
					        : (IData)(
							  (vlTOPp->v__DOT__d 
							   >> 9))));
    vlTOPp->v__DOT__FA__DOT__maxy1 = (0x1ff & (((IData)(vlTOPp->v__DOT__D) 
						& ((IData)(vlTOPp->v__DOT__FA__DOT__y) 
						   > 
						   (0x1ff 
						    & (IData)(vlTOPp->v__DOT__d))))
					        ? (IData)(vlTOPp->v__DOT__FA__DOT__y)
					        : (IData)(vlTOPp->v__DOT__d)));
}

void VLinkRunCCA::_settle__TOP__3(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_settle__TOP__3\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->v__DOT__h_rdata = (IData)(vlTOPp->v__DOT__Head_Table__DOT__ram)
	[(IData)(vlTOPp->v__DOT__Head_Table__DOT__read_addr_reg)];
    vlTOPp->v__DOT__t_rdata = (IData)(vlTOPp->v__DOT__Tail_Table__DOT__ram)
	[(IData)(vlTOPp->v__DOT__Tail_Table__DOT__read_addr_reg)];
    vlTOPp->v__DOT__d_rdata = vlTOPp->v__DOT__Data_Table__DOT__ram
	[(IData)(vlTOPp->v__DOT__Data_Table__DOT__read_addr_reg)];
    vlTOPp->v__DOT__n_rdata = (IData)(vlTOPp->v__DOT__Next_Table__DOT__ram)
	[(IData)(vlTOPp->v__DOT__Next_Table__DOT__read_addr_reg)];
    vlTOPp->v__DOT__ES__DOT__Ec = ((IData)(vlTOPp->v__DOT__C) 
				   & (~ (IData)(vlTOPp->v__DOT__D)));
    vlTOPp->v__DOT__FA__DOT__minx1 = (0x1ff & (((IData)(vlTOPp->v__DOT__D) 
						& ((IData)(vlTOPp->v__DOT__FA__DOT__x) 
						   < 
						   (0x1ff 
						    & (IData)(
							      (vlTOPp->v__DOT__d 
							       >> 0x1b)))))
					        ? (IData)(vlTOPp->v__DOT__FA__DOT__x)
					        : (IData)(
							  (vlTOPp->v__DOT__d 
							   >> 0x1b))));
    vlTOPp->v__DOT__FA__DOT__maxx1 = (0x1ff & (((IData)(vlTOPp->v__DOT__D) 
						& ((IData)(vlTOPp->v__DOT__FA__DOT__x) 
						   > 
						   (0x1ff 
						    & (IData)(
							      (vlTOPp->v__DOT__d 
							       >> 0x12)))))
					        ? (IData)(vlTOPp->v__DOT__FA__DOT__x)
					        : (IData)(
							  (vlTOPp->v__DOT__d 
							   >> 0x12))));
    vlTOPp->v__DOT__FA__DOT__miny1 = (0x1ff & (((IData)(vlTOPp->v__DOT__D) 
						& ((IData)(vlTOPp->v__DOT__FA__DOT__y) 
						   < 
						   (0x1ff 
						    & (IData)(
							      (vlTOPp->v__DOT__d 
							       >> 9)))))
					        ? (IData)(vlTOPp->v__DOT__FA__DOT__y)
					        : (IData)(
							  (vlTOPp->v__DOT__d 
							   >> 9))));
    vlTOPp->v__DOT__FA__DOT__maxy1 = (0x1ff & (((IData)(vlTOPp->v__DOT__D) 
						& ((IData)(vlTOPp->v__DOT__FA__DOT__y) 
						   > 
						   (0x1ff 
						    & (IData)(vlTOPp->v__DOT__d))))
					        ? (IData)(vlTOPp->v__DOT__FA__DOT__y)
					        : (IData)(vlTOPp->v__DOT__d)));
}

void VLinkRunCCA::_sequent__TOP__4(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_sequent__TOP__4\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->v__DOT__n_rdata = (IData)(vlTOPp->v__DOT__Next_Table__DOT__ram)
	[(IData)(vlTOPp->v__DOT__Next_Table__DOT__read_addr_reg)];
    vlTOPp->v__DOT__B = vlTOPp->__Vdly__v__DOT__B;
    vlTOPp->v__DOT__RB__DOT__R[0] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[0];
    vlTOPp->v__DOT__RB__DOT__R[1] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[1];
    vlTOPp->v__DOT__RB__DOT__R[2] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[2];
    vlTOPp->v__DOT__RB__DOT__R[3] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[3];
    vlTOPp->v__DOT__RB__DOT__R[4] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[4];
    vlTOPp->v__DOT__RB__DOT__R[5] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[5];
    vlTOPp->v__DOT__RB__DOT__R[6] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[6];
    vlTOPp->v__DOT__RB__DOT__R[7] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[7];
    vlTOPp->v__DOT__RB__DOT__R[8] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[8];
    vlTOPp->v__DOT__RB__DOT__R[9] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[9];
    vlTOPp->v__DOT__RB__DOT__R[0xa] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xa];
    vlTOPp->v__DOT__RB__DOT__R[0xb] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xb];
    vlTOPp->v__DOT__RB__DOT__R[0xc] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xc];
    vlTOPp->v__DOT__RB__DOT__R[0xd] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xd];
    vlTOPp->v__DOT__RB__DOT__R[0xe] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xe];
    vlTOPp->v__DOT__RB__DOT__R[0xf] = vlTOPp->__Vdly__v__DOT__RB__DOT__R[0xf];
    vlTOPp->v__DOT__ES__DOT__Ec = ((IData)(vlTOPp->v__DOT__C) 
				   & (~ (IData)(vlTOPp->v__DOT__D)));
    vlTOPp->v__DOT__O = (((IData)(vlTOPp->v__DOT__B) 
			  & (IData)(vlTOPp->v__DOT__D)) 
			 & ((~ (IData)(vlTOPp->v__DOT__A)) 
			    | (~ (IData)(vlTOPp->v__DOT__C))));
}

void VLinkRunCCA::_sequent__TOP__5(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_sequent__TOP__5\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->v__DOT__tp = (((~ (IData)(vlTOPp->v__DOT__A)) 
			   & (IData)(vlTOPp->v__DOT__B))
			   ? (IData)(vlTOPp->v__DOT__t_rdata)
			   : (IData)(vlTOPp->v__DOT__TR__DOT__Rtp));
    vlTOPp->v__DOT__dp = (((~ (IData)(vlTOPp->v__DOT__A)) 
			   & (IData)(vlTOPp->v__DOT__B))
			   ? vlTOPp->v__DOT__d_rdata
			   : vlTOPp->v__DOT__TR__DOT__Rdp);
}

void VLinkRunCCA::_settle__TOP__6(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_settle__TOP__6\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->v__DOT__tp = (((~ (IData)(vlTOPp->v__DOT__A)) 
			   & (IData)(vlTOPp->v__DOT__B))
			   ? (IData)(vlTOPp->v__DOT__t_rdata)
			   : (IData)(vlTOPp->v__DOT__TR__DOT__Rtp));
    vlTOPp->v__DOT__dp = (((~ (IData)(vlTOPp->v__DOT__A)) 
			   & (IData)(vlTOPp->v__DOT__B))
			   ? vlTOPp->v__DOT__d_rdata
			   : vlTOPp->v__DOT__TR__DOT__Rdp);
    vlTOPp->v__DOT__O = (((IData)(vlTOPp->v__DOT__B) 
			  & (IData)(vlTOPp->v__DOT__D)) 
			 & ((~ (IData)(vlTOPp->v__DOT__A)) 
			    | (~ (IData)(vlTOPp->v__DOT__C))));
    vlTOPp->v__DOT__DMG = ((IData)(vlTOPp->v__DOT__O) 
			   & (~ ((IData)(vlTOPp->v__DOT__ES__DOT__f) 
				 & ((IData)(vlTOPp->v__DOT__hp) 
				    == (IData)(vlTOPp->v__DOT__ES__DOT__h)))));
    // ALWAYS at ../src/equivalence_resolver.v:85
    vlTOPp->v__DOT__h_we = 0;
    vlTOPp->v__DOT__h_waddr = 0;
    vlTOPp->v__DOT__h_wdata = 0;
    vlTOPp->v__DOT__t_we = 0;
    vlTOPp->v__DOT__t_waddr = 0;
    vlTOPp->v__DOT__t_wdata = 0;
    vlTOPp->v__DOT__n_we = 0;
    vlTOPp->v__DOT__n_waddr = 0;
    vlTOPp->v__DOT__n_wdata = 0;
    vlTOPp->v__DOT__d_we = 0;
    vlTOPp->v__DOT__d_waddr = 0;
    vlTOPp->v__DOT__d_wdata = VL_ULL(0);
    vlTOPp->v__DOT__EOC = 0;
    vlTOPp->v__DOT__ES__DOT__HBF = 0;
    if (vlTOPp->v__DOT__ES__DOT__Ec) {
	vlTOPp->v__DOT__n_we = 1;
	vlTOPp->v__DOT__n_waddr = vlTOPp->v__DOT__ES__DOT__cc;
	vlTOPp->v__DOT__n_wdata = vlTOPp->v__DOT__ES__DOT__cc;
	vlTOPp->v__DOT__h_we = 1;
	vlTOPp->v__DOT__h_waddr = vlTOPp->v__DOT__ES__DOT__cc;
	vlTOPp->v__DOT__h_wdata = vlTOPp->v__DOT__ES__DOT__cc;
	if ((0 == (IData)(vlTOPp->v__DOT__ES__DOT__f))) {
	    vlTOPp->v__DOT__d_we = 1;
	    vlTOPp->v__DOT__d_waddr = vlTOPp->v__DOT__ES__DOT__cc;
	    vlTOPp->v__DOT__d_wdata = vlTOPp->v__DOT__d;
	} else {
	    if ((1 == (IData)(vlTOPp->v__DOT__ES__DOT__f))) {
		vlTOPp->v__DOT__d_we = 1;
		vlTOPp->v__DOT__d_waddr = vlTOPp->v__DOT__ES__DOT__h;
		vlTOPp->v__DOT__d_wdata = vlTOPp->v__DOT__d;
	    }
	}
    } else {
	if (((IData)(vlTOPp->v__DOT__A) & (~ (IData)(vlTOPp->v__DOT__B)))) {
	    if ((0 == (IData)(vlTOPp->v__DOT__fp))) {
		vlTOPp->v__DOT__d_we = 1;
		vlTOPp->v__DOT__d_waddr = vlTOPp->v__DOT__np;
		vlTOPp->v__DOT__d_wdata = vlTOPp->v__DOT__dp;
		if (vlTOPp->v__DOT__fn) {
		    vlTOPp->v__DOT__EOC = 1;
		}
	    } else {
		if ((1 == (IData)(vlTOPp->v__DOT__fp))) {
		    vlTOPp->v__DOT__h_we = 1;
		    vlTOPp->v__DOT__h_waddr = vlTOPp->v__DOT__np;
		    vlTOPp->v__DOT__h_wdata = vlTOPp->v__DOT__hp;
		    vlTOPp->v__DOT__ES__DOT__HBF = 1;
		}
	    }
	} else {
	    if (vlTOPp->v__DOT__O) {
		if (vlTOPp->v__DOT__ES__DOT__f) {
		    if (vlTOPp->v__DOT__fp) {
			vlTOPp->v__DOT__h_wdata = vlTOPp->v__DOT__hp;
			vlTOPp->v__DOT__h_we = 1;
			vlTOPp->v__DOT__h_waddr = vlTOPp->v__DOT__np;
			vlTOPp->v__DOT__t_we = 1;
			vlTOPp->v__DOT__t_waddr = vlTOPp->v__DOT__h_wdata;
			vlTOPp->v__DOT__t_wdata = vlTOPp->v__DOT__ES__DOT__cc;
			vlTOPp->v__DOT__n_we = 1;
			vlTOPp->v__DOT__n_waddr = vlTOPp->v__DOT__tp;
			vlTOPp->v__DOT__n_wdata = vlTOPp->v__DOT__ES__DOT__h;
		    } else {
			vlTOPp->v__DOT__h_wdata = vlTOPp->v__DOT__ES__DOT__h;
			vlTOPp->v__DOT__h_we = 1;
			vlTOPp->v__DOT__h_waddr = vlTOPp->v__DOT__np;
			vlTOPp->v__DOT__t_we = 1;
			vlTOPp->v__DOT__t_waddr = vlTOPp->v__DOT__h_wdata;
			vlTOPp->v__DOT__t_wdata = vlTOPp->v__DOT__ES__DOT__cc;
		    }
		} else {
		    if (vlTOPp->v__DOT__fp) {
			vlTOPp->v__DOT__h_wdata = vlTOPp->v__DOT__hp;
			vlTOPp->v__DOT__h_we = 1;
			vlTOPp->v__DOT__h_waddr = vlTOPp->v__DOT__np;
			vlTOPp->v__DOT__t_we = 1;
			vlTOPp->v__DOT__t_waddr = vlTOPp->v__DOT__h_wdata;
			vlTOPp->v__DOT__t_wdata = vlTOPp->v__DOT__ES__DOT__cc;
			vlTOPp->v__DOT__n_we = 1;
			vlTOPp->v__DOT__n_waddr = vlTOPp->v__DOT__tp;
			vlTOPp->v__DOT__n_wdata = vlTOPp->v__DOT__ES__DOT__cc;
		    } else {
			vlTOPp->v__DOT__h_wdata = vlTOPp->v__DOT__ES__DOT__cc;
			vlTOPp->v__DOT__h_we = 1;
			vlTOPp->v__DOT__h_waddr = vlTOPp->v__DOT__np;
			vlTOPp->v__DOT__t_we = 1;
			vlTOPp->v__DOT__t_waddr = vlTOPp->v__DOT__h_wdata;
			vlTOPp->v__DOT__t_wdata = vlTOPp->v__DOT__ES__DOT__cc;
		    }
		}
	    }
	}
    }
}

void VLinkRunCCA::_sequent__TOP__7(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_sequent__TOP__7\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->v__DOT__DMG = ((IData)(vlTOPp->v__DOT__O) 
			   & (~ ((IData)(vlTOPp->v__DOT__ES__DOT__f) 
				 & ((IData)(vlTOPp->v__DOT__hp) 
				    == (IData)(vlTOPp->v__DOT__ES__DOT__h)))));
    // ALWAYS at ../src/equivalence_resolver.v:85
    vlTOPp->v__DOT__h_we = 0;
    vlTOPp->v__DOT__h_waddr = 0;
    vlTOPp->v__DOT__h_wdata = 0;
    vlTOPp->v__DOT__t_we = 0;
    vlTOPp->v__DOT__t_waddr = 0;
    vlTOPp->v__DOT__t_wdata = 0;
    vlTOPp->v__DOT__n_we = 0;
    vlTOPp->v__DOT__n_waddr = 0;
    vlTOPp->v__DOT__n_wdata = 0;
    vlTOPp->v__DOT__d_we = 0;
    vlTOPp->v__DOT__d_waddr = 0;
    vlTOPp->v__DOT__d_wdata = VL_ULL(0);
    vlTOPp->v__DOT__EOC = 0;
    vlTOPp->v__DOT__ES__DOT__HBF = 0;
    if (vlTOPp->v__DOT__ES__DOT__Ec) {
	vlTOPp->v__DOT__n_we = 1;
	vlTOPp->v__DOT__n_waddr = vlTOPp->v__DOT__ES__DOT__cc;
	vlTOPp->v__DOT__n_wdata = vlTOPp->v__DOT__ES__DOT__cc;
	vlTOPp->v__DOT__h_we = 1;
	vlTOPp->v__DOT__h_waddr = vlTOPp->v__DOT__ES__DOT__cc;
	vlTOPp->v__DOT__h_wdata = vlTOPp->v__DOT__ES__DOT__cc;
	if ((0 == (IData)(vlTOPp->v__DOT__ES__DOT__f))) {
	    vlTOPp->v__DOT__d_we = 1;
	    vlTOPp->v__DOT__d_waddr = vlTOPp->v__DOT__ES__DOT__cc;
	    vlTOPp->v__DOT__d_wdata = vlTOPp->v__DOT__d;
	} else {
	    if ((1 == (IData)(vlTOPp->v__DOT__ES__DOT__f))) {
		vlTOPp->v__DOT__d_we = 1;
		vlTOPp->v__DOT__d_waddr = vlTOPp->v__DOT__ES__DOT__h;
		vlTOPp->v__DOT__d_wdata = vlTOPp->v__DOT__d;
	    }
	}
    } else {
	if (((IData)(vlTOPp->v__DOT__A) & (~ (IData)(vlTOPp->v__DOT__B)))) {
	    if ((0 == (IData)(vlTOPp->v__DOT__fp))) {
		vlTOPp->v__DOT__d_we = 1;
		vlTOPp->v__DOT__d_waddr = vlTOPp->v__DOT__np;
		vlTOPp->v__DOT__d_wdata = vlTOPp->v__DOT__dp;
		if (vlTOPp->v__DOT__fn) {
		    vlTOPp->v__DOT__EOC = 1;
		}
	    } else {
		if ((1 == (IData)(vlTOPp->v__DOT__fp))) {
		    vlTOPp->v__DOT__h_we = 1;
		    vlTOPp->v__DOT__h_waddr = vlTOPp->v__DOT__np;
		    vlTOPp->v__DOT__h_wdata = vlTOPp->v__DOT__hp;
		    vlTOPp->v__DOT__ES__DOT__HBF = 1;
		}
	    }
	} else {
	    if (vlTOPp->v__DOT__O) {
		if (vlTOPp->v__DOT__ES__DOT__f) {
		    if (vlTOPp->v__DOT__fp) {
			vlTOPp->v__DOT__h_wdata = vlTOPp->v__DOT__hp;
			vlTOPp->v__DOT__h_we = 1;
			vlTOPp->v__DOT__h_waddr = vlTOPp->v__DOT__np;
			vlTOPp->v__DOT__t_we = 1;
			vlTOPp->v__DOT__t_waddr = vlTOPp->v__DOT__h_wdata;
			vlTOPp->v__DOT__t_wdata = vlTOPp->v__DOT__ES__DOT__cc;
			vlTOPp->v__DOT__n_we = 1;
			vlTOPp->v__DOT__n_waddr = vlTOPp->v__DOT__tp;
			vlTOPp->v__DOT__n_wdata = vlTOPp->v__DOT__ES__DOT__h;
		    } else {
			vlTOPp->v__DOT__h_wdata = vlTOPp->v__DOT__ES__DOT__h;
			vlTOPp->v__DOT__h_we = 1;
			vlTOPp->v__DOT__h_waddr = vlTOPp->v__DOT__np;
			vlTOPp->v__DOT__t_we = 1;
			vlTOPp->v__DOT__t_waddr = vlTOPp->v__DOT__h_wdata;
			vlTOPp->v__DOT__t_wdata = vlTOPp->v__DOT__ES__DOT__cc;
		    }
		} else {
		    if (vlTOPp->v__DOT__fp) {
			vlTOPp->v__DOT__h_wdata = vlTOPp->v__DOT__hp;
			vlTOPp->v__DOT__h_we = 1;
			vlTOPp->v__DOT__h_waddr = vlTOPp->v__DOT__np;
			vlTOPp->v__DOT__t_we = 1;
			vlTOPp->v__DOT__t_waddr = vlTOPp->v__DOT__h_wdata;
			vlTOPp->v__DOT__t_wdata = vlTOPp->v__DOT__ES__DOT__cc;
			vlTOPp->v__DOT__n_we = 1;
			vlTOPp->v__DOT__n_waddr = vlTOPp->v__DOT__tp;
			vlTOPp->v__DOT__n_wdata = vlTOPp->v__DOT__ES__DOT__cc;
		    } else {
			vlTOPp->v__DOT__h_wdata = vlTOPp->v__DOT__ES__DOT__cc;
			vlTOPp->v__DOT__h_we = 1;
			vlTOPp->v__DOT__h_waddr = vlTOPp->v__DOT__np;
			vlTOPp->v__DOT__t_we = 1;
			vlTOPp->v__DOT__t_waddr = vlTOPp->v__DOT__h_wdata;
			vlTOPp->v__DOT__t_wdata = vlTOPp->v__DOT__ES__DOT__cc;
		    }
		}
	    }
	}
    }
    vlTOPp->v__DOT__HCN = ((IData)(vlTOPp->v__DOT__ES__DOT__HBF) 
			   & ((IData)(vlTOPp->v__DOT__np) 
			      == (IData)(vlTOPp->v__DOT__p)));
}

void VLinkRunCCA::_settle__TOP__8(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_settle__TOP__8\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->v__DOT__HCN = ((IData)(vlTOPp->v__DOT__ES__DOT__HBF) 
			   & ((IData)(vlTOPp->v__DOT__np) 
			      == (IData)(vlTOPp->v__DOT__p)));
    vlTOPp->v__DOT__t_raddr = ((IData)(vlTOPp->v__DOT__HCN)
			        ? (IData)(vlTOPp->v__DOT__h_wdata)
			        : (IData)(vlTOPp->v__DOT__h_rdata));
}

void VLinkRunCCA::_sequent__TOP__9(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_sequent__TOP__9\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->v__DOT__t_raddr = ((IData)(vlTOPp->v__DOT__HCN)
			        ? (IData)(vlTOPp->v__DOT__h_wdata)
			        : (IData)(vlTOPp->v__DOT__h_rdata));
}

void VLinkRunCCA::_eval(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_eval\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (((IData)(vlTOPp->clk) & (~ (IData)(vlTOPp->__Vclklast__TOP__clk)))) {
	vlTOPp->_sequent__TOP__1(vlSymsp);
    }
    if ((((IData)(vlTOPp->clk) & (~ (IData)(vlTOPp->__Vclklast__TOP__clk))) 
	 | ((IData)(vlTOPp->rst) & (~ (IData)(vlTOPp->__Vclklast__TOP__rst))))) {
	vlTOPp->_sequent__TOP__2(vlSymsp);
    }
    if (((IData)(vlTOPp->clk) & (~ (IData)(vlTOPp->__Vclklast__TOP__clk)))) {
	vlTOPp->_sequent__TOP__4(vlSymsp);
    }
    if ((((IData)(vlTOPp->clk) & (~ (IData)(vlTOPp->__Vclklast__TOP__clk))) 
	 | ((IData)(vlTOPp->rst) & (~ (IData)(vlTOPp->__Vclklast__TOP__rst))))) {
	vlTOPp->_sequent__TOP__5(vlSymsp);
	vlTOPp->_sequent__TOP__7(vlSymsp);
	vlTOPp->_sequent__TOP__9(vlSymsp);
    }
    // Final
    vlTOPp->__Vclklast__TOP__clk = vlTOPp->clk;
    vlTOPp->__Vclklast__TOP__rst = vlTOPp->rst;
}

void VLinkRunCCA::_eval_initial(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_eval_initial\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void VLinkRunCCA::final() {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::final\n"); );
    // Variables
    VLinkRunCCA__Syms* __restrict vlSymsp = this->__VlSymsp;
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void VLinkRunCCA::_eval_settle(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_eval_settle\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_settle__TOP__3(vlSymsp);
    vlTOPp->_settle__TOP__6(vlSymsp);
    vlTOPp->_settle__TOP__8(vlSymsp);
}

IData VLinkRunCCA::_change_request(VLinkRunCCA__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    VLinkRunCCA::_change_request\n"); );
    VLinkRunCCA* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    IData __req = false;  // Logically a bool
    return __req;
}
