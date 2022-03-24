----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 		James C Brakefield
-- 
-- Create Date:    12/05/2016 
-- Design Name:		LEM1_9ptr 
-- Module Name:    constants - Behavioral 
-- Project Name:		LEM1_9ptr
-- Target Devices: xilinx Artix-7 chip, Digilent CMOD A7 board
-- Tool versions:	 Vivado 2016.2
-- Description:	Soft core processor with 9-bit instructions and 1-bit data, index registers with auto inc/dec & offset
--		Single bit at a time "accumulator instructions to/from data RAM.
--		Data pointer RAM has four data pointers AKA index registers.  Return address stack of 4+ addresses.
--		Supports 64-2048 word instruction ROM and 32-512 bits of data RAM.  IO mapped to data RAM locations.
--		Parameterization: return address stack depth (4-32), instruction address size (6-11), data stack size (16-256) &
--		 data RAM size (32-512).  Shorter/smaller values reduce LUT counts.
--      Program ROM is dual port so extended instructions do not require a second read cycle (all inst take one clock!)
--      Stacks are desending.
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Revision 0.02 - 12/29/16 Inferred LUT & block RAMs added, signal names defined, compiles but no LUTs or BRAM
-- Revision 0.03 - 12/30/16 "x" suffix used as needed for LUT RAM adressing pointers so ram(--ptr) writes will work
-- Revision 0.03 - 12/30/16 hooking up IO yeilds LUT and block RAM usage, fully coded except no code for p-bit or for bitRAM_radr & bitRAM_wadr
-- Revision 0.04 -  1/ 3/17 modified LEM1_9str to become LEM1_9ptr, eg dropped data stack, p-bit unused
-- Revision 0.04 -  1/ 9/17 does 24-bit binary counter
-- Additional Comments: 
--  12/29/16 ISE 14.7 does not support small ARTIX-7s!  Will need to use Vivado for CMOD A7!
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
USE work.constants.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LEM1_9ptr is Port (    -- 1-bit soft core processor using 2Kx9 block RAM for program
    CLOCK_Y3    : in STD_LOGIC;        -- 100MHz master clock, fully synchronous design
----      Test bench signals
--     PC_tb          : out  std_logic_vector(prog_adr_size-1 downto 0);
--     inst_tb        : out  std_logic_vector(inst_size-1 downto 0);
--     rstack_ptr_tb  : out  std_logic_vector(rtn_ptr_size-1 downto 0);
--     Acc_tb         : out  std_logic;
--     Cry_tb         : out  std_logic;
--     bitRAM_we_tb   : out  std_logic;
--     bitRAMw_DI_tb  : out  std_logic;
--     bitRAMw_DO_tb  : out  std_logic;
--  # User push buttons
    GPIO_DIP1    : in   STD_LOGIC:='0';  
    GPIO_DIP2    : in   STD_LOGIC:='0'; 
--  # User LEDs			
    GPIO_LED1   : out  STD_LOGIC;   -- LOC = A17 high = lit
    GPIO_LED2   : out  STD_LOGIC;   -- LOC = C16 high = lit    
    GPIO_LED3   : out  STD_LOGIC;   -- LOC = A17 high = lit
    GPIO_LED4   : out  STD_LOGIC);   -- LOC = C16 high = lit    
end LEM1_9ptr;

architecture RTL of LEM1_9ptr is

signal clk  : std_logic;                        -- full speed clock (eg after the PLL)
--	N suffix indicates new value, eg pc is current pc, pcN is new/next PC
signal acc, accn, accwe : std_logic;            -- accumulator bit & next & enable
signal cry, cryn, crywe : std_logic;            -- carry bit & next & enable
signal pcwe             : std_logic;            -- PC update enable    
signal pc  : std_logic_vector(prog_adr_size-1 downto 0):=(OTHERS => '1');   -- program counter
signal pcn : std_logic_vector(prog_adr_size-1 downto 0);                    -- next program counter

