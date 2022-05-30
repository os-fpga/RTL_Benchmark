--============================================================================= 
--  TITRE : MEMORY_MAP
--  DESCRIPTION : 
--        Mappe la zone m�moire du BAR acc�d�e par le bus local sur les registres
--        internes et les DPRAM 
--        Les registres sont accesibles en RD / WR par le bus local. 
--        Les signaux discrets associ�s aux registres sortent/entrent directement.
--        Les zones m�moires utilis�es pour stocker les commandes p�riodiques et 
--        ap�riodiques sont accessibles d'un cot� par le bus local, de l'autre
--        par un bus d�di�.
--
--          BUS LOCAL                                       Bus d�di�
--        Mots de 32 bits                                Mots de 8 bits
--        -----------------|--------------------------|
--                         |0000h                     |
--              BAR 0      |    Registres             |   Pas d'acc�s
--                         |7FFFh                     |
--        -----------------|--------------------------|----------------------
--                         |8000h                0000h|
--                         |    Zone Tx Periodique    |
--                         |87FFh                1FFFh|
--                         |--------------------------|
--                         |8800h                2000h|
--                         |     Zone r�serv�e        |
--                         |8FFFh                3FFFh|
--              BAR 1      |--------------------------|    Acc�s par addrr_tx
--              (RFU)      |9000h                4000h|
--                         |    Zone Tx Ap�riodique   |
--                         |97FFh                5FFFh|
--                         |--------------------------|
--                         |9800h                6000h|
--                         |     Zone r�serv�e        |
--                         |9FFFh                7FFFh|
--        -----------------|--------------------------|---------------------
--                         |A000h                     |
--              BAR 1      |     Zone r�serv�e        |   Pas d'acc�s
--                         |FFFFh                     |
--        -----------------|--------------------------|---------------------
--
--  Les DMA transf�rent les trames re�us Rx1, Rx2, et �mises par le PIC Tx dans 3 zones de 32 buffers chacune.
--  L'adresse de ce transfert vaut @ = DMA_BASE_PA + ZON * 2000h + BUF * 100h
--  Avec :
--	      ZON = 0, 1 ou 2 pour respectivement les zones Rx1, RX2 et Tx
--	      BUF = poids du bit � �1� choisi dans un des registres RX1_AVAI, RX2_AVAI ou TX_AVAI (de 0 � 31).
--
--  FICHIER :        memory_map.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  10/04/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION
--  03/03/2015 DRA      SATURN   V1.1 
--    Rajout du bit 7 au registre status 
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY work;
USE work.package_saturn.ALL;

