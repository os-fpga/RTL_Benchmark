lpm_ram_CCode_inst : lpm_ram_CCode PORT MAP (
		data	 => data_sig,
		wren	 => wren_sig,
		wraddress	 => wraddress_sig,
		rdaddress	 => rdaddress_sig,
		clock	 => clock_sig,
		q	 => q_sig
	);
