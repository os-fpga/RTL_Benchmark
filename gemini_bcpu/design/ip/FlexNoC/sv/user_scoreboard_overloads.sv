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

function automatic void userPredictAddress(anvu_nocAip_scoreboard sc,anvu_nocAip_byteTransfer initTransfer,inout anvu_flow targetFlow,inout longint targetAddress);
	//! Scoreboard overload method that handles Strm bursts being returned in error when the target support Strm but cannot handle this one because its length is higher
	//! than the maximum INCR burst supported on the target, or the Strm width is higher than the target wData
	sc.predictNowhere_whenStrmToNoStrm         (initTransfer,targetFlow,"","");

	//! Scoreboard overload method that handles Strm bursts being returned in error when the target cannot handle them.
	//! If this method is needed, it must be called by the function "userPredictAddress".
	sc.predictNowhere_whenStrmToStrm           (initTransfer,targetFlow,"","");

	//! Scoreboard overload method that handles OCP Blck bursts being returned in error when the target cannot handle them.
	//! Only OCP initiators with usePreBlck in the generic interface effectively generate Blck bursts in the NoC.
	//! Only OCP targets with usePreBlck in the generic interface can handle Blck bursts, others will return an error if they receive a Blck preamble.
	sc.predictNowhere_whenBlckToNoBlck         (initTransfer,targetFlow,"","");
	
	//! Scoreboard overload method that handles OCP Blck bursts being returned in error when the target support Blck but cannot handle this one because its total length (burstlength*burstheight) is higher
	//! than the maximum INCR burst supported.
	//! Only OCP initiators with usePreBlck in the generic interface effectively generate Blck bursts in the NoC.
	//! Only OCP targets with usePreBlck in the generic interface can handle Blck bursts, others will return an error if they receive a Blck burst.
	sc.predictNowhere_whenBlckToBlck           (initTransfer,targetFlow,"","");

	//! Scoreboard overload method that handles Exclusive bursts being returned in error when the target cannot handle them, because they would be splitted.
	//! Only supports NSP initiators at the moment.
	//! If this method is needed, it must be called by the function "userPredictAddress".
	sc.predictNowhere_whenExclWouldBeSplitted  (initTransfer,targetFlow,"","");
endfunction

function automatic  bit userQualifyAssociation(anvu_nocAip_scoreboard sc,anvu_nocAip_byteTransfer initTransfer,anvu_nocAip_byteTransfer targetTransfer);
	return 1;
endfunction

function automatic bit userQualifyInitiatorOrphan(anvu_nocAip_scoreboard sc,anvu_nocAip_byteTransfer initTransfer,anvu_flow targetFlow);
	bit result = 0;

	//! Scoreboard overload method that handles transaction coming back in error when the target does not have byteen support and
	//! the initiator transaction requires them. Either because it is a write with incomplete byteen pattern, or a transaction smaller
	//! than the target bus width.
	result |= sc.allowInitOrphan_TargNoByteen   (initTransfer,targetFlow,"","");

	//! Scoreboard overload method that handles Write Exclusive transaction which are transformed to simple Write with byte enable set to 0 (and hence not detected on the target side).
	//! If this method is needed, it must be called by the function "userQualifyInitatorOrphan".
	result |= sc.allowInitOrphan_WriteExcl      (initTransfer,targetFlow,"","");
	
	return result;
endfunction

function automatic bit userQualifyTargetOrphan(anvu_nocAip_scoreboard sc,anvu_nocAip_byteTransfer targTransfer);
	bit result = 0;
	//! Scoreboard overload method that handles the additionnal WR accesses at a target that are caused by a lack of byteEn support.
	result |= sc.allowTargOrphan_TargNoByteen(targTransfer,"");
endfunction
