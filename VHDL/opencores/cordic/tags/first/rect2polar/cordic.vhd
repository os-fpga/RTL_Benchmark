--
--	VHDL implementation of cordic algorithm
--
--
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity Cordic is 
	generic(
		PIPELINE			: integer := 15;
		WIDTH				: integer := 16;
		AWIDTH			: integer := 16;
		EXTEND_PRECISION		: integer := 4);
	port(
		clk	: in std_logic;
		ena : in std_logic;

		Xi	: in std_logic_vector(WIDTH-1 downto 0);
		Yi	: in std_logic_vector(WIDTH-1 downto 0);
		
		R	: out std_logic_vector(WIDTH + EXTEND_PRECISION -1 downto 0);
		A	: out std_logic_vector(AWIDTH -1 downto 0));
		
	constant ANG : natural := 20;
	constant PRECISION : natural := WIDTH + EXTEND_PRECISION;
end Cordic;


architecture dataflow of Cordic is

	--
	--	TYPE defenitions
	--
	type XYVector is array(PIPELINE downto 0) of std_logic_vector(PRECISION downto 0);
	type ZVector is array(PIPELINE downto 0) of std_logic_vector(ANG -1 downto 0);

	--
	--	COMPONENT declarations
	--
	component CordicPipe
		generic(
			WIDTH		: natural;
			AWIDTH	: natural;
			PIPEID	: natural);
		port(
			clk		: in std_logic;
			ena		: in std_logic;

			Xi, Yi	: in std_logic_vector(PRECISION downto 0);
			Zi		: in std_logic_vector(ANG -1 downto 0);
			Xo, Yo	: out std_logic_vector(PRECISION downto 0);
			Zo		: out std_logic_vector(ANG -1 downto 0));
	end component CordicPipe;

	--
	--	SIGNALS
	--
	signal X, Y	: XYVector;
	signal Z	: ZVector;

	--
	--	ACHITECTURE BODY
	--
begin
	-- fill first nodes

	X(0)(PRECISION downto EXTEND_PRECISION) <= ('0' & Xi);		-- fill msb of X0
	fill_x:	
	for n in EXTEND_PRECISION -1 downto 0 generate				-- fill lsb with '0'
		X(0)(n) <= '0';
	end generate;

	Y(0)(PRECISION downto EXTEND_PRECISION) <= (Yi(WIDTH -1) & Yi);
	fill_y:	
	for n in EXTEND_PRECISION -1 downto 0 generate				-- fill lsb with '0'
		Y(0)(n) <= '0';
	end generate;

	fill_z:
	for n in ANG -1 downto 0 generate						-- fill Z with '0'
		Z(0)(n) <= '0';
	end generate;

	--
	-- generate pipeline
	--
	gen_pipe:
	for n in 1 to PIPELINE generate
		Pipe: CordicPipe 
			generic map(WIDTH => PRECISION +1, AWIDTH => ANG, PIPEID => n)
			port map ( clk, ena, X(n-1), Y(n-1), Z(n-1), X(n), Y(n), Z(n) );
	end generate gen_pipe;

	--
	-- assign outputs
	--
	R <= X(PIPELINE)(PRECISION -1 downto 0);
	A <= Z(PIPELINE)(ANG -1 downto ANG -AWIDTH);
end dataflow;