--  instruction field names
signal opcode	: std_logic_vector(2 downto 0);     -- main op-code
signal rbit	    : std_logic;                        -- "replace" bit
--signal pbit	    : std_logic;                        -- pop/push bit
signal ss	    : std_logic_vector(1 downto 0);     -- bit ram pointer mode: (uu), (uu)++, (--uu) & (uu+nnnnnnnnn)
signal uu	    : std_logic_vector(1 downto 0);     -- bit ram pointer selection, ="11" is stack ref except "(11+n)" mode is absolute
signal adr_ops  : std_logic_vector(2 downto 0);     -- branch/pointer op-codes
signal instadrs : std_logic_vector(10 downto 0);    -- extended inst program ROM address field
signal ptradrs  : std_logic_vector(8 downto 0);     -- extended inst bit RAM address/displacement field

--      2R port block RAM for instructions
type instrom_type is array (prog_size-1 downto 0) of std_logic_vector (inst_size-1 downto 0);   -- instruction memory type              
signal instROM : instrom_type:= (                                               -- instruction memory & initialization
op_SETC, op_SETC,   -- in case PC starts at 1
-- 0x02
op_CALL,"000000110",op_JMP,"000000100",                 -- loop forever after return to locate faults
--          micro operation & conditional branch tests
-- 0x06
op_CLRC,op_JCC,"000001010",op_RTN,                      --return/error if carry set
-- 0x0a
op_NOTC,op_JCS,"000001110",op_RTN,                      -- return/error if carry clear
-- 0x0e
op_SETC,op_JCS,"000010010",op_RTN,                      -- return/error if carry clear
-- 0x12
op_SETA,op_JAS,"000010110",op_RTN,                      --return/error if acc clear
-- 0x16
op_NOTA,op_JAC,"000011010",op_RTN,                      -- return/error if acc set
-- 0x1a
op_CLRA,op_JAC,"000011110",op_RTN,                      -- return/error if acc set
-- 0x1e
op_SWAP,op_JCC,"000100010",op_RTN,op_JAS,"000100101",op_RTN,                                   -- test SWAP
--          init pointer #1, test load/store/increment indirect & test bit operations
-- 0x25, A set and C clear
op_LDPT OR ptr_1,"000000110",op_DECM OR ptr_1,op_LD OR ptr_1,op_JAS,"000101100",op_RTN,         -- load ptr #1 with 6, change location #6 to 1 and test
-- 0x2c
op_ST OR ptr_1,op_INCM OR ptr_1,op_LD OR ptr_1,op_JAS,"000110010",op_RTN,                       -- test load/store and increment
-- 0x32
op_SETC, op_INCM OR ptr_1,op_JCS,"000110111",op_RTN,op_LD OR ptr_1,op_JAC,"000111011",op_RTN,   -- test increment and carry propagation
-- 0x3b
op_XOR OR ptr_1,op_JAC,"000111111",op_RTN,                                                      -- test XOR
-- 0x3f
op_OR OR ptr_1,op_JAC,"001000011",op_RTN,                                                       -- test OR
-- 0x43
op_STC OR ptr_1,op_AND OR ptr_1,op_JAC,"001001000",op_RTN,                                      -- test STC and AND
-- 0x48
op_CALL,"001001100",op_JMP,"001010010",op_CALL,"001001111",op_RTN,op_CALL,"001010001",op_RTN,   -- test nested calls
-- 0x52, C set, A set, mem set
op_SETA,op_ST OR ptr_1,op_ADC OR ptr_1,op_JCS,"001011000",op_RTN,op_JAS,"001011011",op_RTN,     -- test ADC
-- 0x5b, clr C, A set, mem set
op_CLRA,op_RADC OR ptr_1,op_JCS,"001100000",op_RTN,op_JAC,"001100011",op_RTN,                   -- test RADC
--          test pointer modes
-- 0x63
op_SETA,op_ST OR ptr_1,op_LDPT OR ptr_2,"000000101",op_LD OR ptr_2PP,op_JAC,"001101011",OP_RTN,op_LD OR ptr_2PP,op_JAS,"001101111",OP_RTN,
-- 06f
op_LD OR ptr_2MM,op_JAS,"001110011",OP_RTN,op_LD OR ptr_2OF,"000000001",op_JAC,"001111000",OP_RTN,
-- 0x78
op_RTN,     -- end of tests

--          28 bit binary counter to LEDs
--op_CALL,"000010000",op_CALL,"000010000",op_CALL,"000010000",op_CALL,"000010000",
--op_CALL,"000010000",op_CALL,"000010000",op_CALL,"000010000",op_JMP ,"000000000",
----  location "10000"
--op_SETC,op_LDPT OR "000000001","000011100",
--op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",
--op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",
--op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",
--op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",
--op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",
--op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",
--op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",op_INCM OR idx_MM OR "000000001",
--op_JCC,"000010000",
--op_RTN,
OTHERS => "000000000");
ATTRIBUTE ram_extract: string;
ATTRIBUTE ram_extract OF instROM: SIGNAL IS "yes";
ATTRIBUTE ram_style: string;
ATTRIBUTE ram_style OF instROM: SIGNAL IS "block";

