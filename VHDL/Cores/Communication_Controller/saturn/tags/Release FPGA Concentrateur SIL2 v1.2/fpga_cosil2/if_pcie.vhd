--============================================================================= 
--  TITRE : IF_PCIE
--  DESCRIPTION : 
--        Interface PCIe
--        D'un coté fournit l'interface au format PCIe
--        De l'autre fournit un bus local qui gère des accès en lecture/écriture		
--
--  FICHIER :        if_pcie.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  10/04/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION 
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_BIT.ALL;
LIBRARY UNISIM;
use UNISIM.VCOMPONENTS.ALL;

ENTITY if_pcie IS
   GENERIC
   (
      fast_train : BOOLEAN := FALSE;
      nbbit_add  : INTEGER := 13                         -- Nombre de bits d'adresse utilisé sur le bus local
   );
   PORT
   (
      pci_exp_txp : OUT STD_LOGIC;                       -- Interface Tx différentielle PCIe
      pci_exp_txn : OUT STD_LOGIC;
      pci_exp_rxp : IN  STD_LOGIC;                       -- Interface Rx différentielle PCIe
      pci_exp_rxn : IN  STD_LOGIC;
      sys_clk_p   : IN  STD_LOGIC;                       -- Clock différentielle PCIe
      sys_clk_n   : IN  STD_LOGIC;
      sys_reset_n : IN  STD_LOGIC;                       -- Reset général du module PCIe

      -- Gestion du DMA
      dma_req     : IN  STD_LOGIC;                       -- Demande d'un transfert DMA de la part du module MANAGE_DMA
      dma_compl   : OUT STD_LOGIC;                       -- Indique que le dernier transfert DMA est fini
      dma_ack     : OUT STD_LOGIC;                       -- Acquitte la demande de transfert DMA
      dma_add_dest: IN  STD_LOGIC_VECTOR(31 downto 0);   -- Adresse de destination dans la zone micro où on souhaite faire le DMA
      dma_data    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Données 32 bits successives à transférer par DMA
      dma_read    : OUT STD_LOGIC;                       -- Lecture d'un mot 32 bits de plus à transférer par DMA
      dma_size    : IN  STD_LOGIC_VECTOR(7 downto 0);    -- Taille du DMA en mots de 32 bits

      -- Gestion du Local Bus
      rd_addr     : OUT STD_LOGIC_VECTOR(nbbit_add-1 downto 0);   -- Adresse pour une lecture (pointe dans MEMORY_MAP)
      rd_data     : IN STD_LOGIC_VECTOR(31 downto 0);             -- Donnée lue
      rd_be       : OUT STD_LOGIC_VECTOR(3 downto 0);             -- Byte Enable pour la lecture
      rd_en       : OUT STD_LOGIC;                                -- Signal de lecture
      wr_addr     : OUT STD_LOGIC_VECTOR(nbbit_add-1 downto 0);   -- Adresse pour une écriture (pointe dans MEMORY_MAP)
      wr_data     : OUT STD_LOGIC_VECTOR(31 downto 0);            -- Donéne à écrire
      wr_be       : OUT STD_LOGIC_VECTOR(3 downto 0);             -- Byte Enbale pour une écriture
      wr_en       : OUT STD_LOGIC;                                -- Signal d'écriture
      wr_busy     : IN STD_LOGIC;                                 -- Indique que le process d'écriture est occupé
      clk_local   : OUT STD_LOGIC;                                -- Clock du bus Local à 62.5MHz
      rst_local_n : OUT STD_LOGIC;                                -- Reset sur le bus local
      link_up_n   : OUT STD_LOGIC                                 -- Indique que le lien PCIe est opérationnel
      );
   END if_pcie;

