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


`timescale 1ps/1ps
`include "uvm_macros.svh"

package anvu_scoreboard_pkg;

import uvm_pkg::*;
import anvu_commons_pkg::*;
import anvu_xactors_pkg::*;
import anvu_noc_definitions_pkg::*;

typedef enum {ANVU_SC_VALID,ANVU_SC_FAIL,ANVU_SC_ERROR,ANVU_SC_UNRELIABLE} eAnvStatus;

//! DPI-C compatible version of the ByteTransfer struct.
typedef struct packed {
	longint          transactionId;
	longint          responseDate;
	longint          dataDate;
	longint          requestDate;
	longint          status;
	longint unsigned userFlagsMask;
	longint unsigned userFlags;
	longint unsigned securityFlagsMask;
	longint unsigned securityFlags;
	longint          opcode;
	longint          posted;
//	longint 	 broadcasted;
	longint          data;
	longint unsigned address;
	longint          flowId;
}	_anvu_nocAip_byteTransfer_dpi;

import "DPI-C" context function string _D_ByteTransfer_str(inout _anvu_nocAip_byteTransfer_dpi bt);

typedef class anvu_nocAip_byteTransfer;


uvm_object  _Transaction__Handles[int];

//! Conversion from a ByteTransfer received through DPI-C to a standard ByteTransfer
function anvu_nocAip_byteTransfer _ByteTransfer_unpack(_anvu_nocAip_byteTransfer_dpi _bt);
	anvu_nocAip_byteTransfer bt;
	bt = new();
	bt.m_flow              = new(_bt.flowId);
	bt.m_address           = _bt.address;
	bt.m_data              = _bt.data;
	bt.m_securityFlags     = _bt.securityFlags;
	bt.m_securityFlagsMask = _bt.securityFlagsMask;
	bt.m_userFlags         = _bt.userFlags;
	bt.m_userFlagsMask     = _bt.userFlagsMask;
	bt.m_posted            = _bt.posted;
//	bt.m_broadcasted       = _bt.broadcasted;
	bt.m_requestDate       = _bt.requestDate;
	bt.m_dataDate          = _bt.dataDate;
	bt.m_responseDate      = _bt.responseDate;
	bt.m_transaction       = _Transaction__Handles[_bt.transactionId];
	$cast(bt.m_status,_bt.status);
	$cast(bt.m_opcode,_bt.opcode);
	return bt;
endfunction

//! Conversion of standard ByteTransfer to its DPI-C-compatible version.
function _anvu_nocAip_byteTransfer_dpi _ByteTransfer_pack(anvu_nocAip_byteTransfer bt);
	_anvu_nocAip_byteTransfer_dpi _bt;
	_bt.flowId            = bt.m_flow.id();
	_bt.address           = bt.m_address;
	_bt.data              = bt.m_data;
	_bt.opcode            = bt.m_opcode;
	_bt.securityFlags     = bt.m_securityFlags;
	_bt.securityFlagsMask = bt.m_securityFlagsMask;
	_bt.userFlags         = bt.m_userFlags;
	_bt.userFlagsMask     = bt.m_userFlagsMask;
	_bt.status            = bt.m_status;
	_bt.posted            = bt.m_posted;
//	_bt.broadcasted	      = bt.m_broadcasted;
	_bt.requestDate       = bt.m_requestDate;
	_bt.dataDate          = bt.m_dataDate;
	_bt.responseDate      = bt.m_responseDate;
	_bt.transactionId     = bt.m_transaction.get_inst_id();
	return _bt;
endfunction

//! Atomic information manipulated by the Scoreboard to check the byte level behaviour of the NoC.
class anvu_nocAip_byteTransfer;
	//! Flow defining 
	anvu_flow              m_flow;
	//! Address of the byte.
	longint unsigned       m_address;
	//! 8b data value, the RD value or WR value for this byte.
	byte                   m_data;
	//! Opcode of the transfer, either RD or WR
	t_opcode               m_opcode;
	//! Value of security flags associated with the transaction. Usage and meaning is context dependant.
	longint unsigned       m_securityFlags;
	//! Mask that indicates which securityFlags bit are valid. Other are unknown
	longint unsigned       m_securityFlagsMask;
	//! Value of user flags associated with the transaction.
	longint unsigned       m_userFlags;
	//! Mask that indicates which userFlags bit are valid. Other are unknown
	longint unsigned       m_userFlagsMask;
	//! Status of this byte transfer
	eAnvStatus             m_status;
	//! True if this byteTransfer is posted, meaning that the response can be received before the byte is guaranteed to be effectively handled.
	bit                    m_posted;
	// True if this byteTransfer is broadcasted, meaning that the request can be sent to many targets and the response can be received from many targets.
//	bit		       m_broadcasted;
	//! Time in picoseconds of the start of address phase of this byte transfer.
	longint                m_requestDate;
	//! Time in picoseconds of the data phase completion of this byte transfer, during request for WR, or response for RD.
	longint                m_dataDate;
	//! Time in picoseconds of the completion of the response phase of this byte transfer.
	longint                m_responseDate;
	//! Transaction object that this byteTransfer is part of.
	//! This attribute required to be cast to the exact transaction type, depending on the flow.
	uvm_object             m_transaction;
	
	//! Compute a single line string to describe this byte transfer.
	function string str();
		_anvu_nocAip_byteTransfer_dpi me = _ByteTransfer_pack(this);
		return _D_ByteTransfer_str(me);
	endfunction
endclass

