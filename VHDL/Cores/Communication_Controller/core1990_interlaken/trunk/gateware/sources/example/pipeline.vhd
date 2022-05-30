library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.ALL; 
library work;

entity pipe is
    generic (
		Nmax : integer
    );
	port (
	    N : in  std_logic_vector(6 downto 0);
	    pipe_in: in std_logic_vector(68 downto 0);
	    pipe_out: out std_logic_vector(68 downto 0);
	    clk: in std_logic
	);
end entity pipe;

architecture rtl of pipe is
    type slv64_array is array (natural range <>) of std_logic_vector(68 downto 0);
    signal pipeline : slv64_array (0 to Nmax);    
begin

    pipe_proc: process(clk, pipe_in, pipeline, N)
    begin
        pipeline(0) <= pipe_in;
		if rising_edge(clk) then
			for i in 1 to Nmax loop
				pipeline(i) <= pipeline(i-1);
			end loop;
		end if;
		pipe_out <= pipeline(to_integer(unsigned(N)));
    end process;

end architecture rtl;