signal inst, nxt_inst       : std_logic_vector(inst_size-1 downto 0);           -- registered readouts
signal instadr, instadr_p1  : std_logic_vector(prog_adr_size-1 downto 0);       -- instruction addresses & PC
signal instROMwe            : std_logic;                                        -- used to invoke a dual port block ROM

--      1RW port LUT ram for return address stack
type rstack_ram_type is array (rtn_stack_size-1 downto 0) of std_logic_vector (prog_adr_size-1 downto 0);
signal rstack_ram : rstack_ram_type:= (OTHERS => "00000000");                   -- return stack LUT ram
signal rstack_ptrn, rstack_ptrx : std_logic_vector (rtn_ptr_size-1 downto 0);   -- pointer into return stack, new pointer & LUT address pointer
signal rstack_ptr : std_logic_vector (rtn_ptr_size-1 downto 0):=(OTHERS => '0');-- pointer into return stack, new pointer & LUT address pointer
signal rstack_do, rstack_di : std_logic_vector (prog_adr_size-1 downto 0);      -- return addresses in & out of stack
signal rstack_we : std_logic;                                                   -- enable write return adr to return stack

--      1RW port LUT RAM for bit ram file
type bitram_type is array (bitRAM_size-1 downto 0) of std_logic;                -- bit data ram type
signal bitRAM : bitram_type:= (OTHERS => '0');                                  -- bit data ram
signal bitRAMw_DI, bitRAMw_DO: std_logic;                                       -- bit data ram IOs
signal bitRAM_wadr: std_logic_vector(bitRAM_adr_size-1 downto 0);               -- bit data ram addresses
signal bitram_we : std_logic;

--      1RW port LUT ram for bit RAM pointer file
type ptr_ram_type is array (3 downto 0) of std_logic_vector (bitRAM_adr_size-1 downto 0);
signal ptr_ram : ptr_ram_type;                                                  -- bit pointer LUT ram
signal bit_ptr : std_logic_vector (1 downto 0);                                 -- pointer into bit pointer file
signal bitptr_do, bitptr_di : std_logic_vector (bitRAM_adr_size-1 downto 0);    -- bit pointer file IO
signal bitptr_we : std_logic;                                                   -- enable write return adr to return stack

begin
----  Test bench signal assignments
--PC_tb           <=PC;
--inst_tb         <=inst;
--rstack_ptr_tb   <=rstack_ptr;
--Acc_tb          <=acc;
--cry_tb          <=cry;
--bitRAM_we_tb    <=bitRAM_we;
--bitRAMw_DI_tb   <=bitRAMw_DI;
--bitRAMw_DO_tb   <=bitRAMw_DO;

--  relay the clock, TBD: PLL clock generation
clk<=CLOCK_Y3;

--      2R port block ROM for instructions
process (clk)
begin
if rising_edge(clk) then
    if (instROMwe = '1') then
       instROM(conv_integer(instadr)) <= "000000000";
    end if;
inst        <= instROM(conv_integer(instadr));
nxt_inst    <= instROM(conv_integer(instadr_p1));
end if;
end process;