import "DPI-C" context function chandle _D_Tracker_New(int id);
import "DPI-C" context function void    _D_Tracker_startTransaction      (chandle me,inout longint date,input int trId);
import "DPI-C" context function void    _D_Tracker_endTransaction        (chandle me,inout longint date,input int trId);
import "DPI-C" context function void    _D_Tracker_purge                 (chandle me,inout longint date,input int close,input int dumpPerfInLog);
import "DPI-C" context function void    _D_Tracker_dumpStats             (chandle me,inout longint date        );
import "DPI-C" context function void    _D_Tracker_setMode               (chandle me,input int     mode        );
import "DPI-C" context function void    _D_Tracker_setMaxNbFuture        (chandle me,input int     maxNbFuture );
import "DPI-C" context function void    _D_Tracker_feedByteTransfer      (chandle me,inout _anvu_nocAip_byteTransfer_dpi bt                           );
import "DPI-C" context function void    _D_Tracker_predictAddress        (chandle me,inout _anvu_nocAip_byteTransfer_dpi ibt,output int targetFlowId[],output longint targetAddress[], output bit forcePostedWr[],output int targetWbsMasks[],output int size);
import "DPI-C" context function bit     _D_Tracker_qualifyAssociation    (chandle me,inout _anvu_nocAip_byteTransfer_dpi ibt,inout _anvu_nocAip_byteTransfer_dpi tbt);
import "DPI-C" context function bit     _D_Tracker_qualifyInitiatorOrphan(chandle me,inout _anvu_nocAip_byteTransfer_dpi ibt,input int TargetFlowId);
import "DPI-C" context function bit     _D_Tracker_qualifyTargetOrphan   (chandle me,                                       inout _anvu_nocAip_byteTransfer_dpi tbt);
import "DPI-C" context function void    _D_Tracker_updateEmptiness       (chandle me,bit trackerEmpty);
import "DPI-C" context function void    _D_Tracker_openAssociationRecord (chandle me,string filename);
import "DPI-C" context function void    _D_Tracker_closeAssociationRecord(chandle me);
import "DPI-C" context function void    _D_Tracker_loadInternalMemoryMap (chandle me, input string memoryMapPath);

typedef class anvu_nocAip_tracker;
anvu_nocAip_tracker _Tracker__Handles[$];
int     _Tracker__FreeIds[$];

