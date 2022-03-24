--------------------------------------------------------------------------
--                                                                      --
--                                                                      --
-- miniMIPS Superscalar Processor : miniMIPS Superscalar processor      --
-- based on miniMIPS Processor                                          --
--                                                                      --
--                                                                      --
-- Author : Miguel Cafruni                                              --
-- miguel_cafruni@hotmail.com                                           --
--                                                      December 2018   --
--------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

library work;
use work.pack_mips.all;

entity minimips is
port (
    clock    : in std_logic;
    clock2   : in std_logic;
    reset    : in std_logic;

    -- Ram connexion
    ram_req  : out std_logic;
    ram_adr  : out bus32;
    ram_r_w  : out std_logic;
    ram_data : inout bus32;
    ram_ack  : in std_logic;

    ram_req2  : out std_logic;
    ram_adr2  : out bus32;
    ram_r_w2  : out std_logic;
    ram_data2 : inout bus32;
    ram_ack2  : in std_logic;

    -- Hardware interruption
    it_mat   : in std_logic
);
end minimips;

architecture rtl of minimips is

    -- General signals
    signal stop_all : std_logic;            -- Lock the pipeline evolution
    signal stop_all2 : std_logic;           -- Lock the pipeline evolution
	 
    signal it_mat_clk : std_logic;          -- Synchronised hardware interruption
    signal stop_pf : std_logic;             -- Lock the pc
    signal stop_pf2 : std_logic;            -- Lock the pc
    signal genop : std_logic;               -- envoi de nops
    signal genop2 : std_logic;              -- envoi de nops
    -- interface PF - EI
    signal PF_pc : bus32;                   -- PC value
    signal PF_pc_4 : bus32; 

    -- interface Controler - EI
    signal CTE_instr : bus32;               -- Instruction from the memory
    signal ETC_adr : bus32;                 -- Address to read in memory

    -- interface Controler - EI2
    signal CTE_instr2 : bus32;               -- Instruction from the memory
    signal ETC_adr2 : bus32;                 -- Address to read in memory
	 
    -- interface EI - DI
    signal EI_instr : bus32;                -- Read interface
    signal EI_adr : bus32;                  -- Address from the read instruction
    signal EI_it_ok : std_logic;            -- Allow hardware interruptions
	 
    -- interface EI2 - DI2
    signal EI_instr2 : bus32;                -- Read interface
    signal EI_adr2 : bus32;                  -- Address from the read instruction
    signal EI_it_ok2 : std_logic;            -- Allow hardware interruptions
	 
    -- DI output
    signal bra_detect : std_logic;          -- Branch detection in the current instruction

    -- DI2 output
    signal bra_detect2 : std_logic;          -- Branch detection in the current instruction
	 
    -- Asynchronous connexion with the bypass unit
    signal adr_reg1 : adr_reg_type;         -- Operand 1 address
    signal adr_reg2 : adr_reg_type;         -- Operand 2 address
    signal use1 : std_logic;                -- Operand 1 utilisation
    signal use2 : std_logic;                -- Operand 2 utilisation
    signal data1 : bus32;                   -- First register value
    signal data2 : bus32;                   -- Second register value
    signal alea : std_logic;                -- Unresolved hazards detected

    -- Asynchronous connexion with the bypass unit
    signal adr_reg3 : adr_reg_type;         -- Operand 1 address
    signal adr_reg4 : adr_reg_type;         -- Operand 2 address
    signal use3 : std_logic;                -- Operand 3 utilisation
    signal use4 : std_logic;                -- Operand 4 utilisation
    signal data3 : bus32;                   -- 3th register value
    signal data4 : bus32;                   -- 4th register value
    signal alea2 : std_logic;                -- Unresolved hazards detected 2nd pipe
	 
    -- interface DI - EX
    signal DI_bra : std_logic;              -- Branch decoded                                        
    signal DI_link : std_logic;             -- A link for that instruction                           
    signal DI_op1 : bus32;                  -- operand 1 for alu                                     
    signal DI_op2 : bus32;                  -- operand 2 for alu                                     
    signal DI_code_ual : alu_ctrl_type;     -- Alu operation                                         
    signal DI_offset : bus32;               -- Offset for the address calculation                    
    signal DI_adr_reg_dest : adr_reg_type;  -- Address of the destination register of the result     
    signal DI_ecr_reg : std_logic;          -- Effective writing of the result                       
    signal DI_mode : std_logic;             -- Address mode (relative to pc or indexed to a register)
    signal DI_op_mem : std_logic;           -- Memory operation request                              
    signal DI_r_w : std_logic;              -- Type of memory operation (reading or writing)         
    signal DI_adr : bus32;                  -- Address of the decoded instruction                    
    signal DI_exc_cause : bus32;            -- Potential exception detected                          
    signal DI_level : level_type;           -- Availability of the result for the data bypass        
    signal DI_it_ok : std_logic;            -- Allow hardware interruptions
 
    -- interface DI2 - EX2
    signal DI_bra2 : std_logic;              -- Branch decoded                                        
    signal DI_link2 : std_logic;             -- A link for that instruction                           
    signal DI_op3 : bus32;                  -- operand 1 for alu 2                                     
    signal DI_op4 : bus32;                  -- operand 2 for alu 2                                    
    signal DI_code_ual2 : alu_ctrl_type;     -- Alu operation                                         
    signal DI_offset2 : bus32;               -- Offset for the address calculation                    
    signal DI_adr_reg_dest2 : adr_reg_type;  -- Address of the destination register of the result     
    signal DI_ecr_reg2 : std_logic;          -- Effective writing of the result                       
    signal DI_mode2 : std_logic;             -- Address mode (relative to pc or indexed to a register)
    signal DI_op_mem2 : std_logic;           -- Memory operation request                              
    signal DI_r_w2 : std_logic;              -- Type of memory operation (reading or writing)         
    signal DI_adr2 : bus32;                  -- Address of the decoded instruction                    
    signal DI_exc_cause2 : bus32;            -- Potential exception detected                          
    signal DI_level2 : level_type;           -- Availability of the result for the data bypass        
    signal DI_it_ok2 : std_logic;            -- Allow hardware interruptions 
	 
    -- interface EX - MEM
    signal EX_adr : bus32;                  -- Instruction address                       
    signal EX_bra_confirm : std_logic;      -- Branch execution confirmation             
    signal EX_data_ual : bus32;             -- Ual result                                
    signal EX_adresse : bus32;              -- Address calculation result    
    signal ex_adresse_p1p2_s  : bus32;      -- resultado do calculo do endereco do desvio + 4 para pipe 2          
    signal EX_adr_reg_dest : adr_reg_type;  -- Destination register for the result       
    signal EX_ecr_reg : std_logic;          -- Effective writing of the result           
    signal EX_op_mem : std_logic;           -- Memory operation needed                   
    signal EX_r_w : std_logic;              -- Type of memory operation (read or write)  
    signal EX_exc_cause : bus32;            -- Potential cause exception                 
    signal EX_level : level_type;           -- Availability stage of result for bypassing
    signal EX_it_ok : std_logic;            -- Allow hardware interruptions

    -- interface EX2 - MEM
    signal EX_adr2 : bus32;                  -- Instruction address                       
    signal EX_bra_confirm2 : std_logic;      -- Branch execution confirmation             
    signal EX_data_ual2 : bus32;             -- Ual result                                
    signal EX_adresse2 : bus32;              -- Address calculation result   
    signal ex_adresse_p2p1_s  : bus32;       -- resultado do calculo do endereco do desvio + 4 para pipe 1        
    signal EX_adr_reg_dest2 : adr_reg_type;  -- Destination register for the result       
    signal EX_ecr_reg2 : std_logic;          -- Effective writing of the result           
    signal EX_op_mem2 : std_logic;           -- Memory operation needed                   
    signal EX_r_w2 : std_logic;              -- Type of memory operation (read or write)  
    signal EX_exc_cause2 : bus32;            -- Potential cause exception                 
    signal EX_level2 : level_type;           -- Availability stage of result for bypassing
    signal EX_it_ok2 : std_logic;            -- Allow hardware interruptions
 
    -- interface Controler - MEM
    signal MTC_data : bus32;                -- Data to write in memory 
    signal MTC_adr : bus32;                 -- Address for memory      
    signal MTC_r_w : std_logic;             -- Read/Write in memory    
    signal MTC_req : std_logic;             -- Request access to memory
    signal CTM_data : bus32;                -- Data from memory        

    -- interface Controler2 - MEM
    signal MTC_data2 : bus32;                -- Data to write in memory 
    signal MTC_adr2 : bus32;                 -- Address for memory      
    signal MTC_r_w2 : std_logic;             -- Read/Write in memory    
    signal MTC_req2 : std_logic;             -- Request access to memory
    signal CTM_data2 : bus32;                -- Data from memory  
	 
    -- interface MEM - REG
    signal MEM_adr : bus32;                 -- Instruction address                            
    signal MEM_adr_reg_dest : adr_reg_type; -- Destination register address                   
    signal MEM_ecr_reg : std_logic;         -- Writing of the destination register            
    signal MEM_data_ecr : bus32;            -- Data to write (from alu or memory)             
    signal MEM_exc_cause : bus32;           -- Potential exception cause                      
    signal MEM_level : level_type;          -- Availability stage for the result for bypassing
    signal MEM_it_ok : std_logic;           -- Allow hardware interruptions
                                            
    -- connexion to the register banks

      -- Writing commands in the register banks
    signal write_data : bus32;              -- Data to write                                
    signal write_adr : bus5;                -- Address of the register to write             
    signal write_GPR : std_logic;           -- Selection in the internal registers          
    signal write_SCP : std_logic;           -- Selection in the coprocessor system registers

      -- Reading commands for Reading in the registers
    signal read_adr1 : bus5;                -- Address of the first register to read
    signal read_adr2 : bus5;                -- Address of the second register to read
    signal read_data1_GPR : bus32;          -- Value of operand 1 from the internal registers
    signal read_data1_SCP : bus32;          -- Value of operand 2 from the internal registers
    signal read_data2_GPR : bus32;          -- Value of operand 1 from the coprocessor system registers
    signal read_data2_SCP : bus32;          -- Value of operand 2 from the coprocessor system registers

    -- interface MEM - REG duplicado as entradas e saidas do REG
    signal MEM_adr2 : bus32;                 -- Instruction address                            
    signal MEM_adr_reg_dest2 : adr_reg_type; -- Destination register address                   
    signal MEM_ecr_reg2 : std_logic;         -- Writing of the destination register            
    signal MEM_data_ecr2 : bus32;            -- Data to write (from alu or memory)             
    signal MEM_exc_cause2 : bus32;           -- Potential exception cause                      
    signal MEM_level2 : level_type;          -- Availability stage for the result for bypassing
    signal MEM_it_ok2 : std_logic;           -- Allow hardware interruptions
                                            
    -- connexion to the register banks

      -- Writing commands in the register banks
    signal write_data2 : bus32;              -- Data to write                                
    signal write_adr2 : bus5;                -- Address of the register to write             
    signal write_GPR2 : std_logic;           -- Selection in the internal registers          
    --signal write_SCP2 : std_logic;           -- Selection in the coprocessor system registers

      -- Reading commands for Reading in the registers
    signal read_adr3 : bus5;                -- Address of the first register to read
    signal read_adr4 : bus5;                -- Address of the second register to read
    signal read_data3_GPR : bus32;          -- Value of operand 1 from the internal registers
    signal read_data3_SCP : bus32;          -- Value of operand 2 from the internal registers
    signal read_data4_GPR : bus32;          -- Value of operand 1 from the coprocessor system registers
    signal read_data4_SCP : bus32;          -- Value of operand 2 from the coprocessor system registers
    -- Interruption controls
    signal interrupt     : std_logic;       -- Interruption to take into account
    signal vecteur_it    : bus32;           -- Interruption vector         

    -- Sinais atrasados meio ciclo
    signal DI_bra_D          : std_logic;
    signal bra_detect_D      : std_logic;
    signal EX_bra_confirm_D  : std_logic;
    signal alea_D 	        : std_logic;
    signal alea2_D 	        : std_logic;
    signal EX_bra_confirm2_D : std_logic;
    signal bra_detect2_D     : std_logic;
    signal DI_bra2_D 	     : std_logic;
    signal iload_D           : bus1; -- sem uso atual
    signal istore_D 			  : bus1;
    signal istore2_D 		  : bus1;
	 -- 
    signal istore            : bus1;
    signal iload             : bus1; -- sem uso atual
    signal istore2  			  : bus1;
    signal branch1	        : std_logic;
    signal branch2	        : std_logic;
    signal bra_adr_s         : bus32;
    signal bra_adr2_s        : bus32;
    signal aleaEI 			  : bus1;
    signal aleaDI            : bus1;
    signal alea2EI2			  : bus1;
    signal alea2DI2			  : bus1;
    signal ex2_data_hilo	  : bus64;--resultado da multiplicacao do pieline2 14-12-18
    signal ex_data_hilo 	  : bus64;--resultado da multiplicacao do pieline1