ARCHITECTURE rtl OF if_pcie IS
   -------------------------
   -- Component declarations
   -------------------------
   COMPONENT pcie_app_s6 IS
   GENERIC (
      nbbit_add  : INTEGER := 13
      );
   PORT (
      trn_clk                : in  std_logic;
      trn_reset_n            : in  std_logic;
      trn_lnk_up_n           : in  std_logic;
      trn_tbuf_av            : in  std_logic_vector(5 downto 0);
      trn_tcfg_req_n         : in  std_logic;
      trn_terr_drop_n        : in  std_logic;
      trn_tdst_rdy_n         : in  std_logic;
      trn_td                 : out std_logic_vector(31 downto 0);
      trn_tsof_n             : out std_logic;
      trn_teof_n             : out std_logic;
      trn_tsrc_rdy_n         : out std_logic;
      trn_tsrc_dsc_n         : out std_logic;
      trn_terrfwd_n          : out std_logic;
      trn_tcfg_gnt_n         : out std_logic;
      trn_tstr_n             : out std_logic;
      trn_rd                 : in  std_logic_vector(31 downto 0);
      trn_rsof_n             : in  std_logic;
      trn_reof_n             : in  std_logic;
      trn_rsrc_rdy_n         : in  std_logic;
      trn_rsrc_dsc_n         : in  std_logic;
      trn_rerrfwd_n          : in  std_logic;
      trn_rbar_hit_n         : in  std_logic_vector(6 downto 0);
      trn_rdst_rdy_n         : out std_logic;
      trn_rnp_ok_n           : out std_logic;
      trn_fc_cpld            : in  std_logic_vector(11 downto 0);
      trn_fc_cplh            : in  std_logic_vector(7 downto 0);
      trn_fc_npd             : in  std_logic_vector(11 downto 0);
      trn_fc_nph             : in  std_logic_vector(7 downto 0);
      trn_fc_pd              : in  std_logic_vector(11 downto 0);
      trn_fc_ph              : in  std_logic_vector(7 downto 0);
      trn_fc_sel             : out std_logic_vector(2 downto 0);
      cfg_do                 : in  std_logic_vector(31 downto 0);
      cfg_rd_wr_done_n       : in  std_logic;
      cfg_dwaddr             : out std_logic_vector(9 downto 0);
      cfg_rd_en_n            : out std_logic;
      cfg_err_cor_n          : out std_logic;
      cfg_err_ur_n           : out std_logic;
      cfg_err_ecrc_n         : out std_logic;
      cfg_err_cpl_timeout_n  : out std_logic;
      cfg_err_cpl_abort_n    : out std_logic;
      cfg_err_posted_n       : out std_logic;
      cfg_err_locked_n       : out std_logic;
      cfg_err_tlp_cpl_header : out std_logic_vector(47 downto 0);
      cfg_err_cpl_rdy_n      : in  std_logic;
      cfg_interrupt_n        : out std_logic;
      cfg_interrupt_rdy_n    : in  std_logic;
      cfg_interrupt_assert_n : out std_logic;
      cfg_interrupt_di       : out std_logic_vector(7 downto 0);
      cfg_interrupt_do       : in  std_logic_vector(7 downto 0);
      cfg_interrupt_mmenable : in  std_logic_vector(2 downto 0);
      cfg_interrupt_msienable: in  std_logic;
      cfg_turnoff_ok_n       : out std_logic;
      cfg_to_turnoff_n       : in  std_logic;
      cfg_trn_pending_n      : out std_logic;
      cfg_pm_wake_n          : out std_logic;
      cfg_bus_number         : in  std_logic_vector(7 downto 0);
      cfg_device_number      : in  std_logic_vector(4 downto 0);
      cfg_function_number    : in  std_logic_vector(2 downto 0);
      cfg_status             : in  std_logic_vector(15 downto 0);
      cfg_command            : in  std_logic_vector(15 downto 0);
      cfg_dstatus            : in  std_logic_vector(15 downto 0);
      cfg_dcommand           : in  std_logic_vector(15 downto 0);
      cfg_lstatus            : in  std_logic_vector(15 downto 0);
      cfg_lcommand           : in  std_logic_vector(15 downto 0);
      cfg_pcie_link_state_n  : in  std_logic_vector(2 downto 0);
      cfg_dsn                : out std_logic_vector(63 downto 0);

      dma_req                : IN  STD_LOGIC;
      dma_compl              : OUT STD_LOGIC;
      dma_ack                : OUT STD_LOGIC;
      dma_add_dest           : IN  STD_LOGIC_VECTOR(31 downto 0);
      dma_data               : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      dma_read               : OUT STD_LOGIC;
      dma_size               : IN  STD_LOGIC_VECTOR(7 downto 0);

      --Local Bus
      rd_addr                : out STD_LOGIC_VECTOR(nbbit_add-1 downto 0);
      rd_data                : in STD_LOGIC_VECTOR(31 downto 0);
      rd_be                  : out STD_LOGIC_VECTOR(3 downto 0);
      rd_en                  : out STD_LOGIC;
      wr_addr                : out STD_LOGIC_VECTOR(nbbit_add-1 downto 0);
      wr_data                : out STD_LOGIC_VECTOR(31 downto 0);
      wr_be                  : out STD_LOGIC_VECTOR(3 downto 0);
      wr_en                  : out STD_LOGIC;  
      wr_busy                : in STD_LOGIC
      );
   end component pcie_app_s6;

   component s6_pcie_v1_4 is
   generic (
      TL_TX_RAM_RADDR_LATENCY           : integer    := 0;
      TL_TX_RAM_RDATA_LATENCY           : integer    := 2;
      TL_RX_RAM_RADDR_LATENCY           : integer    := 0;
      TL_RX_RAM_RDATA_LATENCY           : integer    := 2;
      TL_RX_RAM_WRITE_LATENCY           : integer    := 0;
      VC0_TX_LASTPACKET                 : integer    := 14;
      VC0_RX_RAM_LIMIT                  : bit_vector := x"7FF";
      VC0_TOTAL_CREDITS_PH              : integer    := 32;
      VC0_TOTAL_CREDITS_PD              : integer    := 211;
      VC0_TOTAL_CREDITS_NPH             : integer    := 8;
      VC0_TOTAL_CREDITS_CH              : integer    := 40;
      VC0_TOTAL_CREDITS_CD              : integer    := 211;
      VC0_CPL_INFINITE                  : boolean    := TRUE;
      BAR0                              : bit_vector := x"FFFF8000";
      BAR1                              : bit_vector := x"FFFF8000";
      BAR2                              : bit_vector := x"00000000";
      BAR3                              : bit_vector := x"00000000";
      BAR4                              : bit_vector := x"00000000";
      BAR5                              : bit_vector := x"00000000";
      EXPANSION_ROM                     : bit_vector := "0000000000000000000000";
      DISABLE_BAR_FILTERING             : boolean    := FALSE;
      DISABLE_ID_CHECK                  : boolean    := FALSE;
      TL_TFC_DISABLE                    : boolean    := FALSE;
      TL_TX_CHECKS_DISABLE              : boolean    := FALSE;
      USR_CFG                           : boolean    := FALSE;
      USR_EXT_CFG                       : boolean    := FALSE;
      DEV_CAP_MAX_PAYLOAD_SUPPORTED     : integer    := 2;
      CLASS_CODE                        : bit_vector := x"0B4000";
      CARDBUS_CIS_POINTER               : bit_vector := x"00000000";
      PCIE_CAP_CAPABILITY_VERSION       : bit_vector := x"1";
      PCIE_CAP_DEVICE_PORT_TYPE         : bit_vector := x"0";
      PCIE_CAP_SLOT_IMPLEMENTED         : boolean    := FALSE;
      PCIE_CAP_INT_MSG_NUM              : bit_vector := "00000";
      DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT : integer    := 0;
      DEV_CAP_EXT_TAG_SUPPORTED         : boolean    := FALSE;
      DEV_CAP_ENDPOINT_L0S_LATENCY      : integer    := 7;
      DEV_CAP_ENDPOINT_L1_LATENCY       : integer    := 7;
      SLOT_CAP_ATT_BUTTON_PRESENT       : boolean    := FALSE;
      SLOT_CAP_ATT_INDICATOR_PRESENT    : boolean    := FALSE;
      SLOT_CAP_POWER_INDICATOR_PRESENT  : boolean    := FALSE;
      DEV_CAP_ROLE_BASED_ERROR          : boolean    := TRUE;
      LINK_CAP_ASPM_SUPPORT             : integer    := 1;
      LINK_CAP_L0S_EXIT_LATENCY         : integer    := 7;
      LINK_CAP_L1_EXIT_LATENCY          : integer    := 7;
      LL_ACK_TIMEOUT                    : bit_vector := x"00B7";
      LL_ACK_TIMEOUT_EN                 : boolean    := FALSE;
      LL_REPLAY_TIMEOUT                 : bit_vector := x"0204";
      LL_REPLAY_TIMEOUT_EN              : boolean    := FALSE;
      MSI_CAP_MULTIMSGCAP               : integer    := 0;
      MSI_CAP_MULTIMSG_EXTENSION        : integer    := 0;
      LINK_STATUS_SLOT_CLOCK_CONFIG     : boolean    := TRUE;
      PLM_AUTO_CONFIG                   : boolean    := FALSE;
      FAST_TRAIN                        : boolean    := FALSE;
      ENABLE_RX_TD_ECRC_TRIM            : boolean    := FALSE;
      DISABLE_SCRAMBLING                : boolean    := FALSE;
      PM_CAP_VERSION                    : integer    := 3;
      PM_CAP_PME_CLOCK                  : boolean    := FALSE;
      PM_CAP_DSI                        : boolean    := FALSE;
      PM_CAP_AUXCURRENT                 : integer    := 0;
      PM_CAP_D1SUPPORT                  : boolean    := TRUE;
      PM_CAP_D2SUPPORT                  : boolean    := TRUE;
      PM_CAP_PMESUPPORT                 : bit_vector := x"0F";
      PM_DATA0                          : bit_vector := x"00";
      PM_DATA_SCALE0                    : bit_vector := x"0";
      PM_DATA1                          : bit_vector := x"00";
      PM_DATA_SCALE1                    : bit_vector := x"0";
      PM_DATA2                          : bit_vector := x"00";
      PM_DATA_SCALE2                    : bit_vector := x"0";
      PM_DATA3                          : bit_vector := x"00";
      PM_DATA_SCALE3                    : bit_vector := x"0";
      PM_DATA4                          : bit_vector := x"00";
      PM_DATA_SCALE4                    : bit_vector := x"0";
      PM_DATA5                          : bit_vector := x"00";
      PM_DATA_SCALE5                    : bit_vector := x"0";
      PM_DATA6                          : bit_vector := x"00";
      PM_DATA_SCALE6                    : bit_vector := x"0";
      PM_DATA7                          : bit_vector := x"00";
      PM_DATA_SCALE7                    : bit_vector := x"0";
      PCIE_GENERIC                      : bit_vector := "000011101111";
      GTP_SEL                           : integer    := 0;
      CFG_VEN_ID                        : std_logic_vector(15 downto 0) := x"1597";
      CFG_DEV_ID                        : std_logic_vector(15 downto 0) := x"0301";
      CFG_REV_ID                        : std_logic_vector(7 downto 0)  := x"00";
      CFG_SUBSYS_VEN_ID                 : std_logic_vector(15 downto 0) := x"1597";
      CFG_SUBSYS_ID                     : std_logic_vector(15 downto 0) := x"0001";
      REF_CLK_FREQ                      : integer    := 0
   );
   port (
      -- PCI Express Fabric Interface
      pci_exp_txp             : out std_logic;
      pci_exp_txn             : out std_logic;
      pci_exp_rxp             : in  std_logic;
      pci_exp_rxn             : in  std_logic;

      -- Transaction (TRN) Interface
      trn_lnk_up_n            : out std_logic;

      -- Tx
      trn_td                  : in  std_logic_vector(31 downto 0);
      trn_tsof_n              : in  std_logic;
      trn_teof_n              : in  std_logic;
      trn_tsrc_rdy_n          : in  std_logic;
      trn_tdst_rdy_n          : out std_logic;
      trn_terr_drop_n         : out std_logic;
      trn_tsrc_dsc_n          : in  std_logic;
      trn_terrfwd_n           : in  std_logic;
      trn_tbuf_av             : out std_logic_vector(5 downto 0);
      trn_tstr_n              : in  std_logic;
      trn_tcfg_req_n          : out std_logic;
      trn_tcfg_gnt_n          : in  std_logic;

      -- Rx
      trn_rd                  : out std_logic_vector(31 downto 0);
      trn_rsof_n              : out std_logic;
      trn_reof_n              : out std_logic;
      trn_rsrc_rdy_n          : out std_logic;
      trn_rsrc_dsc_n          : out std_logic;
      trn_rdst_rdy_n          : in  std_logic;
      trn_rerrfwd_n           : out std_logic;
      trn_rnp_ok_n            : in  std_logic;
      trn_rbar_hit_n          : out std_logic_vector(6 downto 0);
      trn_fc_sel              : in  std_logic_vector(2 downto 0);
      trn_fc_nph              : out std_logic_vector(7 downto 0);
      trn_fc_npd              : out std_logic_vector(11 downto 0);
      trn_fc_ph               : out std_logic_vector(7 downto 0);
      trn_fc_pd               : out std_logic_vector(11 downto 0);
      trn_fc_cplh             : out std_logic_vector(7 downto 0);
      trn_fc_cpld             : out std_logic_vector(11 downto 0);

      -- Host (CFG) Interface
      cfg_do                  : out std_logic_vector(31 downto 0);
      cfg_rd_wr_done_n        : out std_logic;
      cfg_dwaddr              : in  std_logic_vector(9 downto 0);
      cfg_rd_en_n             : in  std_logic;
      cfg_err_ur_n            : in  std_logic;
      cfg_err_cor_n           : in  std_logic;
      cfg_err_ecrc_n          : in  std_logic;
      cfg_err_cpl_timeout_n   : in  std_logic;
      cfg_err_cpl_abort_n     : in  std_logic;
      cfg_err_posted_n        : in  std_logic;
      cfg_err_locked_n        : in  std_logic;
      cfg_err_tlp_cpl_header  : in  std_logic_vector(47 downto 0);
      cfg_err_cpl_rdy_n       : out std_logic;
      cfg_interrupt_n         : in  std_logic;
      cfg_interrupt_rdy_n     : out std_logic;
      cfg_interrupt_assert_n  : in  std_logic;
      cfg_interrupt_do        : out std_logic_vector(7 downto 0);
      cfg_interrupt_di        : in  std_logic_vector(7 downto 0);
      cfg_interrupt_mmenable  : out std_logic_vector(2 downto 0);
      cfg_interrupt_msienable : out std_logic;
      cfg_turnoff_ok_n        : in  std_logic;
      cfg_to_turnoff_n        : out std_logic;
      cfg_pm_wake_n           : in  std_logic;
      cfg_pcie_link_state_n   : out std_logic_vector(2 downto 0);
      cfg_trn_pending_n       : in  std_logic;
      cfg_dsn                 : in  std_logic_vector(63 downto 0);
      cfg_bus_number          : out std_logic_vector(7 downto 0);
      cfg_device_number       : out std_logic_vector(4 downto 0);
      cfg_function_number     : out std_logic_vector(2 downto 0);
      cfg_status              : out std_logic_vector(15 downto 0);
      cfg_command             : out std_logic_vector(15 downto 0);
      cfg_dstatus             : out std_logic_vector(15 downto 0);
      cfg_dcommand            : out std_logic_vector(15 downto 0);
      cfg_lstatus             : out std_logic_vector(15 downto 0);
      cfg_lcommand            : out std_logic_vector(15 downto 0);

      -- System Interface
      sys_clk                 : in  std_logic;
      sys_reset_n             : in  std_logic;
      trn_clk                 : out std_logic;
      trn_reset_n             : out std_logic;
      received_hot_reset      : out std_logic
      );
   end component s6_pcie_v1_4;

   ----------------------
   -- Signal declarations
   ----------------------

   -- Common
   signal trn_clk_buf                 : std_logic;
   signal trn_reset_buf_n             : std_logic;
   signal trn_lnk_up_buf_n            : std_logic;

   -- Tx
   signal trn_tbuf_av                 : std_logic_vector(5 downto 0);
   signal trn_tcfg_req_n              : std_logic;
   signal trn_terr_drop_n             : std_logic;
   signal trn_tdst_rdy_n              : std_logic;
   signal trn_td                      : std_logic_vector(31 downto 0);
   signal trn_tsof_n                  : std_logic;
   signal trn_teof_n                  : std_logic;
   signal trn_tsrc_rdy_n              : std_logic;
   signal trn_tsrc_dsc_n              : std_logic;
   signal trn_terrfwd_n               : std_logic;
   signal trn_tcfg_gnt_n              : std_logic;
   signal trn_tstr_n                  : std_logic;

   -- Rx
   signal trn_rd                      : std_logic_vector(31 downto 0);
   signal trn_rsof_n                  : std_logic;
   signal trn_reof_n                  : std_logic;
   signal trn_rsrc_rdy_n              : std_logic;
   signal trn_rsrc_dsc_n              : std_logic;
   signal trn_rerrfwd_n               : std_logic;
   signal trn_rbar_hit_n              : std_logic_vector(6 downto 0);
   signal trn_rdst_rdy_n              : std_logic;
   signal trn_rnp_ok_n                : std_logic;

   -- Flow Control
   signal trn_fc_cpld                 : std_logic_vector(11 downto 0);
   signal trn_fc_cplh                 : std_logic_vector(7 downto 0);
   signal trn_fc_npd                  : std_logic_vector(11 downto 0);
   signal trn_fc_nph                  : std_logic_vector(7 downto 0);
   signal trn_fc_pd                   : std_logic_vector(11 downto 0);
   signal trn_fc_ph                   : std_logic_vector(7 downto 0);
   signal trn_fc_sel                  : std_logic_vector(2 downto 0);

   -- Config
   signal cfg_dsn                     : std_logic_vector(63 downto 0);
   signal cfg_do                      : std_logic_vector(31 downto 0);
   signal cfg_rd_wr_done_n            : std_logic;
   signal cfg_dwaddr                  : std_logic_vector(9 downto 0);
   signal cfg_rd_en_n                 : std_logic;

   -- Error signaling
   signal cfg_err_cor_n               : std_logic;
   signal cfg_err_ur_n                : std_logic;
   signal cfg_err_ecrc_n              : std_logic;
   signal cfg_err_cpl_timeout_n       : std_logic;
   signal cfg_err_cpl_abort_n         : std_logic;
   signal cfg_err_posted_n            : std_logic;
   signal cfg_err_locked_n            : std_logic;
   signal cfg_err_tlp_cpl_header      : std_logic_vector(47 downto 0);
   signal cfg_err_cpl_rdy_n           : std_logic;

   -- Interrupt signaling
   signal cfg_interrupt_n             : std_logic;
   signal cfg_interrupt_rdy_n         : std_logic;
   signal cfg_interrupt_assert_n      : std_logic;
   signal cfg_interrupt_di            : std_logic_vector(7 downto 0);
   signal cfg_interrupt_do            : std_logic_vector(7 downto 0);
   signal cfg_interrupt_mmenable      : std_logic_vector(2 downto 0);
   signal cfg_interrupt_msienable     : std_logic;

   -- Power management signaling
   signal cfg_turnoff_ok_n            : std_logic;
   signal cfg_to_turnoff_n            : std_logic;
   signal cfg_trn_pending_n           : std_logic;
   signal cfg_pm_wake_n               : std_logic;

   -- System configuration and status
   signal cfg_bus_number              : std_logic_vector(7 downto 0);
   signal cfg_device_number           : std_logic_vector(4 downto 0);
   signal cfg_function_number         : std_logic_vector(2 downto 0);
   signal cfg_status                  : std_logic_vector(15 downto 0);
   signal cfg_command                 : std_logic_vector(15 downto 0);
   signal cfg_dstatus                 : std_logic_vector(15 downto 0);
   signal cfg_dcommand                : std_logic_vector(15 downto 0);
   signal cfg_lstatus                 : std_logic_vector(15 downto 0);
   signal cfg_lcommand                : std_logic_vector(15 downto 0);
   signal cfg_pcie_link_state_n       : std_logic_vector(2 downto 0);

   -- System (SYS) Interface
   signal sys_clk_c                   : std_logic;
   signal sys_reset_n_c               : std_logic;

