###################################################################################################
###################################################################################################
################## FILELIST FOR SETTING GLOBAL VARIABLES FOR DIFFERENT TOOLS ######################
###################################################################################################
###################################################################################################

####################################################################
#################### CGA VARIABLES #################################
####################################################################

GEN_CONF = CGA_ROOT+"/.github/configs/all.tcl"

####################################################################
################## YOSYS VARIABLES ##############################
####################################################################

def set_yosys_variables():
  # TOOL PATH
  globals()['YOSYS_MISC_DIR']= CGA_ROOT+"/misc/yosys/"
  globals()['YOSYS_SCRIPT']= CGA_ROOT+"/.github/scripts/tools_auto_scripts/yosys/yosys.tcl"

  #PATH OF GENERATED LOGS
  globals()['YOSYS_GEN_LOG_PATH']= YOSYS_MISC_DIR+PROJECT_NAME
  globals()['YOSYS_ERROR_LOG']= YOSYS_GEN_LOG_PATH+"/"+PROJECT_NAME+".log"

  #PATH FOR FINAL LOG
  globals()['YOSYS_FINAL_LOG_PATH']= CGA_ROOT+"/logs/yosys/"
  globals()['YOSYS_STATUS_LOG1']= YOSYS_FINAL_LOG_PATH+"status_log.csv"


####################################################################
##################  VIVADO VARIABLES  ##############################
####################################################################

def set_vivado_variables():
  # TOOL RUN PATH
  globals()['VIVADO_MISC_DIR']= CGA_ROOT+"/misc/vivado/"

  #PATH OF SCRIPT TEMPLATE AND PATH TO GENERATE SCRIPT FOR RUN
  globals()['VIVADO_SCRIPT_PATH']= CGA_ROOT+"/.github/scripts/tools_auto_scripts/vivado"
  globals()['VIVADO_SCRIPT']= VIVADO_SCRIPT_PATH+"/viv_script.tcl"

  #PATH OF GENERATED LOGS
  globals()['VIVADO_GEN_LOG_PATH']= VIVADO_MISC_DIR+PROJECT_NAME
  globals()['VIVADO_ERROR_LOG']= VIVADO_MISC_DIR+"vivado.log"
  globals()['VIVADO_GEN_UTIL_LOG']= VIVADO_GEN_LOG_PATH+"/util_temp."+PROJECT_NAME+".log"
  globals()['VIVADO_GEN_TIME_LOG']= VIVADO_GEN_LOG_PATH+"/timing_temp."+PROJECT_NAME+".log"

  #PATH FOR FINAL LOG
  globals()['VIVADO_FINAL_LOG_PATH']= CGA_ROOT+"/logs/vivado/"
  globals()['VIVADO_STATUS_LOG1']= VIVADO_FINAL_LOG_PATH+"status_log.csv"

####################################################################
##################  QUARTUS VARIABLES  #############################
####################################################################

def set_quartus_variables():
  # TOOL RUN PATH
  globals()['QUARTUS_MISC_DIR']= CGA_ROOT+"/misc/quartus/"

  #PATH OF SCRIPT TEMPLATE AND PATH TO GENERATE SCRIPT FOR RUN
  globals()['QUARTUS_SCRIPT_PATH']= CGA_ROOT+"/.github/scripts/tools_auto_scripts/quartus"
  globals()['QUARTUS_SCRIPT']= QUARTUS_SCRIPT_PATH+"/quartus_script.tcl"

  #PATH OF GENERATED LOGS
  globals()['QUARTUS_GEN_LOG_PATH']= QUARTUS_MISC_DIR+PROJECT_NAME
  globals()['QUARTUS_ERROR_LOG']= QUARTUS_GEN_LOG_PATH+"/"+PROJECT_NAME+".map.rpt"
  globals()['QUARTUS_GEN_UTIL_LOG']= QUARTUS_GEN_LOG_PATH+"/"+PROJECT_NAME+".fit.rpt"
  globals()['QUARTUS_GEN_TIME_LOG']= QUARTUS_GEN_LOG_PATH+"/"+PROJECT_NAME+".sta.rpt" 

  #PATH FOR FINAL LOG
  globals()['QUARTUS_FINAL_LOG_PATH']= CGA_ROOT+"/logs/quartus/"
  globals()['QUARTUS_STATUS_LOG1']= QUARTUS_FINAL_LOG_PATH+"status_log.csv"

####################################################################
##################  LATTICE VARIABLES  #############################
####################################################################
  
def set_lattice_variables():
  # TOOL RUN PATH
  globals()['LATTICE_MISC_DIR']= CGA_ROOT+"/misc/lattice/"

  #PATH OF SCRIPT TEMPLATE AND PATH TO GENERATE SCRIPT FOR RUN
  globals()['LATTICE_SCRIPT_PATH']= CGA_ROOT+"/.github/scripts/tools_auto_scripts/lattice"
  globals()['LATTICE_SCRIPT']= LATTICE_SCRIPT_PATH+"/lattice_script.tcl"

  #PATH OF GENERATED LOGS
  globals()['LATTICE_GEN_LOG_PATH']= LATTICE_MISC_DIR+"/impl_"+PROJECT_NAME
  globals()['LATTICE_ERROR_LOG']= LATTICE_GEN_LOG_PATH+"/automake.log"
  globals()['LATTICE_GEN_UTIL_LOG']= LATTICE_GEN_LOG_PATH+"/"+PROJECT_NAME+"_impl_"+PROJECT_NAME+".mrp"
  globals()['LATTICE_GEN_TIME_LOG']= LATTICE_GEN_LOG_PATH+"/"+PROJECT_NAME+"_impl_"+PROJECT_NAME+".par" 

  #PATH FOR FINAL LOG
  globals()['LATTICE_FINAL_LOG_PATH']= CGA_ROOT+"/logs/lattice/"
  globals()['LATTICE_STATUS_LOG1']= LATTICE_FINAL_LOG_PATH+"status_log.csv"

####################################################################
##################  GOWIN VARIABLES  ###############################
####################################################################
  
  
def set_gowin_variables():
  # TOOL RUN PATH
  globals()['GOWIN_MISC_DIR']= CGA_ROOT+"/misc/gowin/"

  #PATH OF SCRIPT TEMPLATE AND PATH TO GENERATE SCRIPT FOR RUN
  globals()['GOWIN_SCRIPT_PATH']= CGA_ROOT+"/.github/scripts/tools_auto_scripts/gowin"
  globals()['GOWIN_SCRIPT']= GOWIN_SCRIPT_PATH+"/gowin_script.tcl"

  #PATH OF GENERATED LOGS
  globals()['GOWIN_GEN_LOG_PATH']= GOWIN_MISC_DIR+"/impl/gwsynthesis"
  globals()['GOWIN_ERROR_LOG']= GOWIN_GEN_LOG_PATH+"/"+PROJECT_NAME+".log"
  #globals()['GOWIN_GEN_UTIL_LOG']= GOWIN_GEN_LOG_PATH+"/"+PROJECT_NAME+"_impl_"+PROJECT_NAME+".mrp"
  #globals()['GOWIN_GEN_TIME_LOG']= GOWIN_GEN_LOG_PATH+"/"+PROJECT_NAME+"_impl_"+PROJECT_NAME+".par" 

  #PATH FOR FINAL LOG
  globals()['GOWIN_FINAL_LOG_PATH']= CGA_ROOT+"/logs/gowin/"
  globals()['GOWIN_STATUS_LOG1']= GOWIN_FINAL_LOG_PATH+"status_log.csv"
