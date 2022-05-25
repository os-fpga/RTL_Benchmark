
proc generate {drv_handle} {
  ::hsi::utils::define_include_file $drv_handle "xparameters.h" "TMEMAC" "NUM_INSTANCES" "C_BASEADDR" "C_HIGHADDR" "DEVICE_ID" "C_INTERRUPT_PRESENT"
  ::hsi::utils::define_canonical_xpars $drv_handle "xparameters.h" "TMEMAC" "C_BASEADDR" "C_HIGHADDR" "DEVICE_ID" "C_INTERRUPT_PRESENT"
}