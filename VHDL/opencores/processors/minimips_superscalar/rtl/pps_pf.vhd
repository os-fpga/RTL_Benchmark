--------------------------------------------------------------------------
--                                                                      --
--                                                                      --
-- miniMIPS Superscalar Processor : Address calculation stage           --
-- based on miniMIPS Processor                                          --
--                                                                      --
--                                                                      --
-- Author : Miguel Cafruni                                              --
-- miguel_cafruni@hotmail.com                                           --
--                                                      December 2018   --
--------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.pack_mips.all;

entity pps_pf is
port (
    clock       : in bus1;
    clock2      : in bus1;
    reset       : in bus1;
    stop_all    : in bus1;   	-- Unconditionnal locking of the pipeline stage
    stop_all2    : in bus1;
	 
    -- Asynchronous inputs
    bra_cmd     : in bus1;   	-- Branch
    bra_adr     : in bus32;     -- Address to load when an effective branch
    exch_cmd    : in bus1;   	-- Exception branch
    exch_adr    : in bus32;     -- Exception vector
    -- Asynchronous inputs 2
    bra_cmd2     : in bus1;   	-- Branch
    bra_adr2     : in bus32;    -- Address to load when an effective branch
    exch_cmd2    : in bus1;   	-- Exception branch
    exch_adr2    : in bus32;    -- Exception vector	 
	 
    stop_pf     : in bus1;   	-- Lock the stage
    stop_pf2     : in bus1;   	-- Lock the stage
    -- Synchronous output to EI stage
    PF_pc       : out bus32;     -- PC value
    PF_pc_4     : out bus32      -- PC+4 value
);
end pps_pf;

architecture rtl of pps_pf is

    signal suivant : bus32;     -- Preparation of the future pc
    signal suivant4 : bus32;    -- Preparation of the future pc
    signal pc_interne : bus32;  -- Value of the pc output, needed for an internal reading
    signal pc_interne4 : bus32; -- Value of the pc output, needed for an internal reading
    signal lock : bus1;       	-- Specify the authorization of the pc evolution
    signal lock2 : bus1;        -- independente para o pipe 2, 06.02.18  		

begin
    -- Connexion the pc to the internal pc
    PF_pc <= pc_interne;
    PF_pc_4 <= pc_interne4;

    -- Elaboration of an potential future pc				
    suivant <= exch_adr when exch_cmd  = '1'  else
               bra_adr  when bra_cmd   = '1'  else
               bus32(unsigned(pc_interne) + 8);
					
   suivant4 <= bus32(unsigned(exch_adr2) + 4) when exch_cmd2 = '1' else
	            bra_adr2 when bra_cmd2   = '1' else
	            bus32(unsigned(pc_interne4) + 8);


    lock <= '1' when stop_all  = '1' else -- Lock this stage when all the pipeline is locked   
            '0' when exch_cmd  = '1' else -- Exception
            '0' when bra_cmd   = '1' else -- Branch 
            '1' when stop_pf   = '1' else -- Wait for the branch hazard  
            '0';                         -- Normal evolution
				
   lock2 <= '1' when stop_all2 = '1' else -- Lock this stage when all the pipeline is locked
            '0' when exch_cmd2 = '1' else -- Exception
            '0' when bra_cmd2  = '1' else -- Branch
            '1' when stop_pf2  = '1' else -- Wait for the branch hazard 
            '0';                          -- Normal evolution   

    -- Synchronous evolution of the pc
    process(clock)
    begin
        if rising_edge(clock) then
            if reset='1' then
                -- PC reinitialisation with the boot address
                pc_interne <= ADR_INIT;
            elsif lock='0' then
                -- PC not locked
                pc_interne <= suivant;
            end if;
        end if;
    end process;

    process(clock2)
    begin
        if falling_edge(clock2) then
            if reset='1' then
                -- PC reinitialisation with the boot address
					 pc_interne4 <= ADR_INIT4; 
            elsif (lock2='0') then
                -- PC not locked
					 pc_interne4 <= suivant4;
            end if;
        end if;
    end process;

end rtl;
