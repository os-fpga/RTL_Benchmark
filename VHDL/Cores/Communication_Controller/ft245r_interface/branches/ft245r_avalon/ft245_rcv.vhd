library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ft245_rcv is
	generic(clock_cycle : integer);
	port
	(
		clk					: in	std_logic;
		data_in				: in	std_logic_vector(7 downto 0);
		n_rd					: out	std_logic := '1';
		n_rxf					: in	std_logic;
		
		-- system interface
		ready					: out	std_logic := '0';						-- goes high when there's a byte available for reading
		rd						: in	std_logic;								-- invalidates current byte
		data_out				: out	std_logic_vector(7 downto 0)
	);
end ft245_rcv;


architecture action of ft245_rcv is
	constant	t1	:	integer	:=	integer(100.0 / (50.0 / real(clock_cycle)));
	constant t3	:	integer	:=	integer(40.0 / (50.0 / real(clock_cycle)));
	constant	t5	:	integer	:=	integer(25.0 / (50.0 / real(clock_cycle)));
	constant	t6	:	integer	:=	integer(80.0 / (50.0 / real(clock_cycle)));
	constant	t2	:	integer	:=	integer((50.0 + 80.0) / (50.0 / real(clock_cycle)));
	
	type state_t is
	(
		S_IDLE,
		S_RD_LOW,
		S_RD_HIGH,
		S_DELAY,
		S_END
	);
	signal state			:	state_t	:=	S_IDLE;
	signal n_state			:	state_t	:= S_IDLE;
	signal delay			:	integer	:=	0;
	signal can_read		:	std_logic:= '1';
begin

	ready <= '1' when state = S_END else '0';

	process(clk, n_rxf, rd)
	begin
		if(rd = '1')then
			state 							<= S_IDLE;
		elsif(rising_edge(clk))then
			case state is
				when S_IDLE =>
					if(n_rxf = '0')then
						n_rd					<= '0';
						n_state				<= S_RD_LOW;
						state					<= S_DELAY;
						delay					<= t3;
					end if;
						
				when S_RD_LOW =>
--					data_out					<= data_in;
					n_state					<= S_RD_HIGH;
					state						<= S_DELAY;
					delay 					<= t1 - t3;
					
				when S_RD_HIGH =>
					data_out					<= data_in;
					n_rd						<= '1';
					n_state					<= S_END;
					state						<= S_DELAY;
					delay						<=	t6;
					
				when S_END =>
					if(rd = '1')then 
						state 				<= S_IDLE;
					else
						state						<= S_END;
					end if;
				
				when S_DELAY =>
					if(delay > 0)then
						delay 				<= delay - 1;
					else
						state					<= n_state;
					end if;
				
				when others =>
					state 					<= S_IDLE;
					
			end case;
		end if;
	end process;
end action;