begin
   clk_local    <= trn_clk_buf;
   rst_local_n  <= trn_reset_buf_n;
   link_up_n    <= trn_lnk_up_buf_n;
   
   ---------------------------------------------------------
   -- Clock Input Buffer for differential system clock
   ---------------------------------------------------------
   refclk_ibuf : IBUFDS
   port map
   (
      O  => sys_clk_c,
      I  => sys_clk_p,
      IB => sys_clk_n
   );

   ---------------------------------------------------------
   -- Input buffer for system reset signal
   ---------------------------------------------------------
   sys_reset_n_ibuf : IBUF
   port map
   (
      O  => sys_reset_n_c,
      I  => sys_reset_n
   );

   ---------------------------------------------------------
   -- User application
   ---------------------------------------------------------
   app : pcie_app_s6
   generic map (
      nbbit_add  =>     nbbit_add
      )
   port map
   (
      -- Transaction (TRN) Interface
      -- Common lock & reset
      trn_clk                            => trn_clk_buf,
      trn_reset_n                        => trn_reset_buf_n,
      trn_lnk_up_n                       => trn_lnk_up_buf_n,
      -- Common flow control
      trn_fc_cpld                        => trn_fc_cpld,
      trn_fc_cplh                        => trn_fc_cplh,
      trn_fc_npd                         => trn_fc_npd,
      trn_fc_nph                         => trn_fc_nph,
      trn_fc_pd                          => trn_fc_pd,
      trn_fc_ph                          => trn_fc_ph,
      trn_fc_sel                         => trn_fc_sel,
      -- Transaction Tx
      trn_tbuf_av                        => trn_tbuf_av,
      trn_tcfg_req_n                     => trn_tcfg_req_n,
      trn_terr_drop_n                    => trn_terr_drop_n,
      trn_tdst_rdy_n                     => trn_tdst_rdy_n,
      trn_td                             => trn_td,
      trn_tsof_n                         => trn_tsof_n,
      trn_teof_n                         => trn_teof_n,
      trn_tsrc_rdy_n                     => trn_tsrc_rdy_n,
      trn_tsrc_dsc_n                     => trn_tsrc_dsc_n,
      trn_terrfwd_n                      => trn_terrfwd_n,
      trn_tcfg_gnt_n                     => trn_tcfg_gnt_n,
      trn_tstr_n                         => trn_tstr_n,
      -- Transaction Rx
      trn_rd                             => trn_rd,
      trn_rsof_n                         => trn_rsof_n,
      trn_reof_n                         => trn_reof_n,
      trn_rsrc_rdy_n                     => trn_rsrc_rdy_n,
      trn_rsrc_dsc_n                     => trn_rsrc_dsc_n,
      trn_rerrfwd_n                      => trn_rerrfwd_n,
      trn_rbar_hit_n                     => trn_rbar_hit_n,
      trn_rdst_rdy_n                     => trn_rdst_rdy_n,
      trn_rnp_ok_n                       => trn_rnp_ok_n,

      -- Configuration (CFG) Interface
      -- Configuration space access
      cfg_do                             => cfg_do,
      cfg_rd_wr_done_n                   => cfg_rd_wr_done_n,
      cfg_dwaddr                         => cfg_dwaddr,
      cfg_rd_en_n                        => cfg_rd_en_n,
      -- Error signaling
      cfg_err_cor_n                      => cfg_err_cor_n,
      cfg_err_ur_n                       => cfg_err_ur_n,
      cfg_err_ecrc_n                     => cfg_err_ecrc_n,
      cfg_err_cpl_timeout_n              => cfg_err_cpl_timeout_n,
      cfg_err_cpl_abort_n                => cfg_err_cpl_abort_n,
      cfg_err_posted_n                   => cfg_err_posted_n,
      cfg_err_locked_n                   => cfg_err_locked_n,
      cfg_err_tlp_cpl_header             => cfg_err_tlp_cpl_header,
      cfg_err_cpl_rdy_n                  => cfg_err_cpl_rdy_n,
      -- Interrupt generation
      cfg_interrupt_n                    => cfg_interrupt_n,
      cfg_interrupt_rdy_n                => cfg_interrupt_rdy_n,
      cfg_interrupt_assert_n             => cfg_interrupt_assert_n,
      cfg_interrupt_di                   => cfg_interrupt_di,
      cfg_interrupt_do                   => cfg_interrupt_do,
      cfg_interrupt_mmenable             => cfg_interrupt_mmenable,
      cfg_interrupt_msienable            => cfg_interrupt_msienable,
      -- Power managemnt signaling
      cfg_turnoff_ok_n                   => cfg_turnoff_ok_n,
      cfg_to_turnoff_n                   => cfg_to_turnoff_n,
      cfg_trn_pending_n                  => cfg_trn_pending_n,
      cfg_pm_wake_n                      => cfg_pm_wake_n,
      -- System configuration and status
      cfg_bus_number                     => cfg_bus_number,
      cfg_device_number                  => cfg_device_number,
      cfg_function_number                => cfg_function_number,
      cfg_status                         => cfg_status,
      cfg_command                        => cfg_command,
      cfg_dstatus                        => cfg_dstatus,
      cfg_dcommand                       => cfg_dcommand,
      cfg_lstatus                        => cfg_lstatus,
      cfg_lcommand                       => cfg_lcommand,
      cfg_pcie_link_state_n              => cfg_pcie_link_state_n,
      cfg_dsn                            => cfg_dsn,

      dma_req     => dma_req,
      dma_compl   => dma_compl,
      dma_ack     => dma_ack,
      dma_add_dest=> dma_add_dest,
      dma_data    => dma_data,
      dma_read    => dma_read,
      dma_size    => dma_size,

      rd_addr     => rd_addr,
      rd_data     => rd_data,
      rd_be       => rd_be,
      rd_en       => rd_en,
      wr_addr     => wr_addr,
      wr_data     => wr_data,
      wr_be       => wr_be,
      wr_en       => wr_en,
      wr_busy     => wr_busy
  );

   s6_pcie_v1_4_i : s6_pcie_v1_4  generic map
   (
      FAST_TRAIN                        => fast_train
   )
   port map (
      -- PCI Express (PCI_EXP) Fabric Interface
      pci_exp_txp                        => pci_exp_txp,
      pci_exp_txn                        => pci_exp_txn,
      pci_exp_rxp                        => pci_exp_rxp,
      pci_exp_rxn                        => pci_exp_rxn,

      -- Transaction (TRN) Interface
      -- Common clock & reset
      trn_lnk_up_n                       => trn_lnk_up_buf_n,
      trn_clk                            => trn_clk_buf,
      trn_reset_n                        => trn_reset_buf_n,
      -- Common flow control
      trn_fc_sel                         => trn_fc_sel,
      trn_fc_nph                         => trn_fc_nph,
      trn_fc_npd                         => trn_fc_npd,
      trn_fc_ph                          => trn_fc_ph,
      trn_fc_pd                          => trn_fc_pd,
      trn_fc_cplh                        => trn_fc_cplh,
      trn_fc_cpld                        => trn_fc_cpld,
      -- Transaction Tx
      trn_td                             => trn_td,
      trn_tsof_n                         => trn_tsof_n,
      trn_teof_n                         => trn_teof_n,
      trn_tsrc_rdy_n                     => trn_tsrc_rdy_n,
      trn_tdst_rdy_n                     => trn_tdst_rdy_n,
      trn_terr_drop_n                    => trn_terr_drop_n,
      trn_tsrc_dsc_n                     => trn_tsrc_dsc_n,
      trn_terrfwd_n                      => trn_terrfwd_n,
      trn_tbuf_av                        => trn_tbuf_av,
      trn_tstr_n                         => trn_tstr_n,
      trn_tcfg_req_n                     => trn_tcfg_req_n,
      trn_tcfg_gnt_n                     => trn_tcfg_gnt_n,
      -- Transaction Rx
      trn_rd                             => trn_rd,
      trn_rsof_n                         => trn_rsof_n,
      trn_reof_n                         => trn_reof_n,
      trn_rsrc_rdy_n                     => trn_rsrc_rdy_n,
      trn_rsrc_dsc_n                     => trn_rsrc_dsc_n,
      trn_rdst_rdy_n                     => trn_rdst_rdy_n,
      trn_rerrfwd_n                      => trn_rerrfwd_n,
      trn_rnp_ok_n                       => trn_rnp_ok_n,
      trn_rbar_hit_n                     => trn_rbar_hit_n,

      -- Configuration (CFG) Interface
      -- Configuration space access
      cfg_do                             => cfg_do,
      cfg_rd_wr_done_n                   => cfg_rd_wr_done_n,
      cfg_dwaddr                         => cfg_dwaddr,
      cfg_rd_en_n                        => cfg_rd_en_n,
      -- Error reporting
      cfg_err_ur_n                       => cfg_err_ur_n,
      cfg_err_cor_n                      => cfg_err_cor_n,
      cfg_err_ecrc_n                     => cfg_err_ecrc_n,
      cfg_err_cpl_timeout_n              => cfg_err_cpl_timeout_n,
      cfg_err_cpl_abort_n                => cfg_err_cpl_abort_n,
      cfg_err_posted_n                   => cfg_err_posted_n,
      cfg_err_locked_n                   => cfg_err_locked_n,
      cfg_err_tlp_cpl_header             => cfg_err_tlp_cpl_header,
      cfg_err_cpl_rdy_n                  => cfg_err_cpl_rdy_n,
      -- Interrupt generation
      cfg_interrupt_n                    => cfg_interrupt_n,
      cfg_interrupt_rdy_n                => cfg_interrupt_rdy_n,
      cfg_interrupt_assert_n             => cfg_interrupt_assert_n,
      cfg_interrupt_do                   => cfg_interrupt_do,
      cfg_interrupt_di                   => cfg_interrupt_di,
      cfg_interrupt_mmenable             => cfg_interrupt_mmenable,
      cfg_interrupt_msienable            => cfg_interrupt_msienable,
      -- Power management signaling
      cfg_turnoff_ok_n                   => cfg_turnoff_ok_n,
      cfg_to_turnoff_n                   => cfg_to_turnoff_n,
      cfg_pm_wake_n                      => cfg_pm_wake_n,
      cfg_pcie_link_state_n              => cfg_pcie_link_state_n,
      cfg_trn_pending_n                  => cfg_trn_pending_n,
      -- System configuration and status
      cfg_dsn                            => cfg_dsn,
      cfg_bus_number                     => cfg_bus_number,
      cfg_device_number                  => cfg_device_number,
      cfg_function_number                => cfg_function_number,
      cfg_status                         => cfg_status,
      cfg_command                        => cfg_command,
      cfg_dstatus                        => cfg_dstatus,
      cfg_dcommand                       => cfg_dcommand,
      cfg_lstatus                        => cfg_lstatus,
      cfg_lcommand                       => cfg_lcommand,

      -- System (SYS) Interface
      sys_clk                            => sys_clk_c,
      sys_reset_n                        => sys_reset_n_c,
      received_hot_reset                 => OPEN
   );

end rtl;
