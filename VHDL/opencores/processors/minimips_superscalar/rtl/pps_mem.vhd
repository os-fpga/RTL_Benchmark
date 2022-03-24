--------------------------------------------------------------------------
--                                                                      --
--                                                                      --
-- miniMIPS Superscalar Processor : Memory access stage                 --
-- based on miniMIPS Processor                                          --
--                                                                      --
--                                                                      --
-- Author : Miguel Cafruni                                              --
-- miguel_cafruni@hotmail.com                                           --
--                                                      December 2018   --
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.pack_mips.all;

entity pps_mem is
port
(
    clock : in std_logic;
    clock2 : in std_logic;
    reset : in std_logic;
    stop_all : in std_logic;             -- Unconditionnal locking of the outputs
    stop_all2 : in std_logic;
    clear : in std_logic;                -- Clear the pipeline stage

    -- Interface with the control bus
    MTC_data : out bus32;                -- Data to write in memory
    MTC_adr : out bus32;                 -- Address for memory
    MTC_r_w : out std_logic;             -- Read/Write in memory
    MTC_req : out std_logic;             -- Request access to memory
    CTM_data : in bus32;                 -- Data from memory
	 
    -- Datas from Execution stage
    EX_adr : in bus32;                   -- Instruction address
    EX_data_ual : in bus32;              -- Result of alu operation
    EX_adresse : in bus32;               -- Result of the calculation of the address
    EX_adresse_p1p2 : in bus32;        -- resultado do calculo do endereco do desvio + 4 para pipe 2
    -- *** nao tinha essa entrada no original, so tinha a saida no EX *** 
    EX_bra_confirm : in bus1;            -- Confirmacao do branch no pipe 1 (26-07-18)
    -- ******************
    EX_adr_reg_dest : in adr_reg_type;   -- Destination register address for the result
    EX_ecr_reg : in std_logic;           -- Effective writing of the result
    EX_op_mem : in std_logic;            -- Memory operation needed
    EX_r_w : in std_logic;               -- Type of memory operation (read or write)
    EX_exc_cause : in bus32;             -- Potential exception cause
    EX_level : in level_type;            -- Availability stage for the result for bypassing (Estágio de disponibilidade para o resultado de bypassing)
    EX_it_ok : in std_logic;             -- Allow hardware interruptions

    -- Synchronous outputs for bypass unit
    MEM_adr : out bus32;                 -- Instruction address
    MEM_adr_reg_dest : out adr_reg_type; -- Destination register address
    MEM_ecr_reg : out std_logic;         -- Writing of the destination register
    MEM_data_ecr : out bus32;            -- Data to write (from alu or memory)
    MEM_exc_cause : out bus32;           -- Potential exception cause
    MEM_level : out level_type;          -- Availability stage for the result for bypassing (Estágio de disponibilidade para o resultado de bypassing)
    MEM_it_ok : out std_logic;           -- Allow hardware interruptions

	 --modificação
    -- Interface with the control bus
    MTC_data2 : out bus32;                -- Data to write in memory
    MTC_adr2 : out bus32;                 -- Address for memory
    MTC_r_w2 : out std_logic;             -- Read/Write in memory
    MTC_req2 : out std_logic;             -- Request access to memory
    CTM_data2 : in bus32;                 -- Data from memory

    -- Datas from Execution 2 stage
    EX_adr2 : in bus32;                   -- Instruction address
    EX_data_ual2 : in bus32;              -- Result of alu operation
    EX_adresse2 : in bus32;               -- Result of the calculation of the address
    EX_adresse_p2p1 : in bus32;        -- resultado do calculo do endereco do desvio + 4 para pipe 1
    -- *** nao tinha essa entrada no original, so tinha a saida no EX2 ***
    EX_bra_confirm2 : in bus1;            -- Confirmacao do branch no pipe 2 (26-07-18)
    -- ******************
    EX_adr_reg_dest2 : in adr_reg_type;   -- Destination register address for the result
    EX_ecr_reg2 : in std_logic;           -- Effective writing of the result
    EX_op_mem2 : in std_logic;            -- Memory operation needed
    EX_r_w2 : in std_logic;               -- Type of memory operation (read or write)
    EX_exc_cause2 : in bus32;             -- Potential exception cause
    EX_level2 : in level_type;            -- Availability stage for the result for bypassing (Estágio de disponibilidade para o resultado de bypassing)
    EX_it_ok2 : in std_logic;             -- Allow hardware interruptions

    -- Synchronous outputs for bypass unit
    MEM_adr2 : out bus32;                 -- Instruction address
    MEM_adr_reg_dest2 : out adr_reg_type; -- Destination register address
    MEM_ecr_reg2 : out std_logic;         -- Writing of the destination register
    MEM_data_ecr2 : out bus32;            -- Data to write (from alu or memory)
    MEM_exc_cause2 : out bus32;           -- Potential exception cause
    MEM_level2 : out level_type;          -- Availability stage for the result for bypassing(Estágio de disponibilidade para o resultado de bypassing)
    MEM_it_ok2 : out std_logic            -- Allow hardware interruptions
);
end pps_mem;

