library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--	clk_cycle_duration:
--		20	-	2.5ns (400MHz)
--		10	-	5ns	(200MHz)
--		 5	-	10ns	(100MHz)
--		 1 -	20ns	(50MHz)
	

entity ft245_avalon is
	generic(clk_cycle_duration : integer := 20);
	port
	(
		clk				: in	std_logic;
		pwrite			: in	std_logic;
		pread				: in	std_logic;
		readdata			: out	std_logic_vector(31 downto 0);
		writedata		: in	std_logic_vector(31 downto 0);
		resetn			: in	std_logic;
		address			: in	std_logic_vector(3 downto 0);
		
		-- FT245 interface
		ft_rxf			: in	std_logic;
		ft_txe			: in	std_logic;
		ft_rd				: out	std_logic;
		ft_wr				: out	std_logic;
		ft_data			: inout std_logic_vector(7 downto 0);
		ft_reset			: out	std_logic
	);
end ft245_avalon;

architecture action of ft245_avalon is
	component ft245_rcv
		generic(clock_cycle : integer);
		port
		(
			clk, n_rxf, rd : in	std_logic;
			data_in : in std_logic_vector(7 downto 0);
			n_rd, ready : out std_logic;
			data_out : out std_logic_vector(7 downto 0)
		);
	end component;
	signal rcv_data_in	:	std_logic_vector(7 downto 0);
	signal rcv_rd			:	std_logic;
	signal rcv_ready		:	std_logic;
	signal rcv_data_out	:	std_logic_vector(7 downto 0);
	component ft245_snd
		generic(clock_cycle : integer);
		port
		(
			clk, n_txe, wr : in std_logic;
			data_in : in std_logic_vector(7 downto 0);
			n_wr, ready : out std_logic;
			data_out : out std_logic_vector(7 downto 0)
		);
	end component;
	signal snd_data_out	:	std_logic_vector(7 downto 0);
	signal snd_wr			:	std_logic;
	signal snd_ready		:	std_logic;
	signal snd_data_in	:	std_logic_vector(7 downto 0);
	signal prev_pread		:	std_logic;
	signal prev_pwrite	:	std_logic;
	signal prev_address	:	std_logic_vector(3 downto 0);
begin
	RCV:ft245_rcv
	generic map(clock_cycle => clk_cycle_duration)
	port map
	(
		clk => clk,
		n_rxf => ft_rxf,
		rd => rcv_rd,
		data_in => rcv_data_in,
		n_rd => ft_rd,
		ready => rcv_ready,
		data_out => rcv_data_out
	);
	
	SND:ft245_snd
	generic map(clock_cycle => clk_cycle_duration)
	port map
	(
		clk => clk,
		n_txe => ft_txe,
		wr => snd_wr,
		data_in => snd_data_in,
		n_wr => ft_wr,
		ready => snd_ready,
		data_out => snd_data_out
	);

	ft_reset						<= resetn;
	
--	readdata(7 downto 0)		<=	rcv_data_out;
--	readdata(8)					<= rcv_ready;
--	readdata(9)					<= snd_ready;

	-- Changed the addressing within the component
	readdata(7 downto 0)		<= rcv_data_out when address = "0000" else
										"000000"&snd_ready&rcv_ready when address = "0001" else
										x"ff";
	readdata(31 downto 8)	<= x"000000";
	
	rcv_rd						<= '1' when (prev_pread = '0' and pread = '1' and rcv_ready = '1' and prev_address = "0000") else
										'0';
	
	snd_wr						<= '1' when (prev_pwrite = '0' and pwrite = '1' and snd_ready = '1') else
										'0';
										
	snd_data_in					<= writedata(7 downto 0);
	
	ft_data						<= snd_data_out when snd_ready = '0' else
									"ZZZZZZZZ";
	rcv_data_in					<= ft_data;
	
	TRACK_ADDRESS:process(clk, address)
	begin
		if(rising_edge(clk))then
			prev_address 		<= address;
		end if;
	end process;
	
	TOGGLE_RD:process(clk, pread)
	begin
		if(rising_edge(clk))then
			prev_pread			<= pread;
		end if;
	end process;
	
	TOGGLE_WR:process(clk, pwrite)
	begin
		if(rising_edge(clk))then
			prev_pwrite			<= pwrite;
		end if;
	end process;
	
	
end action;