lpm_code_dp0_inst : lpm_code_dp0 PORT MAP (
		data	 => data_sig,
		wren	 => wren_sig,
		wraddress	 => wraddress_sig,
		rdaddress	 => rdaddress_sig,
		clock	 => clock_sig,
		q	 => q_sig
	);
