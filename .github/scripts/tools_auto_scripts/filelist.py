###################################################################################################
###################################################################################################
################## FILELIST FOR SETTING GLOBAL VARIABLES FOR DIFFERENT TOOLS ######################
###################################################################################################
###################################################################################################

####################################################################
#################### CGA VARIABLES #################################
####################################################################

GEN_CONF = CGA_ROOT+"/configs/all.tcl"

####################################################################
################## OPENFPGA VARIABLES ##############################
####################################################################

def set_openfpga_variables():
  # TOOL PATH
  globals()['OPENFPGA_PATH'] = CGA_ROOT+"/OpenFPGA/"
  globals()['OPENFPGA_MISC_DIR']= CGA_ROOT+"/misc/openfpga/"

  #PATH OF SCRIPT TEMPLATE AND PATH TO GENERATE SCRIPT FOR RUN
  globals()['OPENFPGA_SHELL_TEMP_PATH']= CGA_ROOT+"/scripts/tools_auto_scripts/openfpga/generate_fabric_example_script_param_temp.openfpga"
  globals()['OPENFPGA_SHELL_GEN_PATH']= CGA_ROOT+"/misc/openfpga/cga_gen.openfpga"

  #PATH OF GENERATED LOGS
  globals()['OPENFPGA_GEN_LOG_PATH']= OPENFPGA_PATH+"/openfpga_flow/tasks/param_config/latest/"+VPR_ARCH+"/"+DESIGN_TOP+"/MIN_ROUTE_CHAN_WIDTH"
  globals()['OPENFPGA_GEN_UTIL_LOG']= OPENFPGA_GEN_LOG_PATH+"/openfpgashell.log"
  globals()['OPENFPGA_GEN_UTIL2_LOG']= OPENFPGA_GEN_LOG_PATH+"/yosys_output.log"
  globals()['OPENFPGA_GEN_TIME1_LOG']= OPENFPGA_GEN_LOG_PATH+"/vpr_stdout.log"
  globals()['OPENFPGA_GEN_TIME2_LOG']= OPENFPGA_GEN_LOG_PATH+"/report_timing.setup.rpt"

  #PATH FOR FINAL LOG
  globals()['OPENFPGA_FINAL_LOG_PATH']= CGA_ROOT+"/logs/openfpga/"
  globals()['OPENFPGA_UTIL_LOG']= OPENFPGA_FINAL_LOG_PATH+"/utilization."+PROJECT_NAME+".log"
  globals()['OPENFPGA_TIME1_LOG']= OPENFPGA_FINAL_LOG_PATH+"/timing1."+PROJECT_NAME+".log"
  globals()['OPENFPGA_TIME2_LOG']= OPENFPGA_FINAL_LOG_PATH+"/timing2."+PROJECT_NAME+".log"
  globals()['OPENFPGA_STATUS_LOG']= OPENFPGA_FINAL_LOG_PATH+"status."+PROJECT_NAME+".log"
  globals()['OPENFPGA_STATUS_LOG1']= OPENFPGA_FINAL_LOG_PATH+"status_log.csv"

  #PATH OF SDC TEMPLATE AND PATH TO GENERATE SDC FOR RUN
  globals()['OPENFPGA_SDC_PATH']= CGA_ROOT+"/scripts/etc_scripts"
  globals()['OPENFPGA_SDC_TEMP']= OPENFPGA_SDC_PATH+"/openfpga_sdc_template.sdc"
  globals()['OPENFPGA_SDC_COMB_TEMP']= OPENFPGA_SDC_PATH+"/openfpga_sdc_comb_template.sdc"
  globals()['OPENFPGA_SDC_GEN']= OPENFPGA_SDC_PATH+"/openfpga_sdc.sdc"
  globals()['SDC_JSON']= CGA_ROOT+"/"+DESIGN_DIR+"/sdc.json"

####################################################################
##################  VIVADO VARIABLES  ##############################
####################################################################