ENTITY memory_map IS
   GENERIC (
      reg_version : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10"   -- Version du firmware
      );
   PORT (
      clk_sys        : IN  STD_LOGIC;                       -- Clock g�n�ral syst�me � 62.5MHz issue du module IF_PCIE
      rst_n          : IN  STD_LOGIC;                       -- Reset g�n�ral syst�me
      iid            : IN  STD_LOGIC_VECTOR(63 DOWNTO 0);   -- iid du Cocentrateur
      actif_passifn  : IN  STD_LOGIC;                       -- Indique que le concentrateur est actif ou passif

      -- Signaux du bus Local Bus du PCIe
      rd_addr        : IN  STD_LOGIC_VECTOR(NBBIT_ADD_LOCAL-1 DOWNTO 0);
      rd_data        : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      rd_be          : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
      rd_en          : IN  STD_LOGIC;
      wr_addr        : IN  STD_LOGIC_VECTOR(NBBIT_ADD_LOCAL-1 DOWNTO 0);
      wr_data        : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      wr_be          : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
      wr_en          : IN  STD_LOGIC;  
      wr_busy        : OUT STD_LOGIC;
      
      -- Interface Main Process
      -- Controle g�n�ral
      rst_regn       : OUT STD_LOGIC;                       -- Reset du FPGA par registre interne
      store_enable   : OUT STD_LOGIC;                       -- Autorise le stockage de trame dans la m�moire DMA
      dma_inprogress : IN  STD_LOGIC;                       -- Indique qu'un DMA est en cours
      update_ena     : IN  STD_LOGIC;                       -- Indique que les m�moires d'�mission pridoique peuvent �tre modifi�es
      rx_flushn      : OUT STD_LOGIC;                       -- Purge les m�moires de stockage destrames
      topcyc         : IN  STD_LOGIC;                       -- Un pulse indique un d�but de cycle

      -- Autorisation des buffers d'�mission
      tx_ena_periodic: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Signale les buffers periodiques qui peuvent �tre �mis
      tx_ena_aper    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Signale les buffers aperiodiques qui peuvent �tre �mis
      clr_txena_aper : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Indique les buffers aperiodiques qui ont �t� �mis
      
      -- Param�tres DMA
      dma_base_pa    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Adresse de base du DMA cot� micro
      dma_timestamp  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);    -- LSB du num�ro de cycle en cours

      -- Interfaces de gestion des buffers d'enregitrement des trames Rx et Tx
      bufferrx1_full : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Buffers non vides en r�ception cot� port 1
      bufferrx2_full : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Buffers non vides en r�ception cot� port 2
      buffertx_full  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Buffers non vides des trames �mises par le PIC
      newframe_rx1   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Indique un(les) nouveau(x) buffer(s) Rx 1 rempli(s)
      newframe_rx2   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Indique un(les) nouveau(x) buffer(s) Rx 2 rempli(s)
      newframe_tx    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Indique un(les) nouveau(x) buffer(s) Tx rempli(s)
      rx1_overflow   : IN  STD_LOGIC;                       -- Indique l'impossiblit� de stocker une trame re�ue sur Rx1
      rx2_overflow   : IN  STD_LOGIC;                       -- Indique l'impossiblit� de stocker une trame re�ue sur Rx2
      tx_overflow    : IN  STD_LOGIC;                       -- Indique l'impossiblit� de stocker une trame Tx
      rx1_badformat  : IN  STD_LOGIC;                       -- Indique une erreur de fromat sur une trame de Rx1
      rx2_badformat  : IN  STD_LOGIC;                       -- Indique une erreur de fromat sur une trame de Rx2
		clk_96			: IN  STD_LOGIC;                       -- Horloge 96MHz synhcrone des traitements LS1 et LS2               
		rd_force			: IN  STD_LOGIC;                       -- Signal de lecture d'un octet dans la FIFO Force
		data_force		: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);    -- Donn�e lue dans la FIFO Force
		empty_force		: OUT STD_LOGIC;                       -- Indique que la FIFO force est vide
		
      -- Acc�s en lecture � la m�moire de TX Periodic et Aperiodic(en Read) - RFU
      addrr_tx       : IN  STD_LOGIC_VECTOR(14 DOWNTO 0);   -- Bus d'addresse � la DPRAM de stockage des trames Tx
      data_tx        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);    -- Donn�e lue dans la DPRAM
      rd_datatx      : IN  STD_LOGIC;                       -- Signal de lecture dans la DPRAM
      testpoint      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)     -- Signaux de tests g�n�ralistes
     );
END memory_map;

