// Copyright (c) 2006-2020 Qualcomm Technologies, Inc. All rights reserved.
// This code contains confidential and trade secret material and you may make, have
// made, use, reproduce, display or perform (publicly or otherwise), prepare
// derivative works based on, offer for sale, sell, distribute, import,
// disclose, license, sublicense, dispose of and otherwise exploit this code solely in
// accordance with your license agreement.
// If you have not agreed to all of the terms and conditions in such License
// Agreement, you should immediately return this code (including any copies)
// to your licensor.
// This code or portions thereof are protected under U.S. and foreign patent and patent applications.

`include "uvm_macros.svh"

package anvu_noc_definitions_pkg;
`ifndef WIDTH
 `define WIDTH 64
`endif
import anvu_commons_pkg::*;
import anvu_xactors_pkg::*;
import uvm_pkg::*;

//! Slowest clock period of all the clock defined in the Intent.
//! The value is expressed using the current time unit.
real nocSlowestClkPeriod   = 7504.0;

//! When True the scoreboard abstractors are not connected to their monitors
//! and consequently do not feed the scoreboard. Usually because the
//! scoreboard does not support one of the element in the NoC
bit nocScoreboardDisabled = 0;

// Clk Regime interfaces

//! Number of ClkRegime input of the NoC, that need to be driven by the environment.
int nocClkRegimeDriverNb  = 4;

//! List of the names of the ClkRegime input of the NoC.
string          nocClkRegimeDriverName[$];

longint nocClkRegimePsPeriod[4] = '{
	64'd2500
,	64'd2500
,	64'd2500
,	64'd1876
};

//! Associative array to find back the index of an input ClkRegime by its name.
int nocClkRegimeDriverIdxByName[string];

// RstN interfaces

//! Number of RstN input of the NoC, that need to be driven by the environment.
int nocRstnDriverNb  = 6;
//! Number of RstN output of the NoC, that need to be read by the environment.
int nocRstnReaderNb  = 0;

//! List of the names of the RstN input of the NoC.
string          nocRstnDriverName[$];
//! List of the names of the RstN output of the NoC.
string          nocRstnReaderName[$];
//! For each Rstn signal, indicates if it is a retention reset.
//! These will only be activated on the first 'performNocReset' in the simulation, further call to performNocReset will by default not activated them
bit nocRetRstn[int];

//! Associative array to find back the index of an input RstN by its name.
int nocRstnDriverIdxByName[string];
//! Associative array to find back the index of an output RstN by its name.
int nocRstnReaderIdxByName[string];

// Signal interfaces

//! Number of input signal of the NoC, that need to be driven by the environment.
int nocSignalDriverNb  = 1;
//! Number of output signal of the NoC, that need to be read by the environment.
int nocSignalReaderNb  = 0;

//! List of the names of the input signal of the NoC.
string          nocSignalDriverName[$];
//! List of the names of the output signal of the NoC.
string          nocSignalReaderName[$];

//! List of the default value to be driven on each input signal of the NoC, as defined in the Intent for the choosen mode.
bit[63:0] nocSignalDriverResetValue[1] = '{
	64'h0
};

//! Associative array to find back the index of an input signal by its name.
int nocSignalDriverIdxByName[string];
//! Associative array to find back the index of an output signal by its name.
int nocSignalReaderIdxByName[string];

// For each SignalDriver index, indifcates if the signal must only be set back to its reset value only when retention reset are also activated
// Default is 0 for all
bit nocSignalDriverOnRetRstn[int];
// ModePort interfaces

//! Number of input signal of the NoC, that need to be driven by the environment.
int nocModePortDriverNb  = 1;

//! List of the names of the input signal of the NoC.
string          nocModePortDriverName[$];
//! Associative array to find back the index of an input signal by its name.
int nocModePortDriverIdxByName[string];
//! Associative array to find back the index of a mode port driver based on a Flow Id.
int nocModePortDriverIdxByFlowId[int];
//! Width of each of the modePort
int nocModePortDriverWidth[1] ;


// ClkEn interfaces

// Number of input ClockEnable of the NoC, that need to be driven by the environment.
int nocClkEnDriverNb  = 0;

//! List of the default ratio value to be used for each ClockEnable of the NoC, as defined in the Intent.
bit[63:0] nocClkEnResetRatio[] ;

//! Associative array to find back the index of an ClockEnable by its name.
string    nocClkEnDriverName[$];

//! Associative array to find back the index of an ClkEnable by its name.
int nocClkEnDriverIdxByName[string];

// SecurityFlag, SecurityLevels, UserFlag and UserLevels support variables

//! Number of SecurityFlag defined for the NoC
int nocSecurityFlagNb = 0;
//! List of all the NoC security flags. The position of each securityFlag in the array is the position of the associated bit in a security level.
string nocSecurityFlagName[$];

//! Number of SecurityLevels possible
int nocSecurityLevelNb = 1;

//! Number of UserFlag defined for the NoC
int nocUserFlagNb = 8;
//! List of all the NoC user flags. The position of each userFlag in the array is the position of the associated bit in a security level.
string nocUserFlagName[$];

//! List of all initiators that have access to the Service Network
string nocInitServiceNetwork[$];


//! List of all targets that have access to the Service Network
string nocTargServiceNetwork[$];

//! Number of UserLevels possible
int nocUserLevelNb = 256;

//! Enumerated type defining the possible source for securityFlags and userFlags.
typedef enum {
	NONE
,	CONST
,	CACHE   , PROT
,	CONNID  , REQINFO
,	REQUSER
,	STRM
,	POST
,	QOS
,	DOMAIN
,	SNOOP
,	EXCLID
,	SEC
,	MASTER
,	UNSUPPORTED
} eFlagSrc;

typedef struct packed {
	eFlagSrc flagSrc;
	byte unsigned index;
} anvu_flag_info;

longint nocUserBitInversionByFlowId[*];
longint nocSecurityBitInversionByFlowId[*];

//
// AXI sockets information
//
`ifndef ANVU_AXIVERSION_DEFINE
`define ANVU_AXIVERSION_DEFINE
typedef enum { V3 , V4 , V5, ACE_LITE , ACE_LITE_DVM , ACE , AXI_LITE } eAxiVersion;
`endif

//! Class defining objects storing information and methods related to the AXI flowIdMap (as in FlexNoC GUI) which allow to transpose the master index (i.e. the "thread"/"FlexNoc flow" index) to and from the AXI ARID/AWID fields
class anvu_axi_init_mstIdxMap;
	//! Number of flows (threads) associated with the AXI socket
	int nMstIdx;
	//! ARID AWID width
	int wAid;
	//! Object storing the flowIdMap. It is an associative array of queue of one or several "baseMask". A baseMask is an array of 2 integers : [base,mask].
	//! For example an item 101X in the flowIdMap has a base 1010 (all X=0) and mask 1110 (all X = 0 , all others = 1)
	//! Each queue of baseMask is associated to a master index.
	int mstIdxMap[int][$][2] ;
	//! cache arrays, to speed up the process
	int cacheMstIdxFromAid[int];
	int cacheAidFromMstIdx[int];
	
	//! Function to add a base/mask to the queue with index mstIdx.
	function void addBaseMask(int mstIdx,int base,int mask);
		int baseMask[2]='{base,mask};
		mstIdxMap[mstIdx].push_back(baseMask);
	endfunction
	
	//! Conversion aId -> mstIdx
	function int getMstIdxFromAid(int aId);
		if (nMstIdx==1                    ) return 0;
		if (cacheMstIdxFromAid.exists(aId)) return cacheMstIdxFromAid[aId];
		foreach (mstIdxMap[i]) begin
			int baseMaskQueue[$][2] = mstIdxMap[i];
			foreach (baseMaskQueue[j]) begin
				int base = baseMaskQueue[j][0];
				int mask = baseMaskQueue[j][1];
				if ((aId&mask) == base) begin
					cacheMstIdxFromAid[aId]=i;
					return i;
				end
			end
		end
		cacheMstIdxFromAid[aId]=nMstIdx-1;
		return nMstIdx-1;
	endfunction
	
	//! Conversion mstIdx -> aId. Several values for aId may be possible, so only one is returned (always the same for a given mstIdx, if nMstIdx > 1)
	//! If nMstIdx == 1, returned aId value is fully randomized.
	function int getAidFromMstIdx(int mstIdx);
		if (nMstIdx==1) return $urandom_range((1<<wAid)-1);
		if (cacheAidFromMstIdx.exists(mstIdx)) return cacheAidFromMstIdx[mstIdx];
		for (int aId=0;aId < (1<<wAid); aId++) begin
			if (getMstIdxFromAid(aId)==mstIdx) begin
				cacheAidFromMstIdx[mstIdx]=aId;
				return aId;
			end
		end
		`uvm_error("anvu_test","Could not find a suitable value for AWID or ARID from the value of mstIdx")
	endfunction
endclass

//! Additionnal configuration information for an AXI target socket.
typedef struct packed {
	//! Addr width of the AXI socket.
	int      wAddr;
	//! Data width of the AXI socket.
	int      wData;
	//! wAid of the AXI socket.
	int      wAid;
	//! wRegion of the AXI socket (V4/ACELITE only, it is null for V3)
	int      wRegion;
	//! flowIdMap of this socket.
	int      flowIdMap;
	//! Effective number of Id used on the AXI socket.
	int      nFlow;
	//! wLength of the AXI socket.
	int      wLength;
	//! Support of RD transctions by the NIU connected to the AXI socket.
	bit      enRd;
	//! Support of WR transctions by the NIU connected to the AXI socket.
	bit      enWr;
	//! Addr width of the generic interface associated with the AXI socket.
	int      wGenAddr;
	//! Does the target NIU support soft locks.
	bit useSoftLock;
	//! Does the target NIU support hard locks.
	bit useHardLock;
	//! Does the target NIU support pre locks.
	bit usePreLock;
	//! Does the target NIU is enforced to have in order responses.
	bit inOrder;
	//! version
	eAxiVersion version;
	//! Does the target NIU support receiving strm preambles;
	bit supportStrm;
	//! wLen parameter of the generic interface of the NIU
	int wLen;
	//! True is the NIU supports AMBA5 atomic transactions
	bit      useAtomic;
}	anvu_axi_targ_info;