//! SystemVerilog wrapper class for the C++ Tracker.
//! The tracker implements the main algorithm of the NoC byte level scoreboard pairing.
class anvu_nocAip_tracker extends uvm_scoreboard;
	`uvm_component_utils(anvu_nocAip_tracker)
	
	//! True when the an error has been detected
	bit errorDetected;
	//! Stores if the current reporting is an error
	bit    reportingError;
	//! Stores the current reporting severity of the tracker
	int    reportingSeverity;
	//! Aggregate the current report from the tracker
	string reportingMsg;
	
	chandle object;
	function new(string name = "anvu_nocAip_tracker" , uvm_component parent);
		int id;
		super.new(name,parent);
		if (_Tracker__FreeIds.size == 0)
		begin
			id = _Tracker__Handles.size;
			_Tracker__Handles.push_back(this);
		end
		else
		begin
			id = _Tracker__FreeIds.pop_back();
			_Tracker__Handles[id] = this;
		end
		object = _D_Tracker_New(id);
	endfunction
	
	function void loadInternalMemoryMap(string memoryMapPath);
		_D_Tracker_loadInternalMemoryMap(object,memoryMapPath);
	endfunction
	
	function void startTransaction(longint date,uvm_object transaction);
		`uvm_info("anvu_nocAip_tracker",$psprintf("#DBG startTransaction %0d %0d",date,transaction.get_inst_id()),uvm_pkg::UVM_MEDIUM);
		_Transaction__Handles[transaction.get_inst_id()] = transaction;
		_D_Tracker_startTransaction(object,date,transaction.get_inst_id());
	endfunction
	
	function void endTransaction(longint date,uvm_object transaction);
		`uvm_info("anvu_nocAip_tracker",$psprintf("#DBG endTransaction %0d %0d",date,transaction.get_inst_id()),uvm_pkg::UVM_MEDIUM);
		_D_Tracker_endTransaction(object,date,transaction.get_inst_id());
	endfunction
	
	function void purge(longint date,int close,int dumpPerfInLog);
		_D_Tracker_purge(object,date,close,dumpPerfInLog);
	endfunction
	
	function void dumpStats(longint date);
		_D_Tracker_dumpStats(object,date);
	endfunction
	
	function void setMode(int mode);
		_D_Tracker_setMode(object,mode);
	endfunction
	
	function void setMaxNbFuture(int maxNbFuture);
		_D_Tracker_setMaxNbFuture(object,maxNbFuture);
	endfunction
	
	virtual function void feedByteTransfer(anvu_nocAip_byteTransfer byteTransfer);
		_anvu_nocAip_byteTransfer_dpi bt = _ByteTransfer_pack(byteTransfer);
		_D_Tracker_feedByteTransfer(object,bt);
	endfunction
	
	virtual function void predictAddress(anvu_nocAip_byteTransfer initTransfer,output anvu_flow targetFlow[`WIDTH],output longint targetAddress[`WIDTH], output bit forcePostedWr[`WIDTH],output int size);
		int targetFlowId[`WIDTH];
		int targetWbsMasks[`WIDTH];
		longint targetAddress_tmp[`WIDTH];
		int k;
		int size_tmp;
		_anvu_nocAip_byteTransfer_dpi _ibt = _ByteTransfer_pack(initTransfer);
		_D_Tracker_predictAddress(object,_ibt,targetFlowId,targetAddress_tmp,forcePostedWr,targetWbsMasks,size_tmp);
		for(k=0;k<size_tmp;k++) begin	
			targetFlow[k]    = new(targetFlowId[k],targetWbsMasks[k]);
			targetAddress[k] = targetAddress_tmp[k];
		end
		size = size_tmp;
	endfunction
	
	virtual function bit qualifyAssociation(anvu_nocAip_byteTransfer initTransfer,anvu_nocAip_byteTransfer targetTransfer);
		_anvu_nocAip_byteTransfer_dpi _ibt = _ByteTransfer_pack(initTransfer);
		_anvu_nocAip_byteTransfer_dpi _tbt = _ByteTransfer_pack(targetTransfer);
		return _D_Tracker_qualifyAssociation(object,_ibt,_tbt);
	endfunction
	
	virtual function bit qualifyInitiatorOrphan(anvu_nocAip_byteTransfer initTransfer,anvu_flow targetFlow);
		_anvu_nocAip_byteTransfer_dpi _ibt = _ByteTransfer_pack(initTransfer);
		int targetFlowId = targetFlow.id();
		return _D_Tracker_qualifyInitiatorOrphan(object,_ibt,targetFlowId);
	endfunction
	
	virtual function bit qualifyTargetOrphan(anvu_nocAip_byteTransfer targetTransfer);
		_anvu_nocAip_byteTransfer_dpi _tbt = _ByteTransfer_pack(targetTransfer);
		return _D_Tracker_qualifyTargetOrphan(object,_tbt);
	endfunction
	
	virtual function void updateEmptiness(bit scoreboardEmpty);
		_D_Tracker_updateEmptiness(object,scoreboardEmpty);
	endfunction
	
	virtual function void openAssociationRecord(string filename);
		_D_Tracker_openAssociationRecord(object,filename);
	endfunction
	
	virtual function void closeAssociationRecord();
		_D_Tracker_closeAssociationRecord(object);
	endfunction
	
	virtual function string commentByteTransfer(anvu_nocAip_byteTransfer bt);
		return  bt.m_transaction.sprint();
	endfunction
endclass

function automatic void _U_Transaction__forget(int id);
	_Transaction__Handles.delete(id);
endfunction
function automatic void _U_Tracker_predictAddress(int id,inout _anvu_nocAip_byteTransfer_dpi _ibt,output bit[31:0] targetFlowId[`WIDTH],output bit[63:0] targetAddress[`WIDTH],output bit [`WIDTH:0] forcePostedWr,output bit[31:0] targetWbsMasks[`WIDTH],output int size);
	anvu_nocAip_byteTransfer ibt = _ByteTransfer_unpack(_ibt);
	anvu_flow targetFlow[`WIDTH];
	longint targetAddress_tmp[`WIDTH];
	bit forcePostedWr_tmp[`WIDTH];	
	int k;
	int size_tmp;
	_Tracker__Handles[id].predictAddress(ibt,targetFlow,targetAddress_tmp,forcePostedWr_tmp,size_tmp);

	for(k=0;k<size_tmp;k++) begin
		targetFlowId[k] = targetFlow[k].id();
		targetWbsMasks[k] = targetFlow[k].wbsMask();
		targetAddress[k]= targetAddress_tmp[k];
		forcePostedWr[k]= forcePostedWr_tmp[k];
		`uvm_info("anvu_scoreboard",$psprintf(" _U_Tracker_predictAddress :: create targetFlowId['%d']='%d' targetFlow = %ss, targetFlow.id=%d, - force WrP %d, targetAddress = %x",k,targetFlowId[k],targetFlow[k].str(),targetFlow[k].id(),forcePostedWr[k],targetAddress[k]),uvm_pkg::UVM_MEDIUM)
	end
	size = size_tmp;
endfunction

function automatic bit _U_Tracker_qualifyAssociation(int id,inout _anvu_nocAip_byteTransfer_dpi _ibt,inout _anvu_nocAip_byteTransfer_dpi _tbt);
	anvu_nocAip_byteTransfer ibt = _ByteTransfer_unpack(_ibt);
	anvu_nocAip_byteTransfer tbt = _ByteTransfer_unpack(_tbt);
	
	return _Tracker__Handles[id].qualifyAssociation(ibt,tbt);
endfunction

function automatic bit _U_Tracker_qualifyInitiatorOrphan(int id,inout _anvu_nocAip_byteTransfer_dpi _ibt,input int targetFlowId);
	anvu_nocAip_byteTransfer ibt = _ByteTransfer_unpack(_ibt);
	anvu_flow         targetFlow = new(targetFlowId);
	return _Tracker__Handles[id].qualifyInitiatorOrphan(ibt,targetFlow);
endfunction

function automatic bit _U_Tracker_qualifyTargetOrphan(int id,inout _anvu_nocAip_byteTransfer_dpi _tbt);
	anvu_nocAip_byteTransfer tbt = _ByteTransfer_unpack(_tbt);
	return _Tracker__Handles[id].qualifyTargetOrphan(tbt);
endfunction

function automatic void _U_Tracker_updateEmptiness(int id,bit trackerEmpty);
	_Tracker__Handles[id].updateEmptiness(trackerEmpty);
endfunction

function automatic bit _U_Tracker_logStartMsg(int id,int typ,int severity);
	anvu_nocAip_tracker tracker = _Tracker__Handles[id];
	uvm_report_handler  handler = tracker.get_report_handler();
	tracker.reportingError = (severity == 2);
	tracker.errorDetected  |= tracker.reportingError;
	tracker.reportingMsg   = "";
	case (severity)
		8  : tracker.reportingSeverity = uvm_pkg::UVM_LOW;
		16 : tracker.reportingSeverity = uvm_pkg::UVM_MEDIUM;
		32 : tracker.reportingSeverity = uvm_pkg::UVM_MEDIUM;
	endcase
	return ( tracker.reportingError || handler.get_verbosity_level()>=tracker.reportingSeverity);
endfunction

function automatic bit _U_Tracker_logText(int id,string msg);
	anvu_nocAip_tracker tracker = _Tracker__Handles[id];
	tracker.reportingMsg = { tracker.reportingMsg ,  msg  , "\n" };
	return 1;
endfunction

function automatic void _U_Tracker_logEndMsg(int id);
	anvu_nocAip_tracker tracker = _Tracker__Handles[id];
	if (tracker.reportingError) begin
		`uvm_error("anvu_nocAip",tracker.reportingMsg)
	end else begin
		`uvm_info("anvu_nocAip",tracker.reportingMsg,tracker.reportingSeverity)
	end
endfunction

function automatic string _U_Tracker_commentByteTransfer(int id,inout _anvu_nocAip_byteTransfer_dpi _bt);
	anvu_nocAip_byteTransfer bt = _ByteTransfer_unpack(_bt);
	return _Tracker__Handles[id].commentByteTransfer(bt);
endfunction

export "DPI-C" function _U_Transaction__forget;
export "DPI-C" function _U_Tracker_commentByteTransfer;
export "DPI-C" function _U_Tracker_predictAddress;
export "DPI-C" function _U_Tracker_qualifyAssociation;
export "DPI-C" function _U_Tracker_qualifyInitiatorOrphan;
export "DPI-C" function _U_Tracker_qualifyTargetOrphan;
export "DPI-C" function _U_Tracker_updateEmptiness;
export "DPI-C" function _U_Tracker_logStartMsg;
export "DPI-C" function _U_Tracker_logText;
export "DPI-C" function _U_Tracker_logEndMsg;

typedef class anvu_nocAip_scoreboard;
`include "user_scoreboard_overloads.sv"

