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

`ifndef ANVU_COMMONS
`define ANVU_COMMONS
`timescale 1ps/1ps
`include "uvm_macros.svh"

//! Package used by all part of the NoCverifier environment.
//! It particularly defines :
//! - anvu_flow
//! - anvu_pwrState_handler
//! - Useful functions
package anvu_commons_pkg;
	import uvm_pkg::*;

	// Timescale related information

	//! Factor to be used to convert $realtime values to a time in picoseconds
	//! This takes into account the timescale value defined in the NoCcompiler verilog ExportOption.
	int  nocTimeUnitInPsFactor = 1;

	//! Real representing the minimum time increment expressed in the current time unit.
	//! This takes into account the timescale value defined in the NoCcompiler verilog ExportOption.
	real nocTimeIncrement      = 1.0;

	//! Return the current simulation time into picoSeconds.
	//! This function take 'timescale' values into account
	function automatic longint getTimeInPs();
		return longint'($realtime*nocTimeUnitInPsFactor);
	endfunction

	//! Enumerated type defining the possible ways to handle interleaved ranges 
	typedef enum { JUMP , ASONEBLOCK , ONECONPERTARG , CONNECTIVITY } eHowHandleInterleav;

	//! Enumerated type defining possible ways a target can generate the response status 
	typedef enum { ALWAYSOK , ALWAYSERR , STATUSRAND } eStatusBehaviour;

	//! Enumerated type defining possible ways a target can generate the response delays 
	typedef enum {FAST , FLOWCONTROL , DELAYRAND } eDelaysBehaviour;

	bit nocAipStartAllowed = 0;

	// anvu_flow 

	import "DPI-C" context function int    _D_Flow_FlowName(string name);
	import "DPI-C" context function int    _D_Flow_socket(int id);
	import "DPI-C" context function int    _D_Flow_index(int id);
	import "DPI-C" context function string _D_Flow_str(int id);
	import "DPI-C" context function int    _D_Flow__bracket(int id,int index);
	import "DPI-C" context function bit    _D_Flow__isInternal(int id);
	import "DPI-C" context function bit    _D_Flow__isInitiator(int id);
	import "DPI-C" context function bit    _D_Flow__isRequestDisordered(int id);
	import "DPI-C" context function bit    _D_Flow__areWriteRestricted(int id);
	import "DPI-C" context function void   _D_Flow_declareSocket(string name, bit isInitiator,bit isInternal,bit hasOpcodeDisorder,bit hasRequestDisorder, bit areWriteRestricted=1'b0);
	import "DPI-C" context function int    _D_Flow__wbsMask(int id);
	import "DPI-C" context function int    _D_Flow__postedMask(int id);
	import "DPI-C" context function void    _D_Flow__setwbsMask(int id,int wbsMask);
	import "DPI-C" context function void    _D_Flow__setpostedMask(int id,int posted);

	//! Class to store IDs for all the NoC sockets and socket flows.
	//! The class convert seamlessly to an integer, allowing to use these IDs for system verilog associate arrays, struct, or for transferring
	//! throught the DPI-C interface.
	//!
	//! IDs exists for the NoC socket, but also for any thread within this socket. Methods exists to find back the socketId from a threadId, or find the ID of a given thread given a socketId.
	//!
	//! A special flow value (-1) is used to described the noWhere socket.
	//!
	//! Flows can be easily displayed using the str() method.
	class anvu_flow;
		//! The underlying integer ID for this flow
		int m_id;
		int m_wbsMask;
		int m_postedMask;
		//! Create a new flow object from the provided integer.
		function new(int id,int wbsMask=0, int postedMask=0);
			m_id = id;
			m_wbsMask = wbsMask;
			m_postedMask = postedMask;
		//	_D_Flow__setwbsMask(id,wbsMask);
			_D_Flow__setpostedMask(id,postedMask);

		endfunction

		//! Return the underlying integer.
		function int id();
			return m_id;
		endfunction

		//! Return the socket flow associated to this flow. If this is already a flow representing a socket, return itself.
		function anvu_flow socket();
			anvu_flow f = new(_D_Flow_socket(m_id));
			return f;
		endfunction

		//! Returns this.socket().id()
		function int socketId();
			anvu_flow f = new(_D_Flow_socket(m_id));
			return f.m_id;
		endfunction

		//! Returns the current thread index of this flow. Raises an error if this is not a flow representing a thread.
		function int index();
			return _D_Flow_index(m_id);
		endfunction

		//! Return a string representing the current flow, the displayed format is :
		//! - For a flow representing a socket : "socketName"
		//! - For a flow representing a thread within a socket : "socketName:threadIndex"
		function string str();
			return _D_Flow_str(m_id);
		endfunction

		//! Return the flow representing thread 'index' in the current socket flow.
		//! Raises an error if the current flow does not represent a socket.
		function anvu_flow get(int index);
			anvu_flow f = new(_D_Flow__bracket(m_id,index));
			return f;
		endfunction

		//! Return True if the current flow is associated to an internal socket.
		function bit isInternal();
			return _D_Flow__isInternal(m_id);
		endfunction

		//! Return True if the current flow is associated to an initiator socket.
		function bit isInitiator();
			return _D_Flow__isInitiator(m_id);
		endfunction

		//! Return True if the current flow is associated to a socket which can introduce request disorder.
		function bit isRequestDisordered();
			return _D_Flow__isRequestDisordered(m_id);
		endfunction

		//! Return True if the current flow is associated to an socket for which random writes should allowed, like LLI Svc.
		function bit areWriteRestricted();
			return _D_Flow__areWriteRestricted(m_id);
		endfunction

		//! Return True if the current flow is representing the flow for the nowhere socket.
		function bit isNowhere();	
			return m_id == -1;
		endfunction

		//! Return True if the current flow is representing the socket named "socketName" or a thread within this socket.
		function bit isFrom(string socketName);
			// Return 1 if this flow is part of the socket named socketName
			return (_D_Flow_socket(m_id) == _D_Flow_FlowName(socketName));
		endfunction
		
		//! Return the target socket Wbs mask.
		function int wbsMask();
			return m_wbsMask; //_D_Flow__wbsMask(m_id);
		endfunction
		//! Return the target socket Wbs mask.
		function int isPosted();
			return m_postedMask;//return _D_Flow__postedMask(m_id);
		endfunction

	endclass

	//! Returns the flow object for the socket named "name".
	//! This function should be turned into a static method of the Flow class when supported by the simulators.
	function automatic anvu_flow Flow_fromName(string name);
		anvu_flow f = new(_D_Flow_FlowName(name));
		return f;
	endfunction

	//! Returns the underlying interger ID for the socket named "name".
	//! This function should be turned into a static method of the Flow class when supported by the simulators.
	function automatic int FlowId_fromName(string name);
		anvu_flow f = new(_D_Flow_FlowName(name));
		return f.id();
	endfunction

	//! Returns the flow object for the thread 'idx' for the socket named "name".
	//! This function should be turned into a static method of the Flow class when supported by the simulators.
	function automatic anvu_flow Flow_fromNameAndIdx(string name,int idx);
		anvu_flow f = new(_D_Flow_FlowName(name));
		if (!f.isNowhere())
			f = f.get(idx);
		return f;
	endfunction

	//! Returns the underlying integer ID for the thread 'idx' for the socket named "name".
	//! This function should be turned into a static method of the Flow class when supported by the simulators.
	function automatic int FlowId_fromNameAndIdx(string name,int idx);
		anvu_flow f = new(_D_Flow_FlowName(name));
		if (!f.isNowhere())
			f = f.get(idx);
		return f.id();
	endfunction


	//! Returns the flow for the nowhere socket.
	//! This function should be turned into a static method of the Flow class when supported by the simulators.
	function automatic anvu_flow Flow_nowhere();
		anvu_flow f = new(-1);
		return f;
	endfunction

	// anvu_pwrState_handler

	typedef enum {PWR_ON,PWR_UNK,PWR_OFF} t_pwrState;
	typedef enum {ROUTE_ON,ROUTE_UNK,ROUTE_OFF} t_routeState;

	//Display pwrStateHandler error messages initiated from C through DPI
	function automatic void _U_PowerStateHander_DisplayErrorMessage(input int id , input string message);
		`uvm_fatal("anvu_bench",message)
	endfunction
	export "DPI-C" function _U_PowerStateHander_DisplayErrorMessage;

	import "DPI-C" context function chandle _D_PwrStateHandler_New(int id);
	import "DPI-C" context function void    _D_PwrStateHandler_loadRouteFromFile  (chandle me,string filename);
	import "DPI-C" context function void    _D_PwrStateHandler_updatePwrState     (chandle me,int pwrFlowID , inout longint date, input int state);
	import "DPI-C" context function int     _D_PwrStateHandler_getRouteState      (chandle me,int initFlowId, int targFlowId, inout longint startTime, inout longint endTime);

	typedef class anvu_pwrState_handler;
	anvu_pwrState_handler _PwrStateHandler__Handles[$];
	int     _PwrStateHandler__FreeIds[$];

	//! Class keeping the power state of the NoC.
	//! It is feeded either by the power monitor VIP, or the power master and slave VIPs.
	class anvu_pwrState_handler;
		//! Handler for the underlying C++ object.
		chandle object;
		//! Create a new power state manager of the object.
		function new();
			int id;
			if (_PwrStateHandler__FreeIds.size == 0)
			begin
				id = _PwrStateHandler__Handles.size;
				_PwrStateHandler__Handles.push_back(this);
			end
			else
			begin
				id = _PwrStateHandler__FreeIds.pop_back();
				_PwrStateHandler__Handles[id] = this;
			end
			object = _D_PwrStateHandler_New(id);
		endfunction

		//! Load the power domain crossed by each route within the NoC.
		function void loadRouteFromFile(string fileName);
			_D_PwrStateHandler_loadRouteFromFile(object,fileName);
		endfunction

		//! Allow a Power VIP to inform of a power domain change to the power state handler.
		function void updatePwrState(anvu_flow pwrFlow,longint date, t_pwrState state);
			_D_PwrStateHandler_updatePwrState(object,pwrFlow.id(),date,int'(state));
		endfunction

		//! Return the power state for the route between initFlow and targFlow, between times startTime and endTime.
		//! The different possible state are :
		//! - ROUTE_ON : All the power domains crossed by the route are active.
		//! - ROUTE_OFF : One power domain on the route is off.
		//! - ROUTE_UNK : At least one power domain on the route is in an unstable state, or changed state in the given time period.
		function automatic t_routeState getRouteState(anvu_flow initFlow,anvu_flow targFlow,longint startTime,longint endTime);
			return t_routeState'(_D_PwrStateHandler_getRouteState(object,initFlow.id(),targFlow.id(),startTime,endTime));
		endfunction
	endclass

	// Useful functions

	//! Enumerated type defining the kind of protocol the socket is.
	typedef enum {UNK, AHB, AXI, APB, ATB, OCP, PWRCTL, PWRDISC, DATABAHN, NIF, HIF, UNIQUIFY, UNIVERSALPROBE, LLI_AXI, LLI_OCP, LLI_BFM, NSP, SFI} eSocketType;


	//! Creates the list of values for a byteen signal on a socket with the given data width that follows the 'forceAligned' restrictions.
	function automatic void getForceAlignedByteEnValues(int socketWidth, output bit[63:0] valid[$]);
		int wByteEn=socketWidth/8;
		valid.delete;
		valid.push_back(0);
		for(int i=1;i<=wByteEn;i=i<<1) begin
			int l=(1<<i)-1;
			for (int j=0;j<(wByteEn/i);j++) begin
				valid.push_back(l<<(j*i));
			end
		end
	endfunction

	//! Return the minimum number of bit required to represent 'n' values.
	function automatic int log2( int n );
		log2 = 0;
		while (n>1) begin
			n = n>>1;
			log2++;
		end
		return log2;
	endfunction

	//! Split the provided string line into separate words. The supported separators are the space and the tab characters.
	function automatic void stringSplit( string line , output string words[$] , input string sep = " ");
		int wordStart = 0;
		int len       = line.len();
		words.delete();
		for (int i=0;i<len;i++) begin
			string c = line.substr(i,i);
			if (
				( sep == " " && (c==" " || c=="\t") )
			||	( sep != " " && (c==sep) )
			) begin
				if (wordStart==i) wordStart=i+1;
				else begin
					words.push_back(line.substr(wordStart,i-1));
					wordStart = i+1;
				end
			end
		end
		if (wordStart!=len)
			words.push_back(line.substr(wordStart,len-1));
	endfunction 	

	//! Return the maximum value among two longint values.
	function automatic longint max(longint a,longint b);
		return a>b? a: b;
	endfunction

	//! return the long integer representation of the input string
	//! interpreting it as hexadecimal
	function automatic longint stringToLongHex(string inStr);
		int strLen = inStr.len();
		longint res = 0;
		for (int i=0 ; i<strLen ; i++ ) begin
			string s = inStr.substr(i,i);
			res |= longint'(s.atohex()) << 4*(strLen-i-1);
		end
		return res;
	endfunction

	//! Compute the integer representation of the input string
	//! interpreting it as a decimal
	//! Return False if the string is not a valid int representation
	function automatic bit stringToInt(string inStr,ref int outInt);
		int strLen = inStr.len();
		for (int i=0 ; i<strLen ; i++ ) begin
			if (inStr.getc(i)<48 || inStr.getc(i)>57) return 0;
		end
		outInt = inStr.atoi();
		return 1;
	endfunction

	//! Structure describing a registermap access in the NoC.
	typedef struct {
		//! Mode required for the access
		int  mode;
		//! FlowId of the initiator that will do the access
		int  initFlowId ;
		//! Address of the access. Must be 32b aligned.
		longint address    ;
		//! SecurityLevel of the access
		int securityLevel    ;
		//! If 1, access is a WR, else it will be a RD
		bit  write      ;
		//! For WR access, dataValue is the data to be written. For RD, if it is different from -1, this is the value to check
		longint dataValue  ;
		// For RD this is a mask used to check the returned data.
		longint dataMask   ;
	} anvu_registerMap_access;

	//! Container to store virtual interface and pass them trhought the uvm config space.
	//! This allows placing the testbench in a package
	class anvu_object_container #(type T=int) extends uvm_object;
		T m_object;
	   `uvm_object_param_utils(anvu_object_container#( T ))

	   function new(string name = "anvu_object_container");
		  super.new(name);
	   endfunction
	endclass 

	//! Merges two baseMask :  (val&mask1==base1) && (val&mask2==base2) =>  (val&maskResult==baseResult) .  Returns also bit noMatching asserted if no result baseMask can be found. 
	function void mergeTwoBaseMask(input int unsigned base1,input int unsigned mask1,input int unsigned base2,input int unsigned mask2,output int unsigned baseResult,output int unsigned maskResult,output bit noMatching);
		int unsigned intersecMask;
		maskResult   = mask1|mask2;
		baseResult   = (mask1&base1) | (mask2&base2);
		intersecMask = mask1&mask2;
		noMatching   = ( (intersecMask&base1) != (intersecMask&base2) ) ;
	endfunction
	
endpackage

`endif //ANVU_COMMONS
