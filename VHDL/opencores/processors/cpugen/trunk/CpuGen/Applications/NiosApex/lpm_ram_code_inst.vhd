lpm_ram_code_inst : lpm_ram_code PORT MAP (
		address	 => address_sig,
		we	 => we_sig,
		inclock	 => inclock_sig,
		outclock	 => outclock_sig,
		data	 => data_sig,
		q	 => q_sig
	);
