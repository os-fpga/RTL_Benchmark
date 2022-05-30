----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:27:08 10/17/2010 
-- Design Name: 
-- Module Name:    op2p_host_wb_if - Behavioral 
-- Project Name: 
-- destination Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity op2p_host_wb_if is
    Port ( 
			  --instruction registers : this IP is slave on this
			  op2p_config_wb_data_o : in std_logic_vector(31 downto 0); 
			  op2p_config_wb_data_i : out std_logic_vector(31 downto 0);
			  op2p_config_wb_addr_i : in std_logic_vector(6 downto 0);
			  op2p_config_wb_cyc_i : in std_logic;
			  op2p_config_wb_stb_i : in std_logic;
			  op2p_config_wb_wr_i : in std_logic;
			  op2p_config_wb_ack_o : out std_logic;
			  op2p_config_wb_clk_i : in std_logic; 	
			  op2p_config_wb_sel_o :  in std_logic_vector(3 downto 0);
			  --system signals			  
			  op2p_reset : in std_logic;
			  x25m_clk : in std_logic;
			  user_clk_i : in std_logic;
			  --interrupt out:	
			  op2p_irq : out  STD_LOGIC;
			  --signals to the aurora/op2p scheduler:
			op2p_wr_sourceaddress_regrd_en : in  std_logic; 
			op2p_wr_sourceaddress_regdout : out std_logic_vector(31 downto 0); 
			op2p_wr_sourceaddress_regempty : out std_logic; 
			op2p_wr_destinationaddress_regrd_en : in  std_logic; 
			op2p_wr_destinationaddress_regdout : out std_logic_vector(31 downto 0); 
			op2p_wr_destinationaddress_regempty : out std_logic; 
			op2p_wr_sourceid_regrd_en : in  std_logic; 
			op2p_wr_sourceid_regdout : out std_logic_vector(31 downto 0); 
			op2p_wr_sourceid_regempty : out std_logic; 
			op2p_wr_destinationid_regrd_en : in  std_logic; 
			op2p_wr_destinationid_regdout : out std_logic_vector(31 downto 0); 
			op2p_wr_destinationid_regempty : out std_logic; 
			op2p_wr_bytecount_regrd_en : in  std_logic; 
			op2p_wr_bytecount_regdout : out std_logic_vector(31 downto 0); 
			op2p_wr_bytecount_regempty : out std_logic; 
			op2p_rdreq_localaddress_regrd_en : in  std_logic; 
			op2p_rdreq_localaddress_regdout : out std_logic_vector(31 downto 0); 
			op2p_rdreq_localaddress_regempty : out std_logic; 
			op2p_rdreq_destinationaddress_regrd_en : in  std_logic; 
			op2p_rdreq_destinationaddress_regdout : out std_logic_vector(31 downto 0); 
			op2p_rdreq_destinationaddress_regempty : out std_logic; 
			op2p_rdreq_sourceid_regrd_en : in  std_logic; 
			op2p_rdreq_sourceid_regdout : out std_logic_vector(31 downto 0); 
			op2p_rdreq_sourceid_regempty : out std_logic; 
			op2p_rdreq_destinationid_regrd_en : in  std_logic; 
			op2p_rdreq_destinationid_regdout : out std_logic_vector(31 downto 0); 
			op2p_rdreq_destinationid_regempty : out std_logic; 
			op2p_rdreq_bytecount_regrd_en : in  std_logic; 
			op2p_rdreq_bytecount_regdout : out std_logic_vector(31 downto 0); 
			op2p_rdreq_bytecount_regempty : out std_logic; 
			op2p_forw_freeupaddr_regrd_en : in  std_logic; 
			op2p_forw_freeupaddr_regdout : out std_logic_vector(31 downto 0); 
			op2p_forw_freeupaddr_regempty : out std_logic; 
			op2p_forw_freeupsize_regrd_en : in  std_logic; 
			op2p_forw_freeupsize_regdout : out std_logic_vector(31 downto 0); 
			op2p_forw_freeupsize_regempty : out std_logic; 
			 --these have to be doubleflopped to the userclk clock domain:  
			op2p_forwarding_bufferbase_reg : out std_logic_vector(31 downto 0); 
			op2p_forwarding_bufsize_reg  : out std_logic_vector(31 downto 0);
			op2p_local_id : out  std_logic_vector(15 downto 0); 
			--data to host:
			op2p_forwreq_pointer_regdin : in  std_logic_vector(31 downto 0); 
			op2p_forwreq_pointer_regwr_en : in  std_logic; 
			op2p_forwreq_pointer_regfull : out std_logic; 
			op2p_rdcompl_localaddress_regdin : in  std_logic_vector(31 downto 0); 
			op2p_rdcompl_localaddress_regwr_en : in  std_logic; 
			op2p_rdcompl_localaddress_regfull : out std_logic; 
			op2p_arrivedwrite_address_regdin : in  std_logic_vector(31 downto 0); 
			op2p_arrivedwrite_address_regwr_en : in  std_logic; 
			op2p_link_status_reg : IN std_logic_vector(31 downto 0);
			op2p_soft_reset  : OUT std_logic;
			op2p_forwreq_pointer_regempty2  : OUT std_logic;
			link_error_count_reg  : IN std_logic_vector(31 downto 0);
			op2p_arrivedwrite_address_regfull : out std_logic
			  );
end op2p_host_wb_if;

