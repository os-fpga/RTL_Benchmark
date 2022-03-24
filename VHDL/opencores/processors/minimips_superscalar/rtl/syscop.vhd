--------------------------------------------------------------------------
--                                                                      --
--                                                                      --
-- miniMIPS Superscalar Processor : Coprocessor system (cop0)           --
-- based on miniMIPS Processor                                          --
--                                                                      --
--                                                                      --
-- Author : Miguel Cafruni                                              --
-- miguel_cafruni@hotmail.com                                           --
--                                                      December 2018   --
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.pack_mips.all;

-- By convention in the commentary, the term interruption means hardware interruptions and software exceptions

entity syscop is
port
(
    clock         : in std_logic;
    reset         : in std_logic;

    -- Datas from the pipeline
    MEM_adr       : in bus32;       -- Address (PC) of the current instruction in the pipeline end -> responsible of the exception
    MEM_exc_cause : in bus32;       -- Potential cause exception of that instruction
    MEM_it_ok     : in std_logic;   -- Allow hardware interruptions

    -- Hardware interruption
    it_mat        : in std_logic;   -- Hardware interruption detected

    -- Interruption controls
    interrupt     : out std_logic;  -- Interruption to take into account
    vecteur_it    : out bus32;      -- Interruption vector

    -- Writing request in register bank
    write_data    : in bus32;       -- Data to write
    write_adr     : in bus5;        -- Address of the register to write
    write_SCP     : in std_logic;   -- Writing request

    -- Reading request in register bank
    read_adr1     : in bus5;        -- Address of the first register
    read_adr2     : in bus5;        -- Address of the second register
    read_data1    : out bus32;      -- Value of register 1
    read_data2    : out bus32;       -- Value of register 2
	 
    -- Datas from the pipeline
    MEM_adr2       : in bus32;       -- Address of the current instruction in the pipeline end -> responsible of the exception
    MEM_exc_cause2 : in bus32;       -- Potential cause exception of that instruction
    MEM_it_ok2     : in std_logic;   -- Allow hardware interruptions

    -- Hardware interruption
    --it_mat2        : in std_logic;   -- Hardware interruption detected

    -- Interruption controls
    --interrupt     : out std_logic;  -- Interruption to take into account
    --vecteur_it    : out bus32;      -- Interruption vector

    -- Writing request in register bank
    write_data2    : in bus32;       -- Data to write 
    write_adr2     : in bus5;        -- Address of the register to write
    write_SCP2     : in std_logic;   -- Writing request

    -- Reading request in register bank
    read_adr3     : in bus5;        -- Address of the 3th register
    read_adr4     : in bus5;        -- Address of the 4th register
    read_data3    : out bus32;      -- Value of register 3
    read_data4    : out bus32       -- Value of register 4
);
end syscop;


architecture rtl of syscop is

    subtype adr_scp_reg is integer range 12 to 15;

    type scp_reg_type is array (integer range adr_scp_reg'low to adr_scp_reg'high) of bus32;

    -- Constants to define the coprocessor registers
    constant COMMAND   : integer      := 0;   -- False register to command the coprocessor system
    constant STATUS    : adr_scp_reg  := 12;  -- Registre 12 of the coprocessor system
    constant CAUSE     : adr_scp_reg  := 13;  -- Registre 13 of the coprocessor system
    constant ADRESSE   : adr_scp_reg  := 14;  -- Registre 14 of the coprocessor system
    constant VECTIT    : adr_scp_reg  := 15;  -- Registre 15 of the coprocessor system

    signal scp_reg : scp_reg_type;          -- Internal register bank
    signal pre_reg : scp_reg_type;          -- Register bank preparation
	 
    signal adr_src1 : integer range 0 to 31;
    signal adr_src2 : integer range 0 to 31;
    signal adr_dest : integer range 0 to 31;
	 --mod
    signal adr_src3 : integer range 0 to 31;
    signal adr_src4 : integer range 0 to 31;
    signal adr_dest2 : integer range 0 to 31;
    --fim mod	 
    signal exception, exception2 : std_logic;           -- Set to '1' when exception detected *** quando MEM_exc_cause for diferente de IT_NOEXC
    signal interruption, interruption2 : std_logic;        -- Set to '1' when interruption detected
    signal cmd_itret    : std_logic;        -- Set to '1' when interruption return command is detected

    signal save_msk  : std_logic;           -- Save the mask state when an interruption occurs

begin

    -- Detection of the interruptions
    exception <= '1' when MEM_exc_cause/=IT_NOEXC else '0'; -- *** chegou uma instrucao ilegal ou break ou syscall ***
	 exception2 <= '1' when MEM_exc_cause2/=IT_NOEXC else '0'; -- *** chegou uma instrucao ilegal ou break ou syscall ***
    interruption <= '1' when it_mat='1' and scp_reg(STATUS)(0)='1' and MEM_it_ok='1' else '0';
    interruption2 <= '1' when it_mat='1' and scp_reg(STATUS)(0)='1' and MEM_it_ok2='1' else '0';
    -- Update asynchronous outputs
    interrupt <= exception or exception2 or interruption or interruption2; -- Detection of interruptions
    vecteur_it <= scp_reg(ADRESSE) when cmd_itret = '1' else -- Send the return adress when a return instruction appears -- *** retorno de uma instrucao ilegal ou break ou syscall ***
                  scp_reg(VECTIT);                           -- Send the interruption vector in other cases


    -- Decode the address of the registers
    adr_src1 <= to_integer(unsigned(read_adr1));
    adr_src2 <= to_integer(unsigned(read_adr2));
    adr_dest <= to_integer(unsigned(write_adr));