//! The scoreboard is responsible for checking the coherency of bytes transiting the NoC.
//! The scoreboard uses the method "feedByteTransfer" to request more byte transfers to process. The method is called by abstraction-level callbacks registered on VIP protocol monitors.
//! The scoreboard uses rules to pair compatible initiator and target byte transfers according to the:
//! - Ordering model.
//! - Memory map description.
//! - User bit mapping.
//! - User-defined additional criteria.
//! When the scoreboard cannot continue processing byte transfers based on the rules, an error message is logged.
//! User-defined rules, which are stored in the file "user_scoreboard_overloads.sv", are identified by the obligatory function prefix "user". The scoreboard class includes helper functions to assist in writing rules for typically foreseeable situations.
//! When the scoreboard finally associates two compatible byte transfers, performance is computed. The resulting performance summary is dumped into the log file upon simulation end.
class anvu_nocAip_scoreboard extends anvu_nocAip_tracker;
	`uvm_component_utils(anvu_nocAip_scoreboard)
	
	//! True when the scoreboard has no more byteTransfers pending
	bit m_isEmpty;
	//! Current mode of the scoreboard.
	int mode;
	//! Current maxNbFuture of the scoreboard.
	int maxNbFuture = 500;
	//! NoC Memory Map loaded from the noc/MemoryMap.txt file
	anvu_memoryMap        m_memoryMap;
	//! The current NoC power state computed with the input of the power monitors.
	anvu_pwrState_handler m_pwrStateHandler;
	//! Switch that can be used to allow all byte transfers to be orphaned
	bit allowAllOrphans = 0;
	//! Creates a new scoreboard object.
	function new(string name = "anvu_nocAip_scoreboard" , uvm_component parent);
		super.new(name,parent);
		m_memoryMap = new();
		m_pwrStateHandler = new();
	endfunction
	
	//! Load the system verilog memoryMap and pwrStateHandler, using the pathnames.
	//! The memoryMap pathname is also used to load another memory map used by the C version of the scoreboard.
	function void loadFromFiles( string memoryMapPath , string powerDomainPath );
		bit success;
		success = m_memoryMap.load(memoryMapPath);
		m_isEmpty = 1;
		m_pwrStateHandler.loadRouteFromFile(powerDomainPath);
		if (success) this.loadInternalMemoryMap(memoryMapPath);
	endfunction
	
	function void check();
		purge(getTimeInPs(),1,0);
	endfunction
	
	function void report();
		int logPerf;
		if (!nocScoreboardDisabled) begin
			if (!$value$plusargs("anvu_log_perf=%d", logPerf) )
				logPerf=1;
			if (logPerf)
				dumpStats(getTimeInPs());
		end
	endfunction
	
	//! Change the mode of the scoreboard.
	//! If this is a real mode change, the function will :
	//! Purge the scoreboard.
	//! Update the memoryMap.
	//! Update the statRecorder.
	virtual function void setMode(int mode);
		if (mode == this.mode) return;
		`uvm_info("anvu_nocAip",$psprintf("Changing scoreboard mode to %s - implying a purge.",getModeStr(mode)),uvm_pkg::UVM_MEDIUM)
		super.setMode(mode);
		this.mode = mode;
		purge(getTimeInPs(),1'b0,1'b0);
		m_memoryMap.setMode(mode);
	endfunction
	
	//! Change the maxNbFuture of the scoreboard.
	virtual function void setMaxNbFuture(int maxNbFuture);
		if (maxNbFuture == this.maxNbFuture) return;
		`uvm_info("anvu_nocAip",$psprintf("Changing scoreboard maxNbFuture to %d",maxNbFuture),uvm_pkg::UVM_MEDIUM)
		super.setMaxNbFuture(maxNbFuture);
		this.maxNbFuture = maxNbFuture;
	endfunction
	
	//! Submits a new byte transfer to the scoreboard for analysis.
	//! \param byteTransfer  The byte transfer to be analyzed.
	virtual function void feedByteTransfer(anvu_nocAip_byteTransfer byteTransfer);
		`uvm_info("anvu_nocAip",$psprintf("Feeding %s",byteTransfer.str()),uvm_pkg::UVM_MEDIUM)
		super.feedByteTransfer(byteTransfer);
	endfunction
	
	//! Callback method used by the scoreboard to predict the target flow and address of each new initiator byte transfer.
	//! The three-step method determines target flow and address by:
	//! 1 Querying the memory map.
	//! 2 Modifying the address as required by dynamic endianness.
	//! 3 Calling the function "userPredictAddress" to allow overloads. Overloads could be used, for example, to describe the behavior of a proprietary firewall.
	//! 4 Based on the predicted targetFlow, analyze if the initiator byte transfer must be converted to a Posted Wr.
	virtual function void predictAddress(anvu_nocAip_byteTransfer initTransfer,output anvu_flow targetFlow[`WIDTH],output longint targetAddress[`WIDTH],output bit forcePostedWr[`WIDTH],output int size);
		int size_tmp;
		m_memoryMap.translate_all(initTransfer.m_flow,initTransfer.m_address,initTransfer.m_opcode,initTransfer.m_securityFlags,targetFlow,targetAddress,size_tmp);
		userPredictAddress(this,initTransfer,targetFlow[0], targetAddress[0]);
		for(int k=0;k<size_tmp;k++) begin
			// Analyze if we need to force the initiator bt as a posted wr
			forcePostedWr[k] = 0;
			if (initTransfer.m_opcode == WRITE && !targetFlow[k].isNowhere && !targetFlow[k].isInternal ) begin
				case (nocSocketTypeByFlowId[targetFlow[k].id()])
					AXI : forcePostedWr[k] = targetFlow[k].isRequestDisordered(); // isRequestDisordered means this is an AXI_DRAM with response to WR independent of the state on the AXI Interface
					default :;
				endcase
			forcePostedWr[k] = ((targetFlow[k].isPosted() & initTransfer.m_userFlags) !=0) | forcePostedWr[k];
			end
			`uvm_info("anvu_nocAip",$psprintf("Predict %s to %s %x postedMask %x- force WrP %d",initTransfer.str(),targetFlow[k].str(),targetAddress[k],targetFlow[k].isPosted(),forcePostedWr[k]),uvm_pkg::UVM_MEDIUM) 
		end
		size = size_tmp;
	endfunction
	
	//! Callback method used by the scoreboard to handle a pair of byte transfers that, according to the internal rules, are candidates for an association.
	//! These internal rules take into account the ordering model and the matching of the target byte transfer address with the one predicted by the function predictAddress.
	//! In addition, this method checks:
	//! - Matching opcodes.
	//! - Matching data.
	//! - Matching status.
	//! - Compatibility with the power state of the NoC.
	//! - Matching user bits.
	//! - The call to the "userQualifyAssociation" function that is used to validate the association against any user-defined rules.
	virtual function bit qualifyAssociation(anvu_nocAip_byteTransfer initTransfer,anvu_nocAip_byteTransfer targetTransfer);
		bit result, r_opc, r_data,r_status,r_userF,r_secF, r_userQ;
		string reason;
		bit checkData = 1;
		bit checkStatus = 1;
		if (initTransfer.m_status inside {ANVU_SC_ERROR,ANVU_SC_UNRELIABLE} && initTransfer.m_opcode==anvu_noc_definitions_pkg::READ) begin
			// Data are not guaranteed to be transported on RD ERROR	
			checkData = 0;
		end
		if ( initTransfer.m_status == ANVU_SC_UNRELIABLE || targetTransfer.m_status == ANVU_SC_UNRELIABLE ) begin
			checkStatus = 0;
		end
		r_opc    = (initTransfer.m_opcode == targetTransfer.m_opcode);
		r_data   = (initTransfer.m_data   == targetTransfer.m_data   || !checkData );
		r_status = ( !(!initTransfer.m_posted && initTransfer.m_status == ANVU_SC_VALID && targetTransfer.m_status == ANVU_SC_ERROR) || !checkStatus );
		r_userF  = (	( initTransfer  .m_userFlags & initTransfer.m_userFlagsMask & targetTransfer.m_userFlagsMask )
			==	( targetTransfer.m_userFlags & initTransfer.m_userFlagsMask & targetTransfer.m_userFlagsMask )
			);
		r_secF   = (	( initTransfer  .m_securityFlags & initTransfer.m_securityFlagsMask & targetTransfer.m_securityFlagsMask )
			==	( targetTransfer.m_securityFlags & initTransfer.m_securityFlagsMask & targetTransfer.m_securityFlagsMask )
			);
		result = (r_opc && r_data && r_status &&  r_userF && r_secF );		
		begin
			// Manage power domains
			longint checkedResponseDate = (initTransfer.m_opcode == WRITE && initTransfer.m_posted )  ? targetTransfer.m_responseDate : initTransfer.m_responseDate ;
			if (result && m_pwrStateHandler.getRouteState(initTransfer.m_flow,targetTransfer.m_flow,initTransfer.m_requestDate, checkedResponseDate ) == anvu_commons_pkg::ROUTE_OFF ) begin
				result = 0;
				reason = "PWR STATE is ROUTE_OFF";
			end
		end
		r_userQ  = userQualifyAssociation(this,initTransfer,targetTransfer);
		result = (result  &&	r_userQ );
		`uvm_info("anvu_nocAip",$psprintf("QualifyAssociation  %d - %s with %s",result,initTransfer.str(),targetTransfer.str()),uvm_pkg::UVM_MEDIUM)
		if(! result) begin
			reason=(!r_opc)?	"OPC": (!r_data)? "DATA": (!r_status)? "STATUS": (!r_userF)? "USER_FLAGS":(!r_secF)? "SECURITY_FLAGS":(!r_userQ)? "User Qualify Association":"PWR STATE is ROUTE_OFF";
			`uvm_info("anvu_nocAip",$psprintf("QualifyAssociation FAILES because of %s missmatch",reason),uvm_pkg::UVM_MEDIUM)
		end
		return result;
	endfunction
	
	//! Callback method used by the scoreboard to determine if a given initiator byte transfer can be orphaned.
	//! Being orphaned means that there is a justification for this initiator byte transfer not to exit the NoC.
	//! The method checks for the following possible reasons:
	//! - Power down on the route.
	//! - Address not mapped.
	//! - Internal target, like an access to the configuration registers.
	//! - Call to function "userQualifyInitiatorOrphan" for any other reason.
	virtual function bit qualifyInitiatorOrphan(anvu_nocAip_byteTransfer initTransfer,anvu_flow targetFlow);
		bit result = 0;
		// Manage power domains
		longint checkedResponseDate = (initTransfer.m_opcode == WRITE && initTransfer.m_posted )  ? initTransfer.m_responseDate + 50*nocSlowestClkPeriod*nocTimeUnitInPsFactor : initTransfer.m_responseDate ;
		t_routeState routeState = m_pwrStateHandler.getRouteState(initTransfer.m_flow,targetFlow,initTransfer.m_requestDate,checkedResponseDate);
		if (allowAllOrphans) result = 1;
		if ( routeState == anvu_commons_pkg::ROUTE_UNK || routeState == anvu_commons_pkg::ROUTE_OFF )
			result = 1;
		result = (
			result
		||	( targetFlow.isNowhere && (initTransfer.m_status inside {ANVU_SC_ERROR,ANVU_SC_UNRELIABLE} || initTransfer.m_posted ) )
		||	targetFlow.isInternal()
		||	userQualifyInitiatorOrphan(this,initTransfer,targetFlow)
		);
		`uvm_info("anvu_nocAip",$psprintf("QualifyInitiatorOrphan  %d - %s",result,initTransfer.str()),uvm_pkg::UVM_MEDIUM)
		return result;
	endfunction
	
	//! Callback method used by the scoreboard for when it want to know if a given target byte transfer can be made an orphan.
	//! This means that there are reasons for this target byte transfer to have been generated by the NoC.
	//! This callback is checking for the following possible reasons:
	//! - A wider RD access than the original
	//! - Call to the userQualifyTargetOrphan function for any additionnal reasons.
	virtual function bit qualifyTargetOrphan(anvu_nocAip_byteTransfer targetTransfer);
		bit result =  (
			(targetTransfer.m_opcode == anvu_noc_definitions_pkg::READ)
		||	userQualifyTargetOrphan(this,targetTransfer)
		||	allowAllOrphans
		||	(targetTransfer.m_flow.wbsMask()!=0 && ((targetTransfer.m_flow.wbsMask() & targetTransfer.m_userFlags) == 0))
		);
		`uvm_info("anvu_nocAip",$psprintf("QualifyTargetOrphan  %d - %s wbsMask =%d",result,targetTransfer.str(),targetTransfer.m_flow.wbsMask()),uvm_pkg::UVM_MEDIUM)
		////`uvm_info("anvu_nocAip",$psprintf("QualifyTargetOrphan  %d - %s",result,targetTransfer.str()),uvm_pkg::UVM_MEDIUM)
		return result;
	endfunction
	
	//! Callback method used by the scoreboard to inform about its emptiness.
	virtual function void updateEmptiness(bit scoreboardEmpty);
		m_isEmpty = scoreboardEmpty;
		`uvm_info("anvu_nocAip",$psprintf("Scoreboard - Is empty : %d",m_isEmpty),uvm_pkg::UVM_FULL)
	endfunction
	
	//! Scoreboard overload method that handles the additionnal WR accesses at a target that are caused by a lack of byteEn support.
	//! If this method is needed, it must be called by the function "userQualifyTargetOrphan".
	//! \param targTransfer   The targTransfer argument of function "userQualifyTargetOrphan".
	//! \param targSocketName The name of the target socket at which the additionnal write operations are allowed.
	function bit allowTargOrphan_TargNoByteen(anvu_nocAip_byteTransfer targTransfer,string targSocketName);
		anvu_flow targFlow = targTransfer.m_flow;
		bit targSupportBe = 1;
				
		return (
			targTransfer.m_opcode == anvu_noc_definitions_pkg::WRITE
		&&	!targSupportBe
		&&	( targSocketName == "" || targFlow.isFrom(targSocketName) )
		);
	endfunction
	
	
	//! Scoreboard overload method that handles transaction coming back in error when the target does not have byteen support and
	//! the initiator transaction requires them. Either because it is a write with incomplete byteen pattern, or a transaction smaller
	//! than the target bus width.
	//! If this method is needed, it must be called by the function "userQualifyInitatorOrphan".
	//! \param initTransfer    The initTransfer argument of the function "userQualifyinitatorOrphan".
	//! \param targFlow        The targFlow argument of the function "userQualifyinitiatorOrphan".
	//! \param initSocketName  The name of the initiator socket from which initTransfer is sent. If no name is designated (""), all initiator sockets are allowed.
	//! \param targSocketName  The name of the target socket to which initTransfer is sent. If no name is designated (""), all target sockets are allowed.
	function bit allowInitOrphan_TargNoByteen(anvu_nocAip_byteTransfer initTransfer, anvu_flow targFlow,string initSocketName="",string targSocketName="");
		anvu_flow initFlow = initTransfer.m_flow;
		int targMinGranularity;
		int initAccessGranularity;
		if (
			!( initTransfer.m_status inside {ANVU_SC_ERROR,ANVU_SC_UNRELIABLE} || initTransfer.m_posted )
		||	!( initSocketName == "" || initFlow.isFrom(initSocketName) )
		||	!( targSocketName == "" || targFlow.isFrom(targSocketName) )
		)
			return 0;
		case (nocSocketTypeByFlowId[targFlow.id()])
			AXI : targMinGranularity = 1;
			AHB : targMinGranularity = 1;
			APB : if ( nocApbTargInfoByFlowId[targFlow.id()].useBe == 'd1 || nocApbTargInfoByFlowId[targFlow.id()].version == 'd4 ) // useBe parameter for APBV3, set to 1 for APBV4
				return 0;
			else
				targMinGranularity = nocApbTargInfoByFlowId[targFlow.id()].wData/8;
			default : return 0 ;
		endcase
		if (targMinGranularity == 1) return 0;
		
		// Not a complete specification, it will not support being used for prediction
		// -1 value is used when not a complete specification is described.
		case (nocSocketTypeByFlowId[initFlow.id()])
			AXI : begin
				anvu_axi_monitor_transaction axiTr;
				$cast(axiTr,initTransfer.m_transaction);
				if (axiTr.burst == 0) begin //FIXED BURST
					initAccessGranularity = -1;
				end else if (axiTr.opc==ANVU_AXI_WRITE) begin
					bit fullByteen = 1;
					for (int j=0;j<axiTr.len+1;j++) begin
						if (axiTr.strb[j]!= (1<<(1<<axiTr.size))-1) begin
							fullByteen = 0;
							break;
						end
					end
					if (fullByteen) 
						initAccessGranularity = (axiTr.len+1) * (1<<axiTr.size);
					else
						initAccessGranularity = -1;
				end else
					// read opc case , all read data is set as orphan in function qualifyTargetOrphan. If
					// qualifyTargetOrphan function is changed, considering to add more check here
					return 0;
					//if ((1<<axiTr.size) < (nocAxiInitInfoByFlowId[initFlow.id()].wData/8)) begin
					//	// Narrow burst are split
					//	initAccessGranularity = (1<<axiTr.size);
					//end else
					//	initAccessGranularity = (axiTr.len+1) * (1<<axiTr.size);
			end
			AHB : begin
				anvu_ahb_monitor_transaction ahbTr;
				$cast(ahbTr,initTransfer.m_transaction);
				if ( ahbTr.burst == ANVU_AHB_INCR ) begin
					if( ahbTr.write == 0)
						initAccessGranularity = -1; //nocAhbInitInfoByFlowId[initFlow.id()].rdSplit*ahbTr.m_nNumBytes;
					else
						initAccessGranularity = -1; //nocAhbInitInfoByFlowId[initFlow.id()].wrSplit*ahbTr.m_nNumBytes;
				end else begin
					initAccessGranularity = 1<<ahbTr.size;
					//initAccessGranularity = ahbTr.m_nNumBeats * ahbTr.m_nNumBytes;
				end
			end
			APB : initAccessGranularity = nocApbInitInfoByFlowId[targFlow.id()].wData/8;
			default : return 0 ;
		endcase
		return (initAccessGranularity<targMinGranularity);
	endfunction

	
	//! Scoreboard overload method that handles Write Exclusive transaction which are transformed to simple Write with byte enable set to 0 (and hence not detected on the target side).
	//! If this method is needed, it must be called by the function "userQualifyInitatorOrphan".
	//! \param initTransfer    The initTransfer argument of the function "userQualifyinitatorOrphan".
	//! \param targFlow        The targFlow argument of the function "userQualifyinitiatorOrphan".
	//! \param initSocketName  The name of the initiator socket from which initTransfer is sent. If no name is designated (""), all initiator sockets are allowed.
	//! \param targSocketName  The name of the target socket to which initTransfer is sent. If no name is designated (""), all target sockets are allowed.
	function bit allowInitOrphan_WriteExcl(anvu_nocAip_byteTransfer initTransfer, anvu_flow targFlow,string initSocketName="",string targSocketName="");
		anvu_flow initFlow = initTransfer.m_flow;
		int targMinGranularity;
		int initAccessGranularity;
		if (
			!( initSocketName == "" || initFlow.isFrom(initSocketName) )
		||	!( targSocketName == "" || targFlow.isFrom(targSocketName) )
		)
			return 0;
		case (nocSocketTypeByFlowId[initFlow.id()])
			default:;
		endcase
		return 0;
	endfunction


	//! Scoreboard overload method that handles Strm bursts being returned in error when the target cannot handle them.
	//! If this method is needed, it must be called by the function "userPredictAddress".
	//! \param initTransfer    The initTransfer argument of the function "userPredictAddress".
	//! \param targFlow        The targFlow argument of the function "userPredictAddress".
	//! \param initSocketName  The name of the initiator socket from which initTransfer is sent. If no name is designated (""), all initiator sockets are allowed.
	//! \param targSocketName  The name of the target socket to which initTransfer is sent. If no name is designated (""), all target sockets are allowed.
	function void predictNowhere_whenStrmToNoStrm(anvu_nocAip_byteTransfer initTransfer,inout anvu_flow targFlow,input string initSocketName,input string targSocketName);
		anvu_flow initFlow = initTransfer.m_flow;
		if (
			(targFlow.isNowhere)                                      // Initiator transfer is already returning in error
		||	!(nocSocketTypeByFlowId[initFlow.id()] inside {AXI,OCP,NSP} )     // Only AXI, OCP, or NSP Initiators can generates Strm Preambles
		||	!( initTransfer.m_status inside {ANVU_SC_ERROR,ANVU_SC_UNRELIABLE} || initTransfer.m_posted ) 
		||	!( initSocketName == "" || initFlow.isFrom(initSocketName) )
		||	!( targSocketName == "" || targFlow.isFrom(targSocketName) )
		)
			return;
		case (nocSocketTypeByFlowId[initFlow.id()])
			AXI : begin
				anvu_axi_monitor_transaction axiTr;
				$cast(axiTr,initTransfer.m_transaction);
				if (axiTr.burst != 0) return;
			end
			default:;
		endcase
		case (nocSocketTypeByFlowId[targFlow.id()])
			AXI : if (!nocAxiTargInfoByFlowId[targFlow.id()].supportStrm) targFlow = Flow_nowhere();
			AHB : if (!nocAhbTargInfoByFlowId[targFlow.id()].supportStrm) targFlow = Flow_nowhere();
			APB : if (!nocApbTargInfoByFlowId[targFlow.id()].supportStrm) targFlow = Flow_nowhere();
			default: return;
		endcase
	endfunction

	//! Scoreboard overload method that handles Strm bursts being returned in error when the target support Strm but cannot handle this one because its length is higher
	//! than the maximum INCR burst supported on the target, or the Strm width is higher than the target wData
	//! If this method is needed, it must be called by the function "userPredictAddress".
	//! \param initTransfer    The initTransfer argument of the function "userPredictAddress".
	//! \param targFlow        The targFlow argument of the function "userPredictAddress".
	//! \param initSocketName  The name of the initiator socket from which initTransfer is sent. If no name is designated (""), all initiator sockets are allowed.
	//! \param targSocketName  The name of the target socket to which initTransfer is sent. If no name is designated (""), all target sockets are allowed.
	function void predictNowhere_whenStrmToStrm(anvu_nocAip_byteTransfer initTransfer,inout anvu_flow targFlow,input string initSocketName,input string targSocketName);
		anvu_flow initFlow = initTransfer.m_flow;
		int initStrmWData;
		int initStrmSize;
		int targMaxStrmSize;
		int targWData;
		if (
			(targFlow.isNowhere)                                      // Initiator transfer is already returning in error
		||	!(nocSocketTypeByFlowId[initFlow.id()] inside {AXI,OCP} )     // Only AXI or OCP Initiators can generates Strm Preambles
		||	!( initTransfer.m_status inside {ANVU_SC_ERROR,ANVU_SC_UNRELIABLE} || initTransfer.m_posted ) 
		||	!( initSocketName == "" || initFlow.isFrom(initSocketName) )
		||	!( targSocketName == "" || targFlow.isFrom(targSocketName) )
		)
			return;
		case (nocSocketTypeByFlowId[targFlow.id()])
			AXI : begin
				anvu_axi_targ_info targInfo;
				targInfo     = nocAxiTargInfoByFlowId[targFlow.id()];
				if (!targInfo.supportStrm) return;
				targWData       = targInfo.wData;
				targMaxStrmSize = 1<<targInfo.wLen;
			end
			AHB : begin
				anvu_ahb_targ_info targInfo;
				targInfo     = nocAhbTargInfoByFlowId[targFlow.id()];
				if (!targInfo.supportStrm) return;
				targWData       = targInfo.wData;
				targMaxStrmSize = 1<<targInfo.wLen;
			end
			APB : begin
				anvu_apb_targ_info targInfo;
				targInfo     = nocApbTargInfoByFlowId[targFlow.id()];
				if (!targInfo.supportStrm) return;
				targWData       = targInfo.wData;
				targMaxStrmSize = 1<<targInfo.wLen;
			end
			default : return;
		endcase
				
		case (nocSocketTypeByFlowId[initFlow.id()])
			AXI : begin
				anvu_axi_monitor_transaction axiTr;
				$cast(axiTr,initTransfer.m_transaction);
				if (axiTr.burst != 0) return;
				initStrmWData = 8*(1<<axiTr.size);
				initStrmSize = (axiTr.len+1)*targWData/8; 
			end
			default :;
		endcase
		if (targWData<initStrmWData || initStrmSize>targMaxStrmSize)
			targFlow = Flow_nowhere();
	endfunction

	//! Scoreboard overload method that handles OCP Blck bursts being returned in error when the target cannot handle them.
	//! Only OCP initiators with usePreBlck in the generic interface effectively generate Blck bursts in the NoC.
	//! Only OCP targets with usePreBlck in the generic interface can handle Blck bursts, others will return an error if they receive a Blck preamble.
	//! If this method is needed, it must be called by the function "userPredictAddress".
	//! \param initTransfer    The initTransfer argument of the function "userPredictAddress".
	//! \param targFlow        The targFlow argument of the function "userPredictAddress".
	//! \param initSocketName  The name of the initiator socket from which initTransfer is sent. If no name is designated (""), all initiator sockets are allowed.
	//! \param targSocketName  The name of the target socket to which initTransfer is sent. If no name is designated (""), all target sockets are allowed.
	function void predictNowhere_whenBlckToNoBlck(anvu_nocAip_byteTransfer initTransfer,inout anvu_flow targFlow,input string initSocketName,input string targSocketName);
	endfunction
	//! Scoreboard overload method that handles OCP Blck bursts being returned in error when the target support Blck but cannot handle this one because its total length (burstlength*burstheight) is higher
	//! than the maximum INCR burst supported.
	//! Only OCP initiators with usePreBlck in the generic interface effectively generate Blck bursts in the NoC.
	//! Only OCP targets with usePreBlck in the generic interface can handle Blck bursts, others will return an error if they receive a Blck burst.
	//! If this method is needed, it must be called by the function "userPredictAddress".
	//! \param initTransfer    The initTransfer argument of the function "userPredictAddress".
	//! \param targFlow        The targFlow argument of the function "userPredictAddress".
	//! \param initSocketName  The name of the initiator socket from which initTransfer is sent. If no name is designated (""), all initiator sockets are allowed.
	//! \param targSocketName  The name of the target socket to which initTransfer is sent. If no name is designated (""), all target sockets are allowed.
	function void predictNowhere_whenBlckToBlck(anvu_nocAip_byteTransfer initTransfer,inout anvu_flow targFlow,input string initSocketName,input string targSocketName);
		anvu_flow initFlow = initTransfer.m_flow;
	endfunction

	//! Scoreboard overload method that handles Exclusive bursts being returned in error when the target cannot handle them, because they would be splitted.
	//! Only supports NSP initiators at the moment.
	//! If this method is needed, it must be called by the function "userPredictAddress".
	//! \param initTransfer    The initTransfer argument of the function "userPredictAddress".
	//! \param targFlow        The targFlow argument of the function "userPredictAddress".
	//! \param initSocketName  The name of the initiator socket from which initTransfer is sent. If no name is designated (""), all initiator sockets are allowed.
	//! \param targSocketName  The name of the target socket to which initTransfer is sent. If no name is designated (""), all target sockets are allowed.
	function void predictNowhere_whenExclWouldBeSplitted(anvu_nocAip_byteTransfer initTransfer,inout anvu_flow targFlow,input string initSocketName,input string targSocketName);
		anvu_flow initFlow = initTransfer.m_flow;
		int       burstLen,targMaxExclSize;
		if (
			(targFlow.isNowhere)                                      // Initiator transfer is already returning in error
		||	!(nocSocketTypeByFlowId[initFlow.id()] inside {NSP} )    
		||	!( initTransfer.m_status inside {ANVU_SC_ERROR,ANVU_SC_UNRELIABLE} || initTransfer.m_posted ) 
		||	!( initSocketName == "" || initFlow.isFrom(initSocketName) )
		||	!( targSocketName == "" || targFlow.isFrom(targSocketName) )
		)
			return;
		case (nocSocketTypeByFlowId[initFlow.id()])
			default:return;
		endcase
		case (nocSocketTypeByFlowId[targFlow.id()])
			AXI : begin
				anvu_axi_targ_info targInfo;
				targInfo     = nocAxiTargInfoByFlowId[targFlow.id()];
				targMaxExclSize = 1<<targInfo.wLen;
			end
			AHB : begin
				anvu_ahb_targ_info targInfo;
				targInfo     = nocAhbTargInfoByFlowId[targFlow.id()];
				targMaxExclSize = 1<<targInfo.wLen;
			end
			APB : begin
				anvu_apb_targ_info targInfo;
				targInfo     = nocApbTargInfoByFlowId[targFlow.id()];
				targMaxExclSize = 1<<targInfo.wLen;
			end
			default: return;
		endcase
		
		if (burstLen>targMaxExclSize) targFlow = Flow_nowhere();
	endfunction
endclass

endpackage
