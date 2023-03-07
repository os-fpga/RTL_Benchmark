`ifndef ANVU_JSON
`define ANVU_JSON
`include "uvm_macros.svh"

package anvu_json_pkg;
    import anvu_commons_pkg::*;
    import uvm_pkg::*;
    import "DPI-C" context function chandle     _D_JsonInitialize           (input string jsonFileName                                                                                                                                          );
    import "DPI-C" context function string      _D_GetTargetType            (input chandle jsonDocPtr, input string initiator, input string target                                                                                              );
    import "DPI-C" context function bit         _D_GetTargetBaseAddress     (input chandle jsonDocPtr, input string initiator, input string target, input int indexBaseAddress, inout longint baseAddress                                       );    
    import "DPI-C" context function bit         _D_GetTargetNumberOfMode    (input chandle jsonDocPtr, input string initiator, input string target, inout longint sizeMode                                                                      );
    import "DPI-C" context function bit         _D_SizeDictTarget           (input chandle jsonDocPtr, input string initiator, input string target, inout longint sizeTarget                                                                    );
    import "DPI-C" context function bit         _D_GetTargetMode            (input chandle jsonDocPtr, input string initiator, input string target, inout int mode, input int indexMode                                                         );    
    import "DPI-C" context function bit         _D_GetGlobalAddress         (input chandle jsonDocPtr, input string initiator, inout longint globalAddress                                                                                      );
    import "DPI-C" context function bit         _D_GetInitId                (input chandle jsonDocPtr, input string initiator, inout longint initId                                                                                             );
    import "DPI-C" context function bit         _D_GetField                 (input chandle jsonDocPtr, input string initiator, input string target, input string regName, input string field, inout int startPosition, inout int endPosition    );
    import "DPI-C" context function bit         _D_GetRegisterAddressOffset (input chandle jsonDocPtr, input string initiator, input string target, input string regName, inout longint addressOffset                                           );
    import "DPI-C" context function bit         _D_GetRegisterResetMask     (input chandle jsonDocPtr, input string initiator, input string target, input string regName, inout longint resetMask                                               );
    import "DPI-C" context function bit         _D_GetRegisterResetValue    (input chandle jsonDocPtr, input string initiator, input string target, input string regName, inout longint resetValue                                              );	
    import "DPI-C" context function bit         _D_GetNumberOfField         (input chandle jsonDocPtr, input string initiator, input string target, input string regName, inout int fieldNumbers                                                );
    import "DPI-C" context function string      _D_GetFieldAccess           (input chandle jsonDocPtr, input string initiator, input string target, input string regName, input string field                                                    );
    import "DPI-C" context function string      _D_GetFieldType             (input chandle jsonDocPtr, input string initiator, input string target, input string regName, input string field                                                    );
    import "DPI-C" context function bit         _D_CheckValidRegister       (input chandle jsonDocPtr, input string initiator, input string target, input string regName                                                                        );
    import "DPI-C" context function bit         _D_CheckValidField          (input chandle jsonDocPtr, input string initiator, input string target, input string regName, input string field                                                    );
    import "DPI-C" context function string      _D_GetFieldName             (input chandle jsonDocPtr, input string initiator, input string target, input string regName, input int indexDict                                                   );
    import "DPI-C" context function string      _D_GetRegisterName          (input chandle jsonDocPtr, input string initiator, input string target, input int indexDict                                                                         );
    import "DPI-C" context function bit         _D_CheckValidTarget         (input chandle jsonDocPtr, input string initiator, input string target                                                                                              );



    function chandle openJson(string fileName);
        chandle doc;
        `uvm_info("anvu_json_pkg",$psprintf("Try to open Json File"),uvm_pkg::UVM_LOW);
        doc = _D_JsonInitialize(fileName);
        if (doc == null) begin 
            `uvm_fatal("anvu_json_pkg",$psprintf("Could not open the Json File '%s' .",fileName));
        end
        else begin
            `uvm_info("anvu_json_pkg",$psprintf("Success to open '%s' .",fileName),uvm_pkg::UVM_LOW);
        end
        return doc;
    endfunction

    function string fieldType(chandle jsonDocPtr, string initiator, string target, string regName,string field);
        return _D_GetFieldType(jsonDocPtr, initiator, target, regName, field);
    endfunction

    function string fieldAccess(chandle jsonDocPtr, string initiator, string target, string regName,string field);
        return _D_GetFieldAccess(jsonDocPtr, initiator, target, regName, field);
    endfunction
    
    function string fieldName(chandle jsonDocPtr, string initiator, string target, string regName, int fieldNumbers);
        string fieldN;
        fieldN = _D_GetFieldName(jsonDocPtr, initiator, target, regName, fieldNumbers);
        return fieldN;
        endfunction

    function string targetType(chandle jsonDocPtr, string initiator, string target);
       return _D_GetTargetType (jsonDocPtr, initiator,target);
    endfunction

    function longint widthField(chandle jsonDocPtr, string initiator, string target, string regName, string field);
        int startPosition, endPosition;
        automatic bit boolPassDPI = 0;
        boolPassDPI = _D_GetField(jsonDocPtr, initiator, target, regName, field, startPosition, endPosition);
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetField; Check function parameters  and Json export");
        return endPosition - startPosition + 1;
    endfunction

    function longint resetValueField(chandle jsonDocPtr, string initiator, string target, string regName, string field);
        int startPosition, endPosition;
        longint rstValReg, rstValField, width;
        automatic bit boolPassDPI = 0;
        width = widthField(jsonDocPtr, initiator, target, regName, field);
        boolPassDPI = _D_GetField(jsonDocPtr, initiator, target, regName, field, startPosition, endPosition);
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetField; Check function parameters  and Json export");
        rstValReg = registerResetValue(jsonDocPtr, initiator, target, regName);
        rstValField = (rstValReg >> startPosition) & (-1 + 2**width);
        return rstValField;
    endfunction

    function int numField(chandle jsonDocPtr, string initiator, string target, string regName);
        int fieldNumbers;
        automatic bit boolPassDPI = 0;
        boolPassDPI = _D_GetNumberOfField(jsonDocPtr, initiator, target, regName, fieldNumbers);
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetNumberOfField; Check function parameters  and Json export");
        return fieldNumbers;
    endfunction
    
    function string registerName(chandle jsonDocPtr, string initiator, string target,longint index);
        string regName;
        regName = _D_GetRegisterName(jsonDocPtr, initiator, target, index);
        if(validRegister(jsonDocPtr, initiator, target, regName)) begin
            return regName;
        end
        else begin
            `uvm_error("DPI Json Error", "Error in DPI-C _D_GetRegisterName; Check function parameters  and Json export");
            return "ERROR get RegisterName";
        end
    endfunction

    function longint setWrValue(chandle jsonDocPtr, string initiator, string target, string regName);
        longint indexRegister, wrVal, rstValField;
        automatic bit boolPassDPI = 0;
        int indexField, startPosition, endPosition, width, fieldNumbers;
        string fieldN, currentRegister, fieldAcc;
        wrVal = 0;
        fieldNumbers = numField(jsonDocPtr, initiator,target,regName);
        for(indexField = 0; indexField < fieldNumbers; indexField++) begin
            fieldN = fieldName(jsonDocPtr, initiator, target,regName, indexField);
            if ((fieldAccess(jsonDocPtr, initiator, target, regName, fieldN) == "read-write") && (fieldType(jsonDocPtr, initiator, target, regName, fieldN) == "Control")) begin
                boolPassDPI = _D_GetField(jsonDocPtr, initiator, target, regName, fieldN, startPosition, endPosition);
                assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetField; Check function parameters  and Json export");
                rstValField = resetValueField(jsonDocPtr, initiator, target, regName, fieldN);
                if(rstValField !=0) begin
                    wrVal = wrVal + (0 << startPosition);
                end
                else begin
                    wrVal = wrVal + (1<< startPosition);
                end
            end
        end
        return wrVal;               
    endfunction

    function longint setWrMask(chandle jsonDocPtr, string initiator, string target, string regName);
        longint indexRegister, wrMask, i;
        int startPosition, endPosition, width, indexField, fieldNumbers;
        automatic bit boolPassDPI = 0;
        string fieldN, currentRegister;
        wrMask = 0;
        i = 1;
        fieldNumbers = numField(jsonDocPtr, initiator,target,regName);
        for(indexField = 0; indexField < fieldNumbers; indexField++) begin
            fieldN = fieldName(jsonDocPtr, initiator,target,regName, indexField);
            if ((fieldAccess(jsonDocPtr, initiator,target,regName,fieldN) == "read-write") && (fieldType(jsonDocPtr, initiator,target,regName,fieldN) == "Control")) begin
                boolPassDPI = _D_GetField(jsonDocPtr, initiator,target,regName,fieldN,startPosition,endPosition);
                assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetField; Check function parameters  and Json export");
                wrMask += ((i<<(endPosition-startPosition+1))-1) << startPosition;
            end
        end         
        return wrMask;               
    endfunction
                    
    function longint sizeTarget(chandle jsonDocPtr,  string initiator, string target);
        int size;
        automatic bit boolPassDPI = 0;
        boolPassDPI = _D_SizeDictTarget (jsonDocPtr, initiator, target, size);
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_SizeDictTarget; Check function parameters  and Json export");
        return size;
    endfunction

    function bit validRegister(chandle jsonDocPtr,  string initiator, string target, string regName );
        return _D_CheckValidRegister(jsonDocPtr, initiator, target, regName);
    endfunction

    function bit validTarget(chandle jsonDocPtr,  string initiator, string target);
        return _D_CheckValidTarget(jsonDocPtr, initiator, target );
    endfunction

    function longint globalAddressInit(chandle jsonDocPtr, string initiator);
        longint globalAddress;
        automatic bit boolPassDPI = 0;
        boolPassDPI = _D_GetGlobalAddress(jsonDocPtr, initiator, globalAddress);
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetGlobalAddress; Check function parameters  and Json export");
        return globalAddress;
    endfunction

    function longint targetBaseAddress(chandle jsonDocPtr, string initiator, string target,int indexBaseAddress);
        longint targBaseAddress;
        automatic bit boolPassDPI = 0;
        boolPassDPI = _D_GetTargetBaseAddress(jsonDocPtr, initiator, target,indexBaseAddress, targBaseAddress);
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetTargetBaseAddress; Check function parameters  and Json export");
        return targBaseAddress;
    endfunction

    function int registerWR(chandle jsonDocPtr, string initiator, string target, string regName);
        int fieldNumbers, indexField, isWr;
        automatic bit boolPassDPI = 0;
        string fieldN;
        isWr = 0;
        fieldNumbers = numField(jsonDocPtr, initiator,target,regName);
        fieldN = fieldName(jsonDocPtr, initiator,target,regName,0);
            if ((fieldAccess(jsonDocPtr, initiator, target, regName, fieldN) == "read-write") && (fieldType(jsonDocPtr, initiator, target, regName, fieldN) == "Control")) begin
                isWr = 1;
            end
        return isWr;
    endfunction

    function int modeAccessTarget(chandle jsonDocPtr, string initiator, string target, int indexMode);
        int mode;
        automatic bit boolPassDPI = 0;
        boolPassDPI = _D_GetTargetMode (jsonDocPtr, initiator, target, mode, indexMode );
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetTargetModet; Check function parameters  and Json export");
        return mode;
    endfunction

    function int numberOfMode(chandle jsonDocPtr, string initiator, string target);
        automatic bit boolPassDPI = 0;
        int sizeMode;
        boolPassDPI = _D_GetTargetNumberOfMode( jsonDocPtr, initiator, target, sizeMode);
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetTargetModet; Check function parameters  and Json export");
        return sizeMode;
    endfunction


    function longint registerAddressOffset(chandle jsonDocPtr, string initiator, string target, string field);
        longint addressOffset;
        automatic bit boolPassDPI = 0;
        boolPassDPI = _D_GetRegisterAddressOffset(jsonDocPtr, initiator, target, field, addressOffset);
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetRegisterAddressOffset; Check function parameters  and Json export");
        return addressOffset;
    endfunction

    function longint initiatorId(chandle jsonDocPtr, string initiator);
        longint initId;
        automatic bit boolPassDPI = 0;
        boolPassDPI = _D_GetInitId(jsonDocPtr, initiator, initId);
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetInitId; Check function parameters  and Json export");
        return initId;
    endfunction

    function longint registerResetValue(chandle jsonDocPtr, string initiator, string target, string regName);
        longint resetValue;
        automatic bit boolPassDPI = 0;
        boolPassDPI =  _D_GetRegisterResetValue(jsonDocPtr, initiator, target, regName, resetValue);
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetRegisterResetValue; Check function parameters and Json export");
        return resetValue;
    endfunction

    function longint registerResetMask(chandle jsonDocPtr, string initiator, string target, string regName);
        longint resetMask;
        automatic bit boolPassDPI = 0;
        boolPassDPI =  _D_GetRegisterResetMask(jsonDocPtr, initiator, target, regName, resetMask);
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI Json Error","Error in DPI-C _D_GetRegisterResetMask; Check function parameters and Json export");
        return resetMask;
    endfunction

    function longint addressSum (chandle jsonDocPtr, string initiator, string target, string register,int indexBaseAddress);
        return targetBaseAddress(jsonDocPtr, initiator, target,indexBaseAddress) + registerAddressOffset(jsonDocPtr, initiator, target, register);
    endfunction

    function longint setDataMask (chandle jsonDocPtr, string initiator, string target, string register, string field);
        int startPosition ,endPosition;
        longint resetValue, dataMask;
        automatic bit boolPassDPI = 0;
        boolPassDPI = _D_GetField(jsonDocPtr, initiator, target, register, field, startPosition, endPosition);
        assert (boolPassDPI == 1 ) else `uvm_fatal("DPI _Get_","Error in DPI-C _D_GetField; Check function parameters and Json export");
        dataMask = (2**endPosition - startPosition)-1 << startPosition;
        return dataMask;
    endfunction

    function automatic anvu_registerMap_access setRegisterAccessWrite(chandle jsonDocPtr, anvu_registerMap_access accessBist, string initiator, string target,string register, longint dataValue, longint dataMask,int indexBaseAddress);
        accessBist.address 		= addressSum(jsonDocPtr, initiator,target,register,indexBaseAddress);
        accessBist.write 		= 1'b1;
        accessBist.dataValue 	= dataValue;
        accessBist.dataMask 	= dataMask;
        return accessBist;
    endfunction

    function automatic anvu_registerMap_access setRegisterAccessRead(chandle jsonDocPtr, anvu_registerMap_access accessBist, string initiator, string target, string register, longint dataValue, longint dataMask,int indexBaseAddress);
        accessBist.address 		= addressSum(jsonDocPtr, initiator, target, register,indexBaseAddress);
        accessBist.write 		= 1'b0;
        accessBist.dataValue 	= dataValue;
        accessBist.dataMask 	= dataMask;
        return accessBist;
    endfunction

    function void  getAllWrAccess(chandle jsonDocPtr, string allInitiator[$], string allTarget[$], string register,output anvu_registerMap_access registerMapAccesses[$]);
        longint initId;
		int sizeMode, indexMode;
        int sizeDict,indexRegister;
        longint mode, dataMask, dataValue;
		string currentRegister;
        
        anvu_registerMap_access access;
        anvu_flow initFlow;
        
        
        foreach(allInitiator[i]) begin
			initId 		= initiatorId(jsonDocPtr, allInitiator[i]);
			initFlow 	= Flow_fromNameAndIdx(allInitiator[i],initId);
			if (initFlow.isNowhere()) begin
				`uvm_error("anvu_test",$psprintf("Initiator information '%s %d' does not reference a valid initiator.",allInitiator[i],initId))
				break;
            end
            foreach(allTarget[j]) begin
				if(validTarget(jsonDocPtr,allInitiator[i],allTarget[j])) begin
					sizeDict 	= sizeTarget(jsonDocPtr, allInitiator[i], allTarget[j]);
                    sizeMode 	= numberOfMode(jsonDocPtr, allInitiator[i], allTarget[j]);
					for( indexMode = 0; indexMode < sizeMode; indexMode++) begin
                        for(indexRegister = 0; indexRegister < sizeDict; indexRegister++) begin
                            currentRegister = registerName(jsonDocPtr,allInitiator[i],allTarget[j],indexRegister);
                            if(currentRegister != register) begin
                                continue;
                            end
                            if(registerWR(jsonDocPtr,allInitiator[i],allTarget[j],currentRegister) == 1) begin
								mode = modeAccessTarget (jsonDocPtr,allInitiator[i],allTarget[j], indexMode);
								access.mode 				= mode;
								access.initFlowId 			= initFlow.id();
								access.securityLevel 		= 0;
                                access.address 		        = addressSum(jsonDocPtr, allInitiator[i],allTarget[j],register,indexMode);
                                access.write 		        = 1'b1;
                                access.dataValue 	        = registerResetValue(jsonDocPtr, allInitiator[i],allTarget[j],currentRegister);
                                access.dataMask 	        = registerResetMask (jsonDocPtr, allInitiator[i],allTarget[j],currentRegister);

                                registerMapAccesses.push_back(access);
                            end
                        end
                    end

                end
            end
        end
        

    endfunction


    function void  getWrAccess(chandle jsonDocPtr, string allInitiator[$], string allTarget[$], string register,output anvu_registerMap_access registerMapAccesses[$]);
        longint initId;
		int sizeMode, indexMode;
        int sizeDict,indexRegister;
        longint mode, dataMask, dataValue;
		string currentRegister;
        
        anvu_registerMap_access access;
        anvu_flow initFlow;
        
        
        foreach(allInitiator[i]) begin
			initId 		= initiatorId(jsonDocPtr, allInitiator[i]);
			initFlow 	= Flow_fromNameAndIdx(allInitiator[i],initId);
			if (initFlow.isNowhere()) begin
				`uvm_error("anvu_test",$psprintf("Initiator information '%s %d' does not reference a valid initiator.",allInitiator[i],initId))
				break;
            end
            foreach(allTarget[j]) begin
				if(validTarget(jsonDocPtr,allInitiator[i],allTarget[j])) begin
					sizeDict 	= sizeTarget(jsonDocPtr, allInitiator[i], allTarget[j]);
                    sizeMode 	= numberOfMode(jsonDocPtr, allInitiator[i], allTarget[j]);
					for( indexMode = 0; indexMode < sizeMode; indexMode++) begin
                        for(indexRegister = 0; indexRegister < sizeDict; indexRegister++) begin
                            currentRegister = registerName(jsonDocPtr,allInitiator[i],allTarget[j],indexRegister);
                            if(currentRegister != register) begin
                                continue;
                            end
                            if(registerWR(jsonDocPtr,allInitiator[i],allTarget[j],currentRegister) == 1) begin
								mode = modeAccessTarget (jsonDocPtr,allInitiator[i],allTarget[j], indexMode);
								access.mode 				= mode;
								access.initFlowId 			= initFlow.id();
								access.securityLevel 		= 0;
                                access.address 		        = addressSum(jsonDocPtr, allInitiator[i],allTarget[j],register,indexMode);
                                access.write 		        = 1'b1;
                                access.dataValue 	        = registerResetValue(jsonDocPtr, allInitiator[i],allTarget[j],currentRegister);
                                access.dataMask 	        = registerResetMask (jsonDocPtr, allInitiator[i],allTarget[j],currentRegister);

                                registerMapAccesses.push_back(access);
                            end
                            else begin
                                `uvm_error("anvu_test",$psprintf("The register '%s' is Read Only",register));
                            end

                        end
                    end

                end
            end
        end
    endfunction
endpackage
`endif


