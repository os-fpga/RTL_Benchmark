--
-- corproc.vhd
--
-- XY to RA coordinate processor 
--
-- uses: pre.vhd, cordic.vhd, post.vhd
--
--
--
-- system delay: 21 (data out delay: 20)
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity corproc is
	port(
		clk	: in std_logic;
		ena	: in std_logic;
		Xin	: in signed(15 downto 0);
		Yin 	: in signed(15 downto 0);
		
		Rout	: out std_logic_vector(19 downto 0);
		Aout	: out std_logic_vector(15 downto 0));
end entity corproc;

architecture dataflow of corproc is
	constant PipeLength : natural := 15;

	component pre is
	port(
		clk	: in std_logic;
		ena	: in std_logic;
		Xi	: in signed(15 downto 0);
		Yi	: in signed(15 downto 0);

		Xo	: out std_logic_vector(15 downto 0);
		Yo	: out std_logic_vector(15 downto 0);
		Q	: out std_logic_vector(2 downto 0));
	end component pre;

	component cordic is
	generic(
		PIPELINE		: integer;
		WIDTH			: integer;
		AWIDTH			: integer;
		EXTEND_PRECISION	: integer);
	port(
		clk	: in std_logic;
		ena	: in std_logic;
		Xi	: in std_logic_vector(WIDTH-1 downto 0);
		Yi	: in std_logic_vector(WIDTH-1 downto 0);
		
		R	: out std_logic_vector(WIDTH + EXTEND_PRECISION -1 downto 0);
		A	: out std_logic_vector(AWIDTH -1 downto 0));
	end component cordic;

	component post is
	port(
		clk	: in std_logic;
		ena	: in std_logic;

		Ai	: in std_logic_vector(15 downto 0);
		Ri	: in std_logic_vector(19 downto 0);
		Q	: in std_logic_vector(2 downto 0);

		Ao	: out std_logic_vector(15 downto 0);
		Ro	: out std_logic_vector(19 downto 0));
	end component post;

	signal Xpre, Ypre, Acor	: std_logic_vector(15 downto 0);
	signal Rcor : std_logic_vector(19 downto 0);
	signal Q, dQ : std_logic_vector(2 downto 0);

begin

	-- instantiate components
	u1:	pre port map(clk => clk, ena => ena, Xi => Xin, Yi => Yin, Xo => Xpre, Yo => Ypre, Q => Q);

	u2:	cordic	
			generic map(PIPELINE => PipeLength, WIDTH => 16, AWIDTH => 16, EXTEND_PRECISION => 4)
			port map(clk, ena, Xpre, Ypre, Rcor, Acor);

	u3:	post port map(clk => clk,  ena => ena, Ri => Rcor, Ai => Acor, Q => dQ, Ao => Aout, Ro => Rout);

	delay: block
		type delay_type is array(PipeLength -1 downto 0) of std_logic_vector(2 downto 0);
		signal delay_pipe :delay_type;
	begin
		process(clk, Q)
		begin
			if (clk'event and clk = '1') then
				if (ena = '1') then
					delay_pipe(0) <= Q;
					for n in 1 to PipeLength -1 loop
						delay_pipe(n) <= delay_pipe(n -1);
					end loop;
				end if;
			end if;
		end process;
		dQ <= delay_pipe(PipeLength -1);
	end block delay;

end architecture dataflow;


