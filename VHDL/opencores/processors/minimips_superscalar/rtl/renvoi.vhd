--------------------------------------------------------------------------
--                                                                      --
--                                                                      --
-- miniMIPS Superscalar Processor : Bypass unit                         --
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

entity renvoi is
port (
    -- Register access signals
    adr1 : in adr_reg_type;    -- Operand 1 address (end. a ser lido asssincronamente pelo DI)
    adr2 : in adr_reg_type;    -- Operand 2 address (end. a ser lido asssincronamente pelo DI)
    use1 : in std_logic;       -- Operand 1 utilisation
    use2 : in std_logic;       -- Operand 2 utilisation    
    data1 : out bus32;         -- First register value (para DI OP1)
    data2 : out bus32;         -- Second register value (para DI OP2)
    alea : out std_logic;      -- Unresolved hazards detected

    -- Bypass signals of the intermediary datas (Sinais de retorno dos dados intermediários)
    DI_level : in level_type;  -- Availability level of the data (Nível de disponibilidade dos dados)
    DI_adr : in adr_reg_type;  -- Register destination of the result
    DI_ecr : in std_logic;     -- Writing register request
    DI_data : in bus32;        -- Data to used (op2 do DI)

    EX_level : in level_type;  -- Availability level of the data
    EX_adr : in adr_reg_type;  -- Register destination of the result
    EX_ecr : in std_logic;     -- Writing register request
    EX_data : in bus32;        -- Data to used

    MEM_level : in level_type; -- Availability level of the data
    MEM_adr : in adr_reg_type; -- Register destination of the result
    MEM_ecr : in std_logic;    -- Writing register request
    MEM_data : in bus32;       -- Data to used
    
    interrupt : in std_logic;  -- Exceptions or interruptions

    -- Connexion to the differents bank of register

      -- Writing commands for writing in the registers
    write_data : out bus32;    -- Data to write
    write_adr : out bus5;      -- Address of the register to write
    write_GPR : out std_logic; -- Selection in the internal registers
    write_SCP : out std_logic; -- Selection in the coprocessor system registers

      -- Reading commands for Reading in the registers
    read_adr1 : out bus5;      -- Address of the first register to read
    read_adr2 : out bus5;      -- Address of the second register to read
    read_data1_GPR : in bus32; -- Value of operand 1 from the internal registers
    read_data2_GPR : in bus32; -- Value of operand 2 from the internal registers
    read_data1_SCP : in bus32; -- Value of operand 1 from the coprocessor system registers
    read_data2_SCP : in bus32;  -- Value of operand 2 from the coprocessor system registers

	--modificacao duplicacao
    -- Register access signals
    adr3 : in adr_reg_type;    -- Operand 3 address (end. a ser lido asssincronamente pelo DI2)
    adr4 : in adr_reg_type;    -- Operand 4 address (end. a ser lido asssincronamente pelo DI2)
    use12 : in std_logic;       -- Operand 3 utilisation
    use22 : in std_logic;       -- Operand 4 utilisation

    data3 : out bus32;         -- First register value
    data4 : out bus32;         -- Second register value
    alea2 : out std_logic;      -- Unresolved hazards detected
  
    -- Bypass signals of the intermediary datas
    DI_level2 : in level_type;  -- Availability level of the data
    DI_adr2 : in adr_reg_type;  -- Register destination of the result
    DI_ecr2 : in std_logic;     -- Writing register request
    DI_data2 : in bus32;        -- Data to used (op2 do DI2)

    EX_level2 : in level_type;  -- Availability level of the data
    EX_adr2 : in adr_reg_type;  -- Register destination of the result
    EX_ecr2 : in std_logic;     -- Writing register request
    EX_data2 : in bus32;        -- Data to used

    MEM_level2 : in level_type; -- Availability level of the data
    MEM_adr2 : in adr_reg_type; -- Register destination of the result
    MEM_ecr2 : in std_logic;    -- Writing register request
    MEM_data2 : in bus32;       -- Data to used
    

    -- Connexion to the differents bank of register

      -- Writing commands for writing in the registers
    write_data2 : out bus32;    -- Data to write
    write_adr2 : out bus5;      -- Address of the register to write
    write_GPR2 : out std_logic; -- Selection in the internal registers
    --sem necessidade--write_SCP : out std_logic; -- Selection in the coprocessor system registers

      -- Reading commands for Reading in the registers
    read_adr3 : out bus5;      -- Address of the first register to read
    read_adr4 : out bus5;      -- Address of the second register to read
    read_data3_GPR : in bus32; -- Value of operand 1 from the internal registers
    read_data4_GPR : in bus32; -- Value of operand 2 from the internal registers
    read_data3_SCP : in bus32; -- Value of operand 1 from the coprocessor system registers
    read_data4_SCP : in bus32  -- Value of operand 2 from the coprocessor system registers
);
end renvoi;

