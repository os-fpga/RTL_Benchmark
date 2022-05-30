library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ft245_snd is
	generic(clock_cycle : integer);
	port
	(
		clk					: in	std_logic;
		data_in				: in	std_logic_vector(7 downto 0);
		n_wr					: out	std_logic := '0';
		n_txe					: in	std_logic;
		
		-- system interface
		ready					: out	std_logic := '0';						-- goes high when there's a byte available for reading
		wr						: in	std_logic;								-- invalidates current byte
		data_out				: out	std_logic_vector(7 downto 0)
	);
end ft245_snd;


architecture action of ft245_snd is
	constant	t7	:	integer	:=	integer(100.0 / (50.0 / real(clock_cycle)));
	constant	t8	:	integer	:=	integer(50.0 / (50.0 / real(clock_cycle)));
	constant	t9	:	integer	:=	integer(20.0 / (50.0 / real(clock_cycle)));
	constant	t11:	integer	:=	integer(25.0 / (50.0 / real(clock_cycle)));
	constant	t12:	integer	:=	integer(80.0 / (50.0 / real(clock_cycle)));
	
	type state_t is
	(
		S_IDLE,
		S_WR_HIGH,
		S_WR_LOW,
		S_DELAY,
		S_END
	);
	signal state			:	state_t	:=	S_IDLE;
	signal n_state			:	state_t	:= S_IDLE;
	signal delay			:	integer	:=	0;
begin

	ready	<=	'1'	when n_txe = '0' and state = S_IDLE else '0';
--	n_wr	<= '1' 	when (state = S_WR_HIGH or n_state = S_WR_HIGH) else '0';
	
	process(clk, n_txe, wr)
	begin
		if(rising_edge(clk))then
			case state is
				when S_IDLE =>
					if(wr = '1' and n_txe = '0')then
						n_wr				<= '1';
						delay				<= t7;
						data_out			<= data_in;
						n_state			<= S_WR_HIGH;
						state				<= S_DELAY;
					end if;
				
				when S_WR_HIGH =>
					delay					<= t8;
					n_state				<= S_WR_LOW;
					state					<= S_DELAY;
					n_wr					<= '0';
				
				when S_WR_LOW =>
					delay					<= t12 - t8;
					n_state				<= S_END;
					state					<= S_DELAY;
					
				when S_DELAY =>
					if(delay > 0)then
						delay				<= delay - 1;
					else
						state				<= n_state;
					end if;
				
				when S_END =>
					state					<= S_IDLE;
				
				when others =>
					state 				<= S_IDLE;
			end case;
		end if;
	end process;
end action;