architecture Behavioral of op2p_host_wb_if is

   -- Internal Signals ------------------------------------------------------------

  --received packet properties
  SIGNAL op2p_wr_sourceaddress_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_wr_destinationaddress_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_wr_sourceid_reg  : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_wr_destinationid_reg  : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_wr_destinationid_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_wr_bytecount_reg  : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_wr_sourceaddress_regrd_en : std_logic;
  --SIGNAL op2p_wr_sourceaddress_regdout : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_wr_sourceaddress_regempty : std_logic;
  SIGNAL op2p_wr_sourceaddress_regunderflow : std_logic;
  
  --write request properties
  --SIGNAL op2p_wr_destinationaddress_regrd_en : std_logic;
  --SIGNAL op2p_wr_destinationaddress_regdout : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_wr_destinationaddress_regempty : std_logic;
  SIGNAL op2p_wr_destinationaddress_regunderflow : std_logic;
  --SIGNAL op2p_wr_sourceid_regrd_en : std_logic;
  --SIGNAL op2p_wr_sourceid_regdout : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_wr_sourceid_regempty : std_logic;
  SIGNAL op2p_wr_sourceid_regunderflow : std_logic;
  --SIGNAL op2p_wr_destinationid_regrd_en : std_logic;
  --SIGNAL op2p_wr_destinationid_regdout : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_wr_destinationid_regempty : std_logic;
  SIGNAL op2p_wr_destinationid_regunderflow : std_logic;
  --SIGNAL op2p_wr_bytecount_regrd_en : std_logic;
  --SIGNAL op2p_wr_bytecount_regdout : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_wr_bytecount_regempty : std_logic;
  SIGNAL op2p_wr_bytecount_regunderflow : std_logic;
  SIGNAL op2p_wr_sourceaddress_regfull : std_logic;
  SIGNAL op2p_wr_sourceaddress_regoverflow : std_logic;
  SIGNAL op2p_wr_destinationaddress_regfull : std_logic;
  SIGNAL op2p_wr_destinationaddress_regoverflow : std_logic;
  SIGNAL op2p_wr_sourceid_regfull : std_logic;
  SIGNAL op2p_wr_sourceid_regoverflow : std_logic;
  SIGNAL op2p_wr_destinationid_regfull : std_logic;
  SIGNAL op2p_wr_destinationid_regoverflow : std_logic;
  SIGNAL op2p_wr_bytecount_regfull : std_logic;
  SIGNAL op2p_wr_bytecount_regoverflow : std_logic;
  --SIGNAL op2p_wr_sourceaddress_reg : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_wr_destinationaddress_reg : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_wr_sourceid_reg  : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_wr_destinationid_reg : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_wr_bytecount_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_wr_destinationaddress_regwr_en : std_logic;
  SIGNAL op2p_wr_sourceaddress_regwr_en : std_logic;
  SIGNAL op2p_wr_bytecount_regwr_en : std_logic;
  SIGNAL op2p_wr_destinationid_regwr_en : std_logic;
  SIGNAL op2p_wr_sourceid_regwr_en : std_logic;

  --read request properties
  SIGNAL op2p_rdreq_localaddress_regfull : std_logic;
  SIGNAL op2p_rdreq_localaddress_regoverflow : std_logic;
  SIGNAL op2p_rdreq_destinationaddress_regfull : std_logic;
  SIGNAL op2p_rdreq_destinationaddress_regoverflow : std_logic;
  SIGNAL op2p_rdreq_sourceid_regfull : std_logic;
  SIGNAL op2p_rdreq_sourceid_regoverflow : std_logic;
  SIGNAL op2p_rdreq_destinationid_regfull : std_logic;
  SIGNAL op2p_rdreq_destinationid_regoverflow : std_logic;
  SIGNAL op2p_rdreq_bytecount_regfull : std_logic;
  SIGNAL op2p_rdreq_bytecount_regoverflow : std_logic;
  --SIGNAL op2p_rdreq_localaddress_regrd_en : std_logic;
  --SIGNAL op2p_rdreq_localaddress_regdout : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_rdreq_localaddress_regempty : std_logic;
  SIGNAL op2p_rdreq_localaddress_regunderflow : std_logic;
  --SIGNAL op2p_rdreq_destinationaddress_regrd_en : std_logic;
  --SIGNAL op2p_rdreq_destinationaddress_regdout : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_rdreq_destinationaddress_regempty : std_logic;
  SIGNAL op2p_rdreq_destinationaddress_regunderflow : std_logic;
  --SIGNAL op2p_rdreq_sourceid_regrd_en : std_logic;
  --SIGNAL op2p_rdreq_sourceid_regdout : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_rdreq_sourceid_regempty : std_logic;
  SIGNAL op2p_rdreq_sourceid_regunderflow : std_logic;
  --SIGNAL op2p_rdreq_destinationid_regrd_en : std_logic;
  --SIGNAL op2p_rdreq_destinationid_regdout : std_logic;
  --SIGNAL op2p_rdreq_destinationid_regempty : std_logic;
  SIGNAL op2p_rdreq_destinationid_regunderflow : std_logic;
  --SIGNAL op2p_rdreq_bytecount_regrd_en : std_logic;
  --SIGNAL op2p_rdreq_bytecount_regdout : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_rdreq_bytecount_regempty : std_logic;
  SIGNAL op2p_rdreq_bytecount_regunderflow : std_logic;

  --forwarding request fifo signals
  --SIGNAL op2p_forwreq_pointer_regdin : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_forwreq_pointer_regwr_en : std_logic;
  SIGNAL op2p_forwreq_pointer_regrd_en : std_logic;
  SIGNAL op2p_forwreq_pointer_reg : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_forwreq_pointer_regfull : std_logic;
  SIGNAL op2p_forwreq_pointer_regoverflow : std_logic;
  SIGNAL op2p_forwreq_pointer_regempty : std_logic;
  SIGNAL op2p_forwreq_pointer_regunderflow : std_logic;
  SIGNAL op2p_forw_freeupaddr_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_forw_freeupaddr_regwr_en : std_logic;
  --SIGNAL op2p_forw_freeupaddr_regrd_en : std_logic;
  --SIGNAL op2p_forw_freeupaddr_regdout : std_logic;
  SIGNAL op2p_forw_freeupaddr_regfull : std_logic;
  SIGNAL op2p_forw_freeupaddr_regoverflow : std_logic;
  --SIGNAL op2p_forw_freeupaddr_regempty : std_logic;
  SIGNAL op2p_forw_freeupaddr_regunderflow : std_logic;
  SIGNAL op2p_forw_freeupsize_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_forw_freeupsize_regwr_en : std_logic;
  --SIGNAL op2p_forw_freeupsize_regrd_en : std_logic;
  --SIGNAL op2p_forw_freeupsize_regdout : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_forw_freeupsize_regfull : std_logic;
  SIGNAL op2p_forw_freeupsize_regoverflow : std_logic;
  --SIGNAL op2p_forw_freeupsize_regempty : std_logic;
  SIGNAL op2p_forw_freeupsize_regunderflow   : std_logic;

  --read completion fifo signals
  --SIGNAL op2p_rdcompl_localaddress_regdin : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_rdcompl_localaddress_regwr_en : std_logic;
  SIGNAL op2p_rdcompl_localaddress_regrd_en : std_logic;
  SIGNAL op2p_rdcompl_localaddress_reg : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_rdcompl_localaddress_regfull : std_logic;
  SIGNAL op2p_rdcompl_localaddress_regoverflow : std_logic;
  SIGNAL op2p_rdcompl_localaddress_regempty : std_logic;
  SIGNAL op2p_rdcompl_localaddress_regunderflow : std_logic;
   
  --arrived write address fifo's signals
  --SIGNAL op2p_arrivedwrite_address_regdin : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_arrivedwrite_address_regwr_en : std_logic;
  SIGNAL op2p_arrivedwrite_address_regrd_en : std_logic;
  SIGNAL op2p_arrivedwrite_address_reg : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_arrivedwrite_address_regfull : std_logic;
  SIGNAL op2p_arrivedwrite_address_regoverflow : std_logic;
  SIGNAL op2p_arrivedwrite_address_regempty : std_logic;
  SIGNAL op2p_arrivedwrite_address_regunderflow : std_logic;

  --SIGNAL op2p_forwarding_bufferbase_reg : std_logic_VECTOR(31 downto 0);
  --SIGNAL op2p_forwarding_bufsize_reg  : std_logic_VECTOR(31 downto 0);
  
  SIGNAL op2p_fifostatus_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_local_id_copy : std_logic_VECTOR(15 downto 0);

  SIGNAL op2p_rdreq_localaddress_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_rdreq_localaddress_regwr_en : std_logic;
  SIGNAL op2p_wr_localaddress_regrd_en : std_logic;
  SIGNAL op2p_wr_localaddress_regdout : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_wr_localaddress_regempty : std_logic;
  SIGNAL op2p_wr_localaddress_regunderflow : std_logic;
  SIGNAL op2p_rdreq_destinationaddress_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_rdreq_destinationaddress_regwr_en : std_logic;
  SIGNAL op2p_rdreq_sourceid_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_rdreq_sourceid_regwr_en : std_logic;
  SIGNAL op2p_rdreq_destinationid_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_rdreq_destinationid_regwr_en : std_logic;
  SIGNAL op2p_rdreq_bytecount_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_rdreq_bytecount_regwr_en : std_logic;
  SIGNAL op2p_fifoflags_reg : std_logic_VECTOR(31 downto 0);
  SIGNAL op2p_tx_sourceaddress_regfull : std_logic;
  SIGNAL op2p_tx_sourceaddress_regoverflow : std_logic;
  SIGNAL op2p_tx_destinationaddress_regfull : std_logic;
  SIGNAL op2p_tx_destinationaddress_regoverflow : std_logic;
  SIGNAL op2p_tx_sourceid_regfull : std_logic;
  SIGNAL op2p_tx_sourceid_regoverflow : std_logic;
  SIGNAL op2p_tx_destinationid_regfull : std_logic;
  SIGNAL op2p_tx_destinationid_regoverflow : std_logic;
  SIGNAL op2p_tx_bytecount_regfull : std_logic;
  SIGNAL op2p_tx_bytecount_regoverflow : std_logic;
  SIGNAL op2p_config_state : std_logic_VECTOR(7 downto 0);
  SIGNAL op2p_config_wb_ack_o_copy : std_logic;
  SIGNAL op2p_config_wb_addr_i8bit: std_logic_VECTOR(7 downto 0);
  SIGNAL op2p_port_reset_reg  : std_logic_VECTOR(31 downto 0);
  
  SIGNAL link_error_count_reg_reclocked  : std_logic_VECTOR(31 downto 0);
  SIGNAL link_error_count_reg_reclocked2  : std_logic_VECTOR(31 downto 0);
	