begin
    
    aleaEI  <= alea  or alea2_D;
    aleaDI  <= alea  or alea2_D;
    alea2EI2 <= alea2 or alea_D;
    alea2DI2 <= alea2 or alea_D;

    stop_pf  <= DI_bra or DI_bra2_D or bra_detect or bra_detect2_D or alea or alea2_D or istore2 or istore2_D;
    genop    <= bra_detect or bra_detect2_D or EX_bra_confirm  or EX_bra_confirm2_D or DI_bra or DI_bra2_D  or istore2 or istore2_D;

    stop_pf2 <= DI_bra2 or DI_bra_D or bra_detect2 or bra_detect_D or alea2 or alea_D or istore or istore_D;
    genop2   <= bra_detect2 or bra_detect_D or EX_bra_confirm2 or EX_bra_confirm_D or DI_bra2 or DI_bra_D or istore or istore_D;

    branch1 <= EX_bra_confirm  or EX_bra_confirm2_D;
    branch2 <= EX_bra_confirm2 or EX_bra_confirm_D;

    -- muxes para selecionar o endereco do branh apropriado 12-08-2018
    with EX_bra_confirm2_D select
	 bra_adr_s <= ex_adresse_p2p1_s when '1',
		      EX_adresse  when others;
    with EX_bra_confirm_D select
	 bra_adr2_s <= ex_adresse_p1p2_s when '1',
		       EX_adresse2  when others;

    -- Take into account the hardware interruption on rising edge
    process (clock)
    begin
        if clock='1' and clock'event then
            it_mat_clk <= it_mat;
        end if;
    end process;

    U1_pf : pps_pf port map (
        clock => clock,
	     clock2 => clock2,
        reset => reset,
        stop_all => stop_all,               -- Unconditionnal locking of the pipeline stage
	     stop_all2 => stop_all2,  
        -- entrees asynchrones
        bra_adr => bra_adr_s,--EX_adresse,              -- Branch
        bra_cmd => branch1,          -- Address to load when an effective branch
        exch_adr => vecteur_it,             -- Exception branch
        exch_cmd => interrupt,              -- Exception vector
        -- entrees asynchrones 24\03\18
        bra_adr2 => bra_adr2_s,-- EX_adresse2,              -- Branch
        bra_cmd2 => branch2,          -- Address to load when an effective branch
        exch_adr2 => vecteur_it,             -- Exception branch
        exch_cmd2 => interrupt,              -- Exception vector
        -- Lock the stage                                    
        stop_pf => stop_pf,                 
	     stop_pf2 => stop_pf2,--estava errado 'stop_pf' corrigido em 03-04-18
        -- Synchronous output to EI stage
        PF_pc => PF_pc,                     -- PC value
	     PF_pc_4 => PF_pc_4
    );


    U2_ei : pps_ei port map (
        clock => clock,
        reset => reset,
        clear => interrupt,         -- Clear the pipeline stage                      
        stop_all => stop_all,       -- Evolution locking signal                      
                                                                              
        -- Asynchronous inputs
        stop_ei => aleaEI,            -- Lock the EI_adr and Ei_instr registers        
        genop => genop,             -- Send nops                                     
                                                                              
        -- interface Controler - EI
        CTE_instr => CTE_instr,     -- Instruction from the memory                   
        ETC_adr => ETC_adr,         -- Address to read in memory                     
                                                                              
        -- Synchronous inputs from PF stage
        PF_pc => PF_pc,             -- Current value of the pc                       
                                                                              
        -- Synchronous outputs to DI stage
        EI_instr => EI_instr,       -- Read interface                                
        EI_adr => EI_adr,           -- Address from the read instruction             
        EI_it_ok => EI_it_ok        -- Allow hardware interruptions
    );


    U3_di : pps_di port map (
        clock => clock,
        reset => reset,
        stop_all => stop_all,               -- Unconditionnal locking of the outputs
        clear => interrupt,                 -- Clear the pipeline stage (nop in the outputs)
                                                                                                      
        -- Asynchronous outputs
        bra_detect => bra_detect,           -- Branch detection in the current instruction
                                                                                                      
        -- Asynchronous connexion with the register management and data bypass unit
        adr_reg1 => adr_reg1,               -- Address of the first register operand
        adr_reg2 => adr_reg2,               -- Address of the second register operand
        use1 => use1,                       -- Effective use of operand 1
        use2 => use2,                       -- Effective use of operand 2
        --iload => iload,  
	     istore => istore,                                                                                                    
        stop_di => aleaDI,                    -- Unresolved detected : send nop in the pipeline
        data1 => data1,                     -- Operand register 1
        data2 => data2,                     -- Operand register 2
                                                                                                      
        -- Datas from EI stage
        EI_adr => EI_adr,                   -- Address of the instruction
        EI_instr => EI_instr,               -- The instruction to decode
        EI_it_ok => EI_it_ok,               -- Allow hardware interruptions
                                                                                                      
        -- Synchronous output to EX stage
        DI_bra => DI_bra,                   -- Branch decoded 
        DI_link => DI_link,                 -- A link for that instruction
        DI_op1 => DI_op1,                   -- operand 1 for alu
        DI_op2 => DI_op2,                   -- operand 2 for alu
        DI_code_ual => DI_code_ual,         -- Alu operation
        DI_offset => DI_offset,             -- Offset for the address calculation
        DI_adr_reg_dest => DI_adr_reg_dest, -- Address of the destination register of the result
        DI_ecr_reg => DI_ecr_reg,           -- Effective writing of the result
        DI_mode => DI_mode,                 -- Address mode (relative to pc or indexed to a register)
        DI_op_mem => DI_op_mem,             -- Memory operation request
        DI_r_w => DI_r_w,                   -- Type of memory operation (reading or writing)
        DI_adr => DI_adr,                   -- Address of the decoded instruction
        DI_exc_cause => DI_exc_cause,       -- Potential exception detected
        DI_level => DI_level,               -- Availability of the result for the data bypass
        DI_it_ok => DI_it_ok                -- Allow hardware interruptions
    );


    U4_ex : pps_ex port map (
        clock => clock,
        clock2 => clock2,
        reset => reset,
        stop_all => stop_all,
        stop_all2 => stop_all2,               -- Unconditionnal locking of outputs
        clear => interrupt,                 -- Clear the pipeline stage
                                                                                                    
        -- Datas from DI stage
        DI_bra => DI_bra,                   -- Branch instruction
        DI_link => DI_link,                 -- Branch with link
        DI_op1 => DI_op1,                   -- Operand 1 for alu
        DI_op2 => DI_op2,                   -- Operand 2 for alu
        DI_code_ual => DI_code_ual,         -- Alu operation
        DI_offset => DI_offset,             -- Offset for address calculation
        DI_adr_reg_dest => DI_adr_reg_dest, -- Destination register address for the result
        DI_ecr_reg => DI_ecr_reg,           -- Effective writing of the result
        DI_mode => DI_mode,                 -- Address mode (relative to pc ou index by a register)
        DI_op_mem => DI_op_mem,             -- Memory operation
        DI_r_w => DI_r_w,                   -- Type of memory operation (read or write)
        DI_adr => DI_adr,                   -- Instruction address
        DI_exc_cause => DI_exc_cause,       -- Potential cause exception
        DI_level => DI_level,               -- Availability stage of the result for bypassing
        DI_it_ok => DI_it_ok,               -- Allow hardware interruptions
		  EX2_data_hilo =>  ex2_data_hilo,    -- entrada p resultado do hilo p2  
	     EX_data_hilo =>   ex_data_hilo,     -- saida p resultado do hilo p1                                                                                                     
        -- Synchronous outputs to MEM stage
        EX_adr => EX_adr,                   -- Instruction address
        EX_bra_confirm => EX_bra_confirm,   -- Branch execution confirmation
        EX_data_ual => EX_data_ual,         -- Ual result
        EX_adresse => EX_adresse,           -- Address calculation result
        EX_adresse_p1p2 => ex_adresse_p1p2_s, --resultado do calculo do endereco do desvio + 4 para pipe 2. 12-08-2018
        EX_adr_reg_dest => EX_adr_reg_dest, -- Destination register for the result
        EX_ecr_reg => EX_ecr_reg,           -- Effective writing of the result
        EX_op_mem => EX_op_mem,             -- Memory operation needed
        EX_r_w => EX_r_w,                   -- Type of memory operation (read or write)
        EX_exc_cause => EX_exc_cause,       -- Potential cause exception
        EX_level => EX_level,               -- Availability stage of result for bypassing
        EX_it_ok => EX_it_ok                -- Allow hardware interruptions
    );


    U5_mem : pps_mem port map (
        clock => clock,
	     clock2 => clock2,
        reset => reset,
        stop_all => stop_all,               -- Unconditionnal locking of the outputs
	     stop_all2 => stop_all2,
		  
        clear => interrupt,                 -- Clear the pipeline stage
                                                                                               
        -- Interface with the control bus
        MTC_data => MTC_data,               -- Data to write in memory
        MTC_adr => MTC_adr,                 -- Address for memory
        MTC_r_w => MTC_r_w,                 -- Read/Write in memory
        MTC_req => MTC_req,                 -- Request access to memory
        CTM_data => CTM_data,               -- Data from memory
                                                                                               
        -- Datas from Execution stage
        EX_adr => EX_adr,                   -- Instruction address
        EX_data_ual => EX_data_ual,         -- Result of alu operation
        EX_adresse => EX_adresse,           -- Result of the calculation of the address
        EX_adresse_p1p2 => ex_adresse_p1p2_s, --resultado do calculo do endereco do desvio + 4 para pipe 2. 12-08-2018
	     EX_bra_confirm => EX_bra_confirm,   -- Confirmacao do branch no pipe 1 (26-07-18)
        EX_adr_reg_dest => EX_adr_reg_dest, -- Destination register address for the result
        EX_ecr_reg => EX_ecr_reg,           -- Effective writing of the result
        EX_op_mem => EX_op_mem,             -- Memory operation needed
        EX_r_w => EX_r_w,                   -- Type of memory operation (read or write)
        EX_exc_cause => EX_exc_cause,       -- Potential exception cause
        EX_level => EX_level,               -- Availability stage for the result for bypassing
        EX_it_ok => EX_it_ok,               -- Allow hardware interruptions
                                                                                               
        -- Synchronous outputs for bypass unit
        MEM_adr => MEM_adr,                 -- Instruction address
        MEM_adr_reg_dest=>MEM_adr_reg_dest, -- Destination register address
        MEM_ecr_reg => MEM_ecr_reg,         -- Writing of the destination register
        MEM_data_ecr => MEM_data_ecr,       -- Data to write (from alu or memory)
        MEM_exc_cause => MEM_exc_cause,     -- Potential exception cause
        MEM_level => MEM_level,             -- Availability stage for the result for bypassing
        MEM_it_ok => MEM_it_ok,             -- Allow hardware interruptions
	     -- duplicacao
        -- Interface with the control bus
        MTC_data2 => MTC_data2,               -- Data to write in memory
        MTC_adr2 => MTC_adr2,                 -- Address for memory
        MTC_r_w2 => MTC_r_w2,                 -- Read/Write in memory
        MTC_req2 => MTC_req2,                 -- Request access to memory
        CTM_data2 => CTM_data2,               -- Data from memory
                                                                                               
        -- Datas from Execution 2 stage
        EX_adr2 => EX_adr2,                   -- Instruction address
        EX_data_ual2 => EX_data_ual2,         -- Result of alu operation
        EX_adresse2 => EX_adresse2,           -- Result of the calculation of the address
        EX_adresse_p2p1 => ex_adresse_p2p1_s, --resultado do calculo do endereco do desvio + 4 para pipe 1. 12-08-2018
	     EX_bra_confirm2 => EX_bra_confirm2,   -- Confirmacao do branch no pipe 2 (26-07-18)
        EX_adr_reg_dest2 => EX_adr_reg_dest2, -- Destination register address for the result
        EX_ecr_reg2 => EX_ecr_reg2,           -- Effective writing of the result
        EX_op_mem2 => EX_op_mem2,             -- Memory operation needed
        EX_r_w2 => EX_r_w2,                   -- Type of memory operation (read or write)
        EX_exc_cause2 => EX_exc_cause2,       -- Potential exception cause
        EX_level2 => EX_level2,               -- Availability stage for the result for bypassing
        EX_it_ok2 => EX_it_ok2,               -- Allow hardware interruptions
                                                                                               
        -- Synchronous outputs for bypass unit
        MEM_adr2 => MEM_adr2,                 -- Instruction address
        MEM_adr_reg_dest2=>MEM_adr_reg_dest2, -- Destination register address
        MEM_ecr_reg2 => MEM_ecr_reg2,         -- Writing of the destination register
        MEM_data_ecr2 => MEM_data_ecr2,       -- Data to write (from alu or memory)
        MEM_exc_cause2 => MEM_exc_cause2,     -- Potential exception cause
        MEM_level2 => MEM_level2,             -- Availability stage for the result for bypassing
        MEM_it_ok2 => MEM_it_ok2             -- Allow hardware interruptions
    );


    U6_renvoi : renvoi port map (
        -- Register access signals
        adr1 => adr_reg1,                   -- Operand 1 address
        adr2 => adr_reg2,                   -- Operand 2 address
        use1 => use1,                       -- Operand 1 utilisation
        use2 => use2,                       -- Operand 2 utilisation
                                                                                                        
        data1 => data1,                     -- First register value
        data2 => data2,                     -- Second register value
        alea => alea,                       -- Unresolved hazards detected
                                                                                           
        -- Bypass signals of the intermediary datas
        DI_level => DI_level,               -- Availability level of the data
        DI_adr => DI_adr_reg_dest,          -- Register destination of the result
        DI_ecr => DI_ecr_reg,               -- Writing register request
        DI_data => DI_op2,                  -- Data to used
                                                                                                        
        EX_level => EX_level,               -- Availability level of the data
        EX_adr => EX_adr_reg_dest,          -- Register destination of the result
        EX_ecr => EX_ecr_reg,               -- Writing register request
        EX_data => EX_data_ual,             -- Data to used
                                                                                                        
        MEM_level => MEM_level,             -- Availability level of the data
        MEM_adr => MEM_adr_reg_dest,        -- Register destination of the result
        MEM_ecr => MEM_ecr_reg,             -- Writing register request
        MEM_data => MEM_data_ecr,           -- Data to used
                                                                                                        
        interrupt => interrupt,             -- Exceptions or interruptions
                                                                                                        
        -- Connexion to the differents bank of register

          -- Writing commands for writing in the registers
        write_data => write_data,           -- Data to write
        write_adr => write_adr,             -- Address of the register to write
        write_GPR => write_GPR,             -- Selection in the internal registers
        write_SCP => write_SCP,             -- Selection in the coprocessor system registers
                                                                                                        
          -- Reading commands for Reading in the registers
        read_adr1 => read_adr1,             -- Address of the first register to read
        read_adr2 => read_adr2,             -- Address of the second register to read
        read_data1_GPR => read_data1_GPR,   -- Value of operand 1 from the internal registers
        read_data1_SCP => read_data1_SCP,   -- Value of operand 2 from the internal registers
        read_data2_GPR => read_data2_GPR,   -- Value of operand 1 from the coprocessor system registers
        read_data2_SCP => read_data2_SCP,    -- Value of operand 2 from the coprocessor system registers
	     -- duplicacao
        -- Register access signals
        adr3 => adr_reg3,                   -- Operand 1 address
        adr4 => adr_reg4,                   -- Operand 2 address
        use12 => use3,                       -- Operand 1 utilisation
        use22 => use4,                       -- Operand 2 utilisation
                                                                                                        
        data3 => data3,                     -- First register value
        data4 => data4,                     -- Second register value
        alea2 => alea2,                       -- Unresolved hazards detected

        -- Bypass signals of the intermediary datas
        DI_level2 => DI_level2,               -- Availability level of the data
        DI_adr2 => DI_adr_reg_dest2,          -- Register destination of the result
        DI_ecr2 => DI_ecr_reg2,               -- Writing register request
        DI_data2 => DI_op4,                  -- Data to used
                                                                                                        
        EX_level2 => EX_level2,               -- Availability level of the data
        EX_adr2 => EX_adr_reg_dest2,          -- Register destination of the result
        EX_ecr2 => EX_ecr_reg2,               -- Writing register request
        EX_data2 => EX_data_ual2,             -- Data to used
                                                                                                        
        MEM_level2 => MEM_level2,             -- Availability level of the data
        MEM_adr2 => MEM_adr_reg_dest2,        -- Register destination of the result
        MEM_ecr2 => MEM_ecr_reg2,             -- Writing register request
        MEM_data2 => MEM_data_ecr2,           -- Data to used                                                                                      
                                                                                                        
        -- Connexion to the differents bank of register

          -- Writing commands for writing in the registers
        write_data2 => write_data2,           -- Data to write
        write_adr2 => write_adr2,             -- Address of the register to write
        write_GPR2 => write_GPR2,             -- Selection in the internal registers
        --write_SCP2 => write_SCP,             -- Selection in the coprocessor system registers
                                                                                                        
          -- Reading commands for Reading in the registers
        read_adr3 => read_adr3,             -- Address of the first register to read
        read_adr4 => read_adr4,             -- Address of the second register to read
        read_data3_GPR => read_data3_GPR,   -- Value of operand 1 from the internal registers
        read_data3_SCP => read_data3_SCP,   -- Value of operand 2 from the internal registers
        read_data4_GPR => read_data4_GPR,   -- Value of operand 1 from the coprocessor system registers
        read_data4_SCP => read_data4_SCP    -- Value of operand 2 from the coprocessor system registers
    );


    U7_banc : banc port map(
        clock => clock,
	     clock2 => clock2,
        reset => reset,

        -- Register addresses to read
        reg_src1 => read_adr1,
        reg_src2 => read_adr2,

        -- Register address to write and its data
        reg_dest => write_adr,
        donnee   => write_data,

        -- Write signal
        cmd_ecr  => write_GPR,

        -- Bank outputs
        data_src1 => read_data1_GPR,
        data_src2 => read_data2_GPR,

        -- Register addresses to read
        reg_src3 => read_adr3,
        reg_src4 => read_adr4,

        -- Register address to write and its data
        reg_dest2 => write_adr2,
        donnee2   => write_data2,

        -- Write signal
        cmd_ecr2  => write_GPR2,

        -- Bank outputs
        data_src3 => read_data3_GPR,
        data_src4 => read_data4_GPR
    );


    U8_syscop : syscop port map (
        clock         => clock,
        reset         => reset,

        -- Datas from the pipeline
        MEM_adr       => MEM_adr,           -- Address (PC) of the current instruction in the pipeline end -> responsible of the exception
        MEM_exc_cause => MEM_exc_cause,     -- Potential cause exception of that instruction
        MEM_it_ok     => MEM_it_ok,         -- Allow hardware interruptions
                                                                                                                                      
        -- Hardware interruption
        it_mat        => it_mat_clk,        -- Hardware interruption detected
                                                                                                                                      
        -- Interruption controls
        interrupt     => interrupt,         -- Interruption to take into account
        vecteur_it    => vecteur_it,        -- Interruption vector
                                                                                                                                      
        -- Writing request in register bank
        write_data    => write_data,        -- Data to write
        write_adr     => write_adr,         -- Address of the register to write
        write_SCP     => write_SCP,         -- Writing request
                                                                                                                                      
        -- Reading request in register bank
        read_adr1     => read_adr1,         -- Address of the first register
        read_adr2     => read_adr2,         -- Address of the second register
        read_data1    => read_data1_SCP,    -- Value of register 1
        read_data2    => read_data2_SCP,     -- Value of register 2
        --mod
	     MEM_adr2       => MEM_adr2, 
	     MEM_exc_cause2 => MEM_exc_cause2,   
	     MEM_it_ok2     => MEM_it_ok2,

	     write_data2    => write_data2,   
	     write_adr2     => write_adr2, 
	     write_SCP2     => zero,

	     read_adr3     => read_adr3,
	     read_adr4     => read_adr4,
		  read_data3    => read_data3_SCP,
	     read_data4    => read_data4_SCP
    );


    U9_bus_ctrl01 : bus_ctrl01 port map (
        clock          => clock,
        reset          => reset,

        -- Interruption in the pipeline
        interrupt      => interrupt,

        -- Interface for the Instruction Extraction Stage
        adr_from_ei    => ETC_adr,          -- The address of the data to read
        instr_to_ei    => CTE_instr,        -- Instruction from the memory                                                      
        -- Interface with the MEMory Stage
        req_from_mem   => MTC_req,          -- Request to access the ram
        r_w_from_mem   => MTC_r_w,          -- Read/Write request
        adr_from_mem   => MTC_adr,          -- Address in ram
        data_from_mem  => MTC_data,         -- Data to write in ram
        data_to_mem    => CTM_data,         -- Data from the ram to the MEMory stage	  
                                                                                     
        -- RAM interface signals
        req_to_ram     => ram_req,          -- Request to ram
        adr_to_ram     => ram_adr,          -- Address of the data to read or write
        r_w_to_ram     => ram_r_w,          -- Read/Write request
        ack_from_ram   => ram_ack,          -- Acknowledge from the memory
        data_inout_ram => ram_data,         -- Data from/to the memory

        -- Pipeline progress control signal
        stop_all       => stop_all
    );


    U10_ei_2 :  pps_ei_2 port map (
	     clock => clock2,
        reset => reset,
        clear => interrupt,         -- Clear the pipeline stage                      
        stop_all2 => stop_all2,       -- Evolution locking signal                      
                                                                              
        -- Asynchronous inputs
        stop_ei => alea2EI2,            -- Lock the EI_adr and Ei_instr registers        
        genop => genop2,             -- Send nops                                     
                                                                              
        -- interface Controler - EI
        CTE_instr => CTE_instr2,     -- Instruction from the memory                   
        ETC_adr => ETC_adr2,         -- Address to read in memory (ja feito pelo EI)                     
                                                                              
        -- Synchronous inputs from PF stage
        PF_pc => PF_pc_4,             -- Current value of the pc + 4                     
                                                                              
        -- Synchronous outputs to DI stage
        EI_instr => EI_instr2,       -- Read interface                                
        EI_adr => EI_adr2,           -- Address from the read instruction             
        EI_it_ok => EI_it_ok2        -- Allow hardware interruptions
    );


    U11_di2 : pps_di_2 port map (
        clock => clock2,
        reset => reset,
        stop_all2 => stop_all2,               -- Unconditionnal locking of the outputs
        clear => interrupt,                 -- Clear the pipeline stage (nop in the outputs)
                                                                                                      
        -- Asynchronous outputs
        bra_detect => bra_detect2,           -- Branch detection in the current instruction
                                                                                                      
        -- Asynchronous connexion with the register management and data bypass unit
        adr_reg1 => adr_reg3,               -- Address of the first register operand
        adr_reg2 => adr_reg4,               -- Address of the second register operand
        use1 => use3,                       -- Effective use of operand 1
        use2 => use4,                       -- Effective use of operand 2
        --iload2 => iload2,        
		  istore2 => istore2,                                                                                                
        stop_di => alea2DI2,                    -- Unresolved detected : send nop in the pipeline
        data1 => data3,                     -- Operand register 1
        data2 => data4,                     -- Operand register 2
                                                                                                      
        -- Datas from EI stage
        EI_adr => EI_adr2,                   -- Address of the instruction
        EI_instr => EI_instr2,               -- The instruction to decode
        EI_it_ok => EI_it_ok2,               -- Allow hardware interruptions
                                                                                                      
        -- Synchronous output to EX2 stage
        DI_bra => DI_bra2,                   -- Branch decoded 
        DI_link => DI_link2,                 -- A link for that instruction
        DI_op1 => DI_op3,                   -- operand 1 for alu
        DI_op2 => DI_op4,                   -- operand 2 for alu
        DI_code_ual => DI_code_ual2,         -- Alu operation
        DI_offset => DI_offset2,             -- Offset for the address calculation
        DI_adr_reg_dest => DI_adr_reg_dest2, -- Address of the destination register of the result
        DI_ecr_reg => DI_ecr_reg2,           -- Effective writing of the result
        DI_mode => DI_mode2,                 -- Address mode (relative to pc or indexed to a register)
        DI_op_mem => DI_op_mem2,             -- Memory operation request
        DI_r_w => DI_r_w2,                   -- Type of memory operation (reading or writing)
        DI_adr => DI_adr2,                   -- Address of the decoded instruction
        DI_exc_cause => DI_exc_cause2,       -- Potential exception detected
        DI_level => DI_level2,               -- Availability of the result for the data bypass
        DI_it_ok => DI_it_ok2                -- Allow hardware interruptions
    );	

	 
    U12_ex2 : pps_ex_2 port map (
        clock => clock,
        clock2 => clock2,
        reset => reset,
        stop_all => stop_all,
        stop_all2 => stop_all2,               -- Unconditionnal locking of outputs
        clear => interrupt,                 -- Clear the pipeline stage
                                                                                                    
        -- Datas from DI2 stage
        DI_bra => DI_bra2,                   -- Branch instruction
        DI_link => DI_link2,                 -- Branch with link
        DI_op1 => DI_op3,                   -- Operand 1 for alu 
        DI_op2 => DI_op4,                   -- Operand 2 for alu
        DI_code_ual => DI_code_ual2,         -- Alu operation
        DI_offset => DI_offset2,             -- Offset for address calculation
        DI_adr_reg_dest => DI_adr_reg_dest2, -- Destination register address for the result
        DI_ecr_reg => DI_ecr_reg2,           -- Effective writing of the result
        DI_mode => DI_mode2,                 -- Address mode (relative to pc ou index by a register)
        DI_op_mem => DI_op_mem2,             -- Memory operation
        DI_r_w => DI_r_w2,                   -- Type of memory operation (read or write)
        DI_adr => DI_adr2,                   -- Instruction address
        DI_exc_cause => DI_exc_cause2,       -- Potential cause exception
        DI_level => DI_level2,               -- Availability stage of the result for bypassing
        DI_it_ok => DI_it_ok2,               -- Allow hardware interruptions
        EX2_data_hilo =>  ex2_data_hilo,     -- saida p resultado do hilo p2  
	     EX_data_hilo =>   ex_data_hilo,      -- entrada p resultado do hilo p1                                                                                                   
        -- Synchronous outputs to MEM stage
        EX_adr => EX_adr2,                   -- Instruction address
        EX_bra_confirm => EX_bra_confirm2,   -- Branch execution confirmation
        EX_data_ual => EX_data_ual2,         -- Ual result
        EX_adresse => EX_adresse2,           -- Address calculation result
        EX_adresse_p2p1 => ex_adresse_p2p1_s, --resultado do calculo do endereco do desvio + 4 para pipe 1. 12-08-2018
        EX_adr_reg_dest => EX_adr_reg_dest2, -- Destination register for the result
        EX_ecr_reg => EX_ecr_reg2,           -- Effective writing of the result
        EX_op_mem => EX_op_mem2,             -- Memory operation needed
        EX_r_w => EX_r_w2,                   -- Type of memory operation (read or write)
        EX_exc_cause => EX_exc_cause2,       -- Potential cause exception
        EX_level => EX_level2,               -- Availability stage of result for bypassing
        EX_it_ok => EX_it_ok2                -- Allow hardware interruptions
    );

 U13_bus_ctrl02 : bus_ctrl02 port map (
        clock          => clock2,
        reset          => reset,

        -- Interruption in the pipeline
        interrupt      => interrupt,

        -- Interface for the Instruction Extraction Stage
        adr_from_ei    => ETC_adr2,          -- The address of the data to read
        instr_to_ei    => CTE_instr2,        -- Instruction from the memory                                                         
        -- Interface with the MEMory Stage
        req_from_mem   => MTC_req2,          -- Request to access the ram
        r_w_from_mem   => MTC_r_w2,          -- Read/Write request
        adr_from_mem   => MTC_adr2,          -- Address in ram
        data_from_mem  => MTC_data2,         -- Data to write in ram
        data_to_mem    => CTM_data2,         -- Data from the ram to the MEMory stage	  
                                                                                     
        -- RAM interface signals
        req_to_ram     => ram_req2,          -- Request to ram
        adr_to_ram     => ram_adr2,          -- Address of the data to read or write
        r_w_to_ram     => ram_r_w2,          -- Read/Write request
        ack_from_ram   => ram_ack2,          -- Acknowledge from the memory
        data_inout_ram => ram_data2,         -- Data from/to the memory

        -- Pipeline progress control signal
        stop_all       => stop_all2
    );

U14_delay_gate : delay_gate port map (
		clock => clock,
    	in1   => DI_bra,
    	in2   => bra_detect,
    	in3   => EX_bra_confirm,
    	in4   => alea,
    	in5   => alea2,
    	in6   => EX_bra_confirm2,
    	in7   => bra_detect2,
    	in8   => DI_bra2,
    	in9   => istore,
    	in10  => istore2,
    	in11  => zero,
    	in12  => zero,
    	out1  => DI_bra_D,
    	out2  => bra_detect_D,
    	out3  => EX_bra_confirm_D,
    	out4  => alea_D,
    	out5  => alea2_D,
    	out6  => EX_bra_confirm2_D,  
    	out7  => bra_detect2_D,
    	out8  => DI_bra2_D,
    	out9  => istore_D,
    	out10 => istore2_D,
    	out11 => iload,
    	out12 => iload_D
    );
end rtl;