//! Additionnal configuration information for an AXI initiator socket.
typedef struct packed {
	//! Addr width of the AXI socket.
	int      wAddr;
	//! Data width of the AXI socket.
	int      wData;
	//! wAid of the AXI socket.
	int      wAid;
	//! wRegion of the AXI socket (V4/ACELITE only, it is null for V3)
	int      wRegion;
	//! Effective number of Id used on the AXI socket.
	int      nFlow;
	//! wLength of the AXI socket.
	int      wLength;
	//! Support of FIXED burst by the NIU connected to the AXI socket.
	bit      enFixedBurst;
	//! Addr width of the generic interface associated with the AXI socket.
	int      wGenAddr;
	//! How are Lock converted. If useHardLock is True, only RD/WR lock sequence are supported.
	bit      useHardLock;
	//! How are Lock converted. If usePreLock is True, any sequence are supported.
	bit      usePreLock;
	//! True if EXCLUSIVE accesses are supported.
	bit      useSoftLock;
	//! True if the NIU use Strm preamble.
	bit      usePreStrm;
	//! Support of RD transctions by the NIU connected to the AXI socket.
	bit      enRd;
	//! Support of WR transctions by the NIU connected to the AXI socket.
	bit      enWr;
	//! Minimum value for XferSize.
	int      minXferSize;
	//! Maximum length (number of beat) of the WRAP transaction supported by the NIU connected to the AXI socket.
	int      wrapMax;
	//! Width of the User signal of the AXI socket. Will be 0 if the signal does not exist.
	int      wUser;
	//! Can cache_0 be forced to 0 in the NoC?
	bit      forceNonBuf;
	//! version
	eAxiVersion version;
	//! maxBurst in byte. !=0 only if version==ACE
	int maxBurst;
	//! True is the NIU has can respond early on bufferable writes
	bit      useEarlyWrRsp;
	//! Chache line size in bytes (only if version==ACE, 0 otherwise)
	int      cacheLineSize;
	//! Min alignment of WRAP supported by the NIU connected to the AXI socket.
	int      minWrapAlign;
	//! True is the NIU supports AMBA5 atomic transactions
	bit      useAtomic;
}	anvu_axi_init_info;


//! Number of initiator AXI socket in the NoC.
int nocAxiInitNb  = 9;
//! Number of target AXI socket in the NoC.
int nocAxiTargNb  = 10;

//! List of the names of the initiator AXI socket of the NoC
string          nocAxiInitName[$];
//! List of the names of the target AXI socket of the NoC
string          nocAxiTargName[$];

//! List of the additionnal configuration information of the initiator AXI sockets of the NoC
anvu_axi_init_info nocAxiInitInfo[9] = '{
	{32'd32,32'd64,32'd4,32'd0,32'd1,32'd3,1'd1,32'd32,1'd0,1'd0,1'd1,1'd1,1'd1,1'd1,32'd3,32'd8,32'd0,1'd0,32'd1,32'd0,1'd0,32'd0,32'd8,1'd0}
,	{32'd32,32'd64,32'd4,32'd0,32'd1,32'd3,1'd1,32'd32,1'd0,1'd0,1'd1,1'd1,1'd1,1'd1,32'd3,32'd8,32'd0,1'd0,32'd1,32'd0,1'd0,32'd0,32'd8,1'd0}
,	{32'd32,32'd32,32'd4,32'd0,32'd1,32'd4,1'd1,32'd32,1'd0,1'd0,1'd1,1'd1,1'd1,1'd1,32'd2,32'd16,32'd0,1'd0,32'd1,32'd0,1'd0,32'd0,32'd4,1'd0}
,	{32'd32,32'd32,32'd4,32'd0,32'd1,32'd4,1'd1,32'd32,1'd0,1'd0,1'd1,1'd1,1'd1,1'd1,32'd2,32'd16,32'd0,1'd0,32'd1,32'd0,1'd0,32'd0,32'd4,1'd0}
,	{32'd32,32'd64,32'd4,32'd0,32'd1,32'd3,1'd1,32'd32,1'd0,1'd0,1'd1,1'd1,1'd1,1'd1,32'd3,32'd8,32'd0,1'd0,32'd1,32'd0,1'd0,32'd0,32'd8,1'd0}
,	{32'd32,32'd32,32'd4,32'd0,32'd1,32'd4,1'd1,32'd32,1'd0,1'd0,1'd1,1'd1,1'd1,1'd1,32'd2,32'd16,32'd0,1'd0,32'd1,32'd0,1'd0,32'd0,32'd4,1'd0}
,	{32'd32,32'd32,32'd4,32'd0,32'd1,32'd4,1'd1,32'd32,1'd0,1'd0,1'd1,1'd1,1'd1,1'd1,32'd2,32'd16,32'd0,1'd0,32'd1,32'd0,1'd0,32'd0,32'd4,1'd0}
,	{32'd32,32'd32,32'd4,32'd0,32'd1,32'd4,1'd1,32'd32,1'd0,1'd0,1'd1,1'd1,1'd1,1'd1,32'd2,32'd16,32'd0,1'd0,32'd1,32'd0,1'd0,32'd0,32'd4,1'd0}
,	{32'd32,32'd32,32'd4,32'd0,32'd1,32'd4,1'd1,32'd32,1'd0,1'd0,1'd1,1'd1,1'd1,1'd1,32'd2,32'd16,32'd0,1'd0,32'd1,32'd0,1'd0,32'd0,32'd4,1'd0}
};
//! List of the additionnal configuration information of the target AXI sockets of the NoC
anvu_axi_targ_info nocAxiTargInfo[10] = '{
	{32'd32,32'd32,32'd0,32'd0,32'd0,32'd1,32'd0,1'd1,1'd1,32'd32,1'd0,1'd0,1'd0,1'd1,32'd6,1'd0,32'd7,1'd0}
,	{32'd32,32'd128,32'd4,32'd0,32'd0,32'd1,32'd3,1'd1,1'd1,32'd32,1'd0,1'd0,1'd0,1'd0,32'd1,1'd1,32'd7,1'd0}
,	{32'd32,32'd128,32'd4,32'd0,32'd0,32'd1,32'd3,1'd1,1'd1,32'd32,1'd0,1'd0,1'd0,1'd0,32'd1,1'd1,32'd7,1'd0}
,	{32'd32,32'd128,32'd4,32'd0,32'd0,32'd1,32'd3,1'd1,1'd1,32'd32,1'd0,1'd0,1'd0,1'd0,32'd1,1'd1,32'd7,1'd0}
,	{32'd32,32'd128,32'd4,32'd0,32'd0,32'd1,32'd3,1'd1,1'd1,32'd32,1'd0,1'd0,1'd0,1'd0,32'd1,1'd1,32'd7,1'd0}
,	{32'd32,32'd32,32'd0,32'd0,32'd0,32'd1,32'd0,1'd1,1'd1,32'd32,1'd0,1'd0,1'd0,1'd1,32'd6,1'd0,32'd7,1'd0}
,	{32'd32,32'd32,32'd4,32'd0,32'd0,32'd1,32'd4,1'd1,1'd1,32'd32,1'd0,1'd0,1'd0,1'd0,32'd1,1'd1,32'd6,1'd0}
,	{32'd32,32'd32,32'd4,32'd0,32'd0,32'd1,32'd4,1'd1,1'd1,32'd32,1'd0,1'd0,1'd0,1'd0,32'd1,1'd1,32'd6,1'd0}
,	{32'd32,32'd32,32'd4,32'd0,32'd0,32'd1,32'd4,1'd1,1'd1,32'd32,1'd0,1'd0,1'd0,1'd0,32'd1,1'd1,32'd6,1'd0}
,	{32'd32,32'd32,32'd4,32'd0,32'd0,32'd1,32'd4,1'd1,1'd1,32'd32,1'd0,1'd0,1'd0,1'd0,32'd1,1'd1,32'd6,1'd0}
};

//! For each initiator AXI sockets, for each security levels. Defines if the security level is reachable by the VIP. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals of the protocol ('ReqUser' for AXI).
bit[0:0] nocAxiInitReachableSecurityLevels[9] = '{
	1'b1
,	1'b1
,	1'b1
,	1'b1
,	1'b1
,	1'b1
,	1'b1
,	1'b1
,	1'b1
};
//! List of bases (one for each initiator AXI sockets) allowing to find the security levels which are reacheable by the environment. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals.
//! If there are no security flags, these values have no meaning.
bit[0:0] nocAxiInitReachableSecurityBases[9] = '{
	1'b0
,	1'b0
,	1'b0
,	1'b0
,	1'b0
,	1'b0
,	1'b0
,	1'b0
,	1'b0
};
//! List of masks (one for each initiator AXI sockets) allowing to find the security levels which are reacheable by the environment. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals.
//! If there are no security flags, these values have no meaning.
bit[0:0] nocAxiInitReachableSecurityMasks[9] = '{
	1'b0
,	1'b0
,	1'b0
,	1'b0
,	1'b0
,	1'b0
,	1'b0
,	1'b0
,	1'b0
};
//! List of bases (one for each initiator AXI sockets) allowing to find the user levels which are reacheable by the environment. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals.
//! If there are no user flags, these values have no meaning.
bit[7:0] nocAxiInitReachableUserBases[9] = '{
	8'b00000000
,	8'b00000000
,	8'b00000000
,	8'b00000000
,	8'b00000000
,	8'b00000000
,	8'b00000000
,	8'b00000000
,	8'b00000000
};
//! List of masks (one for each initiator AXI sockets) allowing to find the user levels which are reacheable by the environment. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals.
//! If there are no user flags, these values have no meaning.
bit[7:0] nocAxiInitReachableUserMasks[9] = '{
	8'b10000000