-- -----MODULE DECLARATIONs -------------------------------------------------------
	component fifo_generator_v6_1
		port (
		rst: IN std_logic;
		wr_clk: IN std_logic;
		rd_clk: IN std_logic;
		din: IN std_logic_VECTOR(31 downto 0);
		wr_en: IN std_logic;
		rd_en: IN std_logic;
		dout: OUT std_logic_VECTOR(31 downto 0);
		full: OUT std_logic;
		overflow: OUT std_logic;
		empty: OUT std_logic;
		underflow: OUT std_logic);
	end component;


-- ---------- ARCHITECTURE BEGINS -------------------------------------------------
begin

-----------------------------------------------------------------------------------
	-- COMPONENT INSTALLATIONS (connecting the IPs to local signals) ---------------

	-- ////////////// HOST INTERFACE FIFOs \\\\\\\\\\\\\\----------------
		--  Registers (op2p_config_wb bus):
		--   WRITE REQ (local host writes): source address (local), destination address, source ID, destination ID, 
		--    byte-count.
		--   READ REQ (local host writes): destination address (local), destination source address, local ID, destination ID, 
		--    byte-count.
		--   READ completion status: completed_localaddress
		--   Forwarding REQUEST received: buffer start address pointer and buffer size (local host writes it, not a FIFO), Packet 
		--     pointer (FIFO, the aurora IP writes it). The complete packet with header is stored in memory. the packet size is in the header
		--     Forwarding buffer freeup: free up buffer area already forwarded. address and size.
		--   Control registers: FIFO status for every FIFO.
		--   All of these registers are FIFOs, one transaction involves reading or writing 4 FIFOs. Source ID is local ID 
		--    for most of the transactions, except for the forwarded packets.
	--FIFO for op2p_forwreq_pointer_reg (forwarding request packet pointer)
	fifo_op2p_forwreq_pointer_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => user_clk_i,
				rd_clk => op2p_config_wb_clk_i,
				din => op2p_forwreq_pointer_regdin,
				wr_en => op2p_forwreq_pointer_regwr_en,
				rd_en => op2p_forwreq_pointer_regrd_en,
				dout => op2p_forwreq_pointer_reg,
				full => op2p_forwreq_pointer_regfull,
				overflow => op2p_forwreq_pointer_regoverflow,
				empty => op2p_forwreq_pointer_regempty,
				underflow => op2p_forwreq_pointer_regunderflow);
	--FIFO for op2p_rdcompl_localaddress_reg (read completion)
	fifo_op2p_rdcompl_localaddress_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => user_clk_i,
				rd_clk => op2p_config_wb_clk_i,
				din => op2p_rdcompl_localaddress_regdin,
				wr_en => op2p_rdcompl_localaddress_regwr_en,
				rd_en => op2p_rdcompl_localaddress_regrd_en,
				dout => op2p_rdcompl_localaddress_reg,
				full => op2p_rdcompl_localaddress_regfull,
				overflow => op2p_rdcompl_localaddress_regoverflow,
				empty => op2p_rdcompl_localaddress_regempty,
				underflow => op2p_rdcompl_localaddress_regunderflow);
	--FIFO for op2p_arrivedwrite_address_reg (arrived write's address)
	fifo_op2p_arrivedwrite_address_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => user_clk_i,
				rd_clk => op2p_config_wb_clk_i,
				din => op2p_arrivedwrite_address_regdin,
				wr_en => op2p_arrivedwrite_address_regwr_en,
				rd_en => op2p_arrivedwrite_address_regrd_en,
				dout => op2p_arrivedwrite_address_reg,
				full => op2p_arrivedwrite_address_regfull,
				overflow => op2p_arrivedwrite_address_regoverflow,
				empty => op2p_arrivedwrite_address_regempty,
				underflow => op2p_arrivedwrite_address_regunderflow);
	--FIFO for op2p_wr_sourceaddress_reg (write request)
	fifo_op2p_wr_sourceaddress_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => op2p_config_wb_clk_i,
				rd_clk => user_clk_i,
				din => op2p_wr_sourceaddress_reg,
				wr_en => op2p_wr_sourceaddress_regwr_en,
				rd_en => op2p_wr_sourceaddress_regrd_en,
				dout => op2p_wr_sourceaddress_regdout,
				full => op2p_wr_sourceaddress_regfull,
				overflow => op2p_wr_sourceaddress_regoverflow,
				empty => op2p_wr_sourceaddress_regempty,
				underflow => op2p_wr_sourceaddress_regunderflow);
	--FIFO for op2p_wr_destinationaddress_reg (write request)
	fifo_op2p_wr_destinationaddress_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => op2p_config_wb_clk_i,
				rd_clk => user_clk_i,
				din => op2p_wr_destinationaddress_reg,
				wr_en => op2p_wr_destinationaddress_regwr_en,
				rd_en => op2p_wr_destinationaddress_regrd_en,
				dout => op2p_wr_destinationaddress_regdout,
				full => op2p_wr_destinationaddress_regfull,
				overflow => op2p_wr_destinationaddress_regoverflow,
				empty => op2p_wr_destinationaddress_regempty,
				underflow => op2p_wr_destinationaddress_regunderflow);
	--FIFO for op2p_wr_sourceid_reg (write request)
	fifo_op2p_wr_sourceid_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => op2p_config_wb_clk_i,
				rd_clk => user_clk_i,
				din => op2p_wr_sourceid_reg,
				wr_en => op2p_wr_sourceid_regwr_en,
				rd_en => op2p_wr_sourceid_regrd_en,
				dout => op2p_wr_sourceid_regdout,
				full => op2p_wr_sourceid_regfull,
				overflow => op2p_wr_sourceid_regoverflow,
				empty => op2p_wr_sourceid_regempty,
				underflow => op2p_wr_sourceid_regunderflow);
	--FIFO for op2p_wr_destinationid_reg (write request)
	fifo_op2p_wr_destinationid_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => op2p_config_wb_clk_i,
				rd_clk => user_clk_i,
				din => op2p_wr_destinationid_reg,
				wr_en => op2p_wr_destinationid_regwr_en,
				rd_en => op2p_wr_destinationid_regrd_en,
				dout => op2p_wr_destinationid_regdout,
				full => op2p_wr_destinationid_regfull,
				overflow => op2p_wr_destinationid_regoverflow,
				empty => op2p_wr_destinationid_regempty,
				underflow => op2p_wr_destinationid_regunderflow);
	--FIFO for op2p_wr_bytecount_reg (write request)
	fifo_op2p_wr_bytecount_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => op2p_config_wb_clk_i,
				rd_clk => user_clk_i,
				din => op2p_wr_bytecount_reg,
				wr_en => op2p_wr_bytecount_regwr_en,
				rd_en => op2p_wr_bytecount_regrd_en,
				dout => op2p_wr_bytecount_regdout,
				full => op2p_wr_bytecount_regfull,
				overflow => op2p_wr_bytecount_regoverflow,
				empty => op2p_wr_bytecount_regempty,
				underflow => op2p_wr_bytecount_regunderflow);
	--FIFO for op2p_rdreq_localaddress_reg (read request)
	fifo_op2p_rdreq_localaddress_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => op2p_config_wb_clk_i,
				rd_clk => user_clk_i,
				din => op2p_rdreq_localaddress_reg,
				wr_en => op2p_rdreq_localaddress_regwr_en,
				rd_en => op2p_rdreq_localaddress_regrd_en,
				dout => op2p_rdreq_localaddress_regdout,
				full => op2p_rdreq_localaddress_regfull,
				overflow => op2p_rdreq_localaddress_regoverflow,
				empty => op2p_rdreq_localaddress_regempty,
				underflow => op2p_wr_localaddress_regunderflow);
	--FIFO for op2p_rdreq_destinationaddress_reg (read request)
	fifo_op2p_rdreq_destinationaddress_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => op2p_config_wb_clk_i,
				rd_clk => user_clk_i,
				din => op2p_rdreq_destinationaddress_reg,
				wr_en => op2p_rdreq_destinationaddress_regwr_en,
				rd_en => op2p_rdreq_destinationaddress_regrd_en,
				dout => op2p_rdreq_destinationaddress_regdout,
				full => op2p_rdreq_destinationaddress_regfull,
				overflow => op2p_rdreq_destinationaddress_regoverflow,
				empty => op2p_rdreq_destinationaddress_regempty,
				underflow => op2p_rdreq_destinationaddress_regunderflow);
	--FIFO for op2p_rdreq_sourceid_reg (read request)
	fifo_op2p_rdreq_sourceid_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => op2p_config_wb_clk_i,
				rd_clk => user_clk_i,
				din => op2p_rdreq_sourceid_reg,
				wr_en => op2p_rdreq_sourceid_regwr_en,
				rd_en => op2p_rdreq_sourceid_regrd_en,
				dout => op2p_rdreq_sourceid_regdout,
				full => op2p_rdreq_sourceid_regfull,
				overflow => op2p_rdreq_sourceid_regoverflow,
				empty => op2p_rdreq_sourceid_regempty,
				underflow => op2p_rdreq_sourceid_regunderflow);
	--FIFO for op2p_rdreq_destinationid_reg (read request)
	fifo_op2p_rdreq_destinationid_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => op2p_config_wb_clk_i,
				rd_clk => user_clk_i,
				din => op2p_rdreq_destinationid_reg,
				wr_en => op2p_rdreq_destinationid_regwr_en,
				rd_en => op2p_rdreq_destinationid_regrd_en,
				dout => op2p_rdreq_destinationid_regdout,
				full => op2p_rdreq_destinationid_regfull,
				overflow => op2p_rdreq_destinationid_regoverflow,
				empty => op2p_rdreq_destinationid_regempty,
				underflow => op2p_rdreq_destinationid_regunderflow);
	--FIFO for op2p_rdreq_bytecount_reg (read request)
	fifo_op2p_rdreq_bytecount_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => op2p_config_wb_clk_i,
				rd_clk => user_clk_i,
				din => op2p_rdreq_bytecount_reg,
				wr_en => op2p_rdreq_bytecount_regwr_en,
				rd_en => op2p_rdreq_bytecount_regrd_en,
				dout => op2p_rdreq_bytecount_regdout,
				full => op2p_rdreq_bytecount_regfull,
				overflow => op2p_rdreq_bytecount_regoverflow,
				empty => op2p_rdreq_bytecount_regempty,
				underflow => op2p_rdreq_bytecount_regunderflow);
	--FIFO for op2p_forw_freeupaddr_reg (forwarding buffer freeup)
	fifo_op2p_forw_freeupaddr_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => op2p_config_wb_clk_i,
				rd_clk => user_clk_i,
				din => op2p_forw_freeupaddr_reg,
				wr_en => op2p_forw_freeupaddr_regwr_en,
				rd_en => op2p_forw_freeupaddr_regrd_en,
				dout => op2p_forw_freeupaddr_regdout,
				full => op2p_forw_freeupaddr_regfull,
				overflow => op2p_forw_freeupaddr_regoverflow,
				empty => op2p_forw_freeupaddr_regempty,
				underflow => op2p_forw_freeupaddr_regunderflow);
	--FIFO for op2p_forw_freeupsize_reg (forwarding buffer freeup)
	fifo_op2p_forw_freeupsize_reg : fifo_generator_v6_1
			port map (
				rst => op2p_reset,
				wr_clk => op2p_config_wb_clk_i,
				rd_clk => user_clk_i,
				din => op2p_forw_freeupsize_reg,
				wr_en => op2p_forw_freeupsize_regwr_en,
				rd_en => op2p_forw_freeupsize_regrd_en,
				dout => op2p_forw_freeupsize_regdout,
				full => op2p_forw_freeupsize_regfull,
				overflow => op2p_forw_freeupsize_regoverflow,
				empty => op2p_forw_freeupsize_regempty,
				underflow => op2p_forw_freeupsize_regunderflow);


 -- --------- MAIN LOGIC ----------------------------------------------------------
 
 op2p_config_wb_addr_i8bit(6 downto 0) <= op2p_config_wb_addr_i;
 op2p_config_wb_addr_i8bit(7) <= '0';
 op2p_soft_reset   <= op2p_port_reset_reg(0);
 op2p_forwreq_pointer_regempty2 <= op2p_forwreq_pointer_regempty;
 
 -- FIFO FLAGS REGISTER:
