lpm_ram_dq0_inst : lpm_ram_dq0 PORT MAP (
		address	 => address_sig,
		we	 => we_sig,
		inclock	 => inclock_sig,
		data	 => data_sig,
		q	 => q_sig
	);