def set_vivado_variables():
  # TOOL RUN PATH
  globals()['VIVADO_MISC_DIR']= CGA_ROOT+"/misc/vivado/"

  #PATH OF SCRIPT TEMPLATE AND PATH TO GENERATE SCRIPT FOR RUN
  globals()['VIVADO_SCRIPT_PATH']= CGA_ROOT+"/scripts/tools_auto_scripts/vivado"
  globals()['VIVADO_SCRIPT']= VIVADO_SCRIPT_PATH+"/viv_script.tcl"

  #PATH OF GENERATED LOGS
  globals()['VIVADO_GEN_LOG_PATH']= VIVADO_MISC_DIR+PROJECT_NAME
  globals()['VIVADO_ERROR_LOG']= VIVADO_MISC_DIR+"vivado.log"
  globals()['VIVADO_GEN_UTIL_LOG']= VIVADO_GEN_LOG_PATH+"/util_temp."+PROJECT_NAME+".log"
  globals()['VIVADO_GEN_TIME_LOG']= VIVADO_GEN_LOG_PATH+"/timing_temp."+PROJECT_NAME+".log"

  #PATH FOR FINAL LOG
  globals()['VIVADO_FINAL_LOG_PATH']= CGA_ROOT+"/logs/vivado/"
  globals()['VIVADO_TIME_LOG']= VIVADO_FINAL_LOG_PATH+"/timing."+PROJECT_NAME+".log"
  globals()['VIVADO_UTIL_LOG']= VIVADO_FINAL_LOG_PATH+"/utilization."+PROJECT_NAME+".log"
  globals()['VIVADO_STATUS_LOG']= VIVADO_FINAL_LOG_PATH+"status."+PROJECT_NAME+".log"
  globals()['VIVADO_STATUS_LOG1']= VIVADO_FINAL_LOG_PATH+"status_log.csv"

  #PATH OF SDC TEMPLATE AND PATH TO GENERATE SDC FOR RUN
  globals()['VIVADO_SDC_PATH']= CGA_ROOT+"/scripts/etc_scripts"
  globals()['VIVADO_SDC_TEMP']= VIVADO_SDC_PATH+"/vivado_sdc_template.xdc"
  globals()['VIVADO_SDC_GEN']= VIVADO_SDC_PATH+"/vivado_sdc.xdc"
  globals()['VIVADO_SDC_COMB_TEMP']= VIVADO_SDC_PATH+"/vivado_sdc_comb_template.xdc"
  globals()['SDC_JSON']= CGA_ROOT+"/"+DESIGN_DIR+"/sdc.json"

####################################################################
##################  QUARTUS VARIABLES  #############################
####################################################################

def set_quartus_variables():
  # TOOL RUN PATH
  globals()['QUARTUS_MISC_DIR']= CGA_ROOT+"/misc/quartus/"

  #PATH OF SCRIPT TEMPLATE AND PATH TO GENERATE SCRIPT FOR RUN
  globals()['QUARTUS_SCRIPT_PATH']= CGA_ROOT+"/scripts/tools_auto_scripts/quartus"
  globals()['QUARTUS_SCRIPT']= QUARTUS_SCRIPT_PATH+"/quartus_script.tcl"

  #PATH OF GENERATED LOGS
  globals()['QUARTUS_GEN_LOG_PATH']= QUARTUS_MISC_DIR+PROJECT_NAME
  globals()['QUARTUS_ERROR_LOG']= QUARTUS_GEN_LOG_PATH+"/"+PROJECT_NAME+".map.rpt"
  globals()['QUARTUS_GEN_UTIL_LOG']= QUARTUS_GEN_LOG_PATH+"/"+PROJECT_NAME+".fit.rpt"
  globals()['QUARTUS_GEN_TIME_LOG']= QUARTUS_GEN_LOG_PATH+"/"+PROJECT_NAME+".sta.rpt" 

  #PATH FOR FINAL LOG
  globals()['QUARTUS_FINAL_LOG_PATH']= CGA_ROOT+"/logs/quartus/"
  globals()['QUARTUS_TIME_LOG']= QUARTUS_FINAL_LOG_PATH+"/timing."+PROJECT_NAME+".log"
  globals()['QUARTUS_UTIL_LOG']= QUARTUS_FINAL_LOG_PATH+"/utilization."+PROJECT_NAME+".log"
  globals()['QUARTUS_STATUS_LOG']= QUARTUS_FINAL_LOG_PATH+"status."+PROJECT_NAME+".log"
  globals()['QUARTUS_STATUS_LOG1']= QUARTUS_FINAL_LOG_PATH+"status_log.csv"

  #PATH OF SDC TEMPLATE AND PATH TO GENERATE SDC FOR RUN
  globals()['QUARTUS_SDC_PATH']= CGA_ROOT+"/scripts/etc_scripts"
  globals()['QUARTUS_SDC_TEMP']= QUARTUS_SDC_PATH+"/quartus_sdc_template.sdc"
  globals()['QUARTUS_SDC_GEN']= QUARTUS_SDC_PATH+"/quartus_sdc.sdc"
  globals()['SDC_JSON']= CGA_ROOT+"/"+DESIGN_DIR+"/sdc.json"

