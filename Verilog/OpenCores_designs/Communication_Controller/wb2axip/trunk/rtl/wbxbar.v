////////////////////////////////////////////////////////////////////////////////
//
// Filename: 	wbxbar.v
//
// Project:	Pipelined Wishbone to AXI converter
//
// Purpose:	A Configurable wishbone cross-bar interconnect
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2019, Gisselquist Technology, LLC
//
// This program is free software (firmware): you can redistribute it and/or
// modify it under the terms of  the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
// for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program.  (It's in the $(ROOT)/doc directory, run make with no
// target there if the PDF file isn't present.)  If not, see
// <http://www.gnu.org/licenses/> for a copy.
//
// License:	GPL, v3, as defined and found on www.gnu.org,
//		http://www.gnu.org/licenses/gpl.html
//
//
////////////////////////////////////////////////////////////////////////////////
//
//
`default_nettype none
//
module	wbxbar(i_clk, i_reset,
	i_mcyc, i_mstb, i_mwe, i_maddr, i_mdata, i_msel,
		o_mstall, o_mack, o_mdata, o_merr,
	o_scyc, o_sstb, o_swe, o_saddr, o_sdata, o_ssel,
		i_sstall, i_sack, i_sdata, i_serr);
	parameter	NM = 4, NS=8;
	parameter	AW = 20, DW=32;
	parameter	[NS*AW-1:0]	SADDR = {
				3'b111, 17'h0,
				3'b110, 17'h0,
				3'b101, 17'h0,
				3'b100, 17'h0,
				3'b011, 17'h0,
				3'b010, 17'h0,
				4'b0010, 16'h0,
				4'b0000, 16'h0 };
	parameter	[NS*AW-1:0]	SMASK = (NS <= 1) ? 0
		: { {(NS-2){ 3'b111, 17'h0 }}, {(2){ 4'b1111, 16'h0 }} };
	// parameter	[AW-1:0]	SADDR = 0;
	// parameter	[AW-1:0]	SMASK = 0;
	//
	// LGMAXBURST is the log_2 of the length of the longest burst that
	// might be seen.  It's used to set the size of the internal
	// counters that are used to make certain that the cross bar doesn't
	// switch while still waiting on a response.
	parameter	LGMAXBURST=6;
	//
	// OPT_TIMEOUT is used to help recover from a misbehaving slave.  If
	// set, this value will determine the number of clock cycles to wait
	// for a misbehaving slave before returning a bus error.  Alternatively,
	// if set to zero, this functionality will be removed.
	parameter	OPT_TIMEOUT = 0; // 1023;
	//
	// If OPT_TIMEOUT is set, then OPT_STARVATION_TIMEOUT may also be set.
	// The starvation timeout adds to the bus error timeout generation
	// the possibility that a master will wait OPT_TIMEOUT counts without
	// receiving the bus.  This may be the case, for example, if one
	// bus master is consuming a peripheral to such an extent that there's
	// no time/room for another bus master to use it.  In that case, when
	// the timeout runs out, the waiting bus master will be given a bus
	// error.
	parameter [0:0]	OPT_STARVATION_TIMEOUT = 1'b0 && (OPT_TIMEOUT > 0);
	//
	// TIMEOUT_WIDTH is the number of bits in counter used to check on a
	// timeout.
	localparam	TIMEOUT_WIDTH = $clog2(OPT_TIMEOUT);
	//
	// OPT_DBLBUFFER is used to register all of the outputs, and thus
	// avoid adding additional combinational latency through the core
	// that might require a slower clock speed.
	parameter [0:0]	OPT_DBLBUFFER = 1'b1;
	//
	// OPT_LOWPOWER adds logic to try to force unused values to zero,
	// rather than to allow a variety of logic optimizations that could
	// be used to reduce the logic count of the device.  Hence, OPT_LOWPOWER
	// will use more logic, but it won't drive bus wires unless there's a
	// value to drive onto them.
	parameter [0:0]	OPT_LOWPOWER = 1'b1;
	//
	// LGNM is the log (base two) of the number of bus masters connecting
	// to this crossbar
	localparam	LGNM = (NM>1) ? $clog2(NM) : 1;
	//
	// LGNM is the log (base two) of the number of slaves plus one come
	// out of the system.  The extra "plus one" is used for a pseudo slave
	// representing the case where the given address doesn't connect to
	// any of the slaves.  This address will generate a bus error.
	localparam	LGNS = $clog2(NS+1);
	//
	//
	input	wire			i_clk, i_reset;
	//
	// Here are the bus inputs from each of the WB bus masters
	input	wire	[NM-1:0]	i_mcyc, i_mstb, i_mwe;
	input	wire	[NM*AW-1:0]	i_maddr;
	input	wire	[NM*DW-1:0]	i_mdata;
	input	wire	[NM*DW/8-1:0]	i_msel;
	//
	// .... and their return data
	output	reg	[NM-1:0]	o_mstall, o_mack, o_merr;
	output	reg	[NM*DW-1:0]	o_mdata;
	//
	//
	// Here are the output ports, used to control each of the various
	// slave ports that we are connected to
	output	reg	[NS-1:0]	o_scyc, o_sstb, o_swe;
	output	reg	[NS*AW-1:0]	o_saddr;
	output	reg	[NS*DW-1:0]	o_sdata;
	output	reg	[NS*DW/8-1:0]	o_ssel;
	//
	// ... and their return data back to us.
	input	wire	[NS-1:0]	i_sstall, i_sack, i_serr;
	input	wire	[NS*DW-1:0]	i_sdata;
	//
	//

	// At one time I used o_macc and o_sacc to put into the outgoing
	// trace file, just enough logic to tell me if a transaction was
	// taking place on the given clock.
	//
	// assign	o_macc = (i_mstb & ~o_mstall);
	// assign	o_sacc = (o_sstb & ~i_sstall);
	//
	// These definitions work with Verilator, just not with Yosys
	// reg	[NM-1:0][NS:0]		request;
	// reg	[NM-1:0][NS-1:0]	requested;
	// reg	[NM-1:0][NS:0]		grant;
	//
	// These definitions work with both
	reg	[NS:0]			request		[0:NM-1];
	reg	[NS-1:0]		requested	[0:NM-1];
	reg	[NS:0]			grant		[0:NM-1];
	reg	[NM-1:0]		mgrant;
	reg	[NS-1:0]		sgrant;

	wire	[LGMAXBURST-1:0]	w_mpending [0:NM-1];
	reg	[NM-1:0]		mfull;
	reg	[NM-1:0]		mnearfull;
	reg	[NM-1:0]		mempty, timed_out;

	localparam	NMFULL = (NM > 1) ? (1<<LGNM) : 1;
	localparam	NSFULL = (1<<LGNS);
	reg	[NMFULL-1:0]	r_stb;
	reg	[NMFULL-1:0]	r_we;
	reg	[AW-1:0]	r_addr		[0:NMFULL-1];
	reg	[DW-1:0]	r_data		[0:NMFULL-1];
	reg	[DW/8-1:0]	r_sel		[0:NMFULL-1];
	wire	[TIMEOUT_WIDTH-1:0]	w_deadlock_timer [0:NM-1];


	reg	[LGNS-1:0]	mindex		[0:NMFULL-1];
	reg	[LGNM-1:0]	sindex		[0:NSFULL-1];

	reg	[NMFULL-1:0]	m_cyc;
	reg	[NMFULL-1:0]	m_stb;
	reg	[NMFULL-1:0]	m_we;
	reg	[AW-1:0]	m_addr		[0:NMFULL-1];
	reg	[DW-1:0]	m_data		[0:NMFULL-1];
	reg	[DW/8-1:0]	m_sel		[0:NMFULL-1];
	//
	reg	[NSFULL-1:0]	s_stall;
	reg	[DW-1:0]	s_data		[0:NSFULL-1];
	reg	[NSFULL-1:0]	s_ack;
	reg	[NSFULL-1:0]	s_err;

	genvar	N, M;
	integer	iN, iM;
	generate for(N=0; N<NM; N=N+1)
	begin : DECODE_REQUEST
		reg	none_sel;

		always @(*)
		begin
			none_sel = !m_stb[N];
			for(iM=0; iM<NS; iM=iM+1)
			begin

				none_sel = none_sel
					|| (((m_addr[N] ^ SADDR[iM*AW +: AW])
						&SMASK[iM*AW +: AW])==0);
			end


			none_sel = !none_sel;
		end

		always @(*)
		begin
			for(iM=0; iM<NS; iM=iM+1)
				request[N][iM] = m_stb[N]
					&&(((m_addr[N] ^ SADDR[iM*AW +: AW])
						&SMASK[iM*AW +: AW])==0);

			// Is this address non-existant?
			request[N][NS] = m_stb[N] && none_sel;
		end

		always @(*)
			m_cyc[N] = i_mcyc[N];
		always @(*)
		if (mfull[N])
			m_stb[N] = 1'b0;
		else if (mnearfull[N])
			m_stb[N] = i_mstb[N] && !r_stb[N];
		else
			m_stb[N] = i_mstb[N] || (i_mcyc[N] && r_stb[N]);
		always @(*)
			m_we[N]   = r_stb[N] ? r_we[N] : i_mwe[N];
		always @(*)
			m_addr[N] = r_stb[N] ? r_addr[N] : i_maddr[N*AW +: AW];
		always @(*)
			m_data[N] = r_stb[N] ? r_data[N] : i_mdata[N*DW +: DW];
		always @(*)
			m_sel[N]  = r_stb[N] ? r_sel[N]: i_msel[N*DW/8 +: DW/8];

	end for(N=NM; N<NMFULL; N=N+1)
	begin
		// in case NM isn't one less than a power of two, complete
		// the set
		always @(*)
			m_cyc[N] = 0;
		always @(*)
			m_stb[N] = 0;
		always @(*)
			m_we[N]   = 0;
		always @(*)
			m_addr[N] = 0;
		always @(*)
			m_data[N] = 0;
		always @(*)
			m_sel[N]  = 0;

	end endgenerate

	always @(*)
	begin
		for(iM=0; iM<NS; iM=iM+1)
		begin
			requested[0][iM] = 0;
			for(iN=1; iN<NM; iN=iN+1)
			requested[iN][iM]
				= (request[iN-1][iM] || requested[iN-1][iM]);
		end
	end

	generate for(M=0; M<NS; M=M+1)
	begin

		always @(*)
		begin
			sgrant[M] = 0;
			for(iN=0; iN<NM; iN=iN+1)
				if (grant[iN][M])
					sgrant[M] = 1;
		end

		always @(*)
			s_data[M]  = i_sdata[M*DW +: DW];
		always @(*)
			s_stall[M] = o_sstb[M] && i_sstall[M];
		always @(*)
			s_ack[M]   = o_scyc[M] && i_sack[M];
		always @(*)
			s_err[M]   = o_scyc[M] && i_serr[M];
	end for(M=NS; M<NSFULL; M=M+1)
	begin

		always @(*)
			s_data[M]  = 0;
		always @(*)
			s_stall[M] = 1;
		always @(*)
			s_ack[M]   = 0;
		always @(*)
			s_err[M]   = 1;
		// always @(*) sgrant[M]  = 0;

	end endgenerate

	//
	// Arbitrate among masters to determine who gets to access a given
	// channel
	generate for(N=0; N<NM; N=N+1)
	begin : ARBITRATE_REQUESTS

		// This is done using a couple of variables.
		//
		// request[N][M]
		//	This is true if master N is requesting to access slave
		//	M.  It is combinatorial, so it will be true if the
		//	request is being made on the current clock.
		//
		// requested[N][M]
		//	True if some other master, prior to N, has requested
		//	channel M.  This creates a basic priority arbiter,
		//	such that lower numbered masters have access before
		//	a greater numbered master
		//
		// grant[N][M]
		//	True if a grant has been made for master N to access
		//	slave channel M
		//
		// mgrant[N]
		//	True if master N has been granted access to some slave
		//	channel, any channel.
		//
		// mindex[N]
		//	This is the number of the slave channel that master
		//	N has been given access to
		//
		// sgrant[M]
		//	True if there exists some master, N, that has been
		// 	granted access to this slave, hence grant[N][M] must
		//	also be true
		//
		// sindex[M]
		//	This is the index of the master that has access to
		//	slave M, assuming sgrant[M].  Hence, if sgrant[M]
		//	then grant[sindex[M]][M] must be true
		//
		reg	stay_on_channel;

		always @(*)
		begin
			stay_on_channel = 0;
			for(iM=0; iM<NS; iM=iM+1)
			begin
				if (request[N][iM] && grant[N][iM])
					stay_on_channel = 1;
			end
		end

		reg	requested_channel_is_available;

		always @(*)
		begin
			requested_channel_is_available = 0;
			for(iM=0; iM<NS; iM=iM+1)
			begin
				if (request[N][iM] && !sgrant[iM]
						&& !requested[N][iM])
					requested_channel_is_available = 1;
			end
		end

		initial	grant[N] = 0;
		initial	mgrant[N] = 0;
		always @(posedge i_clk)
		if (i_reset || !i_mcyc[N])
		begin
			grant[N] <= 0;
			mgrant[N] <= 0;
		end else if (!mgrant[N] || mempty[N])
		begin
			if (stay_on_channel)
				mgrant[N] <= 1'b1;
			else if (requested_channel_is_available)
				mgrant[N] <= 1'b1;
			else if (i_mstb[N] || r_stb[N])
				mgrant[N] <= 1'b0;

			for(iM=0; iM<NS; iM=iM+1)
			begin

				if (request[N][iM] && grant[N][iM])
					// Maintain any open channels
					grant[N][iM] <= 1;
				else if (request[N][iM] && !sgrant[iM]
						&& !requested[N][iM])
					// Open a new channel if necessary
					grant[N][iM] <= 1;
				else if (i_mstb[N] || r_stb[N])
					grant[N][iM] <= 0;

			end
			if (request[N][NS])
			begin
				grant[N][NS] <= 1'b1;
				mgrant[N] <= 1'b1;
			end else begin
				grant[N][NS] <= 1'b0;
				if (grant[N][NS])
					mgrant[N] <= 1'b1;
			end
		end

		if (NS == 1)
		begin

			always @(*)
				mindex[N] = 0;

		end else begin

			always @(posedge i_clk)
			if (!mgrant[N] || mempty[N])
			begin

				for(iM=0; iM<NS; iM=iM+1)
				begin
					if (request[N][iM] && grant[N][iM])
					begin
						// Maintain any open channels
						mindex[N] <= iM;
					end else if (request[N][iM]
							&& !sgrant[iM]
							&& !requested[N][iM])
					begin
						// Open a new channel
						// if necessary
						mindex[N] <= iM;
					end
				end
			end
		end

	end for (N=NM; N<NMFULL; N=N+1)
	begin

		always @(*)
			mindex[N] = 0;

	end endgenerate

	// Calculate sindex.  sindex[M] (indexed by slave ID)
	// references the master controlling this slave.  This makes for
	// faster/cheaper logic on the return path, since we can now use
	// a fully populated LUT rather than a priority based return scheme
	generate for(M=0; M<NS; M=M+1)
	begin

		if (NM <= 1)
		begin

			// If there will only ever be one master, then we
			// can assume all slave indexes point to that master
			always @(*)
				sindex[M] = 0;

		end else begin : SINDEX_MORE_THAN_ONE_MASTER

			always @(posedge i_clk)
			for (iN=0; iN<NM; iN=iN+1)
			begin
				if (!mgrant[iN] || mempty[iN])
				begin
					if (request[iN][M] && grant[iN][M])
						sindex[M] <= iN;
					else if (request[iN][M] && !sgrant[M]
							&& !requested[iN][M])
						sindex[M] <= iN;
				end
			end
		end

	end for(M=NS; M<NSFULL; M=M+1)
	begin
		// Assign the unused slave indexes to zero
		//
		// Remember, to full out a full 2^something set of slaves,
		// we may have more slave indexes than we actually have slaves

		always @(*)
			sindex[M] = 0;

	end endgenerate


	//
	// Assign outputs to the slaves, part one
	//
	// In this part, we assign the difficult outputs: o_scyc and o_sstb
	generate for(M=0; M<NS; M=M+1)
	begin

		initial	o_scyc[M] = 0;
		initial	o_sstb[M] = 0;
		always @(posedge i_clk)
		begin
			if (sgrant[M])
			begin

				if (!i_mcyc[sindex[M]])
				begin
					o_scyc[M] <= 1'b0;
					o_sstb[M] <= 1'b0;
				end else begin
					o_scyc[M] <= 1'b1;

					if (!s_stall[M])
						o_sstb[M] <= m_stb[sindex[M]]
						  && request[sindex[M]][M]
						  && !mnearfull[sindex[M]];
				end
			end else begin
				o_scyc[M]  <= 1'b0;
				o_sstb[M]  <= 1'b0;
			end

			if (i_reset || s_err[M])
			begin
				o_scyc[M] <= 1'b0;
				o_sstb[M] <= 1'b0;
			end
		end
	end endgenerate

	//
	// Assign outputs to the slaves, part two
	//
	// These are the easy(er) outputs, since there are fewer properties
	// riding on them
	generate if ((NM == 1) && (!OPT_LOWPOWER))
	begin
		//
		// This is the low logic version of our bus data outputs.
		// It only works if we only have one master.
		//
		// The basic idea here is that we share all of our bus outputs
		// between all of the various slaves.  Since we only have one
		// bus master, this works.
		//
		always @(posedge i_clk)
		begin
			o_swe[0]        <= o_swe[0];
			o_saddr[0+: AW] <= o_saddr[0+:AW];
			o_sdata[0+: DW] <= o_sdata[0+:DW];
			o_ssel[0+:DW/8] <=o_ssel[0+:DW/8];

			if (sgrant[mindex[0]] && !s_stall[mindex[0]])
			begin
				o_swe[0]        <= m_we[0];
				o_saddr[0+: AW] <= m_addr[0];
				o_sdata[0+: DW] <= m_data[0];
				o_ssel[0+:DW/8] <= m_sel[0];
			end
		end

		for(M=1; M<NS; M=M+1)
		always @(*)
		begin
			o_swe[M]            = o_swe[0];
			o_saddr[M*AW +: AW] = o_saddr[0 +: AW];
			o_sdata[M*DW +: DW] = o_sdata[0 +: DW];
			o_ssel[M*DW/8+:DW/8]= o_ssel[0 +: DW/8];
		end

	end else for(M=0; M<NS; M=M+1)
	begin
		always @(posedge i_clk)
		begin
			if (OPT_LOWPOWER && !sgrant[M])
			begin
				o_swe[M]              <= 1'b0;
				o_saddr[M*AW   +: AW] <= 0;
				o_sdata[M*DW   +: DW] <= 0;
				o_ssel[M*(DW/8)+:DW/8]<= 0;
			end else if (!s_stall[M]) begin
				o_swe[M]              <= m_we[sindex[M]];
				o_saddr[M*AW   +: AW] <= m_addr[sindex[M]];
				if (OPT_LOWPOWER && !m_we[sindex[M]])
					o_sdata[M*DW   +: DW] <= 0;
				else
					o_sdata[M*DW   +: DW] <= m_data[sindex[M]];
				o_ssel[M*(DW/8)+:DW/8]<= m_sel[sindex[M]];
			end

		end
	end endgenerate

	//
	// Assign return values to the masters
	generate if (OPT_DBLBUFFER)
	begin : DOUBLE_BUFFERRED_STALL

		for(N=0; N<NM; N=N+1)
		begin
			initial	o_mstall[N] = 0;
			initial	o_mack[N]   = 0;
			initial	o_merr[N]   = 0;
			always @(posedge i_clk)
			begin
				iM = mindex[N];
				o_mstall[N] <= o_mstall[N]
						|| (i_mstb[N] && !o_mstall[N]);
				o_mack[N]   <= mgrant[N] && s_ack[mindex[N]];
				o_merr[N]   <= mgrant[N] && s_err[mindex[N]];
				if (OPT_LOWPOWER && !mgrant[N])
					o_mdata[N*DW +: DW] <= 0;
				else
					o_mdata[N*DW +: DW] <= s_data[mindex[N]];

				if (mgrant[N])
				begin
					if ((i_mstb[N]||o_mstall[N])
								&& mnearfull[N])
						o_mstall[N] <= 1'b1;
					else if ((i_mstb[N] || o_mstall[N])
							&& !request[N][iM])
						// Requesting another channel
						o_mstall[N] <= 1'b1;
					else if (!s_stall[iM])
						// Downstream channel is clear
						o_mstall[N] <= 1'b0;
					else // if (o_sstb[mindex[N]]
						//   && i_sstall[mindex[N]])
						// Downstream channel is stalled
						o_mstall[N] <= i_mstb[N];
				end

				if (mnearfull[N] && i_mstb[N])
					o_mstall[N] <= 1'b1;

				if ((o_mstall[N] && grant[N][NS])
					||(timed_out[N] && !o_mack[N]))
				begin
					o_mstall[N] <= 1'b0;
					o_mack[N]   <= 1'b0;
					o_merr[N]   <= 1'b1;
				end

				if (i_reset || !i_mcyc[N])
				begin
					o_mstall[N] <= 1'b0;
					o_mack[N]   <= 1'b0;
					o_merr[N]   <= 1'b0;
				end
			end

			always @(*)
				r_stb[N] = o_mstall[N];

			always @(posedge i_clk)
			if (OPT_LOWPOWER && !i_mcyc[N])
			begin
				r_we[N]   <= 0;
				r_addr[N] <= 0;
				r_data[N] <= 0;
				r_sel[N]  <= 0;
			end else if ((!OPT_LOWPOWER || i_mstb[N]) && !o_mstall[N])
			begin
				r_we[N]   <= i_mwe[N];
				r_addr[N] <= i_maddr[N*AW +: AW];
				r_data[N] <= i_mdata[N*DW +: DW];
				r_sel[N]  <= i_msel[N*(DW/8) +: DW/8];
			end
		end

		for(N=NM; N<NMFULL; N=N+1)
		begin

			always @(*)
				r_stb[N] <= 1'b0;

			always @(*)
			begin
				r_we[N]   = 0;
				r_addr[N] = 0;
				r_data[N] = 0;
				r_sel[N]  = 0;
			end
		end


	end else if (NS == 1) // && !OPT_DBLBUFFER
	begin : SINGLE_SLAVE

		for(N=0; N<NM; N=N+1)
		begin
			always @(*)
			begin
				o_mstall[N] = !mgrant[N] || s_stall[0]
					|| (i_mstb[N] && !request[N][0]);
				o_mack[N]   =  mgrant[N] && i_sack[0];
				o_merr[N]   =  mgrant[N] && i_serr[0];
				o_mdata[N*DW +: DW]  = (!mgrant[N] && OPT_LOWPOWER)
					? 0 : i_sdata;

				if (mnearfull[N])
					o_mstall[N] = 1'b1;

				if (timed_out[N]&&!o_mack[0])
				begin
					o_mstall[N] = 1'b0;
					o_mack[N]   = 1'b0;
					o_merr[N]   = 1'b1;
				end

				if (grant[N][NS] && m_stb[N])
				begin
					o_mstall[N] = 1'b0;
					o_mack[N]   = 1'b0;
					o_merr[N]   = 1'b1;
				end

				if (!m_cyc[N])
				begin
					o_mack[N] = 1'b0;
					o_merr[N] = 1'b0;
				end
			end
		end

		for(N=0; N<NMFULL; N=N+1)
		begin

			always @(*)
				r_stb[N] <= 1'b0;

			always @(*)
			begin
				r_we[N]   = 0;
				r_addr[N] = 0;
				r_data[N] = 0;
				r_sel[N]  = 0;
			end
		end

	end else begin : SINGLE_BUFFER_STALL
		for(N=0; N<NM; N=N+1)
		begin
			// initial	o_mstall[N] = 0;
			// initial	o_mack[N]   = 0;
			always @(*)
			begin
				o_mstall[N] = 1;
				o_mack[N]   = mgrant[N] && s_ack[mindex[N]];
				o_merr[N]   = mgrant[N] && s_err[mindex[N]];
				if (OPT_LOWPOWER && !mgrant[N])
					o_mdata[N*DW +: DW] = 0;
				else
					o_mdata[N*DW +: DW] = s_data[mindex[N]];

				if (mgrant[N])
				begin
					iM = mindex[N];
					o_mstall[N]       = (s_stall[mindex[N]])
					    || (i_mstb[N] && !request[N][iM]);
				end

				if (mnearfull[N])
					o_mstall[N] = 1'b1;

				if (grant[N][NS] ||(timed_out[N]&&!o_mack[0]))
				begin
					o_mstall[N] = 1'b0;
					o_mack[N]   = 1'b0;
					o_merr[N]   = 1'b1;
				end

				if (!m_cyc[N])
				begin
					o_mack[N] = 1'b0;
					o_merr[N] = 1'b0;
				end
			end
		end

		for(N=0; N<NMFULL; N=N+1)
		begin

			always @(*)
				r_stb[N] <= 1'b0;

			always @(*)
			begin
				r_we[N]   = 0;
				r_addr[N] = 0;
				r_data[N] = 0;
				r_sel[N]  = 0;
			end
		end

	end endgenerate

	//
	// Count the pending transactions per master
	generate for(N=0; N<NM; N=N+1)
	begin
		reg	[LGMAXBURST-1:0]	lclpending;
		initial	lclpending  = 0;
		initial	mempty[N]    = 1;
		initial	mnearfull[N] = 0;
		initial	mfull[N]     = 0;
		always @(posedge i_clk)
		if (i_reset || !i_mcyc[N] || o_merr[N])
		begin
			lclpending <= 0;
			mfull[N]    <= 0;
			mempty[N]   <= 1'b1;
			mnearfull[N]<= 0;
		end else case({ (i_mstb[N] && !o_mstall[N]), o_mack[N] })
		2'b01: begin
			lclpending <= lclpending - 1'b1;
			mnearfull[N]<= mfull[N];
			mfull[N]    <= 1'b0;
			mempty[N]   <= (lclpending == 1);
			end
		2'b10: begin
			lclpending <= lclpending + 1'b1;
			mnearfull[N]<= (&lclpending[LGMAXBURST-1:2])&&(lclpending[1:0] != 0);
			mfull[N]    <= mnearfull[N];
			mempty[N]   <= 1'b0;
			end
		default: begin end
		endcase

		assign w_mpending[N] = lclpending;

	end endgenerate


	generate if (OPT_TIMEOUT > 0)
	begin : CHECK_TIMEOUT

		for(N=0; N<NM; N=N+1)
		begin

			reg	[TIMEOUT_WIDTH-1:0]	deadlock_timer;

			initial	deadlock_timer = OPT_TIMEOUT;
			initial	timed_out[N] = 1'b0;
			always @(posedge i_clk)
			if (i_reset || !i_mcyc[N]
					||((w_mpending[N] == 0)
						&&(!i_mstb[N] && !r_stb[N]))
					||((i_mstb[N] || r_stb[N])
						&&(!o_mstall[N]))
					||(o_mack[N] || o_merr[N])
					||(!OPT_STARVATION_TIMEOUT&&!mgrant[N]))
			begin
				deadlock_timer <= OPT_TIMEOUT;
				timed_out[N] <= 0;
			end else if (deadlock_timer > 0)
			begin
				deadlock_timer <= deadlock_timer - 1;
				timed_out[N] <= (deadlock_timer <= 1);
			end

			assign	w_deadlock_timer[N] = deadlock_timer;
		end

	end else begin

		always @(*)
			timed_out = 0;

	end endgenerate

`ifdef	FORMAL
	localparam	F_MAX_DELAY = 4;
	localparam	F_LGDEPTH = LGMAXBURST;
	//
	reg			f_past_valid;
	//
	// Our bus checker keeps track of the number of requests,
	// acknowledgments, and the number of outstanding transactions on
	// every channel, both the masters driving us
	wire	[F_LGDEPTH-1:0]	f_mreqs		[0:NM-1];
	wire	[F_LGDEPTH-1:0]	f_macks		[0:NM-1];
	wire	[F_LGDEPTH-1:0]	f_moutstanding	[0:NM-1];
	//
	// as well as the slaves that we drive ourselves
	wire	[F_LGDEPTH-1:0]	f_sreqs		[0:NS-1];
	wire	[F_LGDEPTH-1:0]	f_sacks		[0:NS-1];
	wire	[F_LGDEPTH-1:0]	f_soutstanding	[0:NS-1];


	initial	assert(!OPT_STARVATION_TIMEOUT || OPT_TIMEOUT > 0);

	reg	f_past_valid;
	initial	f_past_valid = 0;
	always @(posedge i_clk)
		f_past_valid = 1'b1;

	always @(*)
	if (!f_past_valid)
		assume(i_reset);

	generate for(N=0; N<NM; N=N+1)
	begin
		always @(*)
		if (f_past_valid)
		for(iN=N+1; iN<NM; iN=iN+1)
			// Can't grant the same channel to two separate
			// masters.  This applies to all but the error or
			// no-slave-selected channel
			assert((grant[N][NS-1:0] & grant[iN][NS-1:0])==0);

		for(M=1; M<=NS; M=M+1)
		begin
			// Can't grant two channels to the same master
			always @(*)
			if (f_past_valid && grant[N][M])
				assert(grant[N][M-1:0] == 0);
		end


		always @(*)
		if (&w_mpending[N])
			assert(o_merr[N] || o_mstall[N]);

		reg	checkgrant;
		always @(*)
		if (f_past_valid)
		begin
			checkgrant = 0;
			for(iM=0; iM<NS; iM=iM+1)
				if (grant[N][iM])
					checkgrant = 1;
			if (grant[N][NS])
				checkgrant = 1;

			assert(checkgrant == mgrant[N]);
		end

	end endgenerate

	// Double check the grant mechanism and its dependent variables
	generate for(N=0; N<NM; N=N+1)
	begin

		for(M=0; M<NS; M=M+1)
		begin
			always @(*)
			if ((f_past_valid)&&grant[N][M])
			begin
				assert(mgrant[N]);
				assert(mindex[N] == M);
				assert(sindex[M] == N);
			end
		end
	end endgenerate

	// Double check the timeout flags for consistency
	generate for(N=0; N<NM; N=N+1)
	begin
		always @(*)
		if (f_past_valid)
		begin
			assert(mempty[N] == (w_mpending[N] == 0));
			assert(mnearfull[N]==(&w_mpending[N][LGMAXBURST-1:1]));
			assert(mfull[N] == (&w_mpending[N]));
		end
	end endgenerate