ARCHITECTURE rtl of memory_map is
   -- D�finition des @ des registres sur le bus Local
   CONSTANT msb_addr       : INTEGER := 5;
   CONSTANT ad_iid1        : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "000000";
   CONSTANT ad_iid2        : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "000001";
   CONSTANT ad_controle    : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "000010";
   CONSTANT ad_statut      : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "000011";
   CONSTANT ad_statutrp    : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "000100";
   CONSTANT ad_txenaper    : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "000101";
   CONSTANT ad_txenaaper   : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "000110";
   CONSTANT ad_rx1avai     : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "000111";
   CONSTANT ad_rx2avai     : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "001000";
   CONSTANT ad_txavai      : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "001001";
   CONSTANT ad_dmabasepa   : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "001010";
   CONSTANT ad_timestamp   : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "001011";
   CONSTANT ad_fifoforce   : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "001100";
   CONSTANT ad_testpoint   : STD_LOGIC_VECTOR(msb_addr DOWNTO 0) := "001101";
   
   CONSTANT vec_null : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";

   -- Signaux temporaires de constitution des bus adresse et data (RFU)
   SIGNAL wea_periodic     : STD_LOGIC_VECTOR(3 DOWNTO 0);  -- Pour �crire les 4 fois 8 bits de la DPRAM p�riodique
   SIGNAL addra_periodic   : STD_LOGIC_VECTOR(8 DOWNTO 0);  -- Bus d'addresse cot� A de la DPRAM p�riodique
   SIGNAL addrb_periodic   : STD_LOGIC_VECTOR(10 DOWNTO 0); -- Bus d'addresse cot� B de la DPRAM p�riodique
   SIGNAL rd_data_periodic : STD_LOGIC_VECTOR(31 DOWNTO 0); -- signal de relecture (cot� A) dans la DPRAM p�riodique
   SIGNAL wea_aper         : STD_LOGIC_VECTOR(3 DOWNTO 0);  -- Pour �crire les 4 fois 8 bits de la DPRAM ap�riodique
   SIGNAL addra_aper       : STD_LOGIC_VECTOR(10 DOWNTO 0); -- Bus d'addresse cot� A de la DPRAM ap�riodique
   SIGNAL rd_data_aper     : STD_LOGIC_VECTOR(31 DOWNTO 0); -- signal de lecture dans la DPRAM ap�riodique
   SIGNAL addrr_tx14_r     : STD_LOGIC;                     -- Pour latcher le bit de poids 14 du bius addresse
   SIGNAL rd_dataperiodictx: STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Donn�e lue (cot� B) dans la DPRAM p�riodique
   SIGNAL rd_dataapertx    : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Donn�e lue (cot� B) dans la DPRAM ap�riodique
   SIGNAL rd_data_int      : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Pour passer le bus data read du local bus de Little � Big Endian
   SIGNAL wr_data_int      : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Pour passer le bus data write du local bus de Little � Big Endian
   SIGNAL rd_reg           : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Signal multiplex� de lecture des registres
   SIGNAL mem_rxflush      : STD_LOGIC;                     -- Pour g�rer l'ordre de flush des m�mories Rx
	SIGNAL we_force			: STD_LOGIC;	                  -- Signal d'�criture dans la FIFO de for�age
   
   -- Registres internes
   SIGNAL reg_iid          : STD_LOGIC_VECTOR(63 DOWNTO 0);
   SIGNAL reg_ctl          : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL reg_status       : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL reg_statutrp     : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL reg_txena_per    : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL reg_txena_aper   : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL reg_rx1avai      : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL reg_rx2avai      : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL reg_txavai       : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL reg_dmabasepa    : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL reg_timestamp    : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL reg_testpoint    : STD_LOGIC_VECTOR(31 DOWNTO 0);

   -- Compteurs de satut
   SIGNAL cpt_badfmt1      : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Compteur de trame re�ue avec un mauvais FCS sur port 1
   SIGNAL cpt_badfmt2      : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Compteur de trame re�ue avec un mauvais FCS sur port 2
   
   -- Pour d�tecter un front sur Top_cyc
   SIGNAL top_cyc_r        : STD_LOGIC_VECTOR(2 DOWNTO 0);
   SIGNAL front_topcyc     : STD_LOGIC;

   COMPONENT dpram_periodic
   PORT (
      clka     : IN STD_LOGIC;
      wea      : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      addra    : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      dina     : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      douta    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      clkb     : IN STD_LOGIC;
      enb      : IN STD_LOGIC;
      web      : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addrb    : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
      dinb     : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      doutb    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT dpram_aper
   PORT (
      clka     : IN STD_LOGIC;
      wea      : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      addra    : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
      dina     : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      douta    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      clkb     : IN STD_LOGIC;
      enb      : IN STD_LOGIC;
      web      : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addrb    : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
      dinb     : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      doutb    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
   END COMPONENT;

	COMPONENT fifo_force
	PORT (
		rst 		: IN STD_LOGIC;
		wr_clk 	: IN STD_LOGIC;
		rd_clk 	: IN STD_LOGIC;
		din 		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		wr_en 	: IN STD_LOGIC;
		rd_en 	: IN STD_LOGIC;
		dout 		: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		full 		: OUT STD_LOGIC;
		empty 	: OUT STD_LOGIC
	); 
	END COMPONENT;

   
BEGIN
   wr_busy <= '0';         -- Aucune op�ration de WR sur le bus local ne dure plus d'un cycle de clk_sys
   -- Swap des octets des mots de 32 bits (little endian <-> big endian) 
   wr_data_int <= wr_data( 7 DOWNTO  0) & wr_data(15 DOWNTO  8) & 
                  wr_data(23 DOWNTO 16) & wr_data(31 DOWNTO 24);
   rd_data <= rd_data_int( 7 DOWNTO  0) & rd_data_int(15 DOWNTO  8) & 
              rd_data_int(23 DOWNTO 16) & rd_data_int(31 DOWNTO 24);

   reg_iid <= iid;         -- Affectation de l'IID du module

   -- Affectation des sorties de controle g�n�ral
   store_enable <= reg_ctl(0);   -- Autorise le stockage des trames pour transfert DMA

   -- Affectation des sorties d'autorisation � �mettre des buffers (RFU)
   tx_ena_periodic <= reg_txena_per;
   tx_ena_aper     <= reg_txena_aper;

   -- Affectation des sorties de gestion des buffers de r�ception
   bufferrx1_full <= reg_rx1avai;
   bufferrx2_full <= reg_rx2avai;
   buffertx_full  <= reg_txavai;

   -- Affectation de l'adresse de base du DMA
   dma_base_pa <= reg_dmabasepa;
   dma_timestamp <= reg_timestamp(7 DOWNTO 0);

   testpoint <= reg_testpoint(7 DOWNTO 0);
   
   -- Process pour assurer que le reset interne pilot� par registre dure un clk
   proc_rstreg : PROCESS(clk_sys)
   BEGIN
      IF (clk_sys'event AND clk_sys = '1') THEN
         -- Gestion du reset interne pilot� par registre
         rst_regn <= NOT(reg_ctl(1));
      END IF;
   END PROCESS;

   ---------------------------------------------
   -- Process de gestion des �critures dans les registres
   -- Une �criture est efefctive lorsque le signal WR_EN est actif
   -- et que le vecteur WR_ADDR d�signe une adresse valable dans le BAR0
   -- L'adresse du registre dans le BAR0 est d�finie par:
   --   @ BAR0 + Offset_registre ce qui �quivaut � @BAR OR Offset_registre
   -- car l'@BAR0 est forc�ment align� sur une adresse multiple de la taille du BAR0 (i.e. les LSB sont nuls)
   ---------------------------------------------
   proc_writereg : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_ctl        <= x"00000000";
         reg_txena_per  <= x"00000000";
         reg_txena_aper <= x"00000000";
         reg_rx1avai    <= x"00000000";
         reg_rx2avai    <= x"00000000";
         reg_txavai     <= x"00000000";
         reg_dmabasepa  <= x"00000000";
         reg_testpoint  <= x"00000000";
      ELSIF (clk_sys'event AND clk_sys = '1') THEN
         IF (wr_en = '1' AND wr_addr = (ADD_BASE_BAR0 OR EXT(ad_controle, NBBIT_ADD_LOCAL))) THEN
            reg_ctl <= wr_data_int;
         END IF;
         IF (wr_en = '1' AND wr_addr = (ADD_BASE_BAR0 OR EXT(ad_txenaper, NBBIT_ADD_LOCAL))) THEN
            reg_txena_per <= wr_data_int;
         END IF;
         -- Gestion du registre d'�mission ap�riodique
         loop_txenaaper : FOR i IN 0 TO 31 LOOP
            IF (wr_en = '1' AND wr_addr = (ADD_BASE_BAR0 OR EXT(ad_txenaaper, NBBIT_ADD_LOCAL))) THEN
            -- Si on est en train d'acc�der en WR au registre TX_ENA_APER
               IF (wr_data_int(i) = '1') THEN
               -- Chaque bit de la donn�e � �crire � 1
                  reg_txena_aper(i) <= '1';  -- Place le bit correspondant � 1
               ELSIF (clr_txena_aper(i) = '1') THEN
               -- Si le bit � �crire correspondant est 0 et qu'on re�oit un clear du module de transmission
                  reg_txena_aper(i) <= '0';
               END IF;
            ELSE
            -- Il n'y a pas d'�criture en cours
               IF (clr_txena_aper(i) = '1') THEN
               -- Le registre est inchang� tnat qu'on en re�oit pas un clear du module d'�mission
                  reg_txena_aper(i) <= '0';
               END IF;
            END IF;
         END LOOP;
         -- Gestion du registre de statuts du buffer DMA pour Rx1
         loop_rx1full : FOR i IN 0 TO 31 LOOP
            IF (mem_rxflush = '1') THEN
               reg_rx1avai(i) <= '0';
            ELSIF (newframe_rx1(i) = '1') THEN
            -- Lorsqu'une nouvelle trame est envoy�e par DMA
               reg_rx1avai(i) <= '1';     -- On positionne le bit correspondant
            ELSE
               IF (wr_en = '1' AND wr_addr = (ADD_BASE_BAR0 OR EXT(ad_rx1avai, NBBIT_ADD_LOCAL))) THEN
               -- Sur un WR au registre de RX1_AVAI
                  IF (wr_data_int(i) = '1') THEN
                  -- Seul un '1' cleare le registre
                     reg_rx1avai(i) <= '0';
                  END IF;
               END IF;
            END IF;
         END LOOP;
         -- Gestion du registre de statuts du buffer DMA pour Rx2
         loop_rx2full : FOR i IN 0 TO 31 LOOP
         -- Idem pour RX1_AVAI
            IF (mem_rxflush = '1') THEN
               reg_rx2avai(i) <= '0';
            ELSIF (newframe_rx2(i) = '1') THEN
               reg_rx2avai(i) <= '1';
            ELSE
               IF (wr_en = '1' AND wr_addr = (ADD_BASE_BAR0 OR EXT(ad_rx2avai, NBBIT_ADD_LOCAL))) THEN
                  IF (wr_data_int(i) = '1') THEN
                     reg_rx2avai(i) <= '0';
                  END IF;
               END IF;
            END IF;
         END LOOP;
         -- Gestion du registre de statuts du buffer DMA pour Tx
         loop_txfull : FOR i IN 0 TO 31 LOOP
         -- Idem pour RX2_AVAI
            IF (mem_rxflush = '1') THEN
               reg_txavai(i) <= '0';
            ELSIF (newframe_tx(i) = '1') THEN
               reg_txavai(i) <= '1';
            ELSE
               IF (wr_en = '1' AND wr_addr = (ADD_BASE_BAR0 OR EXT(ad_txavai, NBBIT_ADD_LOCAL))) THEN
                  IF (wr_data_int(i) = '1') THEN
                     reg_txavai(i) <= '0';
                  END IF;
               END IF;
            END IF;
         END LOOP;
         IF (wr_en = '1' AND wr_addr = (ADD_BASE_BAR0 OR EXT(ad_dmabasepa, NBBIT_ADD_LOCAL))) THEN
            reg_dmabasepa <= wr_data_int;
         END IF;
         IF (wr_en = '1' AND wr_addr = (ADD_BASE_BAR0 OR EXT(ad_testpoint, NBBIT_ADD_LOCAL))) THEN
            reg_testpoint <= wr_data_int;
         END IF;
      END IF;
   END PROCESS;
   
   -------------------------------------
   -- Process de gestion du registre STATUT
   -------------------------------------
   proc_status : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_status   <= x"00000000";
      ELSIF (clk_sys'event AND clk_sys = '1') THEN
         IF (wr_en = '1' AND wr_addr = (ADD_BASE_BAR0 OR EXT(ad_statut, NBBIT_ADD_LOCAL))) THEN
         -- Remise � '0' des bits en Write One Clear
         -- Un registre n'est remis � '0' sur WOC que si l'�v�nement corrspondant n'est pas actif
            IF (wr_data_int(0) = '1') THEN
               reg_status(0)  <= front_topcyc;   
            END IF;
            IF (wr_data_int(1) = '1') THEN
               reg_status(1)  <= rx1_overflow;
            END IF;
            IF (wr_data_int(2) = '1') THEN
               reg_status(2) <= rx2_overflow;
            END IF;
            IF (wr_data_int(3) = '1') THEN
               reg_status(3)  <= tx_overflow;
            END IF;
            IF (wr_data_int(4) = '1') THEN
               reg_status(4) <= rx1_badformat;
            END IF;
            IF (wr_data_int(5) = '1') THEN
               reg_status(5) <= rx2_badformat;
            END IF;
         ELSE
            IF (front_topcyc = '1') THEN
               reg_status(0)  <= '1';
            END IF;
            IF (rx1_overflow = '1') THEN
               reg_status(1)  <= '1';
            END IF;
            IF (rx2_overflow = '1') THEN
               reg_status(2) <= '1';
            END IF;
            IF (tx_overflow = '1') THEN
               reg_status(3)  <= '1';
            END IF;
            IF (rx1_badformat = '1') THEN
               reg_status(4)  <= '1';
            END IF;
            IF (rx2_badformat = '1') THEN
               reg_status(5)  <= '1';
            END IF;            
         END IF;
         reg_status(6) <= update_ena;
         reg_status(7) <= actif_passifn;
         reg_status(23 DOWNTO 8) <= (OTHERS => '0');
         reg_status(31 DOWNTO 24) <= reg_version;
      END IF;
   END PROCESS;

   ---------------------------------------------
   -- Process de gestion des registres particuliers
   ---------------------------------------------
   proc_spec : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         mem_rxflush <= '1';  
         rx_flushn   <= '0';  -- Pour faire un Reset au d�marrage
      ELSIF (clk_sys'event AND clk_sys = '1') THEN
         IF (wr_en = '1' AND wr_addr = (ADD_BASE_BAR0 OR EXT(ad_controle, NBBIT_ADD_LOCAL)) AND
             wr_data_int(7) = '1') THEN
         -- Si on �crit un '1' dans le bit 7 du registre de controle
            mem_rxflush <= '1';  -- on m�morise la commande 
         ELSIF (dma_inprogress = '0') THEN
            mem_rxflush <= '0';  -- la commande reste active jusqu'� la fin d'un DMA
         END IF;
         -- le reset du module DMA ne survient que si un DMA n'est pas en cours.
         -- la condition sur mem_rxflush fait en sorte que le rx_flush ne dure qu'1 cycle
         rx_flushn    <= NOT(mem_rxflush) OR dma_inprogress;
      END IF;
   END PROCESS;

   --------------------------------------------------
   -- Process de gestion des compteurs de trame avec un mauvais format
   --------------------------------------------------
   proc_fmt : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         cpt_badfmt1 <= (OTHERS => '0');
         cpt_badfmt2 <= (OTHERS => '0');
      ELSIF (clk_sys'event AND clk_sys = '1') THEN
         IF (rd_en = '1' AND rd_addr = (ADD_BASE_BAR0 OR EXT(ad_statutrp, NBBIT_ADD_LOCAL))) THEN
         -- Les compteurs sont remis � 0 sur un RD du registre. Si l'�v�nement est actif � ce moment l�
         -- on remet pas � 0 mais � 1 -> LSB = �v�nement
            cpt_badfmt1 <= "0000000" & rx1_badformat;
            cpt_badfmt2 <= "0000000" & rx2_badformat;
         ELSE
            IF (rx1_badformat = '1') THEN
               IF (cpt_badfmt1 /= x"FF") THEN
                  cpt_badfmt1 <= cpt_badfmt1 + 1;
               END IF;
            END IF;
            IF (rx2_badformat = '1') THEN
               IF (cpt_badfmt2 /= x"FF") THEN
                  cpt_badfmt2 <= cpt_badfmt2 + 1;
               END IF;
             END IF;            
         END IF;
      END IF;
   END PROCESS;

   reg_statutrp   <= x"0000" & cpt_badfmt2 & cpt_badfmt1;

   ---------------------------------------------
   -- Process de gestion d'un free compteur de cycle indiquant le timestamp
   ---------------------------------------------
   front_topcyc <= NOT(top_cyc_r(2)) AND top_cyc_r(1);
   proc_tmstmp : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_timestamp <= (OTHERS => '0');
         top_cyc_r <= "000";
      ELSIF (clk_sys'event AND clk_sys = '1') THEN
         top_cyc_r <= top_cyc_r(1 DOWNTO 0) & topcyc; -- Pour d�tecter un front montant de top_cyc qu est g�n�r� � 96MHz
         IF (front_topcyc = '1') THEN
            reg_timestamp <= reg_timestamp + 1;
         END IF;
      END IF;
   END PROCESS;

   ---------------------------------------------
   -- Multiplexage du bus de donn�e local en lecture
   ---------------------------------------------
   -- S�lection entre registres ou m�moires internes selon MSB du bus local
   rd_data_int <= 
      rd_data_periodic      WHEN (rd_addr(NBBIT_ADD_LOCAL-1 DOWNTO NBBIT_ADD_LOCAL-4) = ADD_BASE_TXPER(NBBIT_ADD_LOCAL-1 DOWNTO NBBIT_ADD_LOCAL-4)) ELSE
      rd_data_aper          WHEN (rd_addr(NBBIT_ADD_LOCAL-1 DOWNTO NBBIT_ADD_LOCAL-4) = ADD_BASE_TXAPER(NBBIT_ADD_LOCAL-1 DOWNTO NBBIT_ADD_LOCAL-4)) ELSE
      rd_reg;

   -- Multiplexage des registres en lecture
   proc_readreg : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         rd_reg     <= (OTHERS => '0');
      ELSIF (clk_sys'event AND clk_sys = '1') THEN
         CASE rd_addr(msb_addr DOWNTO 0) IS
            WHEN ad_iid1 =>
               rd_reg <= reg_iid(31 DOWNTO  0);
            WHEN ad_iid2 =>
               rd_reg <= reg_iid(63 DOWNTO 32);
            WHEN ad_controle =>
               rd_reg <= reg_ctl;
            WHEN ad_statut =>
               rd_reg <= reg_status;
            WHEN ad_statutrp =>
               rd_reg <= reg_statutrp;
            WHEN ad_txenaper =>
               rd_reg <= reg_txena_per;
            WHEN ad_txenaaper =>
               rd_reg <= reg_txena_aper;
            WHEN ad_rx1avai =>
               rd_reg <= reg_rx1avai;
            WHEN ad_rx2avai =>
               rd_reg <= reg_rx2avai;
            WHEN ad_txavai =>
               rd_reg <= reg_txavai;
            WHEN ad_dmabasepa =>
               rd_reg <= reg_dmabasepa;
            WHEN ad_timestamp =>
               rd_reg <= reg_timestamp;            
            WHEN ad_testpoint =>
               rd_reg <= reg_testpoint;            
            WHEN OTHERS =>
               rd_reg <= reg_status;
         END CASE;
      END IF;
   END PROCESS;
      
   --------------------------------------------
   -- Gestion du bloc m�moire de transmission APERIODIC
   --------------------------------------------
   we_force   <= wr_en WHEN wr_addr = (ADD_BASE_BAR0 OR EXT(ad_fifoforce, NBBIT_ADD_LOCAL)) ELSE '0';

	inst_force : fifo_force
	PORT MAP(
		rst 		=> front_topcyc,
		wr_clk 	=> clk_sys,
		rd_clk 	=> clk_96,
		din 		=> wr_data_int,
		wr_en 	=> we_force,
		rd_en 	=> rd_force,
		dout 		=> data_force,
		full 		=> OPEN,
		empty 	=> empty_force
	); 

   --------------------------------------
   -- M�morisation du MSB de addrr_tx pour savoir quelle zone est lue (p�riodique ou ap�riodique)
   -- Lorsqu'un module de transmission lit une m�moire APER ou PER
   -- La donn�e est dispo un cycle apr�s. On m�morise le MSB de l'adresse pour savoir quelle
   -- zone a �t� address�e
   --------------------------------------
   lat_addr14 : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         addrr_tx14_r <= '0';
      ELSIF (clk_sys'event AND clk_sys = '1') THEN
         addrr_tx14_r <= addrr_tx(14);
      END IF;
   END PROCESS;
   data_tx <= rd_dataperiodictx WHEN (addrr_tx14_r = '0') ELSE rd_dataapertx;
   
   --------------------------------------------
   -- Gestion du bloc m�moire de transmission PERIODIC (RFU)
   --------------------------------------------
   -- Le bloc periodic fait 32 zones de 256 octets mais seuls les 64 premiers octets de chaque zone sont mapp�s
   -- Arrangement des bits d'adresses pour le bus sp�cifique
   addrb_periodic <= addrr_tx(12 DOWNTO 8) & addrr_tx(5 DOWNTO 0);
   -- Multiplexage et arrangement des bits d'adresses pour le bus local
   addra_periodic <= (wr_addr(10 DOWNTO 6) & wr_addr(3 DOWNTO 0)) WHEN (wr_en = '1') ELSE 
                     (rd_addr(10 DOWNTO 6) & rd_addr(3 DOWNTO 0));
   -- G�n�ration des signaux de WR dans la zone P�riodique
   wea_periodic   <= (wr_be(3 DOWNTO 0) AND (wr_en & wr_en & wr_en & wr_en)) WHEN
                     (wr_addr(NBBIT_ADD_LOCAL-1 DOWNTO NBBIT_ADD_LOCAL-4) = ADD_BASE_TXPER(NBBIT_ADD_LOCAL-1 DOWNTO NBBIT_ADD_LOCAL-4)) ELSE "0000";
   dpr_periodic : dpram_periodic
   PORT MAP(
      clka     => clk_sys,
      wea      => wea_periodic,
      addra    => addra_periodic,
      dina     => wr_data_int,
      douta    => rd_data_periodic,
      clkb     => clk_sys,
      enb      => rd_datatx,
      web      => vec_null(0 DOWNTO 0),
      addrb    => addrb_periodic,
      dinb     => vec_null(7 DOWNTO 0),
      doutb    => rd_dataperiodictx
   );

   --------------------------------------------
   -- Gestion du bloc m�moire de transmission APERIODIC (RFU)
   --------------------------------------------
   -- Multiplexage des bits d'adresse pour le bus local
   addra_aper <= wr_addr(10 DOWNTO 0) WHEN (wr_en = '1') ELSE rd_addr(10 DOWNTO 0);
   -- G�n�ration des signaux de WR dans la zone Ap�riodique
   wea_aper   <= (wr_be(3 DOWNTO 0) AND (wr_en & wr_en & wr_en & wr_en)) WHEN
                 (wr_addr(NBBIT_ADD_LOCAL-1 DOWNTO NBBIT_ADD_LOCAL-4) = ADD_BASE_TXAPER(NBBIT_ADD_LOCAL-1 DOWNTO NBBIT_ADD_LOCAL-4)) ELSE "0000";
   dpr_aper : dpram_aper
   PORT MAP(
      clka     => clk_sys,
      wea      => wea_aper,
      addra    => addra_aper,
      dina     => wr_data_int,
      douta    => rd_data_aper,
      clkb     => clk_sys,
      enb      => rd_datatx,
      web      => vec_null(0 DOWNTO 0),
      addrb    => addrr_tx(12 DOWNTO 0),
      dinb     => vec_null(7 DOWNTO 0),
      doutb    => rd_dataapertx
   );
   
END rtl;