architecture rtl of renvoi is
    signal dep_r1 : level_type; -- Dependency level for operand 1
    signal dep_r2 : level_type; -- Dependency level for operand 2
    signal read_data1 : bus32;  -- Data contained in the register asked by operand 1
    signal read_data2 : bus32;  -- Data contained in the register asked by operand 2
    signal res_reg, res_mem, res_ex, res_di, res_mem2, res_ex2, res_di2 : std_logic;
    signal resolution : bus7;   -- Verification of the resolved hazards
    signal idx1, idx2, idx3, idx4 : integer range 0 to 6;
	--duplicação dos sinais para o segundo pipe
    signal dep_r3 : level_type; -- Dependency level for operand 1
    signal dep_r4 : level_type; -- Dependency level for operand 2
    signal read_data3 : bus32;  -- Data contained in the register asked by operand 1
    signal read_data4 : bus32;  -- Data contained in the register asked by operand 2

begin
    -- Connexion of the writing command signals
    write_data <= MEM_data;
    write_adr <= MEM_adr(4 downto 0);
    write_GPR <= not MEM_adr(5) and MEM_ecr when interrupt = '0' else  -- The high bit to 0 selects the internal registers
                 '0';
    write_SCP <= MEM_adr(5) and MEM_ecr;      -- The high bit to 1 selects the coprocessor system registers
    -- Connexion of the writing command signals
    read_adr1 <= adr1(4 downto 0);            -- Connexion of the significative address bits (end. source 1 a ser lido no banco assincronamente pelo DI)
    read_adr2 <= adr2(4 downto 0);            -- Connexion of the significative address bits (end. source 2 a ser lido no banco assincronamente PELO DI)
    -- Evaluation of the level of dependencies
    dep_r1 <= LVL_REG  when adr1(4 downto 0)="00000" or use1='0' else -- No dependency with register 0, se use1 for igual a '0' aqui, significa que op1 = imm ou shamt
              LVL_DI   when adr1=DI_adr  and DI_ecr ='1' else         -- Dependency with DI stage (reg. fonte = reg.destino no momento da escrita, (DI_ecr ='1'))
              LVL_EX   when adr1=EX_adr  and EX_ecr ='1' else         -- Dependency with EX stage
              LVL_MEM  when adr1=MEM_adr and MEM_ecr='1' else         -- Dependency with MEM stage
              LVL_DI2  when adr1=DI_adr2  and DI_ecr2 = '1' else  -- Dependency with DI stage (reg. fonte = reg.destino no momento da escrita, (DI_ecr ='1'))
              LVL_EX2  when adr1=EX_adr2  and EX_ecr2 = '1' else  -- Dependency with EX stage
              LVL_MEM2 when adr1=MEM_adr2 and MEM_ecr2 ='1' else  -- Dependency with MEM stage
              LVL_REG;                                               -- No dependency detected
    dep_r2 <= LVL_REG  when adr2(4 downto 0)="00000" or use2='0' else -- No dependency with register 0
              LVL_DI   when adr2=DI_adr  and DI_ecr ='1' else         -- Dependency with DI stage
              LVL_EX   when adr2=EX_adr  and EX_ecr ='1' else         -- Dependency with EX stage
              LVL_MEM  when adr2=MEM_adr and MEM_ecr='1' else         -- Dependency with MEM stage
              LVL_DI2  when adr2=DI_adr2  and DI_ecr2 = '1' else  -- Dependency with DI2 stage (reg. fonte = reg.destino no momento da escrita, (DI_ecr ='1'))
              LVL_EX2  when adr2=EX_adr2  and EX_ecr2 = '1' else  -- Dependency with EX2 stage
              LVL_MEM2 when adr2=MEM_adr2 and MEM_ecr2 ='1' else  -- Dependency with MEM stage
              LVL_REG;                                               -- No dependency detected

    -- Elaboration of the signals with the datas form the bank registers
    read_data1 <= read_data1_GPR when adr1(5)='0' else       -- Selection of the internal registers
                  read_data1_SCP when adr1(5)='1' else       -- Selection of the coprocessor registers
                  (others => '0');
    read_data2 <= read_data2_GPR when adr2(5)='0' else       -- Selection of the internal registers   
                  read_data2_SCP when adr2(5)='1' else       -- Selection of the coprocessor registers
                  (others => '0');
    -- Bypass the datas (the validity is tested later when detecting the hazards)
    data1 <= read_data1 when dep_r1=LVL_REG  else -- DI recebe dado direto dos registradores
             MEM_data   when dep_r1=LVL_MEM  else -- DI recebe dado direto do MEM2 (MEM no original )
             MEM_data2  when dep_r1=LVL_MEM2 else -- DI recebe dado direto do MEM2 (MEM no original )
             EX_data    when dep_r1=LVL_EX   else -- DI recebe dado direto do EX2  (EX no original )
             EX_data2   when dep_r1=LVL_EX2  else -- DI recebe dado direto do EX2  (EX no original )
             DI_data    when dep_r1=LVL_DI   else
             DI_data2;				  -- DI recebe dado direto do DI2  (DI no original )
    data2 <= read_data2 when dep_r2=LVL_REG  else
             MEM_data   when dep_r2=LVL_MEM  else
             MEM_data2  when dep_r2=LVL_MEM2 else
             EX_data    when dep_r2=LVL_EX   else
             EX_data2   when dep_r2=LVL_EX2  else
             DI_data    when dep_r2=LVL_DI   else
             DI_data2;

    -- duplicação para o segundo pipe
	 
    -- Connexion of the writing command signals
    write_data2 <= MEM_data2;
    write_adr2 <= MEM_adr2(4 downto 0);
    write_GPR2 <= not MEM_adr2(5) and MEM_ecr2 when interrupt = '0' else  -- The high bit to 0 selects the internal registers
                 '0';
    --write_SCP <= MEM_adr(5) and MEM_ecr;      -- The high bit to 1 selects the coprocessor system registers

    -- Connexion of the writing command signals
    read_adr3 <= adr3(4 downto 0);            -- Connexion of the significative address bits (lido assincronamente pelo DI2)
    read_adr4 <= adr4(4 downto 0);            -- Connexion of the significative address bits (lido assincronamente pelo DI2)

    -- Evaluation of the level of dependencies
    dep_r3 <= LVL_REG  when adr3(4 downto 0)="00000" or use12='0' else -- No dependency with register 0, se use1 for igual a '0' aqui, significa que op1 = imm ou shamt
              LVL_DI   when adr3=DI_adr  and DI_ecr ='1' else         -- Dependency with DI stage (reg. fonte = reg.destino no momento da escrita, (DI_ecr ='1'))
              LVL_EX   when adr3=EX_adr  and EX_ecr ='1' else         -- Dependency with EX stage
              LVL_MEM  when adr3=MEM_adr and MEM_ecr='1' else         -- Dependency with MEM stage
              LVL_DI2  when adr3=DI_adr2  and DI_ecr2 = '1' else  -- Dependency with DI stage (reg. fonte = reg.destino no momento da escrita, (DI_ecr ='1'))
              LVL_EX2  when adr3=EX_adr2  and EX_ecr2 = '1' else  -- Dependency with EX stage
              LVL_MEM2 when adr3=MEM_adr2 and MEM_ecr2 ='1' else  -- Dependency with MEM stage
              LVL_REG;                                               -- No dependency detected
    dep_r4 <= LVL_REG  when adr4(4 downto 0)="00000" or use22='0' else -- No dependency with register 0
              LVL_DI   when adr4=DI_adr  and DI_ecr ='1' else         -- Dependency with DI stage
              LVL_EX   when adr4=EX_adr  and EX_ecr ='1' else         -- Dependency with EX stage
              LVL_MEM  when adr4=MEM_adr and MEM_ecr='1' else         -- Dependency with MEM stage
              LVL_DI2  when adr4=DI_adr2  and DI_ecr2 = '1' else  -- Dependency with DI2 stage (reg. fonte = reg.destino no momento da escrita, (DI_ecr ='1'))
              LVL_EX2  when adr4=EX_adr2  and EX_ecr2 = '1' else  -- Dependency with EX2 stage
              LVL_MEM2 when adr4=MEM_adr2 and MEM_ecr2 ='1' else  -- Dependency with MEM stage
              LVL_REG;                                               -- No dependency detected
    -- Elaboration of the signals with the datas form the bank registers
    read_data3 <= read_data3_GPR when adr3(5)='0' else       -- Selection of the internal registers
                  read_data3_SCP when adr3(5)='1' else       -- Selection of the coprocessor registers
                  (others => '0');

    read_data4 <= read_data4_GPR when adr4(5)='0' else       -- Selection of the internal registers   
                  read_data4_SCP when adr4(5)='1' else       -- Selection of the coprocessor registers
                  (others => '0');

    -- Bypass the datas (the validity is tested later when detecting the hazards) Dar a volta dos dados(a validade é testada posteriormente ao detectar os hazards)
    data3 <= read_data3 when dep_r3=LVL_REG  else -- DI recebe dado direto dos registradores
             MEM_data   when dep_r3=LVL_MEM  else -- DI recebe dado direto do MEM2 (MEM no original )
             MEM_data2  when dep_r3=LVL_MEM2 else -- DI recebe dado direto do MEM2 (MEM no original )
             EX_data    when dep_r3=LVL_EX   else -- DI recebe dado direto do EX2  (EX no original )
             EX_data2   when dep_r3=LVL_EX2  else -- DI recebe dado direto do EX2  (EX no original )
             DI_data    when dep_r3=LVL_DI   else
             DI_data2;				  -- DI recebe dado direto do DI2  (DI no original )
    data4 <= read_data4 when dep_r4=LVL_REG  else
             MEM_data   when dep_r4=LVL_MEM  else
             MEM_data2  when dep_r4=LVL_MEM2 else
             EX_data    when dep_r4=LVL_EX   else
             EX_data2   when dep_r4=LVL_EX2  else
             DI_data    when dep_r4=LVL_DI   else
             DI_data2;

    -- Detection of a potential unresolved hazard
    -- '1' significa que os dados estao atualizados,
    -- '0' nao, os dados ainda serao escritos			       <<< dep neste sentido nao eh hazard <<< dados repassado por forwarding ou bypassing para o DI/DI2
    res_reg <= '1'; --This hazard is always resolved LVL_REG=0  	 ________ _______ _______ _______
    res_mem <= '1' when MEM_level>=LVL_MEM else '0'; -- >= 1		| 3      | 2     | 1     | 0     |
    res_ex  <= '1' when EX_level >=LVL_EX  else '0'; -- >= 2		|   DI   |   EX  |  MEM  |  REG  |
    res_di  <= '1' when DI_level >=LVL_DI  else '0'; -- >= 3		|________|_______|_______|_______|___
    res_mem2 <= '1' when MEM_level2>=LVL_MEM2 else '0'; -- >= 4		  | 6      | 5     | 4     | 0     |
    res_ex2  <= '1' when EX_level2 >=LVL_EX2  else '0'; -- >= 5		  |   DI2  |  EX2  |  MEM2 |  REG  |
    res_di2  <= '1' when DI_level2 >=LVL_DI2  else '0'; -- >= 6		  |________|_______|_______|_______|
--    						     --                                 >>> dep neste sentido eh hazard  >>> espera o proximo ciclo para entrar novamente no DI/DI2
    -- Table defining the resolved hazard for each stage
    resolution <= res_di2 & res_ex2 & res_mem2 & res_di & res_ex & res_mem & res_reg; -- '1111111', se nao ocorrer hazard
    -- Verification of the validity of the transmitted datas (test the good resolution of the hazards)
    idx1 <= to_integer(unsigned(dep_r1(2 downto 0)));
    idx2 <= to_integer(unsigned(dep_r2(2 downto 0)));
    idx3 <= to_integer(unsigned(dep_r3(2 downto 0)));
    idx4 <= to_integer(unsigned(dep_r4(2 downto 0)));

    alea  <= (not resolution(idx1) or not resolution(idx2));
    alea2 <= (not resolution(idx3) or not resolution(idx4));
	 
end rtl;