--      1RW port LUT ram for return address stack
process (clk)
begin
if rising_edge(clk) then
if (rstack_we = '1') then
    rstack_ram(conv_integer(rstack_ptrx)) <= rstack_di;
end if;
end if;
end process;
rstack_do <= rstack_ram(conv_integer(rstack_ptrx));

--      1RW port LUT RAM for bit ram
process (clk)
begin
if rising_edge(clk) then
    if (bitRAM_we = '1') then
        bitRAM(conv_integer(bitRAM_wadr)) <= bitRAMw_DI;
        if bitRAM_wadr = "0000100" then GPIO_LED1 <= bitRAMw_DI; end if;    -- map bit ram location to LED
        if bitRAM_wadr = "0000101" then GPIO_LED2 <= bitRAMw_DI; end if;    -- map bit ram location to LED
        if bitRAM_wadr = "0000110" then GPIO_LED3 <= bitRAMw_DI; end if;    -- map bit ram location to LED
        if bitRAM_wadr = "0000111" then GPIO_LED4 <= bitRAMw_DI; end if;    -- map bit ram location to LED
    end if;
end if;
end process;
with bitRAM_wadr select
    bitRAMw_DO <= GPIO_DIP1 when "000000",         -- map push button to bit ram read location
                  GPIO_DIP2 when "000001",         -- map push button to bit ram read location
                  bitRAM(conv_integer(bitRAM_wadr)) when others;

--      1RW port LUT ram for bit RAM pointer file
process (clk)
begin
if rising_edge(clk) then
if (bitptr_we = '1') then
    ptr_ram(conv_integer(bit_ptr)) <= bitptr_di;
end if;
end if;
end process;
bitptr_do <= ptr_ram(conv_integer(bit_ptr));

--      Instruction ROM connect
instadr<= NOT pcn; instadr_p1<= NOT (pcn+1);        -- Spartan-6 hack
--instadr<=pcn; instadr_p1<=pcn+1;

--      instruction decode and implementation
decode: process(inst,nxt_inst,instrom,pc,acc,cry, opcode,rbit,ss,uu,adr_ops,instadrs,ptradrs,
                rstack_ptr,bitptr_do,rstack_do,bitptr_do,bitramw_do)
begin
--		        parse the instruction (eg give names to instruction fields)
opcode	<= inst(8 downto 6);                        -- main op-code
rbit	<= inst(5);                                 -- "replace" bit
--pbit	<= inst(4);                                 -- pop/push bit
ss	    <= inst(3 downto 2);                        -- bit ram pointer mode: (uu), (uu)++, (--uu) & (uu+nnnnnnnnn)
uu	    <= inst(1 downto 0);                        -- bit ram pointer selection, =0 is stack ref except "(0+n)" mode is absolute
adr_ops <= inst(4 downto 2);                        -- branch/pointer op-codes
instadrs<= inst(1 downto 0) & nxt_inst(8 downto 0); -- extended inst program ROM address field
ptradrs <= nxt_inst(8 downto 0);                    -- extended inst bit RAM address/displacement field

--		default signal values
pcn<=pc+1; pcwe<='1'; if (opcode = "111" AND rbit = '1') OR (opcode /= "111" AND ss = "11") then pcn <= pc+2; end if;
accn<='0'; cryn<='0'; accwe<='0'; crywe<='0';
bit_ptr<=uu; bitptr_we<='0'; bitptr_di <=ptradrs(bitRAM_adr_size-1 downto 0);
bitRAM_we<='0'; bitRAMw_DI <='0';
rstack_ptrx<=rstack_ptr; rstack_we<='0'; rstack_di <= pc+2; rstack_ptrn <= rstack_ptr - 1; -- only used by CALL & RTN, so defaults arranged for one of the two
instROMwe<='0';

case ss is          --      handle bit ram pointer updates
    when idx_DX(3 downto 2) => bitRAM_wadr <= bitptr_do;
    when idx_PP(3 downto 2) => bitRAM_wadr <= bitptr_do;     bitptr_we <= '1'; bitptr_di <= bitptr_do + 1;
    when idx_MM(3 downto 2) => bitRAM_wadr <= bitptr_do - 1; bitptr_we <= '1'; bitptr_di <= bitptr_do - 1;
    when idx_OF(3 downto 2) => bitRAM_wadr <= bitptr_do + ptradrs(bitRAM_adr_size-1 downto 0);
    when others => null;