--mod
    adr_src3 <= to_integer(unsigned(read_adr3));
    adr_src4 <= to_integer(unsigned(read_adr4));
    adr_dest2 <= to_integer(unsigned(write_adr2));
--fim mod	 
    -- Read the two registers
    read_data1 <= (others => '0') when (adr_src1<scp_reg'low or adr_src1>scp_reg'high) else
                  scp_reg(adr_src1);
    read_data2 <= (others => '0') when (adr_src2<scp_reg'low or adr_src2>scp_reg'high) else
                  scp_reg(adr_src2);
--mod	 
    -- Read the two registers
    read_data3 <= (others => '0') when (adr_src3<scp_reg'low or adr_src3>scp_reg'high) else
                  scp_reg(adr_src3);
    read_data4 <= (others => '0') when (adr_src4<scp_reg'low or adr_src4>scp_reg'high) else -- erro de copia e cola
                  scp_reg(adr_src4);																		  -- arrumado em 04\12\17 
    --fim mod	
						
    -- Define the pre_reg signal, next value for the registers
    process (scp_reg, adr_dest, write_SCP, write_data, interruption, interruption2,--process (scp_reg, adr_dest, write_SCP, write_data, interruption,
             exception, exception2, MEM_exc_cause, MEM_adr, reset, adr_dest2, write_SCP2, write_data2, MEM_exc_cause2, MEM_adr2)--exception, MEM_exc_cause, MEM_adr, reset)
    begin    -- *** exception eh um sinal interno e tambem pode ser tratado em um processo *** --
        pre_reg <= scp_reg;
        cmd_itret <= '0'; -- No IT return in most cases

        -- Potential writing in a register
        if (write_SCP='1' and adr_dest>=pre_reg'low and adr_dest<=pre_reg'high) then
            pre_reg(adr_dest) <= write_data;
        end if;
		  --mod
        -- Potential writing in a register from 2nd pipe
        if (write_SCP2='1' and adr_dest2>=pre_reg'low and adr_dest2<=pre_reg'high) then
            pre_reg(adr_dest2) <= write_data2;
        end if;
        --fim mod

        -- Command from the core
        if write_SCP='1' and adr_dest=COMMAND then
            case write_data is -- Different operations
                when SYS_UNMASK => pre_reg(STATUS)(0) <= '1'; -- Unamsk command
                when SYS_MASK   => pre_reg(STATUS)(0) <= '0'; -- Mask command
                when SYS_ITRET  => -- Interruption return command
                                   pre_reg(STATUS)(0) <= save_msk; -- Restore the mask before the interruption
                                   cmd_itret          <= '1';      -- False interruption request (to clear the pipeline)
                when others     => null;
            end case;
        end if;

        -- Modifications from the interruptions
        if interruption='1' then
            pre_reg(STATUS)(0) <= '0';       -- Mask the interruptions
            pre_reg(CAUSE) <= IT_ITMAT;      -- Save the interruption cause
            pre_reg(ADRESSE) <= MEM_adr;     -- Save the return address
        end if;
		  
        -- Modifications from the interruptions
        if interruption2='1' then
            pre_reg(STATUS)(0) <= '0';       -- Mask the interruptions
            pre_reg(CAUSE) <= IT_ITMAT;      -- Save the interruption cause
            pre_reg(ADRESSE) <= MEM_adr2;     -- Save the return address
        end if;
		  
        -- Modifications from the exceptions
        if exception='1' then  -- *** chegou uma instrucao ilegal ou break ou syscall ***
            pre_reg(STATUS)(0) <= '0';       -- Mask the interruptions
            pre_reg(CAUSE) <= MEM_exc_cause; -- Save the exception cause
            pre_reg(ADRESSE) <= MEM_adr;     -- Save the return address
        end if;
		  
        -- Modifications from the exceptions
        if exception2='1' then  -- *** chegou uma instrucao ilegal ou break ou syscall ***
            pre_reg(STATUS)(0) <= '0';       -- Mask the interruptions
            pre_reg(CAUSE) <= MEM_exc_cause2; -- Save the exception cause
            pre_reg(ADRESSE) <= MEM_adr2;     -- Save the return address
        end if;
        -- The reset has the priority on the other cuases
        if reset='1' then
            pre_reg <= (others => (others => '0'));

            -- NB : The processor is masked after a reset
            --      The exception handler is set at address 0
        end if;
    end process;

    -- Memorisation of the modifications in the register bank
    process(clock)
    begin
        if clock='1' and clock'event then
            -- Save the mask when an interruption appears
            if (exception='1') or (interruption='1') or (exception2='1') or (interruption2='1')  then
                save_msk <= scp_reg(STATUS)(0);
            end if;
            scp_reg <= pre_reg;   
	     end if;
    end process;

end rtl;
