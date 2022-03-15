lpm_ram_dq1_inst : lpm_ram_dq1 PORT MAP (
		address	 => address_sig,
		we	 => we_sig,
		inclock	 => inclock_sig,
		data	 => data_sig,
		q	 => q_sig
	);
