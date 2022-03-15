lpm_fifo_dc0_inst : lpm_fifo_dc0 PORT MAP (
		data	 => data_sig,
		wrreq	 => wrreq_sig,
		rdreq	 => rdreq_sig,
		rdclk	 => rdclk_sig,
		wrclk	 => wrclk_sig,
		q	 => q_sig
	);