,	8'b10000000
,	8'b10000000
,	8'b10000000
,	8'b10000000
,	8'b10000000
,	8'b10000000
,	8'b10000000
,	8'b10000000
};
//! List for each initiator AXI sockets, how each securityFlag is driven.
anvu_flag_info nocAxiInitSecurityFlagMapping[] ;
//! List for each target AXI sockets, how each securityFlag is driven.
anvu_flag_info nocAxiTargSecurityFlagMapping[] ;
//! List for each initiator AXI sockets, how each userFlag is driven.
anvu_flag_info nocAxiInitUserFlagMapping[9][8] = '{
	'{'{CACHE ,8'h0},'{CACHE ,8'h1},'{CACHE ,8'h2},'{CACHE ,8'h3},'{PROT ,8'h0},'{PROT ,8'h1},'{PROT ,8'h2},'{CONST ,8'h0}} // Specification_acpu_axi_m0
,	'{'{CACHE ,8'h0},'{CACHE ,8'h1},'{CACHE ,8'h2},'{CACHE ,8'h3},'{PROT ,8'h0},'{PROT ,8'h1},'{PROT ,8'h2},'{CONST ,8'h0}} // Specification_arm_axi_m0
,	'{'{CACHE ,8'h0},'{CACHE ,8'h1},'{CACHE ,8'h2},'{CACHE ,8'h3},'{PROT ,8'h0},'{PROT ,8'h1},'{PROT ,8'h2},'{CONST ,8'h0}} // Specification_dma_axi_m0
,	'{'{CACHE ,8'h0},'{CACHE ,8'h1},'{CACHE ,8'h2},'{CACHE ,8'h3},'{PROT ,8'h0},'{PROT ,8'h1},'{PROT ,8'h2},'{CONST ,8'h0}} // Specification_dma_axi_m1
,	'{'{CACHE ,8'h0},'{CACHE ,8'h1},'{CACHE ,8'h2},'{CACHE ,8'h3},'{PROT ,8'h0},'{PROT ,8'h1},'{PROT ,8'h2},'{CONST ,8'h0}} // Specification_fpga_axi_m0
,	'{'{CACHE ,8'h0},'{CACHE ,8'h1},'{CACHE ,8'h2},'{CACHE ,8'h3},'{PROT ,8'h0},'{PROT ,8'h1},'{PROT ,8'h2},'{CONST ,8'h0}} // Specification_fpga_axi_m1
,	'{'{CACHE ,8'h0},'{CACHE ,8'h1},'{CACHE ,8'h2},'{CACHE ,8'h3},'{PROT ,8'h0},'{PROT ,8'h1},'{PROT ,8'h2},'{CONST ,8'h0}} // Specification_gbe_axi_m0
,	'{'{CACHE ,8'h0},'{CACHE ,8'h1},'{CACHE ,8'h2},'{CACHE ,8'h3},'{PROT ,8'h0},'{PROT ,8'h1},'{PROT ,8'h2},'{CONST ,8'h0}} // Specification_pufcc_axi_m0
,	'{'{CACHE ,8'h0},'{CACHE ,8'h1},'{CACHE ,8'h2},'{CACHE ,8'h3},'{PROT ,8'h0},'{PROT ,8'h1},'{PROT ,8'h2},'{CONST ,8'h0}} // Specification_usb_axi_m0
};
//! List for each target AXI sockets, how each userFlag is driven.
anvu_flag_info nocAxiTargUserFlagMapping[10][8] = '{
	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{PROT,8'h0},'{PROT,8'h1},'{PROT,8'h2},'{NONE,0}} // Specification_USB_axi_s0
,	'{'{CACHE,8'h0},'{CACHE,8'h1},'{CACHE,8'h2},'{CACHE,8'h3},'{PROT,8'h0},'{PROT,8'h1},'{PROT,8'h2},'{NONE,0}} // Specification_ddr_axi_s0
,	'{'{CACHE,8'h0},'{CACHE,8'h1},'{CACHE,8'h2},'{CACHE,8'h3},'{PROT,8'h0},'{PROT,8'h1},'{PROT,8'h2},'{NONE,0}} // Specification_ddr_axi_s1
,	'{'{CACHE,8'h0},'{CACHE,8'h1},'{CACHE,8'h2},'{CACHE,8'h3},'{PROT,8'h0},'{PROT,8'h1},'{PROT,8'h2},'{NONE,0}} // Specification_ddr_axi_s2
,	'{'{CACHE,8'h0},'{CACHE,8'h1},'{CACHE,8'h2},'{CACHE,8'h3},'{PROT,8'h0},'{PROT,8'h1},'{PROT,8'h2},'{NONE,0}} // Specification_ddr_axi_s3
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{PROT,8'h0},'{PROT,8'h1},'{PROT,8'h2},'{NONE,0}} // Specification_ddr_axil_s0
,	'{'{CACHE,8'h0},'{CACHE,8'h1},'{CACHE,8'h2},'{CACHE,8'h3},'{PROT,8'h0},'{PROT,8'h1},'{PROT,8'h2},'{NONE,0}} // Specification_sram_axi_s0
,	'{'{CACHE,8'h0},'{CACHE,8'h1},'{CACHE,8'h2},'{CACHE,8'h3},'{PROT,8'h0},'{PROT,8'h1},'{PROT,8'h2},'{NONE,0}} // Specification_sram_axi_s1
,	'{'{CACHE,8'h0},'{CACHE,8'h1},'{CACHE,8'h2},'{CACHE,8'h3},'{PROT,8'h0},'{PROT,8'h1},'{PROT,8'h2},'{NONE,0}} // Specification_sram_axi_s2
,	'{'{CACHE,8'h0},'{CACHE,8'h1},'{CACHE,8'h2},'{CACHE,8'h3},'{PROT,8'h0},'{PROT,8'h1},'{PROT,8'h2},'{NONE,0}} // Specification_sram_axi_s3
};

//! Associative array to find back the index of an initiator AXI socket based on a Flow Id.
int nocAxiInitIdxByFlowId[int];
//! Associative array to find back the index of an target AXI socket based on a Flow Id.
int nocAxiTargIdxByFlowId[int];
//! Associative array to find back the index of an initiator AXI socket based on a name.
int nocAxiInitIdxByName[string];
//! Associative array to find back the index of an target AXI socket based on a name.
int nocAxiTargIdxByName[string];
//! Associative array to find back the additionnal initiator configuration information based on a Flow Id.
anvu_axi_init_info nocAxiInitInfoByFlowId[int];
//! Associative array to find back the additionnal target configuration information based on a Flow Id.
anvu_axi_targ_info nocAxiTargInfoByFlowId[int];
//! Associative array to find back the anvu_axi_init_mstIdxMap object (related to flowIdMap in FlexNoC GUI) based on a FlowId.
anvu_axi_init_mstIdxMap nocAxiInitMastIdxMapByFlowId[int];


//
// APB sockets information
//

//! Additionnal configuration information for an APB initiator socket.
typedef struct packed {
	//! Address width of this socket.
	int      wAddr;
	//! Data width of this socket.
	int      wData;
	//! Endianness of the data of this socket, 1 is LITTLE endian, 0 is BIG endian.
	bit      littleEndian;
	//! APB version (3 or 4)
	int      version;
	//! Width of the User signal of the APB socket. Will be 0 if the signal does not exist.
	int      wUser;
	//! useBe parameter for APBV3, set to 1 for APBV4
	bit      useBe;
}	anvu_apb_init_info;

//! Additionnal configuration information for an APB target socket.
typedef struct packed {
	//! Address width of this socket.
	int      wAddr;
	//! Data width of this socket.
	int      wData;
	//! Endianness of the data of this socket, 1 is LITTLE endian, 0 is BIG endian.
	bit      littleEndian;
	//! APB version (3 or 4)
	int      version;
	//! Does the target NIU support soft locks.
	bit      useSoftLock;
	//! Does the target NIU support receiving strm preambles;
	bit      supportStrm;
	//! wLen parameter of the generic interface of the NIU
	int      wLen;
	//! useBe parameter for APBV3, set to 1 for APBV4
	bit      useBe;
}	anvu_apb_targ_info;

//! Number of initiator APB socket in the NoC.
int nocApbInitNb  = 0;
//! Number of target APB socket in the NoC.
int nocApbTargNb  = 13;

//! List of the names of the initiator APB socket of the NoC
string          nocApbInitName[$];
//! List of the names of the target APB socket of the NoC
string          nocApbTargName[$];

//! List of the additionnal configuration information of the initiator APB sockets of the NoC
anvu_apb_init_info nocApbInitInfo[] ;
//! List of the additionnal configuration information of the target APB sockets of the NoC
anvu_apb_targ_info nocApbTargInfo[13] = '{
	{32'd32,32'd32,1'd1,32'd3,1'd0,1'd0,32'd7,1'd1}
,	{32'd32,32'd32,1'd1,32'd3,1'd0,1'd0,32'd7,1'd1}
,	{32'd32,32'd32,1'd1,32'd3,1'd0,1'd0,32'd7,1'd1}
,	{32'd32,32'd32,1'd1,32'd3,1'd0,1'd1,32'd7,1'd1}
,	{32'd32,32'd32,1'd1,32'd3,1'd0,1'd1,32'd7,1'd1}
,	{32'd32,32'd32,1'd1,32'd3,1'd0,1'd1,32'd7,1'd1}
,	{32'd32,32'd32,1'd1,32'd3,1'd0,1'd1,32'd7,1'd1}
,	{32'd32,32'd32,1'd1,32'd3,1'd0,1'd1,32'd7,1'd1}
,	{32'd32,32'd32,1'd1,32'd4,1'd0,1'd0,32'd7,1'd1}
,	{32'd32,32'd32,1'd1,32'd3,1'd0,1'd0,32'd7,1'd1}
,	{32'd32,32'd32,1'd1,32'd3,1'd0,1'd1,32'd7,1'd1}
,	{32'd32,32'd32,1'd1,32'd3,1'd0,1'd1,32'd7,1'd1}
,	{32'd32,32'd32,1'd1,32'd3,1'd0,1'd0,32'd7,1'd1}
};

//! For each initiator Apb sockets, for each security levels. Defines if the security level is reachable by the VIP. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals of the protocol.
bit[0:0] nocApbInitReachableSecurityLevels[] ;
//! List of bases (one for each initiator APB sockets) allowing to find the security levels which are reacheable by the environment. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals.
//! If there are no security flags, these values have no meaning.
bit[0:0] nocApbInitReachableSecurityBases[] ;
//! List of masks (one for each initiator APB sockets) allowing to find the security levels which are reacheable by the environment. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals.
//! If there are no security flags, these values have no meaning.
bit[0:0] nocApbInitReachableSecurityMasks[] ;
//! List of bases (one for each initiator APB sockets) allowing to find the user levels which are reacheable by the environment. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals.
//! If there are no user flags, these values have no meaning.
bit[7:0] nocApbInitReachableUserBases[] ;
//! List of masks (one for each initiator APB sockets) allowing to find the user levels which are reacheable by the environment. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals.
//! If there are no user flags, these values have no meaning.
bit[7:0] nocApbInitReachableUserMasks[] ;
//! List for each initiator Apb sockets, how each securityFlag is driven.
anvu_flag_info nocApbInitSecurityFlagMapping[] ;
//! List for each target APB sockets, how each securityFlag is driven.
anvu_flag_info nocApbTargSecurityFlagMapping[] ;
//! List for each initiator APB sockets, how each userFlag is driven.
anvu_flag_info nocApbInitUserFlagMapping[] ;
//! List for each target APB sockets, how each userFlag is driven.
anvu_flag_info nocApbTargUserFlagMapping[13][8] = '{
	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0}} // Specification_SCU_Multi_APB
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0}} // Specification_SCU_Multi_APB
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0}} // Specification_DMA_apb_s0
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0}} // Specification_FCB_apb_s0
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0}} // Specification_Periph_Multi_APB
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0}} // Specification_Periph_Multi_APB
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0}} // Specification_Periph_Multi_APB
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0}} // Specification_Periph_Multi_APB
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{PROT,8'h0},'{PROT,8'h1},'{PROT,8'h2},'{NONE,0}} // Specification_PUFCC_apb_s0
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0}} // Specification_SCU_Multi_APB
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0}} // Specification_Periph_Multi_APB
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0}} // Specification_Periph_Multi_APB
,	'{'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0},'{NONE,0}} // Specification_gbe_apb_s0
};

//! Associative array to find back the index of an initiator APB socket based on a Flow Id.
int nocApbInitIdxByFlowId[int];
//! Associative array to find back the index of an target APB socket based on a Flow Id.
int nocApbTargIdxByFlowId[int];
//! Associative array to find back the index of an initiator APB socket based on a name.
int nocApbInitIdxByName[string];
//! Associative array to find back the index of an target APB socket based on a name.
int nocApbTargIdxByName[string];
//! Associative array to find back the additionnal initiator configuration information based on a Flow Id.
anvu_apb_init_info nocApbInitInfoByFlowId[int];
//! Associative array to find back the additionnal target configuration information based on a Flow Id.
anvu_apb_targ_info nocApbTargInfoByFlowId[int];


//
// AHB sockets information
//

//! Additionnal configuration information for an AHB initiator socket.
typedef struct packed {
	//! Address width of this socket.
	int      wAddr;
	//! Data width of this socket.
	int      wData;
	//! Endianness of the data of this socket, 0='LITTLE' , 1='BE8' , 2='BE32', 3='BIG'.
	int      littleEndian;
	//! How are Lock converted. If usePreLock is True, any sequence are supported.
	bit      usePreLock;
	//! rdSplit performance parameter
	int      rdSplit;
	//! wrSplit performance parameter
	int      wrSplit;
	//! Maximum length (number of beats) of the Wrap bursts supported by the NIU connected to this socket.
	int      wrapMax;
	//! Minimum value for XferSize.
	int      minXferSize;
	//! Width of the User signal of the AHB socket. Will be 0 if the signal does not exist.
	int      wUser;
	//! Suport for Strb of this socket.
	bit      useStrb;
	//! Min alignment of WRAP supported by the NIU connected to the AHB socket.
	int      minWrapAlign;
	//! Is the socket configured to ignore HReady for BUSY?
	bit      busyIgnoreWaits;
	//! Version of the AHB socket. 0=V3, 1 =V5.
	int      version;
	//! Master width of this socket.
	int      wMaster;
	//! Prot width of this socket.
	int      wProt;
	//! NonSec support.
	int      wNonSec;
	//! Exclusive support.
	bit      useExcl;
}	anvu_ahb_init_info;

//! Additionnal configuration information for an AHB target socket.
typedef struct packed {
	//! Address width of this socket.
	int      wAddr;
	//! Data width of this socket.
	int      wData;
	//! Endianness of the data of this socket, 0='LITTLE' , 1='BE8' , 2='BE32', 3='BIG'.
	int      littleEndian;
	//! Does the target NIU support soft locks.
	bit      useSoftLock;
	//! Does the target NIU support hard locks.
	bit      useHardLock;
	//! Suport for Strb of this socket.
	bit      useStrb;
	//! Does the target NIU support receiving strm preambles;
	bit      supportStrm;
	//! wLen parameter of the generic interface of the NIU
	int      wLen;
	//! Version of the AHB socket. 0=V3, 1 =V5.
	int      version;
	//! Master width of this socket.
	int      wMaster;
	//! Prot width of this socket.
	int      wProt;
	//! NonSec support.
	int      wNonSec;
	//! Exclusive support.
	bit      useExcl;
}	anvu_ahb_targ_info;

//! Number of initiator AHB socket in the NoC.
int nocAhbInitNb  = 1;
//! Number of target AHB socket in the NoC.
int nocAhbTargNb  = 3;

//! List of the names of the initiator AHB socket of the NoC
string          nocAhbInitName[$];
//! List of the names of the target AHB socket of the NoC
string          nocAhbTargName[$];

//! List of the additionnal configuration information of the initiator AHB sockets of the NoC
anvu_ahb_init_info nocAhbInitInfo[1] = '{
	{32'd32,32'd32,32'd0,1'd0,32'd4,32'd4,32'd16,32'd2,32'd0,1'd1,32'd4,1'd0,32'd4,32'd0,32'd4,32'd0,1'd0}
};
//! List of the additionnal configuration information of the target AHB sockets of the NoC
anvu_ahb_targ_info nocAhbTargInfo[3] = '{
	{32'd32,32'd32,32'd0,1'd0,1'd0,1'd1,1'd0,32'd6,32'd4,32'd0,32'd4,32'd0,1'd0}
,	{32'd32,32'd32,32'd0,1'd0,1'd0,1'd1,1'd0,32'd6,32'd4,32'd0,32'd4,32'd0,1'd0}
,	{32'd32,32'd32,32'd0,1'd0,1'd0,1'd1,1'd0,32'd6,32'd4,32'd0,32'd4,32'd0,1'd0}
};

//! For each initiator Ahb sockets, for each security levels. Defines if the security level is reachable by the VIP. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals of the protocol.
bit[0:0] nocAhbInitReachableSecurityLevels[1] = '{
	1'b1
};
//! List of bases (one for each initiator AHB sockets) allowing to find the security levels which are reacheable by the environment. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals.
//! If there are no security flags, these values have no meaning.
bit[0:0] nocAhbInitReachableSecurityBases[1] = '{
	1'b0
};
//! List of masks (one for each initiator AHB sockets) allowing to find the security levels which are reacheable by the environment. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals.
//! If there are no security flags, these values have no meaning.
bit[0:0] nocAhbInitReachableSecurityMasks[1] = '{
	1'b0
};
//! List of bases (one for each initiator AHB sockets) allowing to find the user levels which are reacheable by the environment. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals.
//! If there are no user flags, these values have no meaning.
bit[7:0] nocAhbInitReachableUserBases[1] = '{
	8'b00100000
};
//! List of masks (one for each initiator AHB sockets) allowing to find the user levels which are reacheable by the environment. Unreachable levels can be due to flags mapped to Constant, or mapped to undrivable signals.
//! If there are no user flags, these values have no meaning.
bit[7:0] nocAhbInitReachableUserMasks[1] = '{
	8'b11101100
};
//! List for each initiator Ahb sockets, how each securityFlag is driven.
anvu_flag_info nocAhbInitSecurityFlagMapping[] ;
//! List for each target AHB sockets, how each securityFlag is driven.
anvu_flag_info nocAhbTargSecurityFlagMapping[] ;
//! List for each initiator AHB sockets, how each userFlag is driven.
anvu_flag_info nocAhbInitUserFlagMapping[1][8] = '{
	'{'{PROT ,8'h2},'{PROT ,8'h3},'{CONST ,8'h0},'{CONST ,8'h0},'{PROT ,8'h1},'{CONST ,8'h1},'{PROT ,8'h0},'{CONST ,8'h0}} // Specification_bcpu_ahb_m0
};
//! List for each target AHB sockets, how each userFlag is driven.
anvu_flag_info nocAhbTargUserFlagMapping[3][8] = '{
	'{'{PROT,8'h2},'{PROT,8'h3},'{NONE,0},'{NONE,0},'{PROT,8'h1},'{NONE,0},'{PROT,8'h0},'{NONE,0}} // Specification_SPI_ahb_s0
,	'{'{PROT,8'h2},'{PROT,8'h3},'{NONE,0},'{NONE,0},'{PROT,8'h1},'{NONE,0},'{PROT,8'h0},'{NONE,0}} // Specification_SPI_mem_ahb
,	'{'{PROT,8'h2},'{PROT,8'h3},'{NONE,0},'{NONE,0},'{PROT,8'h1},'{NONE,0},'{PROT,8'h0},'{NONE,0}} // Specification_fpga_ahb_s0
};

//! Associative array to find back the index of an initiator AHB socket based on a Flow Id.
int nocAhbInitIdxByFlowId[int];
//! Associative array to find back the index of an target AHB socket based on a Flow Id.
int nocAhbTargIdxByFlowId[int];
//! Associative array to find back the index of an initiator AHB socket based on a name.
int nocAhbInitIdxByName[string];
//! Associative array to find back the index of an target AHB socket based on a name.
int nocAhbTargIdxByName[string];
//! Associative array to find back the additionnal initiator configuration information based on a Flow Id.
anvu_ahb_init_info nocAhbInitInfoByFlowId[int];
//! Associative array to find back the additionnal target configuration information based on a Flow Id.
anvu_ahb_targ_info nocAhbTargInfoByFlowId[int];






// Commons

// Associative array that return the Flow Id of a Power Controller socket for every Flow Id of data socket of the NoC.
int nocPwrFlowIdBySocketFlowId[int];

//! Associative array that return of every Flow Id of a data socket of the NoC, the type of this socket.
eSocketType nocSocketTypeByFlowId[int];

//! Associative array that return of every initiator Flow Id of a data socket of the NoC, the maximum address valid for this flow.
longint nocMaxAddrByInitFlowId[int];
//! Associative array that 2 bits per Flow Id of a data socket of the NoC. Bit 0 set to 1'b1, means READ transaction are supported. Bit 1 for WRITE transaction;
bit[1:0] nocOpcodesByInitFlowId[int];

//! Associative array per initiator Flow Id , defining in one hot what security level are reachable from this initiator.
bit[0:0] nocReachableSecurityLevelsByInitFlowId[int];
//! Associative array per initiator Flow Id , defining the "base" which allows to find what security level are reachable from this initiator.
bit[0:0] nocReachableSecurityBasesByInitFlowId[int];
//! Associative array per initiator Flow Id , defining the "mask" which allows to find what security level are reachable from this initiator.
bit[0:0] nocReachableSecurityMasksByInitFlowId[int];
//! Associative array per initiator Flow Id , defining the "base" which allows to find what user levels are reachable from this initiator.
bit[7:0] nocReachableUserBasesByInitFlowId[int];
//! Associative array per initiator Flow Id , defining the "mask" which allows to find what user levels are reachable from this initiator.
bit[7:0] nocReachableUserMasksByInitFlowId[int];


// ModeFlag and mode support variables


//! Number of ModeFlag defined for the NoC
int nocModeFlagNb = 0;
//! List of all the NoC mode flags. The position of each modeflag is the array is the position of the associated bit in a mode integer.
string nocModeFlagName[$];

//! List for each modeFlag, the value required for each ModePort to set the given flag. -1 is special to say don't care.
int nocModeFlagModePortValues[1][1] ;

//! List of meaningfull mode to test for each initiator flowId. 16'hffff is a special entry to skip, required because we need fixed size array here.
int nocMeaningfullModeByInitFlowId[int][$];

//! Define the mode flag value to be used by default by tests
int nocDfltMode = 0;

int _initDone  = 0;
int _fillStrArrayDone = 0;

//! Initialisation function which fills all string queues declared above.
function void anvu_noc_definitions_fillStrArrays();
	if (_fillStrArrayDone) return;
	_fillStrArrayDone = 1;

	nocClkRegimeDriverName.push_back("fpga_regime_m0");
	nocClkRegimeDriverName.push_back("fpga_regime_m1");
	nocClkRegimeDriverName.push_back("fpga_regime_s0");
	nocClkRegimeDriverName.push_back("interconnect_synch_regime");
	nocAxiInitName.push_back("acpu_axi_m0");
	nocAxiInitName.push_back("arm_axi_m0");
	nocAxiInitName.push_back("dma_axi_m0");
	nocAxiInitName.push_back("dma_axi_m1");
	nocAxiInitName.push_back("fpga_axi_m0");
	nocAxiInitName.push_back("fpga_axi_m1");
	nocAxiInitName.push_back("gbe_axi_m0");
	nocAxiInitName.push_back("pufcc_axi_m0");
	nocAxiInitName.push_back("usb_axi_m0");
	nocModePortDriverName.push_back("port1");
	nocRstnDriverName.push_back("fpga_rstm0_n");
	nocRstnDriverName.push_back("fpga_rstm1_n");
	nocRstnDriverName.push_back("fpga_rsts0_n");
	nocRstnDriverName.push_back("rst_133_n");
	nocRstnDriverName.push_back("rst_266_n");
	nocRstnDriverName.push_back("rst_533_n");
	nocAhbInitName.push_back("bcpu_ahb_m0");
	nocAxiTargName.push_back("USB_axi_s0");
	nocAxiTargName.push_back("ddr_axi_s0");
	nocAxiTargName.push_back("ddr_axi_s1");
	nocAxiTargName.push_back("ddr_axi_s2");
	nocAxiTargName.push_back("ddr_axi_s3");
	nocAxiTargName.push_back("ddr_axil_s0");
	nocAxiTargName.push_back("sram_axi_s0");
	nocAxiTargName.push_back("sram_axi_s1");
	nocAxiTargName.push_back("sram_axi_s2");
	nocAxiTargName.push_back("sram_axi_s3");
	nocSignalDriverName.push_back("tm");
	nocApbTargName.push_back("ACPU_WDT");
	nocApbTargName.push_back("BCPU_WDT");
	nocApbTargName.push_back("DMA_apb_s0");
	nocApbTargName.push_back("FCB_apb_s0");
	nocApbTargName.push_back("GPIO_apb_s0");
	nocApbTargName.push_back("GPT_apb_s0");
	nocApbTargName.push_back("I2C_apb_s0");
	nocApbTargName.push_back("MBOX_apb_s0");
	nocApbTargName.push_back("PUFCC_apb_s0");
	nocApbTargName.push_back("SCU");
	nocApbTargName.push_back("UART_apb_s0");
	nocApbTargName.push_back("UART_apb_s1");
	nocApbTargName.push_back("gbe_apb_s0");
	nocAhbTargName.push_back("SPI_ahb_s0");
	nocAhbTargName.push_back("SPI_mem_ahb");
	nocAhbTargName.push_back("fpga_ahb_s0");
	nocUserFlagName.push_back("Cache_0");
	nocUserFlagName.push_back("Cache_1");
	nocUserFlagName.push_back("Cache_2");
	nocUserFlagName.push_back("Cache_3");
	nocUserFlagName.push_back("Prot_0");
	nocUserFlagName.push_back("Prot_1");
	nocUserFlagName.push_back("Prot_2");
	nocUserFlagName.push_back("user_endianness");

	extractTestOptions();
endfunction


//! Initialisation function for all the data objects associated to the NoC.
//! This function :
//! - Creates and fill the configuration objects for each sockets of the NoC.
//! - Fills the different associative arrays.
function automatic void anvu_noc_definitions_init();
	anvu_flow socketFlow;
	anvu_flow threadFlow;
	if (_initDone) return;
	_initDone = 1;

	foreach (nocAxiInitName[i]) begin
		anvu_axi_init_mstIdxMap axiMap = new();
		axiMap.nMstIdx = nocAxiInitInfo[i].nFlow;
		axiMap.wAid    = nocAxiInitInfo[i].wAid;
		socketFlow     = Flow_fromName(nocAxiInitName[i]);
		nocAxiInitMastIdxMapByFlowId[socketFlow.id()] = axiMap;
		nocAxiInitIdxByName[nocAxiInitName[i]] = i;
		nocAxiInitIdxByFlowId[socketFlow.id()] = i;
		nocAxiInitInfoByFlowId[socketFlow.id()] = nocAxiInitInfo[i];
		nocSocketTypeByFlowId[socketFlow.id()] = anvu_commons_pkg::AXI;
		for (int j=0 ; j < nocAxiInitInfo[i].nFlow ; j ++ ) begin
			threadFlow = socketFlow.get(j);
			nocAxiInitIdxByFlowId[threadFlow.id()] = i;
			nocAxiInitInfoByFlowId[threadFlow.id()] = nocAxiInitInfo[i];
			nocSocketTypeByFlowId[threadFlow.id()] = anvu_commons_pkg::AXI;
			nocMaxAddrByInitFlowId[threadFlow.id()] =  64'h1 << nocAxiInitInfo[i].wGenAddr;
			nocOpcodesByInitFlowId[threadFlow.id()] =  {nocAxiInitInfo[i].enWr,nocAxiInitInfo[i].enRd};
			nocReachableSecurityLevelsByInitFlowId[threadFlow.id()] =  nocAxiInitReachableSecurityLevels[i];
			nocReachableSecurityBasesByInitFlowId [threadFlow.id()] =  nocAxiInitReachableSecurityBases [i];
			nocReachableSecurityMasksByInitFlowId [threadFlow.id()] =  nocAxiInitReachableSecurityMasks [i];
			nocReachableUserBasesByInitFlowId     [threadFlow.id()] =  nocAxiInitReachableUserBases     [i];
			nocReachableUserMasksByInitFlowId     [threadFlow.id()] =  nocAxiInitReachableUserMasks     [i];
		end
	end
	foreach (nocAxiTargName[i]) begin
		socketFlow = Flow_fromName(nocAxiTargName[i]);
		nocAxiTargIdxByName[nocAxiTargName[i]] = i;
		nocAxiTargIdxByFlowId[socketFlow.id()] = i;
		nocAxiTargInfoByFlowId[socketFlow.id()] = nocAxiTargInfo[i];
		nocSocketTypeByFlowId[socketFlow.id()] = anvu_commons_pkg::AXI;
		for (int j=0 ; j < nocAxiTargInfo[i].nFlow ; j ++ ) begin
			threadFlow = socketFlow.get(j);
			nocAxiTargIdxByFlowId[threadFlow.id()] = i;
			nocAxiTargInfoByFlowId[threadFlow.id()] = nocAxiTargInfo[i];
			nocSocketTypeByFlowId[threadFlow.id()] = anvu_commons_pkg::AXI;
		end
	end
	
	begin
		anvu_axi_init_mstIdxMap axiMap=new();
		socketFlow = Flow_fromName("acpu_axi_m0");
		axiMap = nocAxiInitMastIdxMapByFlowId[socketFlow.id()];
	end
	begin
		anvu_axi_init_mstIdxMap axiMap=new();
		socketFlow = Flow_fromName("arm_axi_m0");
		axiMap = nocAxiInitMastIdxMapByFlowId[socketFlow.id()];
	end
	begin
		anvu_axi_init_mstIdxMap axiMap=new();
		socketFlow = Flow_fromName("dma_axi_m0");
		axiMap = nocAxiInitMastIdxMapByFlowId[socketFlow.id()];
	end
	begin
		anvu_axi_init_mstIdxMap axiMap=new();
		socketFlow = Flow_fromName("dma_axi_m1");
		axiMap = nocAxiInitMastIdxMapByFlowId[socketFlow.id()];
	end
	begin
		anvu_axi_init_mstIdxMap axiMap=new();
		socketFlow = Flow_fromName("fpga_axi_m0");
		axiMap = nocAxiInitMastIdxMapByFlowId[socketFlow.id()];
	end
	begin
		anvu_axi_init_mstIdxMap axiMap=new();
		socketFlow = Flow_fromName("fpga_axi_m1");
		axiMap = nocAxiInitMastIdxMapByFlowId[socketFlow.id()];
	end
	begin
		anvu_axi_init_mstIdxMap axiMap=new();
		socketFlow = Flow_fromName("gbe_axi_m0");
		axiMap = nocAxiInitMastIdxMapByFlowId[socketFlow.id()];
	end
	begin
		anvu_axi_init_mstIdxMap axiMap=new();
		socketFlow = Flow_fromName("pufcc_axi_m0");
		axiMap = nocAxiInitMastIdxMapByFlowId[socketFlow.id()];
	end
	begin
		anvu_axi_init_mstIdxMap axiMap=new();
		socketFlow = Flow_fromName("usb_axi_m0");
		axiMap = nocAxiInitMastIdxMapByFlowId[socketFlow.id()];
	end



	foreach (nocApbInitName[i]) begin
		socketFlow = Flow_fromName(nocApbInitName[i]);
		nocApbInitIdxByName[nocApbInitName[i]] = i;
		nocApbInitIdxByFlowId[socketFlow.id()] = i;
		nocApbInitInfoByFlowId[socketFlow.id()] = nocApbInitInfo[i];
		nocSocketTypeByFlowId[socketFlow.id()] = anvu_commons_pkg::APB;
		threadFlow = socketFlow.get(0);
		nocApbInitIdxByFlowId[threadFlow.id()] = i;
		nocApbInitInfoByFlowId[threadFlow.id()] = nocApbInitInfo[i];
		nocSocketTypeByFlowId[threadFlow.id()] = anvu_commons_pkg::APB;
		nocMaxAddrByInitFlowId[threadFlow.id()] =  64'h1 << nocApbInitInfo[i].wAddr;
		nocOpcodesByInitFlowId[threadFlow.id()] =  {1'b1,1'b1};
		nocReachableSecurityLevelsByInitFlowId[threadFlow.id()] =  nocApbInitReachableSecurityLevels[i];
		nocReachableSecurityBasesByInitFlowId [threadFlow.id()] =  nocApbInitReachableSecurityBases [i];
		nocReachableSecurityMasksByInitFlowId [threadFlow.id()] =  nocApbInitReachableSecurityMasks [i];
		nocReachableUserBasesByInitFlowId     [threadFlow.id()] =  nocApbInitReachableUserBases     [i];
		nocReachableUserMasksByInitFlowId     [threadFlow.id()] =  nocApbInitReachableUserMasks     [i];
		
	end
	foreach (nocApbTargName[i]) begin
		socketFlow = Flow_fromName(nocApbTargName[i]);
		nocApbTargIdxByName[nocApbTargName[i]] = i;
		nocApbTargIdxByFlowId[socketFlow.id()] = i;
		nocApbTargInfoByFlowId[socketFlow.id()] = nocApbTargInfo[i];
		nocSocketTypeByFlowId[socketFlow.id()] = anvu_commons_pkg::APB;
		threadFlow = socketFlow.get(0);
		nocApbTargIdxByFlowId[threadFlow.id()] = i;
		nocApbTargInfoByFlowId[threadFlow.id()] = nocApbTargInfo[i];
		nocSocketTypeByFlowId[threadFlow.id()] = anvu_commons_pkg::APB;
		
	end

	foreach (nocAhbInitName[i]) begin
		socketFlow = Flow_fromName(nocAhbInitName[i]);
		nocAhbInitIdxByName[nocAhbInitName[i]] = i;
		nocAhbInitIdxByFlowId[socketFlow.id()] = i;
		nocAhbInitInfoByFlowId[socketFlow.id()] = nocAhbInitInfo[i];
		nocSocketTypeByFlowId[socketFlow.id()] = anvu_commons_pkg::AHB;
		threadFlow = socketFlow.get(0);
		nocAhbInitIdxByFlowId[threadFlow.id()] = i;
		nocAhbInitInfoByFlowId[threadFlow.id()] = nocAhbInitInfo[i];
		nocSocketTypeByFlowId[threadFlow.id()] = anvu_commons_pkg::AHB;
		nocMaxAddrByInitFlowId[threadFlow.id()] =  64'h1 << nocAhbInitInfo[i].wAddr;
		nocOpcodesByInitFlowId[threadFlow.id()] =  {1'b1,1'b1};
		nocReachableSecurityLevelsByInitFlowId[threadFlow.id()] =  nocAhbInitReachableSecurityLevels[i];
		nocReachableSecurityBasesByInitFlowId [threadFlow.id()] =  nocAhbInitReachableSecurityBases [i];
		nocReachableSecurityMasksByInitFlowId [threadFlow.id()] =  nocAhbInitReachableSecurityMasks [i];
		nocReachableUserBasesByInitFlowId     [threadFlow.id()] =  nocAhbInitReachableUserBases     [i];
		nocReachableUserMasksByInitFlowId     [threadFlow.id()] =  nocAhbInitReachableUserMasks     [i];
		
	end
	foreach (nocAhbTargName[i]) begin
		socketFlow = Flow_fromName(nocAhbTargName[i]);
		nocAhbTargIdxByName[nocAhbTargName[i]] = i;
		nocAhbTargIdxByFlowId[socketFlow.id()] = i;
		nocAhbTargInfoByFlowId[socketFlow.id()] = nocAhbTargInfo[i];
		nocSocketTypeByFlowId[socketFlow.id()] = anvu_commons_pkg::AHB;
		threadFlow = socketFlow.get(0);
		nocAhbTargIdxByFlowId[threadFlow.id()] = i;
		nocAhbTargInfoByFlowId[threadFlow.id()] = nocAhbTargInfo[i];
		nocSocketTypeByFlowId[threadFlow.id()] = anvu_commons_pkg::AHB;
		
	end

	foreach (nocClkRegimeDriverName[i])  nocClkRegimeDriverIdxByName[nocClkRegimeDriverName[i]] = i;
	foreach (nocRstnReaderName[i])       nocRstnReaderIdxByName[nocRstnReaderName[i]] = i;
	foreach (nocRstnDriverName[i])       nocRstnDriverIdxByName[nocRstnDriverName[i]] = i;
	foreach (nocSignalReaderName[i])     nocSignalReaderIdxByName[nocSignalReaderName[i]] = i;
	foreach (nocSignalDriverName[i])     nocSignalDriverIdxByName[nocSignalDriverName[i]] = i;
	foreach (nocClkEnDriverName[i])      nocClkEnDriverIdxByName[nocClkEnDriverName[i]] = i;
	foreach (nocModePortDriverName[i])   begin
		socketFlow = Flow_fromName(nocModePortDriverName[i]);
		nocModePortDriverIdxByName[nocModePortDriverName[i]] = i;
		nocModePortDriverIdxByFlowId[socketFlow.id()] = i;
	end


	foreach (nocRstnReaderName[i])       nocRstnReaderIdxByName[nocRstnReaderName[i]] = i;
	foreach (nocRstnDriverName[i])       nocRstnDriverIdxByName[nocRstnDriverName[i]] = i;
	foreach (nocSignalReaderName[i])     nocSignalReaderIdxByName[nocSignalReaderName[i]] = i;
	foreach (nocSignalDriverName[i])     nocSignalDriverIdxByName[nocSignalDriverName[i]] = i;
	foreach (nocClkEnDriverName[i])      nocClkEnDriverIdxByName[nocClkEnDriverName[i]] = i;
	foreach (nocModePortDriverName[i])   begin
		socketFlow = Flow_fromName(nocModePortDriverName[i]);
		nocModePortDriverIdxByName[nocModePortDriverName[i]] = i;
		nocModePortDriverIdxByFlowId[socketFlow.id()] = i;
	end

	

	nocUserBitInversionByFlowId[FlowId_fromName("dma_axi_m1")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("dma_axi_m1")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("usb_axi_m0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("usb_axi_m0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("arm_axi_m0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("arm_axi_m0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("fpga_axi_m0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("fpga_axi_m0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("bcpu_ahb_m0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("bcpu_ahb_m0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("dma_axi_m0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("dma_axi_m0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("acpu_axi_m0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("acpu_axi_m0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("fpga_axi_m1")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("fpga_axi_m1")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("gbe_axi_m0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("gbe_axi_m0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("pufcc_axi_m0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("pufcc_axi_m0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("I2C_apb_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("I2C_apb_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("fpga_ahb_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("fpga_ahb_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("ddr_axi_s2")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("ddr_axi_s2")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("DMA_apb_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("DMA_apb_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("SPI_ahb_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("SPI_ahb_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("sram_axi_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("sram_axi_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("UART_apb_s1")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("UART_apb_s1")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("SPI_mem_ahb")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("SPI_mem_ahb")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("USB_axi_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("USB_axi_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("ACPU_WDT")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("ACPU_WDT")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("ddr_axi_s3")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("ddr_axi_s3")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("ddr_axi_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("ddr_axi_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("sram_axi_s3")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("sram_axi_s3")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("SCU")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("SCU")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("PUFCC_apb_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("PUFCC_apb_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("sram_axi_s1")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("sram_axi_s1")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("ddr_axil_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("ddr_axil_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("GPT_apb_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("GPT_apb_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("FCB_apb_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("FCB_apb_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("BCPU_WDT")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("BCPU_WDT")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("gbe_apb_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("gbe_apb_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("ddr_axi_s1")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("ddr_axi_s1")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("sram_axi_s2")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("sram_axi_s2")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("GPIO_apb_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("GPIO_apb_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("MBOX_apb_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("MBOX_apb_s0")] = 64'h0;
	nocUserBitInversionByFlowId[FlowId_fromName("UART_apb_s0")] = 64'h0;
	nocSecurityBitInversionByFlowId[FlowId_fromName("UART_apb_s0")] = 64'h0;

	// Association of the Data sockets with their power socket, if it exists
	


endfunction


//! return the mode corresponding to the mode port value provided.
//! ModePort value in the array are in the order of the nocModePortDriverName declaration
function automatic int getModeFromModePortValues(int modePortValues[]);
	int mode = 0;
	foreach ( nocModeFlagModePortValues[i] ) begin
		bit valid = 1;
		for (int j=0;j<nocModePortDriverNb;j++) begin
			int expValue = nocModeFlagModePortValues[i][j];
			if ( expValue == -1 ) continue;
			if ( expValue != modePortValues[j] ) begin
				valid = 0;
				break;
			end
		end
		mode |= valid << i;
	end
	return mode;
endfunction

class anvu_modePort_values;
	rand int modePortValues[32];
	bit modeBits[];
	int mode;

	
	constraint width_constraints {
		foreach (nocModePortDriverWidth[i]) {
			if (nocModePortDriverWidth[i]==1)
				modePortValues[i] <= 1;
			else
				modePortValues[i] <  64'b1<<nocModePortDriverWidth[i];
			modePortValues[i] >= 0;
		}
	}
	function void randomizeAndCheck();
		bit ok = 0;
		int count = 0;
		foreach(modePortValues[i]) modePortValues[i] = -1;
		foreach(modeBits[i]) begin
			for(int j=0;j<nocModePortDriverNb;j++) begin
				if (modeBits[i] == 1 && nocModeFlagModePortValues[i][j] != -1) begin
					if (modePortValues[j] != -1 && modePortValues[j]!=nocModeFlagModePortValues[i][j])
							`uvm_error("anvu_bench",$psprintf("Could not generate a set of ModePorts values to get to mode %x",mode))
					modePortValues[j] = nocModeFlagModePortValues[i][j];
					modePortValues[j].rand_mode(0);
				end
			end
		end
		while (!ok && count<10000) begin
			if (!randomize()) begin
				`uvm_error("anvu_bench","Unexpected randomization failed")
			end
			ok = getModeFromModePortValues(modePortValues) == mode;
			count += 1;
		end
		if (count == 10000) begin
			`uvm_error("anvu_bench",$psprintf("Could not randomize the ModePorts to get to mode %x",mode))
		end
	endfunction
	
	function new(int mode);
		this.mode = mode;
		modeBits = new[nocModeFlagNb];
		foreach(modeBits[i])
			modeBits[i] = (mode>>i)%2;
	endfunction
endclass
//! Fill the provided modePortValues array with values that will set the NoC in the provided mode.
//! ModePort value in the array are in the order of the nocModePortDriverName declaration
function automatic void computeModePortValuesForMode(int mode, ref int modePortValues[]);
	anvu_modePort_values values = new(mode);
	values.randomizeAndCheck();
	foreach(modePortValues[i]) modePortValues[i] = values.modePortValues[i];
endfunction

//! Compute a display string for the given mode.
//! The string is following the format ModeFlag0 & !ModeFlag1 & ..
function automatic string getModeStr(int mode);
	bit first = 1;
	string s = "";
	foreach(nocModeFlagName[i]) begin
		if (!first) s = { s , " & " };
		else        first=0;
		if ((mode>>i)%2==0) s = { s, "!" };
		else                s = { s, " " };
		s = { s , nocModeFlagName[i] };
	end
	return s;
endfunction

//! Compute a display string for the given securityLevel.
//! The string is following the format SecurityFlag0 & !SecurityFlag1 & ..
function automatic string getSecurityLevelStr(int securityLevel);
	bit first = 1;
	string s = "";
	foreach(nocSecurityFlagName[i]) begin
		if (!first) s = { s , " & " };
		else        first=0;
		if ((securityLevel>>i)%2==0) s = { s, "!" };
		else                         s = { s, " " };
		s = { s , nocSecurityFlagName[i] };
	end
	return s;
endfunction

//! For each token of the format "a=b" in the anvu_test_options plusarg
//! this associative array contains an entry for "a" with value "b"
string nocTestOptionsKeywords[string];
//! For each token of the format "xx" in the anvu_test_options plusarg
//! this associative array contains an entry for "xx" with value 1
bit    nocTestOptionsArguments[string];

//! This functions analyzes the content of the +anvu_test_options runtime plusarg to fill
//! both nocTestOptionsKeywords and nocTestOptiosnArguments in the following way
//! Split the testOptions string on 'space'
//! For each item, if it has '=' within it, add to keywords
//! else add to arguments
function automatic void extractTestOptions();
	string testOptionStr;
	string tokens[$];
	if (!$value$plusargs("anvu_test_options=%s",testOptionStr))
		testOptionStr = "";
	stringSplit(testOptionStr,tokens);
	foreach(tokens[i]) begin
		string elts[$];
		stringSplit(tokens[i],elts,"=");
		if (elts.size()==1) begin
			nocTestOptionsArguments[elts[0]] = 1;
			`uvm_info("anvu_test",$psprintf("Adding testOption argument '%s'",elts[0]),uvm_pkg::UVM_HIGH)
		end else if (elts.size()==2) begin
			nocTestOptionsKeywords[elts[0]] = elts[1];
			`uvm_info("anvu_test",$psprintf("Adding testOption keyword '%s'='%s'",elts[0],elts[1]),uvm_pkg::UVM_HIGH)
		end else begin
			`uvm_error("anvu_test",$psprintf("Unexpected entry in the anvu_test_options : '%s'",tokens[i]))
		end
	end
endfunction

function automatic void getFlowIdFromTestOptions(output bit initFlowId[int],output bit targFlowId[int]);
	anvu_flow socketFlow;
	initFlowId.delete();
	targFlowId.delete();
	foreach(nocTestOptionsArguments[k]) begin
		socketFlow = Flow_fromName(k);
		if (nocSocketTypeByFlowId[socketFlow.id()]==UNK) begin
			`uvm_fatal("anvu_test",$psprintf("Unknown socket name passed in the anvu_test_options string : '%s'",k))
		end
		if (socketFlow.isInitiator()) initFlowId[socketFlow.id()] = 1;
		else                          targFlowId[socketFlow.id()] = 1;
	end
endfunction


// Memory Map
typedef enum {READ,WRITE} t_opcode;

import "DPI-C" context function chandle _D_MemoryMap_New
(	int id
);
import "DPI-C" context function void _D_MemoryMap_load
(	chandle    me
,	string     filename
,	output bit success
);
//ZB
import "DPI-C" context function void _D_MemoryMap_translate
(	chandle me
,	int    initiatorFlowId
,	inout  longint         initiatorAddress
,	input  int             accessType
,	input  int             permissions
,	output int             targetFlowId
,	output longint         targetAddress
,	output int             targetFlowIdWithNoRights
);

import "DPI-C" context function void _D_MemoryMap_translate_all
(	chandle me
,	int    initiatorFlowId
,	inout  longint         initiatorAddress
,	input  int             accessType
,	input  int             permissions
,	output int             targetFlowId[]
,	output longint         targetAddress[]
,	output int             targetWbsMasks[]
,	output int             targetPostedMasks[]
,	output int             size
);
import "DPI-C" context function void _D_MemoryMap_nextBoundary
(	chandle me
,	int    initiatorFlowId
,	inout  longint         startAddress
,	output longint         endAddress
,	output bit             isInterleaved
);
import "DPI-C" context function void _D_MemoryMap_nextMaskedBoundary
(	chandle me
,	int    initiatorFlowId
,	inout  longint         startAddress
,	inout  longint         maxAddress
,	output longint         endAddress
);
import "DPI-C" context function void _D_MemoryMap_findNotriggedPaths
(	chandle me
,	input    int    initiatorFlowId
,	input    int    modes[]
);
import "DPI-C" context function void _D_MemoryMap_nextInterleavedBoundary
(	chandle me
,	int    initiatorFlowId
,	inout  longint         startAddress
,	output longint         endAddress
,	output longint         periodMask
);

import "DPI-C" context function void _D_MemoryMap_setMode
(	chandle me
,	int mode
);
import "DPI-C" context function void _D_MemoryMap_findInterleavedTargets
(	chandle me
,	int    initiatorFlowId
,	inout  longint         initiatorAddress
,	output int             targetFlowIds[8]
);

//Display MemoryMap error messages initiated from C through DPI
function automatic void _U_MemoryMap_DisplayErrorMessage(input int id , input string message);
	`uvm_fatal("anvu_bench",message)
endfunction
export "DPI-C" function _U_MemoryMap_DisplayErrorMessage;

//! Class to represent a connection within the memory map.
//! This class is really a struct, but class objects wihtin a struct are currently not supported by simulators.
class  anvu_memoryMap_connection;
	//! The initiator thread flow of this memory map connection.
	anvu_flow    initFlow;
	//! Starting address of the range within the initiator.
	longint initStartAddr;
	//! Ending address of the range within the initiator.
	longint initEndAddr;
	//! The target thread flow of this memory map connection.
	anvu_flow    targFlow;
	//! Starting address of the range within the target.
	longint targStartAddr;
	//! Base to find the securityLevels for which RD access will be accepted
	int unsigned rdSecurityBase    = 0;
	//! Mask to find the securityLevels for which RD access will be accepted
	int unsigned rdSecurityMask    = 8'hFF;
	//! Bit asserted if there is no securityLevel which allow a RD to be accepted
	bit rdSecurityNoLevel = 1;
	//! Base to find the securityLevels for which WR access will be accepted
	int unsigned wrSecurityBase    = 0;
	//! Mask to find the securityLevels for which WR access will be accepted
	int unsigned wrSecurityMask    = 8'hFF;
	//! Bit asserted if there is no securityLevel which allow a WR to be accepted
	bit  wrSecurityNoLevel = 1;
	//! Indicates if the connection is for an interleaved stripe (1),
	//! or is of a fake line to indicates the start of an interleaved range (2).
	//! Otherwise it is set to (0)
	int  interleavedStatus;
	//! List the interleaved targets to display their names
	anvu_flow displayInterleavedTargets[int];
	//! Creates a new memory map connection object
	function new(anvu_flow initFlow, longint initStartAddr, longint initEndAddr , anvu_flow targFlow , longint targStartAddr, int interleavedStatus, anvu_flow displayInterleavedTargets[int]);
		this.initFlow               = initFlow;
		this.initStartAddr          = initStartAddr;
		this.initEndAddr            = initEndAddr;
		this.targFlow               = targFlow;
		this.targStartAddr          = targStartAddr;
		this.interleavedStatus      = interleavedStatus;
		this.displayInterleavedTargets = displayInterleavedTargets;
	endfunction
	function string reachedTargStr(t_opcode opcode,int securityLevel);
		anvu_flow flow = Flow_nowhere();
		if ( opcode == READ  && ((securityLevel&rdSecurityMask) == rdSecurityBase) ) flow = targFlow;
		if ( opcode == WRITE && ((securityLevel&wrSecurityMask) == wrSecurityBase) ) flow = targFlow;
		return flow.str();
	endfunction
	function string interleavedTargetsListStr();
		string s="" ;
		foreach ( displayInterleavedTargets[i] ) s = { s , " " , displayInterleavedTargets[i].str() };
		return s;
	endfunction
	
	// Deprecated
	//function int findValidSecurityLevel(t_opcode opcode,bit[1023:0] reachableSecurityLevels);
	//	int securityLevels[$];
	//	int found = -1;
	//	if (opcode == READ) securityLevels = rdSecurityLevels;
	//	else                securityLevels = wrSecurityLevels;
	//	foreach ( securityLevels[i] ) begin
	//		int securityLevel = securityLevels[i];
	//		if (reachableSecurityLevels[securityLevel]) begin
	//			found = securityLevel;
	//			break;
	//		end
	//	end
	//	return found;
	//endfunction
	
	// Returns a base/mask for security so that secu&mask=base means secu is a valid  value for rd/wr security filtering for this connection, and is reachable by the VIP
	// Returns also noMatching which is asserted when no value can match this requirement.
	function void findValidSecurityBaseMask(input t_opcode opcode,input int unsigned reachableSecurityBase,input int unsigned reachableSecurityMask,output int unsigned securityBase,output int unsigned securityMask,output bit noMatching);
		int intersecMask;
		if (opcode == READ) begin
			mergeTwoBaseMask(reachableSecurityBase,reachableSecurityMask,rdSecurityBase,rdSecurityMask,securityBase,securityMask,noMatching);
		end else begin
			mergeTwoBaseMask(reachableSecurityBase,reachableSecurityMask,wrSecurityBase,wrSecurityMask,securityBase,securityMask,noMatching);
		end
	endfunction
	//check if the current connection is an interleaved stripe
	function bit isInterleavedStripe();
		return (interleavedStatus == 1);
	endfunction
	//check if the current connection is a fake line to indicate the start of an interleved range
	function bit isStartInterleavedRange();
		return (interleavedStatus == 2);
	endfunction
endclass

typedef class anvu_memoryMap;
anvu_memoryMap _anvu_memoryMap__Handles[$];
int       _anvu_memoryMap__FreeIds[$];

//! Memory Map description of the NoC
//! This class is mainly a wrapper for the C++ version of the class, interfaced through DPI-C.
//! All the existing C++ methods are available in the system verilog version.
class anvu_memoryMap;
	//! Handler of the underlying C++ object.
	chandle object;
	
	//! Creates a new memory map, reading the description from the provided fileName.
	function new();
		int id;
		if (_anvu_memoryMap__FreeIds.size == 0)
		begin
			id = _anvu_memoryMap__Handles.size;
		_anvu_memoryMap__Handles.push_back(this);
		end
		else
		begin
			id = _anvu_memoryMap__FreeIds.pop_back();
			_anvu_memoryMap__Handles[id] = this;
		end
		object = _D_MemoryMap_New(id);
	endfunction
	
	//! Load the memoryMap using information in the file passed as argument.
	function bit load(string fileName);
		bit success;
		_D_MemoryMap_load(object,fileName,success);
		return success;
	endfunction
	//! Compute based on the Memorymap the targetFlow and targetAddress of a byte entering the NoC from initiatorFlow at initiatorAddress, with the given opcode.
	function void translate(anvu_flow initiatorFlow,longint initiatorAddress,t_opcode accessType,int permissions,output anvu_flow targetFlow,output longint targetAddress,output anvu_flow targetFlowWithNoRights);
		int targetFlowId;
		int targetFlowIdWithNoRights;
		_D_MemoryMap_translate(object,initiatorFlow.id(),initiatorAddress,accessType,permissions,targetFlowId,targetAddress,targetFlowIdWithNoRights);
		targetFlow = new(targetFlowId);
		targetFlowWithNoRights = new(targetFlowIdWithNoRights);
	endfunction

	//! Compute based on the Memorymap the targetFlow and targetAddress of a byte entering the NoC from initiatorFlow at initiatorAddress, with the given opcode.
	function void translate_all(anvu_flow initiatorFlow,longint initiatorAddress,t_opcode accessType,int permissions,output anvu_flow targetFlow[`WIDTH],output longint targetAddress[`WIDTH],output int size);
		int targetFlowId[`WIDTH];
		int targetWbsMasks[`WIDTH];
		int targetPostedMasks[`WIDTH];
		longint targetAddress_tmp[`WIDTH];
		int i;
		int size_tmp;
		_D_MemoryMap_translate_all(object,initiatorFlow.id(),initiatorAddress,accessType,permissions,targetFlowId,targetAddress_tmp,targetWbsMasks,targetPostedMasks,size_tmp);
		i=0;
		`uvm_info("anvu_noc_definition",$psprintf("initiatorFlow '%s' address '%x' have '%0d' targets",initiatorFlow.str(),initiatorAddress,size_tmp),uvm_pkg::UVM_HIGH)
		while(i<size_tmp) begin
			targetFlow[i]       = new(targetFlowId[i],targetWbsMasks[i],targetPostedMasks[i]);
			targetAddress[i]    = targetAddress_tmp[i];
			`uvm_info("anvu_noc_definition",$psprintf("targetFlow['%0d'] '%s' targetAddress '%x' targetPostedMasks : %x",i,targetFlow[i].str(),targetAddress[i],targetPostedMasks[i]),uvm_pkg::UVM_HIGH)
			i++;
		end
		size = size_tmp;
	endfunction
	
	//! Compute for the given initiator the start of the next memorymap range
	function longint nextBoundary(anvu_flow initiatorFlow,longint startAddress,output bit isInterleaved);
		longint endAddress;
		_D_MemoryMap_nextBoundary(object,initiatorFlow.id(),startAddress,endAddress,isInterleaved);
		return endAddress;
	endfunction
	
	//! Compute for the given initiator the start of the next masked memorymap range
	function longint nextMaskedBoundary(anvu_flow initiatorFlow,longint startAddress,longint maxAddress);
		longint endAddress;
		_D_MemoryMap_nextMaskedBoundary(object,initiatorFlow.id(),startAddress,maxAddress, endAddress);
		return endAddress;
	endfunction

	function void findNotriggedPaths(anvu_flow initiatorFlow,input int  modes[]);
		_D_MemoryMap_findNotriggedPaths(object,initiatorFlow.id(),modes); 
	endfunction

	function longint nextInterleavedBoundary(anvu_flow initiatorFlow,longint startAddress,output longint periodMask);
		longint endAddress;
		_D_MemoryMap_nextInterleavedBoundary(object,initiatorFlow.id(),startAddress,endAddress,periodMask);
		return endAddress;
	endfunction
	
	function void findInterleavedTargets(anvu_flow initiatorFlow,longint initiatorAddress,output anvu_flow targetFlows[int]);
		int targetFlowIds[8];
		int j=0;
		_D_MemoryMap_findInterleavedTargets(object,initiatorFlow.id(),initiatorAddress,targetFlowIds);
		foreach(targetFlowIds[i]) begin
			if ( targetFlowIds[i] != -1 ) targetFlows[j] = new(targetFlowIds[i]);
			j++;
		end
	endfunction
	//! Compute a list of connections for the initiator flow, given the upper boundary for the memorymap.
	function void getConnections(anvu_flow initFlow , bit [63:0] maxAddr , eHowHandleInterleav howInter , output anvu_memoryMap_connection connections[$] );
		anvu_memoryMap_connection iconnections[$];
		anvu_memoryMap_connection iconnection;
		longint  currentAddr = 0;
		longint  endAddr;
		longint  endRangeAddr;
		longint  endFirstRangeAddr;
		longint  nextInterBound;
		longint  nextStartAddr;
		longint  startInterleavRangeAddr;
		anvu_flow targFlow;
		anvu_flow targetFlowWithNoRights;
		anvu_flow displayInterleavedTargets[int];
		longint  targStartAddr;
		longint  periodMask;
		bit      isInterleaved;
		bit      setStartInterleavRange = 1;
		bit      doPushConnection;
		bit      inFirstPeriod;
		bit      seenTargFlow[int];
		bit      seenTargFlowLast[int];
		bit      hasMaskedtargets = 0;
		do begin
			doPushConnection = 1;
			//! this nextBoundary fct does not take into account inner interleaved stripe boundaries  or masked targets when finding the next boundary.
			endRangeAddr = nextBoundary( initFlow , currentAddr , isInterleaved);
			if (setStartInterleavRange == 1 && isInterleaved == 1) begin
				startInterleavRangeAddr = currentAddr;
				setStartInterleavRange = 0;
				inFirstPeriod = 1;
				seenTargFlow.delete();
				seenTargFlowLast.delete();
				//! Next we create a fake line in the log file to indicate the start of an interleaved range.
				targFlow = new(-1);
				if (howInter != anvu_commons_pkg::JUMP) begin
					findInterleavedTargets(initFlow,startInterleavRangeAddr,displayInterleavedTargets);
					iconnection = new(initFlow,startInterleavRangeAddr,endRangeAddr,targFlow,0,2,displayInterleavedTargets);
					iconnections.push_back(iconnection);
					displayInterleavedTargets.delete();//to send an empty "display array" when connections are later used in a traditionnal way
				end
			end
			
			//! "return" an nowhere target flow if no target flow with Read-enabled can be matched (whatever the security flags)
			translate(initFlow,currentAddr,READ,-1,targFlow,targStartAddr,targetFlowWithNoRights);
			//! if no read-enable target flow matched, check if a write-enable target can match. If not, then it is really a nowhere target flow.
			if (targFlow.isNowhere()) begin
				translate(initFlow,currentAddr,WRITE,-1,targFlow,targStartAddr,targetFlowWithNoRights);
			end

			if (endRangeAddr == 0 && currentAddr == 0 )   break;
			if (endRangeAddr == 0 || endRangeAddr > maxAddr) endRangeAddr = maxAddr;
			if (isInterleaved) begin
				//! Function nextInterleavedBoundary gives the next valid stripe boundary
				if      (howInter == anvu_commons_pkg::JUMP) begin              // => Ignore interleaved target regions
					doPushConnection = 0;
					endAddr       = endRangeAddr;
					nextStartAddr = endRangeAddr;
				end
				else if (howInter == anvu_commons_pkg::ASONEBLOCK) begin        // => Interleaved contiguous stripes considered as one block
					endAddr       = endRangeAddr;
					nextStartAddr = endRangeAddr;
				end
				else if (howInter == anvu_commons_pkg::ONECONPERTARG) begin     // => Check the firt bottom set of stripes. Only one connection per target.
					nextInterBound = nextInterleavedBoundary( initFlow , currentAddr , periodMask );
					if (endRangeAddr <= nextInterBound) endAddr = endRangeAddr;
					else                                endAddr = nextInterBound;
					if ( endAddr > startInterleavRangeAddr + periodMask ) nextStartAddr = endRangeAddr;
					else nextStartAddr = endAddr;
					if (nextStartAddr == endRangeAddr) setStartInterleavRange=1;
					if (seenTargFlow.exists(targFlow.id())) doPushConnection = 0;
					else                                    seenTargFlow[targFlow.id()] = 1;

				end
				else if (howInter == anvu_commons_pkg::CONNECTIVITY) begin     // => Check both the bottom and the top sets of stripes (= connectivity)
					nextInterBound = nextInterleavedBoundary( initFlow , currentAddr , periodMask );
					if (endRangeAddr <= nextInterBound) endAddr = endRangeAddr;
					else                                endAddr = nextInterBound;
					if (inFirstPeriod) begin
						if (seenTargFlow.exists(targFlow.id())) doPushConnection = 0;
						else                                    seenTargFlow[targFlow.id()] = 1;
					end else begin
						if (seenTargFlowLast.exists(targFlow.id())) doPushConnection = 0;
						else                                        seenTargFlowLast[targFlow.id()] = 1;
					end
					if ( endAddr > startInterleavRangeAddr + periodMask && inFirstPeriod == 1 ) begin
						if (endRangeAddr-periodMask-1 > endAddr) nextStartAddr = endRangeAddr-periodMask-1;
						else                                     nextStartAddr = endAddr;
						inFirstPeriod = 0;
					end
					else nextStartAddr = endAddr;
					if (nextStartAddr == endRangeAddr) setStartInterleavRange=1;
				end
			end
			else begin
				nextStartAddr = nextMaskedBoundary( initFlow , currentAddr ,maxAddr);
				endAddr       = nextStartAddr;
			end

			if (doPushConnection) begin
				bit firstRoundRd = 1;
				bit firstRoundWr = 1;
				iconnection = new(initFlow,currentAddr,endAddr,targFlow,targStartAddr,isInterleaved,displayInterleavedTargets);
				for ( int i=0;i<nocSecurityLevelNb;i++) begin
					translate(initFlow,currentAddr,READ,i,targFlow,targStartAddr,targetFlowWithNoRights);
					if (!targFlow.isNowhere) begin
						if (firstRoundRd) firstRoundRd = 0;
						else begin
							iconnection.rdSecurityMask -= iconnection.rdSecurityMask & (i^iconnection.rdSecurityBase) ;
						end
						iconnection.rdSecurityBase = i;
					end
					translate(initFlow,currentAddr,WRITE,i,targFlow,targStartAddr,targetFlowWithNoRights);
					if (!targFlow.isNowhere) begin
						if (firstRoundWr) firstRoundWr = 0;
						else begin
							iconnection.wrSecurityMask -= iconnection.wrSecurityMask & (i^iconnection.wrSecurityBase) ;
						end
						iconnection.wrSecurityBase = i;
					end
				end
				iconnection.rdSecurityBase    = iconnection.rdSecurityBase&iconnection.rdSecurityMask;
				iconnection.wrSecurityBase    = iconnection.wrSecurityBase&iconnection.wrSecurityMask;
				iconnection.rdSecurityNoLevel = firstRoundRd;
				iconnection.wrSecurityNoLevel = firstRoundWr;
				iconnections.push_back(iconnection);
			end
			currentAddr = nextStartAddr;
		end while ( endAddr != maxAddr);
		connections = iconnections;
	endfunction

	//! Return 1 if the memory map of all the first 'nbId' of 'initSocketFlow' are empty.
	function bit hasEmptyMemoryMap(anvu_flow initSocketFlow, int nbId);
		for (int i=0;i<nbId;i++ ) begin
			anvu_flow flow = initSocketFlow.get(i);
			bit isInterleaved;
			if ( nextBoundary(flow,0,isInterleaved) != 0 ) return 0;
		end
		return 1;
	endfunction
	
	//! Change the current mode of the memory map
	function void setMode(int mode);
		_D_MemoryMap_setMode(object,mode);
	endfunction
	
endclass

endpackage