end case;

if rbit = '0' then  --      write to accumulator instructions instruction implementation 
case opcode is
    when op_LD  (8 downto 6) => accn<=        bitRAMw_DO;         accwe<='1';
    when op_LDC (8 downto 6) => accn<=    NOT bitRAMw_DO;         accwe<='1';
    when op_AND (8 downto 6) => accn<=acc AND bitRAMw_DO;         accwe<='1';
    when op_OR  (8 downto 6) => accn<=acc OR  bitRAMw_DO;         accwe<='1';
    when op_XOR (8 downto 6) => accn<=acc XOR bitRAMw_DO;         accwe<='1';
    when op_ADC (8 downto 6) => accn<=acc XOR bitRAMw_DO XOR cry; accwe<='1';     cryn<=(acc AND cry)OR(acc AND bitRAMw_DO)OR(cry AND bitRAMw_DO); crywe<='1';
    when op_INCM(8 downto 6) => bitRAMw_DI<=bitRAMw_DO XOR cry;   bitram_we<='1'; cryn<=cry AND bitRAMw_DO; crywe<='1';
    when op_MACS(8 downto 6) => 
        case inst(4 downto 0) is        -- SCCAA: swap bit, carry & accum modifications: no change/complement/set to 0/set to 1; mods done before swap
            when "00000" => pcn <= rstack_do; rstack_ptrn <= rstack_ptr + 1; rstack_we <= '1'; -- op_RTN
            when "00001" => accn <= NOT acc; accwe <= '1';                                      -- op_NOTA
            when "00010" => accn <= '0'; accwe <= '1';                                          -- op_SAT0
            when "00011" => accn <= '1'; accwe <= '1';                                          -- op_SAT1
            when "00100" =>                                 cryn <= NOT cry; crywe <= '1';      --           op_NOTC
            when "00101" => accn <= NOT acc; accwe <= '1';  cryn <= NOT cry; crywe <= '1';      -- op_NOTA | op_NOTC
            when "00110" => accn <= '0'; accwe <= '1';      cryn <= NOT cry; crywe <= '1';      -- op_SAT0 | op_NOTC
            when "00111" => accn <= '1'; accwe <= '1';      cryn <= NOT cry; crywe <= '1';      -- op_SAT1 | op_NOTC
            when "01000" =>                                 cryn <= '0'; crywe <= '1';          --           op_SCT0
            when "01001" => accn <= NOT acc; accwe <= '1';  cryn <= '0'; crywe <= '1';          -- op_NOTA | op_SCT0
            when "01010" => accn <= '0'; accwe <= '1';      cryn <= '0'; crywe <= '1';          -- op_SAT0 | op_SCT0
            when "01011" => accn <= '1'; accwe <= '1';      cryn <= '0'; crywe <= '1';          -- op_SAT1 | op_SCT0
            when "01100" =>                                 cryn <= '1'; crywe <= '1';          --           op_SCT1
            when "01101" => accn <= NOT acc; accwe <= '1';  cryn <= '1'; crywe <= '1';          -- op_NOTA | op_SCT1
            when "01110" => accn <= '0'; accwe <= '1';      cryn <= '1'; crywe <= '1';          -- op_SAT0 | op_SCT1
            when "01111" => accn <= '1'; accwe <= '1';      cryn <= '1'; crywe <= '1';          -- op_SAT1 | op_SCT1
            --      swaps
            when "10000" => accn <= cry; accwe <= '1';      cryn <= acc; crywe <= '1';          --                      op_SWAP acc & cry after mods
            when "10001" => accn <= cry; accwe <= '1';      cryn <= NOT acc; crywe <= '1';
            when "10010" => accn <= cry; accwe <= '1';      cryn <= '0'; crywe <= '1';
            when "10011" => accn <= cry; accwe <= '1';      cryn <= '1'; crywe <= '1';
            when "10100" => accn <= NOT cry; accwe <= '1';  cryn <= acc; crywe <= '1';
            when "10101" => accn <= NOT cry; accwe <= '1';  cryn <= NOT acc; crywe <= '1';
            when "10110" => accn <= NOT cry; accwe <= '1';  cryn <= '0'; crywe <= '1';
            when "10111" => accn <= NOT cry; accwe <= '1';  cryn <= '1'; crywe <= '1';
            when "11000" => accn <= '0'; accwe <= '1';      cryn <= acc; crywe <= '1';
            when "11001" => accn <= '0'; accwe <= '1';      cryn <= NOT acc; crywe <= '1';
            when "11010" => null; -- redundant code
            when "11011" => null; -- redundant code
            when "11100" => accn <= '1'; accwe <= '1';      cryn <= acc; crywe <= '1';
            when "11101" => accn <= '1'; accwe <= '1';      cryn <= NOT acc; crywe <= '1';
            when "11110" => null; -- redundant code
            when "11111" => null; -- redundant code
            when others=> null;
        end case;
    when others => null;
