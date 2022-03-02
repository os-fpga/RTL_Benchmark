library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity CordicPipe is 
	generic(
		WIDTH 	: natural;
		AWIDTH	: natural;
		PIPEID	: natural);
	port(
		clk		: in std_logic;
		ena		: in std_logic;

		Xi		: in std_logic_vector(WIDTH -1 downto 0); 
		Yi		: in std_logic_vector(WIDTH -1 downto 0);
		Zi		: in std_logic_vector(AWIDTH -1 downto 0);
		Xo		: out std_logic_vector(WIDTH -1 downto 0);
		Yo		: out std_logic_vector(WIDTH -1 downto 0);
		Zo		: out std_logic_vector(AWIDTH -1 downto 0));
end entity CordicPipe;

architecture dataflow of CordicPipe is

	--
	-- functions
	--
	function CATAN(n :natural) return integer is
	variable result	:integer;
	begin
		case n is
			when 1 => result := 16#012E40#;
			when 2 => result := 16#09FB4#;
			when 3 => result := 16#05111#;
			when 4 => result := 16#028B1#;
			when 5 => result := 16#0145D#;
			when 6 => result := 16#0A2F#;
			when 7 => result := 16#0518#;
			when 8 => result := 16#028C#;
			when 9 => result := 16#0146#;
			when 10 => result := 16#0A3#;
			when 11 => result := 16#051#;
			when 12 => result := 16#029#;
			when 13 => result := 16#014#;
			when 14 => result := 16#0A#;
			when 15 => result := 16#05#;
			when 16 => result := 16#03#;
			when 17 => result := 16#01#;
			when others => result := 16#0#;
		end case;
		return result;
	end CATAN;

	function Delta(Arg : std_logic_vector; Cnt : natural) return std_logic_vector is
		variable tmp : std_logic_vector(Arg'range);
	begin
		tmp := Arg;
		for n in 1 to cnt loop
			tmp := ( tmp(Arg'high) & tmp(Arg'high downto 1) );
		end loop;
		return tmp;
	end function Delta;

	function AddSub(dataa, datab : in std_logic_vector; add_sub : in std_logic) return std_logic_vector is
	begin
		if (add_sub = '1') then
			return unsigned(dataa) + unsigned(datab);
		else
			return unsigned(dataa) - unsigned(datab);
		end if;
	end;

	--
	--	ARCHITECTURE BODY
	--
	signal dX, Xresult	: std_logic_vector(WIDTH -1 downto 0);
	signal dY, Yresult	: std_logic_vector(WIDTH -1 downto 0);
	signal atan, Zresult	: std_logic_vector(AWIDTH -1 downto 0);

	signal Yneg, Ypos	: std_logic;
	
begin

	dX <= Delta(Xi, PIPEID);
	dY <= Delta(Yi, PIPEID);
	atan <= std_logic_vector(conv_unsigned( catan(PIPEID), AWIDTH) );

	-- generate adder structures
	Yneg <= Yi(WIDTH -1);
	Ypos <= not Yi(WIDTH -1);

	-- xadd
    Xresult <= AddSub(Xi, dY, YPos);

	-- yadd 
	Yresult <= AddSub(Yi, dX, Yneg);

	-- zadd
	Zresult <= AddSub(Zi, atan, Ypos);

	gen_regs: process(clk)
	begin
		if(clk'event and clk='1') then
			if (ena = '1') then
				Xo <= Xresult;
				Yo <= Yresult;
				Zo <= Zresult;
			end if;
		end if;
	end process;

end architecture dataflow;