----fifo flags of write req
op2p_fifoflags_reg (0) <= op2p_tx_sourceaddress_regfull;
op2p_fifoflags_reg (1) <= op2p_tx_sourceaddress_regoverflow;
op2p_fifoflags_reg (2) <= op2p_tx_destinationaddress_regfull;
op2p_fifoflags_reg (3) <= op2p_tx_destinationaddress_regoverflow;
op2p_fifoflags_reg (4) <= op2p_tx_sourceid_regfull;
op2p_fifoflags_reg (5) <= op2p_tx_sourceid_regoverflow;
op2p_fifoflags_reg (6) <= op2p_tx_destinationid_regfull;
op2p_fifoflags_reg (7) <= op2p_tx_destinationid_regoverflow;
op2p_fifoflags_reg (8) <= op2p_tx_bytecount_regfull;
op2p_fifoflags_reg (9) <= op2p_tx_bytecount_regoverflow;
----fifo flags of read req
op2p_fifoflags_reg (10) <= op2p_rdreq_localaddress_regfull;
op2p_fifoflags_reg (11) <= op2p_rdreq_localaddress_regoverflow;
op2p_fifoflags_reg (12) <= op2p_rdreq_destinationaddress_regfull;
op2p_fifoflags_reg (13) <= op2p_rdreq_destinationaddress_regoverflow;
op2p_fifoflags_reg (14) <= op2p_rdreq_sourceid_regfull;
op2p_fifoflags_reg (15) <= op2p_rdreq_sourceid_regoverflow;
op2p_fifoflags_reg (16) <= op2p_rdreq_destinationid_regfull;
op2p_fifoflags_reg (17) <= op2p_rdreq_destinationid_regoverflow;
op2p_fifoflags_reg (18) <= op2p_rdreq_bytecount_regfull;
op2p_fifoflags_reg (19) <= op2p_rdreq_bytecount_regoverflow;
--forwarding freeup. write here:
op2p_fifoflags_reg (20) <= op2p_forw_freeupaddr_regfull;
op2p_fifoflags_reg (21) <= op2p_forw_freeupaddr_regoverflow;
op2p_fifoflags_reg (22) <= op2p_forw_freeupsize_regfull;
op2p_fifoflags_reg (23) <= op2p_forw_freeupsize_regoverflow;
-----registers to read here:
op2p_fifoflags_reg (24) <= op2p_forwreq_pointer_regempty;
op2p_fifoflags_reg (25) <= op2p_forwreq_pointer_regunderflow;
op2p_fifoflags_reg (26) <= op2p_rdcompl_localaddress_regempty;
op2p_fifoflags_reg (27) <= op2p_rdcompl_localaddress_regunderflow;
op2p_fifoflags_reg (28) <= op2p_arrivedwrite_address_regempty;
op2p_fifoflags_reg (29) <= op2p_arrivedwrite_address_regunderflow;
op2p_fifoflags_reg (31 downto 30) <= (OTHERS => '0');



	--reclocking some stuff---------
	process (op2p_reset, user_clk_i) 
	begin
	if (op2p_reset='1') then 
		link_error_count_reg_reclocked <= (OTHERS => '0');
		link_error_count_reg_reclocked2 <= (OTHERS => '0');
	else
		if (op2p_config_wb_clk_i'event and op2p_config_wb_clk_i = '1') then
			link_error_count_reg_reclocked <= link_error_count_reg;
			link_error_count_reg_reclocked2 <= link_error_count_reg_reclocked;
		end if;        
	end if;
	end process;
	
	
	
	 

	-- WISHBONE SLAVE INTERFACE ----------------------------------------------------
	--this is for control and configuration by the local host/cpu
	--  Registers (op2p_config_wb bus):
	--   TX (local host writes): source address (local), destination address, source ID (set up once), destination ID, 
	--    byte-count.
	--   RX (this IP writes it): source address (remote), destination address (local), source ID, destination ID 
	--    (check for match or forwarding), byte-count.
	--   Forwarding: buffer start address pointer and buffer size (local host writes it), Packet 
	--     pointer (FIFO, the aurora IP writes it). The complete packet with header is stored in memory.
	--   Control registers: FIFO status for every FIFO.
	--   All of these registers are FIFOs, one transaction involves reading or writing 4 FIFOs.
	-- The local host has to check if the FIFO-full flags are '0', otherwise an overwrite will occur.
	--  Instead of holding the wb_ack antil it gets empty, we let it overwrite. This was we can
	--  prevent system hang on the wishbone bus.
	--
--	  Register Addresses (BYTE ADDRESSES):
--	  -------------------
--		--00h - op2p_fifostatus_reg		
--			Tells the status flags of the command FIFOs	
--		--04h - op2p_wr_sourceaddress_reg			(write command)
--		--08h - op2p_wr_destinationaddress_reg		(write command)
--		--0Ch - op2p_wr_sourceid_reg					(write command) 
--		--10h - op2p_wr_destinationid_reg			(write command)
--		--14h - op2p_wr_bytecount_reg					(write command)
--		--18h - op2p_rdreq_localaddress_reg			 (read request command)
--		--1Ch - op2p_rdreq_destinationaddress_reg	 (read request command)
--		--20h - op2p_rdreq_sourceid_reg				 (read request command)
--		--24h - op2p_rdreq_destinationid_reg		 (read request command)
--		--28h - op2p_rdreq_bytecount_reg				 (read request command)
--		--2Ch - op2p_rdcompl_localaddress_reg 
--		--30h - op2p_forwarding_bufferbase_reg
--		--34h - op2p_forwarding_bufsize_reg 
--		--38h - op2p_forw_freeupaddr_reg
--		--3Ch - op2p_forw_freeupsize_reg
--		--40h - op2p_forwreq_pointer_reg
--    --44h - op2p_arrivedwrite_address_reg
--		--48h - op2p_localid_reg
--			The local ID of this device. written by local host. Receiving completion 
--			or addressed (dest ID/=0) packet without setting this is not poosible. Set after startup.
--		--4Ch - op2p_link_status_reg
--			Tells if the link is alive, and also which lanes
--		--50h - op2p_port_reset_reg
--			We can initiate a soft reset to this port wy register write
--		--54h - link_error_count_reg
--			This counts errors found in incoming packets. Counts forever from reset
--			8b10b encoding-based "non-existing-code" and disparity errors get detected.
--
--   Register bits:
--     op2p_link_status_reg: 
--        bit-0=CHANNEL_UP, 
--			 bit-n:1=LANE_UP(0:n), 
--			 upper bits all zero
--     op2p_fifostatus_reg
--			(0) <=  op2p_forwreq_pointer_regempty;       --empty
--			(1) <=  op2p_rdcompl_localaddress_regempty;
--			(2) <=  op2p_arrivedwrite_address_regempty; 
--			(3) <=  op2p_wr_sourceaddress_regfull;       --full
--			(4) <=  op2p_wr_destinationaddress_regfull;
--			(5) <=  op2p_wr_sourceid_regfull;
--			(6) <=  op2p_wr_destinationid_regfull;
--			(7) <=  op2p_wr_bytecount_regfull;
--			(8) <=  op2p_rdreq_localaddress_regfull;
--			(9) <=  op2p_rdreq_destinationaddress_regfull;
--			(10) <=  op2p_rdreq_sourceid_regfull;
--			(11) <=  op2p_rdreq_destinationid_regfull;
--			(12) <=  op2p_rdreq_bytecount_regfull;
--			(13) <=  op2p_forw_freeupaddr_regfull;
--			(14) <=  op2p_forw_freeupsize_regfull;
--			(31 downto 15) <=  (OTHERS => '0');
--		op2p_port_reset_reg
--			bit-0: set 1 to hold reset, set 0 to release from reset. After startup its not in reset.
--		address registers:
--			all 32 bits are used. 4GB address space in the local DRAM buffer. (not x86 host memory space address)
--		ID registers: 
--			bit [15:0] are used for the 16-bit IDs.
	
				--the wishbone slave state machine---------------------
				wishbone: process (op2p_reset, op2p_config_wb_wr_i, op2p_config_wb_clk_i, op2p_local_id_copy,
										op2p_config_wb_cyc_i, op2p_config_wb_addr_i, op2p_config_wb_data_o) is
					begin
					if (op2p_reset='1') then 
					  op2p_config_wb_data_i(31 downto 0) <= (others => '0'); 
					  op2p_wr_sourceaddress_reg <= (OTHERS => '0');
					  op2p_wr_destinationaddress_reg <= (OTHERS => '0');
					  op2p_wr_sourceid_reg <= (OTHERS => '0'); 
					  op2p_wr_destinationid_reg <= (OTHERS => '0');
					  op2p_wr_bytecount_reg <= (OTHERS => '0');
					  op2p_forwarding_bufferbase_reg <= (OTHERS => '0');
					  op2p_forwarding_bufsize_reg  <= (OTHERS => '0');
					  op2p_rdreq_localaddress_reg <= (OTHERS => '0');
					  op2p_rdreq_destinationaddress_reg <= (OTHERS => '0');
					  op2p_rdreq_sourceid_reg <= (OTHERS => '0');
					  op2p_rdreq_destinationid_reg <= (OTHERS => '0');
					  op2p_rdreq_bytecount_reg <= (OTHERS => '0');
					  op2p_forw_freeupaddr_reg <= (OTHERS => '0');
					  op2p_forw_freeupsize_reg <= (OTHERS => '0');
						op2p_wr_destinationaddress_regwr_en  <= '0';
						op2p_wr_sourceaddress_regwr_en  <= '0';
						op2p_wr_bytecount_regwr_en  <= '0';
						op2p_wr_destinationid_regwr_en  <= '0';
						op2p_wr_sourceid_regwr_en  <= '0';
						op2p_rdreq_localaddress_regwr_en <= '0';
						op2p_rdreq_destinationaddress_regwr_en <= '0';
						op2p_rdreq_sourceid_regwr_en <= '0';
						op2p_rdreq_destinationid_regwr_en <= '0';
						op2p_rdreq_bytecount_regwr_en <= '0';
						op2p_forw_freeupaddr_regwr_en <= '0';
						op2p_forw_freeupsize_regwr_en <= '0';
						op2p_forwreq_pointer_regrd_en <= '0';
						op2p_rdcompl_localaddress_regrd_en <= '0';
						op2p_arrivedwrite_address_regrd_en <= '0';
						op2p_config_state <= (OTHERS => '0');
						op2p_config_wb_ack_o <= '0';
						op2p_config_wb_ack_o_copy <= '0';
						op2p_local_id <= (OTHERS => '0');
						op2p_port_reset_reg <=  (OTHERS => '0');
					else
						if (op2p_config_wb_clk_i'event and op2p_config_wb_clk_i = '1') then
						
							 case ( op2p_config_state ) is

							 --********** IDLE STATE  **********
							 when "00000000" =>   --state 0    
								op2p_config_wb_ack_o <= '0';
								op2p_config_wb_ack_o_copy <= '0';
								op2p_wr_destinationaddress_regwr_en  <= '0';
								op2p_wr_sourceaddress_regwr_en  <= '0';
								op2p_wr_bytecount_regwr_en  <= '0';
								op2p_wr_destinationid_regwr_en  <= '0';
								op2p_wr_sourceid_regwr_en  <= '0';
								op2p_rdreq_localaddress_regwr_en <= '0';
								op2p_rdreq_destinationaddress_regwr_en <= '0';
								op2p_rdreq_sourceid_regwr_en <= '0';
								op2p_rdreq_destinationid_regwr_en <= '0';
								op2p_rdreq_bytecount_regwr_en <= '0';
								op2p_forw_freeupaddr_regwr_en <= '0';
								op2p_forw_freeupsize_regwr_en <= '0';
								op2p_forwreq_pointer_regrd_en <= '0';
								op2p_rdcompl_localaddress_regrd_en <= '0';	
								op2p_arrivedwrite_address_regrd_en <= '0';								
								--writes:
								if (op2p_config_wb_cyc_i = '1' and op2p_config_wb_wr_i = '1' and op2p_config_wb_ack_o_copy='0') then 
									op2p_config_state <= "00000001";
								--reads:
								elsif (op2p_config_wb_cyc_i = '1' and op2p_config_wb_wr_i = '0' and op2p_config_wb_ack_o_copy='0')	then --read
									op2p_config_state <= "00000010";
								end if;

							 --********** write STATE ********** 
							 when "00000001" =>   --state 1
								  op2p_config_state <= "00000000"; --no wait states, go back to idle
								  op2p_config_wb_ack_o <= '1';
								  op2p_config_wb_ack_o_copy <= '1';
								if (  op2p_config_wb_addr_i8bit(7 downto 0) = X"04" ) then 
								  op2p_wr_sourceaddress_reg <=   op2p_config_wb_data_o(31 downto 0);
								  op2p_wr_sourceaddress_regwr_en  <= '1';
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"08" ) then 
								  op2p_wr_destinationaddress_reg <=   op2p_config_wb_data_o(31 downto 0);
								  op2p_wr_destinationaddress_regwr_en  <= '1';
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"0C" ) then 
								  op2p_wr_sourceid_reg <=   op2p_config_wb_data_o(31 downto 0); 
								  op2p_wr_sourceid_regwr_en  <= '1';
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"10" ) then 
								  op2p_wr_destinationid_reg <=   op2p_config_wb_data_o(31 downto 0);
								  op2p_wr_destinationid_regwr_en  <= '1';
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"14" ) then 
								  op2p_wr_bytecount_reg <=   op2p_config_wb_data_o(31 downto 0);
								  op2p_wr_bytecount_regwr_en  <= '1';
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"18" ) then 
								  op2p_rdreq_localaddress_reg <=   op2p_config_wb_data_o(31 downto 0);
								  op2p_rdreq_localaddress_regwr_en  <= '1';
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"1C" ) then 
								  op2p_rdreq_destinationaddress_reg <=   op2p_config_wb_data_o(31 downto 0);
								  op2p_rdreq_destinationaddress_regwr_en  <= '1';
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"20" ) then 
								  op2p_rdreq_sourceid_reg <=   op2p_config_wb_data_o(31 downto 0);
								  op2p_rdreq_sourceid_regwr_en  <= '1';
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"24" ) then 
								  op2p_rdreq_destinationid_reg <=   op2p_config_wb_data_o(31 downto 0);
								  op2p_rdreq_destinationid_regwr_en  <= '1';
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"28" ) then 
								  op2p_rdreq_bytecount_reg <=   op2p_config_wb_data_o(31 downto 0);
								  op2p_rdreq_bytecount_regwr_en  <= '1';
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"30" ) then 
								  op2p_forwarding_bufferbase_reg <=   op2p_config_wb_data_o(31 downto 0);
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"34" ) then 
								  op2p_forwarding_bufsize_reg <=   op2p_config_wb_data_o(31 downto 0); 
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"38" ) then 
								  op2p_forw_freeupaddr_reg <=   op2p_config_wb_data_o(31 downto 0);
								  op2p_forw_freeupaddr_regwr_en  <= '1';
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"3C" ) then 
								  op2p_forw_freeupsize_reg <=   op2p_config_wb_data_o(31 downto 0);
								  op2p_forw_freeupsize_regwr_en  <= '1';
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"48" ) then 
								  op2p_local_id <=   op2p_config_wb_data_o(15 downto 0);
								  op2p_local_id_copy <=   op2p_config_wb_data_o(15 downto 0);
								elsif (  op2p_config_wb_addr_i8bit(7 downto 0) = X"50" ) then 
								  op2p_port_reset_reg <=   op2p_config_wb_data_o(31 downto 0);
								end if; 

							 --********** read STATE **********
							 when "00000010" =>   --state 2: initiate FIFO read
									op2p_config_state <= "00000011";
								if (op2p_config_wb_addr_i8bit(7 downto 0) = X"2C" ) then 
								  op2p_rdcompl_localaddress_regrd_en <='1';
								elsif (op2p_config_wb_addr_i8bit(7 downto 0) = X"40" ) then 
								  op2p_forwreq_pointer_regrd_en <='1';
								elsif (op2p_config_wb_addr_i8bit(7 downto 0) = X"44" ) then 
								  op2p_arrivedwrite_address_regrd_en <='1';
								end if;
							 when "00000011" =>   --state 3: initiate FIFO read-2
									op2p_config_state <= "00000100";
									op2p_forwreq_pointer_regrd_en <= '0';
									op2p_rdcompl_localaddress_regrd_en <= '0';
									op2p_arrivedwrite_address_regrd_en <= '0';
							 when "00000100" =>   --state 4: FIFO read-out
								  op2p_config_state <= "00000000"; --no wait states, go back to idle
								  op2p_config_wb_ack_o <= '1';
								  op2p_config_wb_ack_o_copy <= '1';
								if (op2p_config_wb_addr_i8bit(7 downto 0) = X"00" ) then 
								  op2p_config_wb_data_i(31 downto 0) <= op2p_fifostatus_reg; 
								elsif (op2p_config_wb_addr_i8bit(7 downto 0) = X"2C" ) then 
								  op2p_config_wb_data_i(31 downto 0) <= op2p_rdcompl_localaddress_reg; 
								elsif (op2p_config_wb_addr_i8bit(7 downto 0) = X"40" ) then 
								  op2p_config_wb_data_i(31 downto 0) <= op2p_forwreq_pointer_reg;
								elsif (op2p_config_wb_addr_i8bit(7 downto 0) = X"44" ) then 
								  op2p_config_wb_data_i(31 downto 0) <= op2p_arrivedwrite_address_reg;
								elsif (op2p_config_wb_addr_i8bit(7 downto 0) = X"48" ) then 
								  op2p_config_wb_data_i(15 downto 0) <= op2p_local_id_copy;
								  op2p_config_wb_data_i(31 downto 16) <= (others => '0');
								elsif (op2p_config_wb_addr_i8bit(7 downto 0) = X"4C" ) then 
								  op2p_config_wb_data_i(31 downto 0) <= op2p_link_status_reg;
								elsif (op2p_config_wb_addr_i8bit(7 downto 0) = X"50" ) then 
								  op2p_config_wb_data_i(31 downto 0) <= op2p_port_reset_reg;
								elsif (op2p_config_wb_addr_i8bit(7 downto 0) = X"54" ) then 
								  op2p_config_wb_data_i(31 downto 0) <= link_error_count_reg_reclocked2;
								else
								  op2p_config_wb_data_i(31 downto 0) <= (OTHERS => '0');
								end if;
									
							 when others => --error
									 op2p_config_state <= "00000000"; --go to state 0
							 end case; 

						end if;
					end if;
				end process wishbone;	
				
				--  Interrupts to local host:
				--   - read completion (fifo was written)
				--   - forwarding request
				--   - write arrived
				op2p_irq <= (not op2p_forwreq_pointer_regempty)
					or (not op2p_rdcompl_localaddress_regempty)
					or (not op2p_arrivedwrite_address_regempty);
				--flag: if any of the readable FIFOs is not empty, the interrupt is asserted.


	-- FIFO STATUS:
	op2p_fifostatus_reg (0) <=  op2p_forwreq_pointer_regempty;       --empty
	op2p_fifostatus_reg (1) <=  op2p_rdcompl_localaddress_regempty;
	op2p_fifostatus_reg (2) <=  op2p_arrivedwrite_address_regempty; 
	op2p_fifostatus_reg (3) <=  op2p_wr_sourceaddress_regfull;       --full
	op2p_fifostatus_reg (4) <=  op2p_wr_destinationaddress_regfull;
	op2p_fifostatus_reg (5) <=  op2p_wr_sourceid_regfull;
	op2p_fifostatus_reg (6) <=  op2p_wr_destinationid_regfull;
	op2p_fifostatus_reg (7) <=  op2p_wr_bytecount_regfull;
	op2p_fifostatus_reg (8) <=  op2p_rdreq_localaddress_regfull;
	op2p_fifostatus_reg (9) <=  op2p_rdreq_destinationaddress_regfull;
	op2p_fifostatus_reg (10) <=  op2p_rdreq_sourceid_regfull;
	op2p_fifostatus_reg (11) <=  op2p_rdreq_destinationid_regfull;
	op2p_fifostatus_reg (12) <=  op2p_rdreq_bytecount_regfull;
	op2p_fifostatus_reg (13) <=  op2p_forw_freeupaddr_regfull;
	op2p_fifostatus_reg (14) <=  op2p_forw_freeupsize_regfull;
	op2p_fifostatus_reg (31 downto 15) <=  (OTHERS => '0');





-------------- END FILE -----------------------------------------------------------
end Behavioral;

