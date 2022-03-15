lpm_ram_CData_inst : lpm_ram_CData PORT MAP (
		data	 => data_sig,
		wren	 => wren_sig,
		wraddress	 => wraddress_sig,
		rdaddress	 => rdaddress_sig,
		clock	 => clock_sig,
		q	 => q_sig
	);
