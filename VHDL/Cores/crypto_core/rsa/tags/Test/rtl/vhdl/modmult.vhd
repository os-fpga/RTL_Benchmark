library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity modmult32 is
	Generic (MPWID: integer := 32);
    Port ( mpand : in std_logic_vector(MPWID-1 downto 0);
           mplier : in std_logic_vector(MPWID-1 downto 0);
           modulus : in std_logic_vector(MPWID-1 downto 0);
           product : out std_logic_vector(MPWID-1 downto 0);
           clk : in std_logic;
			  ds : in std_logic;
			  reset : in std_logic;
			  ready : out std_logic);
end modmult32;

architecture modmult of modmult32 is

signal mpreg: std_logic_vector(MPWID-1 downto 0);
signal mcreg, mcreg1, mcreg2: std_logic_vector(MPWID+1 downto 0);
signal modreg1, modreg2: std_logic_vector(MPWID+1 downto 0);
signal prodreg, prodreg1, prodreg2, prodreg3, prodreg4: std_logic_vector(MPWID+1 downto 0);

signal count: integer;
signal modstate: std_logic_vector(1 downto 0);
signal first: std_logic;

begin


	product <= prodreg4(MPWID-1 downto 0);

	with mpreg(0) select
		prodreg1 <= prodreg + mcreg when '1',
						prodreg when others;

	prodreg2 <= prodreg1 - modreg1;
	prodreg3 <= prodreg1 - modreg2;

	modstate <= prodreg3(mpwid+1) & prodreg2(mpwid+1);

	with modstate select
		prodreg4 <= prodreg1 when "11",
						prodreg2 when "10",
						prodreg3 when others;

	mcreg1 <= mcreg - modreg1;

	with mcreg1(MPWID) select
		mcreg2 <= mcreg when '1',
					 mcreg1 when others;

	ready <= first;

	combine: process (clk, first, ds, count, mpreg, reset) is

	begin
	
		if reset = '1' then
			first <= '1';
		elsif rising_edge(clk) then
			if first = '1' then
				if ds = '1' then
					mpreg <= mplier;
					mcreg <= "00" & mpand;
					modreg1 <= "00" & modulus;
					modreg2 <= '0' & modulus & '0';
					prodreg <= (others => '0');
					count <= MPWID;
					first <= '0';
				end if;
			else
				if count = 0 or mpreg = 0 then
					first <= '1';
				else
					count <= count - 1;
					mcreg <= mcreg2(MPWID downto 0) & '0';
					mpreg <= '0' & mpreg(MPWID-1 downto 1);
					prodreg <= prodreg4;
				end if;
			end if;
		end if;

	end process combine;

--	combine: process (clk, reset) is
--
--	variable mpvar: std_logic_vector(MPWID downto 0);
--	variable mcvar: std_logic_vector(MPWID downto 0);
--	variable prodvar: std_logic_vector(MPWID downto 0);
--	variable count: integer;
--
--	begin
--	
--		if reset = '1' then
--			first <= '1';
--		elsif rising_edge(clk) then
--			if first = '1' then
--				if ds = '1' then
--					mpvar := '0' & mplier;
--					mcvar := '0' & mpand;
--					modreg1 <= '0' & modulus;
--					modreg2 <= modulus & '0';
--					prodvar := (others => '0');
--					count := MPWID;
--					first <= '0';
--				end if;
--			else
--				count := count - 1;
--
--				if mcvar > modreg then
--					mcvar := mcvar - modreg;
--				end if;
--
--				if mpvar(0) = '1' then
--					prodvar1 := prodvar + mcvar;
--				end if;
--
--				if prodvar > modreg then
--					prodvar := prodvar - modreg;
--				end if;
--
--				mcvar := mcvar(MPWID-1 downto 0) & '0';
--
--				mpvar := '0' & mpvar(MPWID downto 1);
--
--				if count = 0 or mpvar = 0 then
--					first <= '1';
--					product <= prodvar(MPWID-1 downto 0);
--				end if;
--			end if;
--		end if;
--
--	end process combine;

end modmult;