end case;
else               --       write to bit RAM (replace) instructions instruction implementation
case opcode is
    when op_ST  (8 downto 6) => bitRAMw_DI<=               acc;         bitram_we<='1';
    when op_STC (8 downto 6) => bitRAMw_DI<=           NOT acc;         bitram_we<='1';
    when op_RAND(8 downto 6) => bitRAMw_DI<=bitRAMw_DO AND acc;         bitram_we<='1';
    when op_ROR (8 downto 6) => bitRAMw_DI<=bitRAMw_DO OR  acc;         bitram_we<='1';
    when op_RXOR(8 downto 6) => bitRAMw_DI<=bitRAMw_DO XOR acc;         bitram_we<='1';
    when op_RADC(8 downto 6) => bitRAMw_DI<=acc XOR bitRAMw_DO XOR cry; bitram_we<='1'; cryn<=(acc AND cry)OR(acc AND bitRAMw_DO)OR(cry AND bitRAMw_DO); crywe<='1';
    when op_DECM(8 downto 6) => bitRAMw_DI<=NOT bitRAMw_DO XOR cry;     bitram_we<='1'; cryn<=cry OR bitRAMw_DO; crywe<='1';
    when op_CALL(8 downto 6) => 
        case adr_ops is
            when op_CALL(4 downto 2) => pcn <= instadrs(prog_adr_size-1 downto 0); rstack_ptrx <= rstack_ptr - 1; rstack_we <= '1';
            when op_JMP (4 downto 2) => pcn <= instadrs(prog_adr_size-1 downto 0);
            when op_JAC (4 downto 2) => if acc = '0' then pcn <= instadrs(prog_adr_size-1 downto 0); end if;
            when op_JAS (4 downto 2) => if acc = '1' then pcn <= instadrs(prog_adr_size-1 downto 0); end if;
            when op_JCC (4 downto 2) => if cry = '0' then pcn <= instadrs(prog_adr_size-1 downto 0); end if;
            when op_JCS (4 downto 2) => if cry = '1' then pcn <= instadrs(prog_adr_size-1 downto 0); end if;
            when op_LDPT(4 downto 2) => bitptr_di <=             ptradrs(bitRAM_adr_size-1 downto 0); bitptr_we <= '1';
            when op_ADPT(4 downto 2) => bitptr_di <= bitptr_do + ptradrs(bitRAM_adr_size-1 downto 0); bitptr_we <= '1'; 
            when others => null;
        end case;
    when others => null;
end case;
end if;
end process decode;

--      registers and state update
update: process(clk)
begin
if (rising_edge(clk)) then
    if pcwe = '1'           then pc<=pcN;                   end if;
    if crywe = '1'          then cry<=cryn;                 end if;    -- for carry bit
    if accwe = '1'          then acc<=accn;                 end if;    -- for accumulator bit
    if rstack_we = '1'      then rstack_ptr<=rstack_ptrn;   end if;
end if;
end process update;

end RTL;