`ifdef	VERIFIC
	//
	// The Verific parser is currently broken, and doesn't allow
	// initial assumes or asserts.  The following lines get us around that
	//
	always @(*)
	if (!f_past_valid)
		assume(sgrant == 0);

	generate for(M=0; M<NS; M=M+1)
	begin
		always @(*)
		if (!f_past_valid)
		begin
			assume(o_scyc[M] == 0);
			assume(o_sstb[M] == 0);
		end
	end endgenerate

	generate for(N=0; N<NM; N=N+1)
	begin
		always @(*)
		if (!f_past_valid)
		begin
			assume(grant[N] == 0);
			assume(mgrant[N] == 0);
		end
	end
`endif

	////////////////////////////////////////////////////////////////////////
	//
	//	BUS CHECK
	//
	// Verify that every channel, whether master or slave, follows the rules
	// of the WB road.
	//
	////////////////////////////////////////////////////////////////////////
	generate for(N=0; N<NM; N=N+1)
	begin : WB_SLAVE_CHECK

		fwb_slave #(
			.AW(AW), .DW(DW),
			.F_LGDEPTH(LGMAXBURST),
			.F_MAX_ACK_DELAY(0),
			.F_MAX_STALL(0)
			) slvi(i_clk, i_reset,
				i_mcyc[N], i_mstb[N], i_mwe[N],
				i_maddr[N*AW +: AW], i_mdata[N*DW +: DW],					i_msel[N*(DW/8) +: (DW/8)],
			o_mack[N], o_mstall[N], o_mdata[N*DW +: DW], o_merr[N],
			f_mreqs[N], f_macks[N], f_moutstanding[N]);

		always @(*)
		if ((f_past_valid)&&(grant[N][NS]))
			assert(f_moutstanding[N] <= 1);

		always @(*)
		if ((f_past_valid)&&(grant[N][NS] && i_mcyc[N]))
			assert(o_mstall[N] || o_merr[N]);

	end endgenerate

	generate for(M=0; M<NS; M=M+1)
	begin : WB_MASTER_CHECK
		fwb_master #(
			.AW(AW), .DW(DW),
			.F_LGDEPTH(LGMAXBURST),
			.F_MAX_ACK_DELAY(F_MAX_DELAY),
			.F_MAX_STALL(2)
			) mstri(i_clk, i_reset,
				o_scyc[M], o_sstb[M], o_swe[M],
				o_saddr[M*AW +: AW], o_sdata[M*DW +: DW],
				o_ssel[M*(DW/8) +: (DW/8)],
			i_sack[M], i_sstall[M], s_data[M], i_serr[M],
			f_sreqs[M], f_sacks[M], f_soutstanding[M]);
	end endgenerate

	////////////////////////////////////////////////////////////////////////
	//
	////////////////////////////////////////////////////////////////////////
	generate for(N=0; N<NM; N=N+1)
	begin : CHECK_OUTSTANDING

		always @(posedge i_clk)
		if (i_mcyc[N])
			assert(f_moutstanding[N] == w_mpending[N]);

		reg	[LGMAXBURST:0]	n_outstanding;
		always @(*)
		if (i_mcyc[N])
			assert(f_moutstanding[N] >=
				(o_mstall[N] && OPT_DBLBUFFER) ? 1:0
				+ (o_mack[N] && OPT_DBLBUFFER) ? 1:0);

		always @(*)
			n_outstanding = f_moutstanding[N]
				- ((o_mstall[N] && OPT_DBLBUFFER) ? 1:0)
				- ((o_mack[N] && OPT_DBLBUFFER) ? 1:0);
		always @(posedge i_clk)
		if (i_mcyc[N] && !mgrant[N] && !o_merr[N])
			assert(f_moutstanding[N]
					== (o_mstall[N]&&OPT_DBLBUFFER ? 1:0));
		else if (i_mcyc[N] && mgrant[N])
		for(iM=0; iM<NS; iM=iM+1)
		if (grant[N][iM] && o_scyc[iM] && !i_serr[iM] && !o_merr[N])
			assert(n_outstanding
				== {1'b0,f_soutstanding[iM]}+(o_sstb[iM] ? 1:0));

		always @(*)
		if (i_mcyc[N] && r_stb[N] && OPT_DBLBUFFER)
			assume(i_mwe[N] == r_we[N]);

		always @(*)
		if (!OPT_DBLBUFFER && !mnearfull[N])
			assert(i_mstb[N] == m_stb[N]);

		always @(*)
		if (!OPT_DBLBUFFER)
			assert(i_mwe[N] == m_we[N]);

		always @(*)
		for(iM=0; iM<NS; iM=iM+1)
		if (grant[N][iM] && i_mcyc[N])
		begin
			if (f_soutstanding[iM] > 0)
				assert(i_mwe[N] == o_swe[iM]);
			if (o_sstb[iM])
				assert(i_mwe[N] == o_swe[iM]);
			if (o_mack[N])
				assert(i_mwe[N] == o_swe[iM]);
			if (o_scyc[iM] && i_sack[iM])
				assert(i_mwe[N] == o_swe[iM]);
			if (o_merr[N] && !timed_out[N])
				assert(i_mwe[N] == o_swe[iM]);
			if (o_scyc[iM] && i_serr[iM])
				assert(i_mwe[N] == o_swe[iM]);
		end

	end endgenerate

	generate for(M=0; M<NS; M=M+1)
	begin
		always @(posedge i_clk)
		if (!$past(sgrant[M]))
			assert(!o_scyc[M]);
	end endgenerate

	////////////////////////////////////////////////////////////////////////
	//
	//	CONTRACT SECTION
	//
	// Here's the contract, in two parts:
	//
	//	1. Should ever a master (any master) wish to read from a slave
	//		(any slave), he should be able to read a known value
	//		from that slave (any value) from any arbitrary address
	//		he might wish to read from (any address)
	//
	//	2. Should ever a master (any master) wish to write to a slave
	//		(any slave), he should be able to write the exact
	//		value he wants (any value) to the exact address he wants
	//		(any address)
	//
	//	special_master	is an arbitrary constant chosen by the solver,
	//		which can reference *any* possible master
	//	special_address	is an arbitrary constant chosen by the solver,
	//		which can reference *any* possible address the master
	//		might wish to access
	//	special_value	is an arbitrary value (at least during
	//		induction) representing the current value within the
	//		slave at the given address
	//
	//
	////////////////////////////////////////////////////////////////////////
	//
	// Now let's pay attention to a special bus master and a special
	// address referencing a special bus slave.  We'd like to assert
	// that we can access the values of every slave from every master.
	(* anyconst *) reg	[(NM<=1)?0:(LGNM-1):0]	special_master;
			reg	[(NS<=1)?0:(LGNS-1):0]	special_slave;
	(* anyconst *) reg	[AW-1:0]	special_address;
			reg	[DW-1:0]	special_value;

	always @(*)
	if (NM <= 1)
		assume(special_master == 0);
	always @(*)
	if (NS <= 1)
		assume(special_slave == 0);

	//
	// Decode the special address to discover the slave associated with it
	always @(*)
	begin
		special_slave = NS;
		for(iM=0; iM<NS; iM = iM+1)
		begin
			if (((special_address ^ SADDR[iM*AW +: AW])
					&SMASK[iM*AW +: AW]) == 0)
				special_slave = iM;
		end
	end

	generate if (NS > 1)
	begin : DOUBLE_ADDRESS_CHECK
		//
		// Check that no slave address has been assigned twice.
		// This check only needs to be done once at the beginning
		// of the run, during the BMC section.
		reg	address_found;

		always @(*)
		if (!f_past_valid)
		begin
			address_found = 0;
			for(iM=0; iM<NS; iM = iM+1)
			begin
				if (((special_address ^ SADDR[iM*AW +: AW])
						&SMASK[iM*AW +: AW]) == 0)
				begin
					assert(address_found == 0);
					address_found = 1;
				end
			end
		end

	end endgenerate
	//
	// Let's assume this slave will acknowledge any request on the next
	// bus cycle after the stall goes low.  Further, lets assume that
	// it never creates an error, and that it always responds to our special
	// address with the special data value given above.  To do this, we'll
	// also need to make certain that the special value will change
	// following any write.
	//
	// These are the "assumptions" associated with our fictitious slave.
	initial	assume(special_value == 0);
	always @(posedge i_clk)
	if (special_slave < NS)
	begin
		if ($past(o_sstb[special_slave] && !i_sstall[special_slave]))
		begin
			assume(i_sack[special_slave]);

			if ($past(!o_swe[special_slave])
					&&($past(o_saddr[special_slave*AW +: AW]) == special_address))
				assume(i_sdata[special_slave*DW+: DW]
						== special_value);
		end else
			assume(!i_sack[special_slave]);
		assume(!i_serr[special_slave]);

		if (o_scyc[special_slave])
			assert(f_soutstanding[special_slave]
				== i_sack[special_slave]);

		if (o_sstb[special_slave] && !i_sstall[special_slave]
			&& o_swe[special_slave])
		begin
			for(iM=0; iM < DW/8; iM=iM+1)
			if (o_ssel[special_slave * DW/8 + iM])
				special_value[iM*8 +: 8] <= o_sdata[special_slave * DW + iM*8 +: 8];
		end
	end

	//
	// Now its time to make some assertions.  Specifically, we want to
	// assert that any time we read from this special slave, the special
	// value is returned.
	reg	[2:0]	read_seq;
	initial	read_seq = 0;
	always @(posedge i_clk)
	if ((special_master < NM)&&(special_slave < NS)
			&&(i_mcyc[special_master])
			&&(!timed_out[special_master]))
	begin
		read_seq <= 0;
		if ((grant[special_master][special_slave])
			&&(m_stb[special_master])
			&&(m_addr[special_master] == special_address)
			&&(!m_we[special_master])
			)
		begin
			read_seq[0] <= 1;
		end

		if (|read_seq)
		begin
			assert(grant[special_master][special_slave]);
			assert(mgrant[special_master]);
			assert(sgrant[special_slave]);
			assert(mindex[special_master] == special_slave);
			assert(sindex[special_slave] == special_master);
			assert(!o_merr[special_master]);
		end

		if (read_seq[0] && !$past(s_stall[special_slave]))
		begin
			assert(o_scyc[special_slave]);
			assert(o_sstb[special_slave]);
			assert(!o_swe[special_slave]);
			assert(o_saddr[special_slave*AW +: AW] == special_address);

			read_seq[1] <= 1;

		end else if (read_seq[0] && $past(s_stall[special_slave]))
		begin
			assert($stable(m_stb[special_master]));
			assert(!m_we[special_master]);
			assert(m_addr[special_master] == special_address);

			read_seq[0] <= 1;
		end

		if (read_seq[1] && $past(s_stall[special_slave]))
		begin
			assert(o_scyc[special_slave]);
			assert(o_sstb[special_slave]);
			assert(!o_swe[special_slave]);
			assert(o_saddr[special_slave*AW +: AW] == special_address);
			read_seq[1] <= 1;
		end else if (read_seq[1] && !$past(s_stall[special_slave]))
		begin
			assert(i_sack[special_slave]);
			assert(i_sdata[special_slave*DW +: DW] == $past(special_value));
			if (OPT_DBLBUFFER)
				read_seq[2] <= 1;
		end

		if (read_seq[2] || ((!OPT_DBLBUFFER)&&read_seq[1]
					&& !$past(s_stall[special_slave])))
		begin
			assert(o_mack[special_master]);
			assert(o_mdata[special_master * DW +: DW]
				== $past(special_value,2));
		end
	end else
		read_seq <= 0;

	//
	// Let's try a write assertion now.  Specifically, on any request to
	// write to our special address, we want to assert that the special
	// value at that address can be written.
	reg	[2:0]	write_seq;
	initial	write_seq = 0;
	always @(posedge i_clk)
	if ((special_master < NM)&&(special_slave < NS)
			&&(i_mcyc[special_master])
			&&(!timed_out[special_master]))
	begin
		write_seq <= 0;
		if ((grant[special_master][special_slave])
			&&(m_stb[special_master])
			&&(m_addr[special_master] == special_address)
			&&(m_we[special_master]))
		begin
			// Our write sequence begins when our special master
			// has access to the bus, *and* he is trying to write
			// to our special address.
			write_seq[0] <= 1;
		end

		if (|write_seq)
		begin
			assert(grant[special_master][special_slave]);
			assert(mgrant[special_master]);
			assert(sgrant[special_slave]);
			assert(mindex[special_master] == special_slave);
			assert(sindex[special_slave] == special_master);
			assert(!o_merr[special_master]);
		end

		if (write_seq[0] && !$past(s_stall[special_slave]))
		begin
			assert(o_scyc[special_slave]);
			assert(o_sstb[special_slave]);
			assert(o_swe[special_slave]);
			assert(o_saddr[special_slave*AW +: AW] == special_address);
			assert(o_sdata[special_slave*DW +: DW]
				== $past(m_data[special_master]));
			assert(o_ssel[special_slave*DW/8 +: DW/8]
				== $past(m_sel[special_master]));

			write_seq[1] <= 1;

		end else if (write_seq[0] && $past(s_stall[special_slave]))
		begin
			assert($stable(m_stb[special_master]));
			assert(m_we[special_master]);
			assert(m_addr[special_master] == special_address);
			assert($stable(m_data[special_master]));
			assert($stable(m_sel[special_master]));

			write_seq[0] <= 1;
		end

		if (write_seq[1] && $past(s_stall[special_slave]))
		begin
			assert(o_scyc[special_slave]);
			assert(o_sstb[special_slave]);
			assert(o_swe[special_slave]);
			assert(o_saddr[special_slave*AW +: AW] == special_address);
			assert($stable(o_sdata[special_slave*DW +: DW]));
			assert($stable(o_ssel[special_slave*DW/8 +: DW/8]));
			write_seq[1] <= 1;
		end else if (write_seq[1] && !$past(s_stall[special_slave]))
		begin
			for(iM=0; iM<DW/8; iM=iM+1)
			begin
				if ($past(o_ssel[special_slave * DW/8 + iM]))
					assert(special_value[iM*8 +: 8]
						== $past(o_sdata[special_slave*DW+iM*8 +: 8]));
			end

			assert(i_sack[special_slave]);
			if (OPT_DBLBUFFER)
				write_seq[2] <= 1;
		end

		if (write_seq[2] || ((!OPT_DBLBUFFER)&&write_seq[1]
					&& !$past(s_stall[special_slave])))
			assert(o_mack[special_master]);
	end else
		write_seq <= 0;

`endif
endmodule