architecture rtl of pps_mem is

    signal tmp_data_ecr  : bus32;         -- Selection of the data source (memory or alu)
    signal tmp_data_ecr2 : bus32;         -- Selection of the data source (memory or alu)
    signal sel_MTC       : bus2;

begin
    sel_MTC  <= EX_bra_confirm & EX_bra_confirm2;

    with sel_MTC select
	      MTC_adr <= EX_adresse_p2p1 when "01",
		   EX_adresse  when others;

    with sel_MTC select
	       MTC_adr2 <= EX_adresse_p1p2 when "10",
		    EX_adresse2 when others;

    -- Bus controler connexions
    MTC_r_w <= EX_r_w;                    -- Connexion of R/W
    MTC_data <= EX_data_ual;                -- Connexion of the data bus
    MTC_req <= EX_op_mem and not clear;   -- Connexion of the request (if there is no clearing of the pipeline)
    -- Bus controler connexions 2nd pipe
    MTC_r_w2 <= EX_r_w2;                  -- Connexion of R/W
    MTC_data2 <= EX_data_ual2;              -- Connexion of the data bus
    MTC_req2 <= EX_op_mem2 and not clear; -- Connexion of the request (if there is no clearing of the pipeline)
    -- Preselection of the data source for the outputs
    tmp_data_ecr <= CTM_data when EX_op_mem = '1' else EX_data_ual;
    tmp_data_ecr2 <= CTM_data2 when EX_op_mem2 = '1' else EX_data_ual2; --(modificação) para EX2 
    -- Set the synchronous outputs
    process (clock)
    begin
        if rising_edge(clock) then
            if reset = '1' then
                MEM_adr  <= (others => '0');
                MEM_adr_reg_dest <= (others => '0');
                MEM_ecr_reg <= '0';
                MEM_data_ecr <= (others => '0');
                MEM_exc_cause <= IT_NOEXC;
                MEM_level <= LVL_DI;
                MEM_it_ok <= '0';
            elsif stop_all = '0' then
                if clear = '1' then -- Clear the stage
                    MEM_adr <= EX_adr;
                    MEM_adr_reg_dest <= (others => '0');
                    MEM_ecr_reg <= '0';
                    MEM_data_ecr <= (others => '0');
                    MEM_exc_cause <= IT_NOEXC;
                    MEM_level <= LVL_DI;
                    MEM_it_ok <= '0';
                else -- Normal evolution 
                    MEM_adr <= EX_adr;
                    MEM_adr_reg_dest <= EX_adr_reg_dest;
                    MEM_ecr_reg <= EX_ecr_reg;
                    MEM_data_ecr <= tmp_data_ecr;
                    MEM_exc_cause <= EX_exc_cause;
                    MEM_level <= EX_level;
                    MEM_it_ok <= EX_it_ok;
                end if;
            end if;
        end if;
    end process;

    process (clock2)
    begin
	if falling_edge(clock2) then
            if reset = '1' then
                MEM_adr2  <= (others => '0');
                MEM_adr_reg_dest2 <= (others => '0');
                MEM_ecr_reg2 <= '0';
                MEM_data_ecr2 <= (others => '0');
                MEM_exc_cause2 <= IT_NOEXC;
                MEM_level2 <= LVL_DI;
                MEM_it_ok2 <= '0';
            elsif stop_all2 = '0' then
                if clear = '1' then -- Clear the stage
                    MEM_adr2 <= EX_adr2;
                    MEM_adr_reg_dest2 <= (others => '0');
                    MEM_ecr_reg2 <= '0';
                    MEM_data_ecr2 <= (others => '0');
                    MEM_exc_cause2 <= IT_NOEXC;
                    MEM_level2 <= LVL_DI;
                    MEM_it_ok2 <= '0';
                else -- Normal evolution 
                    MEM_adr2 <= EX_adr2;
                    MEM_adr_reg_dest2 <= EX_adr_reg_dest2;
                    MEM_ecr_reg2 <= EX_ecr_reg2;
                    MEM_data_ecr2 <= tmp_data_ecr2;
                    MEM_exc_cause2 <= EX_exc_cause2;
                    MEM_level2 <= EX_level2;
                    MEM_it_ok2 <= EX_it_ok2;
                end if;
            end if;
        end if;
 end process;

end rtl;
