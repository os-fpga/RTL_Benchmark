--============================================================================= 
--  TITRE : IF_PICSPI
--  DESCRIPTION : 
--       Assure l'interface avec le PIC21 à travers un lien SPI
--       Implémente les registres mémoires tels que définis dans le HSI

--  FICHIER :        if_picspi.vhd 
--=============================================================================
--  CREATION 
--  DATE	AUTEUR	PROJET	REVISION 
--  29/02/2012	DRA	CONCERTO	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	AUTEUR	PROJET	REVISION 
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;



-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY if_picspi IS
   GENERIC (
      version : STD_LOGIC_VECTOR(7 DOWNTO 0));
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;  -- Clock système
      rst_n    : IN  STD_LOGIC;  -- Reset génrél système

      -- Interface SPI
      sclk     : IN  STD_LOGIC;  -- Clock SPI
      sdi      : IN  STD_LOGIC;  -- Bit IN SPI
      sdo      : OUT STD_LOGIC;  -- Bit OUT SPI
      ssn      : IN  STD_LOGIC;  -- CSn SPI

      -- Interface avec les autres modules du FPGA
      -- Tous ces signaux sont synchrones de clk_sys
         -- Signaux de configurations
      iid      : IN  STD_LOGIC_VECTOR(63 DOWNTO 0);   -- Identifiant IID du FPGA
      tid      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);    -- Identifiant TID du FPGA
      cpy1     : OUT STD_LOGIC;                       -- Autorise la recopie du port 1 sur port 2
      cpy2     : OUT STD_LOGIC;                       -- Autorise la recopie du port 2 sur port 1
      repli    : OUT STD_LOGIC;                       -- Indique que le module est en repli (gestion des LED)
      
      -- Interfaces de lecture des trames port 1
      l7_rx1       : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);-- Données reçues sur port 1
      l7_soc1      : IN  STD_LOGIC;                   -- Indique le début d'une trame
      l7_rd1       : OUT STD_LOGIC;                   -- Signal de lecture d'une donnée supplémentaire
      l7_comdispo1 : IN  STD_LOGIC;                   -- Indique qu'il y'a au moins une trame de dispo
      l7_newframe1 : IN  STD_LOGIC;                   -- Indique la réception d'une nouvelle trame
      l7_l2ok1     : IN  STD_LOGIC;                   -- Indique si la couche transport est bonne ou non
      l7_overflow1 : IN  STD_LOGIC;                   -- Indique un overflow sur réception
     
         -- Interfaces de lecture des trames port 2
      l7_rx2       : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);-- Données reçues sur port 2
      l7_soc2      : IN  STD_LOGIC;                   -- Indique le début d'une trame
      l7_rd2       : OUT STD_LOGIC;                   -- Signal de lecture d'une donnée supplémentaire
      l7_comdispo2 : IN  STD_LOGIC;                   -- Indique qu'il y'a au moins une trame de dispo
      l7_newframe2 : IN  STD_LOGIC;                   -- Indique la réception d'une nouvelle trame
      l7_l2ok2     : IN  STD_LOGIC;                   -- Indique si la couche transport est bonne ou non
      l7_overflow2 : IN  STD_LOGIC;                   -- Indique un overflow sur réception

      -- Interface d'écriture des trames
      tx_dat       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);-- Données à transmettre sur les 2 ports
      val_txdat    : OUT STD_LOGIC;                   -- Validant de chaque octet
      tx_sof       : OUT STD_LOGIC;                   -- Indique le début d'une trame
      tx_eof       : OUT STD_LOGIC;                   -- Indique la fin d'une trame
      txdat_free   : IN  STD_LOGIC;                   -- Indique que la couche transport en tx est libre
      clr_fifo_tx  : OUT STD_LOGIC;                   -- Permet de purger les FIFO Tx
      
      -- Gestion de l'interface SPI PROM
      txprom_dat   : OUT STD_LOGIC_VECTOR(7 downto 0);
      txprom_val   : OUT STD_LOGIC; 
      rxprom_dat   : IN  STD_LOGIC_VECTOR(7 downto 0);
      rxprom_val   : IN  STD_LOGIC;
      rxprom_next  : OUT STD_LOGIC;
      prom_type_com: OUT STD_LOGIC;
      prom_exec_com: OUT STD_LOGIC;
      prom_busy    : IN  STD_LOGIC;
      prom_nbread  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      prom_rstn    : OUT STD_LOGIC
      );
END if_picspi;

ARCHITECTURE rtl of if_picspi is
   TYPE fsmtx_state IS (idle_st, senddat_st);
   SIGNAL fsm_tx  : fsmtx_state;

   TYPE fsmrx_state IS (idle_st, pump_st, recdat_st, waitnotempty_st);
   SIGNAL fsm_rx  : fsmrx_state;

   -- Définition du Mapping mémoire des registre SPI
   CONSTANT adreg_iid      : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0, 7);
   CONSTANT adreg_tid      : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(8, 7);
   CONSTANT adreg_ctl      : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(9, 7);
   CONSTANT adreg_stat     : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(10, 7);
   CONSTANT adreg_rxsize1  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(11, 7);
   CONSTANT adreg_rxsize2  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(12, 7);
   CONSTANT adreg_txfree   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(13, 7);
   CONSTANT adreg_fiforx1  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(14, 7);
   CONSTANT adreg_fiforx2  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(15, 7);
   CONSTANT adreg_fifotx   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(16, 7);
   CONSTANT adreg_version  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(17, 7);
   CONSTANT adreg_promtx   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(18, 7);
   CONSTANT adreg_promrx   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(19, 7);
   CONSTANT adreg_promctl  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(20, 7);
   CONSTANT adreg_promnbrd : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(21, 7);
   
   -- Définition des registres internes
   SIGNAL reg_tid_spi      : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_ctl_spi      : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_stat_spi     : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_rx1size_spi  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_rx2size_spi  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_txfree_spi   : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_fiforx1_spi  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_fiforx2_spi  : STD_LOGIC_VECTOR(7 DOWNTO 0);

   -- Signaux de gestion de l'interface SPI
   SIGNAL cpt_bitspi       : STD_LOGIC_VECTOR(2 DOWNTO 0); -- Compte le nombre de bits sur un cycle SPI
   SIGNAL adrd_spi         : STD_LOGIC_VECTOR(6 DOWNTO 0); -- Bus d'adresse d'accès des registres SPI en rd
   SIGNAL adwr_spi         : STD_LOGIC_VECTOR(6 DOWNTO 0); -- Bus d'adresse d'accès des registres SPI en wr
   SIGNAL rwn_spi          : STD_LOGIC;                    -- Mémorise le type d'accès SPI R/Wn
   SIGNAL dat_adn          : STD_LOGIC;          -- Indique si l'octet en cours sur SPI est une data ou l'adresse
   SIGNAL shifter_spirx    : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Registre à déclage de réception SPI
   SIGNAL shifter_spitx    : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Registre à déclage d'émission SPI
   SIGNAL spi_encours      : STD_LOGIC;
   SIGNAL data_rdspi       : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Donnée lue à l'adresse adrd_spi
   SIGNAL wr_reg           : STD_LOGIC;               -- 1 Pulse pour lire le registre adwr_spi
   SIGNAL rd_reg           : STD_LOGIC;               -- 1 pulse pour écrire le registre adrd_spi

   -- Signaux de gestion interne et changement d'horloge
   SIGNAL bfo1    : STD_LOGIC;
   SIGNAL bfo2    : STD_LOGIC;
   SIGNAL ovf1_spi: STD_LOGIC;
   SIGNAL ovf2_spi: STD_LOGIC;
   SIGNAL bfo1_spi: STD_LOGIC;
   SIGNAL bfo2_spi: STD_LOGIC;
   
   SIGNAL cpy1_reg : STD_LOGIC;
   SIGNAL cpy2_reg : STD_LOGIC;
   SIGNAL tid_reg  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL repli_reg: STD_LOGIC;

   SIGNAL difftx_free   : STD_LOGIC_VECTOR(10 DOWNTO 0);
   SIGNAL fifotx_datacnt: STD_LOGIC_VECTOR(10 DOWNTO 0);
   SIGNAL wr_datatx_spi : STD_LOGIC;
   SIGNAL rd_datatx_sys : STD_LOGIC;
   SIGNAL datatx_rd_sys : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL fifotx_empty  : STD_LOGIC;
   SIGNAL rst_fifotx    : STD_LOGIC;
   SIGNAL cpt_tx        : STD_LOGIC_VECTOR(7 DOWNTO 0);
   
   SIGNAL fiforx_datacnt1: STD_LOGIC_VECTOR(10 DOWNTO 0);
   SIGNAL rd_datarx_spi1 : STD_LOGIC;
   SIGNAL fiforx_empty1  : STD_LOGIC;
   SIGNAL firx_e1_r1     : STD_LOGIC;
   SIGNAL firx_e1_r2     : STD_LOGIC;

   SIGNAL fiforx_datacnt2: STD_LOGIC_VECTOR(10 DOWNTO 0);
   SIGNAL rd_datarx_spi2 : STD_LOGIC;
   SIGNAL fiforx_empty2  : STD_LOGIC;
   SIGNAL firx_e2_r1     : STD_LOGIC;
   SIGNAL firx_e2_r2     : STD_LOGIC;

   SIGNAL l7_rd          : STD_LOGIC;
   SIGNAL l7_rd1buf      : STD_LOGIC;
   SIGNAL l7_rd2buf      : STD_LOGIC;
   SIGNAL sel_voie       : STD_LOGIC;
   SIGNAL frm2           : STD_LOGIC;
   SIGNAL frm2_r1        : STD_LOGIC;
   SIGNAL frm2_r2        : STD_LOGIC;
   SIGNAL frm1           : STD_LOGIC;
   SIGNAL frm1_r1        : STD_LOGIC;
   SIGNAL frm1_r2        : STD_LOGIC;
   SIGNAL comdispo       : STD_LOGIC;
   SIGNAL soc            : STD_LOGIC;

   SIGNAL reg_promctl    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_promnbrd   : STD_LOGIC_VECTOR(7 DOWNTO 0);
   
   COMPONENT jk_chgclk
   PORT (
      rstn     : IN  STD_LOGIC;  -- Reset général
      clk1     : IN  STD_LOGIC;  -- Horloge principale 1
      clk2     : IN  STD_LOGIC;  -- Horloge principale 2
      pulsein  : IN  STD_LOGIC;  -- Signal synchronie de clk1 à prendre en compte avec clk2
      pulseout : OUT STD_LOGIC   -- Pulse sur clk2 sur front montant de pulse1
      );
   END COMPONENT;

   COMPONENT fifotx_spi
   PORT (
      rst      : IN STD_LOGIC;
      wr_clk   : IN STD_LOGIC;
      rd_clk   : IN STD_LOGIC;
      din      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en    : IN STD_LOGIC;
      rd_en    : IN STD_LOGIC;
      dout     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      full     : OUT STD_LOGIC;
      empty    : OUT STD_LOGIC;
      wr_data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
      );
   END COMPONENT;
   
   COMPONENT fiforx_spi
   PORT (
      rst      : IN STD_LOGIC;
      wr_clk   : IN STD_LOGIC;
      rd_clk   : IN STD_LOGIC;
      din      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en    : IN STD_LOGIC;
      rd_en    : IN STD_LOGIC;
      dout     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      full     : OUT STD_LOGIC;
      empty    : OUT STD_LOGIC;
      rd_data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
      );
   END COMPONENT;

BEGIN
   --------------------------------------------
   -- Process de gestion du SPI
   --------------------------------------------
   sdo <= shifter_spitx(7);
   rd_reg <= (dat_adn AND rwn_spi AND NOT(ssn)) WHEN (cpt_bitspi = "111" AND spi_encours = '1') ELSE 
             NOT(ssn) WHEN spi_encours = '0' ELSE
             '0';
   wr_reg <= (spi_encours AND dat_adn AND NOT(rwn_spi)) WHEN (cpt_bitspi = "111") ELSE '0';

   serrx_spi : PROCESS(sclk, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         cpt_bitspi  <= (OTHERS => '0');
         adrd_spi    <= (OTHERS => '0');
         adwr_spi    <= (OTHERS => '0');
         rwn_spi     <= '0';
         dat_adn     <= '0';
         shifter_spirx  <= (OTHERS => '0');
         spi_encours    <= '0';
      ELSIF (sclk'EVENT and sclk = '1') THEN
         IF (spi_encours = '1' AND ssn = '0') THEN
         -- Si une transaction SPI est en cours et temps qu'elle est en cours (ssn = '0')
            cpt_bitspi <= cpt_bitspi + 1;                      -- On comtpe librement le nombre de bits de 0 à 7
            shifter_spirx <= shifter_spirx(6 DOWNTO 0) & sdi;  -- On déserailsie tout le temps
            IF (cpt_bitspi = "110") THEN
            -- Si on a déjà reçu 7 bits, le prochain front montant est pour le 8ème en réception
               IF (dat_adn = '0') THEN
               -- Si c'est le 1er octet de la trame SPI
                  IF (sdi = '1') THEN
                     dat_adn <= '1';            -- On mémorise le fait qu'on a eu l'@
                  END IF;
                  rwn_spi <= sdi;            -- On mémorise si c'est un Rd ou un Wr
                  adrd_spi  <= shifter_spirx(6 DOWNTO 0);  -- On mémorise l'adresse d'accès
               ELSE
                  adwr_spi <= adrd_spi;
                  IF (adrd_spi /= adreg_fiforx1 AND 
                      adrd_spi /= adreg_fiforx2 AND
                      adrd_spi /= adreg_fifotx  AND
                      adrd_spi /= adreg_promtx  AND
                      adrd_spi /= adreg_promrx) THEN
                  -- Si on accède à un registre qui n'est pas une FIFO, on incrémente le pointeur d'@
                     adrd_spi <= adrd_spi + 1;
                  END IF;
               END IF;
            ELSIF (cpt_bitspi = "111") THEN
            -- Si on est au 8ème coup d'horloge
               dat_adn <= '1';
            END IF;
         ELSE
         -- Si une transaction n'est pas en cours
            IF (ssn = '0') THEN
            -- Au début d'une transaction
               spi_encours <= '1';              -- Pour détecter le front descendant de ssn
               dat_adn <= '0';                  -- Le prochain octet sera celui de l'adresse
               cpt_bitspi <= (OTHERS => '0');   -- On va comtper de 0 à 7 le nombre de bits
               shifter_spirx(0) <= sdi;         -- Sur ce front on échantillone le premier bit
            ELSE
               spi_encours <= '0';              -- Pour détecter le front descendant de ssn
               adrd_spi <= adreg_stat;
            END IF;            
         END IF;
      END IF;
   END PROCESS;

   sertx_spi : PROCESS(sclk, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         shifter_spitx  <= (OTHERS => '0');
      ELSIF (sclk'EVENT and sclk = '0') THEN
         IF (spi_encours = '1' AND ssn = '0') THEN
         -- Si une transaction SPI est en cours et temps qu'elle est en cours (ssn = '0')
            IF (cpt_bitspi = "111") THEN
            -- Si on est au 8ème coup d'horloge
               shifter_spitx <= data_rdspi;   -- On initialise le déserailsiateur avec la donnée lue
            ELSE
               -- Pour tous les autres bits, on sérialise
               shifter_spitx <= shifter_spitx(6 DOWNTO 0) & '0';
            END IF;
         ELSE
         -- Si une transaction n'est pas en cours
            IF (ssn = '0') THEN
               shifter_spitx <= reg_stat_spi;   -- Il faut sortir le registre de stutut comme 1er donnée
            END IF;            
         END IF;
      END IF;
   END PROCESS;
   
   --------------------------------------------
   -- Process Combinatoire de gestion du Read (MUX)
   --------------------------------------------
   mux_read: PROCESS(adrd_spi, iid, reg_tid_spi, reg_ctl_spi, reg_stat_spi, reg_rx1size_spi, reg_rx2size_spi,
                     reg_txfree_spi, reg_fiforx1_spi, reg_fiforx2_spi, rxprom_val, reg_promnbrd, rxprom_dat, reg_promctl)
   BEGIN
      CASE adrd_spi IS
         WHEN adreg_iid    => data_rdspi <= iid(63 DOWNTO 56);
         WHEN adreg_iid+1  => data_rdspi <= iid(55 DOWNTO 48);
         WHEN adreg_iid+2  => data_rdspi <= iid(47 DOWNTO 40);
         WHEN adreg_iid+3  => data_rdspi <= iid(39 DOWNTO 32);
         WHEN adreg_iid+4  => data_rdspi <= iid(31 DOWNTO 24);
         WHEN adreg_iid+5  => data_rdspi <= iid(23 DOWNTO 16);
         WHEN adreg_iid+6  => data_rdspi <= iid(15 DOWNTO 8);
         WHEN adreg_iid+7  => data_rdspi <= iid(7 DOWNTO 0);
         WHEN adreg_tid    => data_rdspi <= reg_tid_spi;
         WHEN adreg_ctl    => data_rdspi <= reg_ctl_spi;
         WHEN adreg_stat   => data_rdspi <= reg_stat_spi;
         WHEN adreg_rxsize1=> data_rdspi <= reg_rx1size_spi;
         WHEN adreg_rxsize2=> data_rdspi <= reg_rx2size_spi;
         WHEN adreg_txfree => data_rdspi <= reg_txfree_spi;
         WHEN adreg_fiforx1=> data_rdspi <= reg_fiforx1_spi;
         WHEN adreg_fiforx2=> data_rdspi <= reg_fiforx2_spi;
         -- WHEN adreg_fifotx => data_rdspi <= dummy  -- Ce registre est Write Only
         WHEN adreg_version=> data_rdspi <= version;
         WHEN adreg_promctl=> data_rdspi <= rxprom_val & reg_promctl(6 DOWNTO 4) & prom_busy & reg_promctl(2 DOWNTO 0);
         WHEN adreg_promnbrd=>data_rdspi <= reg_promnbrd;
         -- WHEN adreg_promtx => data_rdspi <= dummy  -- Ce registre est Write Only
         WHEN adreg_promrx=> data_rdspi <= rxprom_dat;
         WHEN OTHERS       => data_rdspi <= reg_stat_spi;
      END CASE;
   END PROCESS;

   --------------------------------------------
   -- Process de gestion des écritures dans les registres
   --------------------------------------------
   write_reg : PROCESS(sclk, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_tid_spi <= x"8F";
         reg_ctl_spi <= x"87";
      ELSIF (sclk'EVENT and sclk = '1') THEN
         IF (wr_reg = '1') THEN
            CASE adwr_spi IS
               WHEN adreg_tid  => reg_tid_spi <= shifter_spirx;
               WHEN adreg_ctl  => reg_ctl_spi <= shifter_spirx;
               WHEN OTHERS =>
            END CASE;
         END IF;
      END IF;
   END PROCESS;
   rst_fifotx <= reg_ctl_spi(2);

   --------------------------------------------
   -- Process de gestion du registre de status
   --------------------------------------------
   gest_stat : PROCESS(sclk, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_stat_spi(7 DOWNTO 2) <= (OTHERS => '0');
         frm1_r1 <= '0';
         frm1_r2 <= '0';
         frm2_r1 <= '0';
         frm2_r2 <= '0';
      ELSIF (sclk'EVENT and sclk = '1') THEN
         frm1_r1 <= frm1;              -- Passe les signaux Frame dispo de clk_sys à sclk
         frm1_r2 <= frm1_r1;
         frm2_r1 <= frm2;
         frm2_r2 <= frm2_r1;
         IF (bfo1_spi = '1') THEN
            reg_stat_spi(2) <= '1';
         ELSIF (wr_reg = '1' AND adwr_spi = adreg_stat) THEN
            reg_stat_spi(2) <= reg_stat_spi(2) AND NOT(shifter_spirx(2));
         END IF;
         IF (bfo2_spi = '1') THEN
            reg_stat_spi(3) <= '1';
         ELSIF (wr_reg = '1' AND adwr_spi = adreg_stat) THEN
            reg_stat_spi(3) <= reg_stat_spi(3) AND NOT(shifter_spirx(3));
         END IF;
         IF (ovf1_spi = '1') THEN
            reg_stat_spi(4) <= '1';
         ELSIF (wr_reg = '1' AND adwr_spi = adreg_stat) THEN
            reg_stat_spi(4) <= reg_stat_spi(4) AND NOT(shifter_spirx(4));
         END IF;
         IF (ovf2_spi = '1') THEN
            reg_stat_spi(5) <= '1';
         ELSIF (wr_reg = '1' AND adwr_spi = adreg_stat) THEN
            reg_stat_spi(5) <= reg_stat_spi(5) AND NOT(shifter_spirx(5));
         END IF;
      END IF; 
   END PROCESS;
   reg_stat_spi(1 DOWNTO 0) <= frm2_r2 & frm1_r2;
   
   --------------------------------------------
   -- Process de gestion des changement d'horloge
   --------------------------------------------
   bfo1 <= l7_newframe1 AND NOT(l7_l2ok1);   -- Définition d'une mauvaise trame sur port 1
   bfo2 <= l7_newframe2 AND NOT(l7_l2ok2);   -- Définition d'une mauvaise trame sur port 2
   
   clkovf1 : jk_chgclk PORT MAP(rst_n, clk_sys, sclk, l7_overflow1, ovf1_spi);   
   clkovf2 : jk_chgclk PORT MAP(rst_n, clk_sys, sclk, l7_overflow2, ovf2_spi);   
   clkobfo1: jk_chgclk PORT MAP(rst_n, clk_sys, sclk, bfo1, bfo1_spi);   
   clkobfo2: jk_chgclk PORT MAP(rst_n, clk_sys, sclk, bfo2, bfo2_spi);   

   to_clk_sys : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         cpy1_reg <= '1';
         cpy2_reg <= '1';
         repli_reg <= '1';
         cpy1 <= '1';
         cpy2 <= '1';
         repli <= '1';
      ELSIF (clk_sys'event AND clk_sys ='1') THEN
         cpy1_reg <= reg_ctl_spi(0);
         cpy2_reg <= reg_ctl_spi(1);
         tid_reg  <= reg_tid_spi;
         repli_reg<= reg_ctl_spi(7);
         cpy1 <= cpy1_reg;
         cpy2 <= cpy2_reg;
         tid  <= tid_reg;
         repli<= repli_reg;
      END IF;
   END PROCESS;
   
   --------------------------------------------
   -- Process de gestion de la FIFO Tx
   --------------------------------------------
   difftx_free <= "10000000001" - fifotx_datacnt; -- Calcul du nombre d'octets dispo dans la FIFO 257-cnt
   reg_txfree_spi <= x"FF" WHEN difftx_free(10 DOWNTO 8) /= "000" ELSE  -- Si txfree >=256 on tronque le résultat
                     difftx_free(7 DOWNTO 0);              -- Sinon on donne le résultat

   -- Condition d'écriture d'un octet dans la FIFO TX
   wr_datatx_spi <= '1' WHEN (wr_reg = '1' AND adwr_spi = adreg_fifotx) ELSE '0';
   
   clr_fifo_tx <= '0';              -- Spare pour l'instant on ne fait pas de clear de la fifo tx aval

   -- On lit un octet dans la FIFO TX au début lorsuq'on détecte qu'elle n'est plus vide
   -- ou bien en cours de transfert lorsque le module suivant est dispo
   rd_datatx_sys <= '1' WHEN ((fsm_tx = idle_st AND fifotx_empty = '0') OR
                              (fsm_tx = senddat_st AND txdat_free = '1' AND fifotx_empty = '0')) ELSE
                    '0';

   val_txdat <= NOT(fifotx_empty);
   tx_dat <= datatx_rd_sys;
   tx_eof <= txdat_free AND NOT(fifotx_empty) WHEN (fsm_tx = senddat_st AND cpt_tx = "00000001") ELSE '0';

   gest_fsm_tx : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         fsm_tx <= idle_st;
         tx_sof    <= '0';
         cpt_tx    <= (OTHERS => '0');

      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_tx IS
            WHEN idle_st  => 
            -- Etat d'attente de données dans la FIFO TX
               IF (fifotx_empty = '0') THEN
               -- Si il y'a des données dans la FIFO TX
                  cpt_tx <= datatx_rd_sys;   -- On initialise le compteur avec la longueur de la trame
                  fsm_tx <= senddat_st;      -- On va transmettre des données
                  tx_sof <= '1';             -- On active le sof pour signaler un début de trame
               END IF;

            WHEN senddat_st =>
            -- Etat de transfert d'une donnée
               IF (txdat_free = '1' AND fifotx_empty = '0') THEN
               -- Les données restent sur le bus tx_dat tant que le module suivant n'est pas libre
               -- i.e. tant qu'il a pas platché la donnée actuelle
                  cpt_tx <= cpt_tx - 1;         -- Dans ce cas on enregistre une donnee de moins
                  tx_sof <= '0';                -- On peut annuler le sof car on est sur que le module suivant l'a pris en comtpe
                  IF (cpt_tx = "00000001") THEN -- Lors du dernier octet à transmettre
                     fsm_tx <= idle_st;         -- On a fini
                  END IF;
               END IF;
            
            WHEN OTHERS =>
               fsm_tx <= idle_st;            
         END CASE;
      END IF;
   END PROCESS;

   inst_fiftx : fifotx_spi
   PORT MAP (
      rst      => rst_fifotx,
      wr_clk   => sclk,
      rd_clk   => clk_sys,
      din      => shifter_spirx,
      wr_en    => wr_datatx_spi,
      rd_en    => rd_datatx_sys,
      dout     => datatx_rd_sys,
      full     => OPEN,
      empty    => fifotx_empty,
      wr_data_count => fifotx_datacnt
   );                     
   
   --------------------------------------------
   -- Process de gestion des FIFO Rx
   --------------------------------------------
   rd_datarx_spi1 <= '1' WHEN (rd_reg = '1' AND adrd_spi = adreg_fiforx1) ELSE '0';
   rd_datarx_spi2 <= '1' WHEN (rd_reg = '1' AND adrd_spi = adreg_fiforx2) ELSE '0';

   l7_rd1buf <= (l7_rd AND NOT(sel_voie) AND comdispo AND NOT(soc)) WHEN (fsm_rx = recdat_st) ELSE 
                (l7_rd AND NOT(sel_voie));
   l7_rd1 <= l7_rd1buf;
   l7_rd2buf <= (l7_rd AND sel_voie AND comdispo AND NOT(soc)) WHEN (fsm_rx = recdat_st) ELSE 
                (l7_rd AND sel_voie);
   l7_rd2 <= l7_rd2buf;
   
   comdispo <= l7_comdispo1 WHEN (sel_voie = '0') ELSE l7_comdispo2;
   soc <= l7_soc1 WHEN (sel_voie = '0') ELSE l7_soc2;

   gest_fsm_rx : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         l7_rd <= '0';
         sel_voie <= '0';         
         fsm_rx <= idle_st;
         frm2 <= '0';
         frm1 <= '0';
         firx_e1_r1 <= '0';
         firx_e1_r2 <= '0';
         firx_e2_r1 <= '0';
         firx_e2_r2 <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         firx_e1_r1 <= fiforx_empty1;     -- Passe les FIFO empty sur la clok_sys
         firx_e1_r2 <= firx_e1_r1;
         firx_e2_r1 <= fiforx_empty2;
         firx_e2_r2 <= firx_e2_r1;
         CASE fsm_rx IS
            WHEN idle_st  => 
               frm1 <= NOT(firx_e1_r2);
               frm2 <= NOT(firx_e2_r2);
               IF ((l7_comdispo1 = '1' AND firx_e1_r2 = '1') AND 
                   (l7_comdispo2 = '0' OR  firx_e2_r2 = '0' OR sel_voie = '1')) THEN
                  sel_voie <= '0';
                  l7_rd <= '1';
                  fsm_rx <= pump_st;
               ELSIF (l7_comdispo2 = '1' AND firx_e2_r2 = '1') THEN
                  sel_voie <= '1';
                  l7_rd <= '1';
                  fsm_rx <= pump_st;
               ELSE
                  l7_rd <= '0';
               END IF;
               
            WHEN pump_st =>
               fsm_rx <= recdat_st;

            WHEN recdat_st =>
               IF (soc = '1' OR comdispo = '0') THEN
                  l7_rd <= '0';
                  fsm_rx <= waitnotempty_st;
               END IF;
               
            WHEN waitnotempty_st =>
            -- Etat d'attente que la FIFO soit indiquée comme non vide
            -- Necessaire du fait de la latence entre sclk et clk_sys
               IF ((firx_e1_r2 = '0' AND sel_voie = '0') OR
                  (firx_e2_r2 = '0' AND sel_voie = '1')) THEN
                  frm1 <= NOT(sel_voie);
                  frm2 <= sel_voie;
                  fsm_rx <= idle_st;
               END IF;

            WHEN OTHERS =>
               fsm_rx <= idle_st;            
         END CASE;
      END IF;
   END PROCESS;

   inst_fifrx1 : fiforx_spi
   PORT MAP (
      rst      => NOT(rst_n),
      wr_clk   => clk_sys,
      rd_clk   => sclk,
      din      => l7_rx1,
      wr_en    => l7_rd1buf,
      rd_en    => rd_datarx_spi1,
      dout     => reg_fiforx1_spi,
      full     => OPEN,
      empty    => fiforx_empty1,
      rd_data_count => fiforx_datacnt1
   );                     
   -- Taille de la trame dans la FIFO : 255 si >= 256, sinon Nb octets dans la FIFO
   reg_rx1size_spi <= x"FF" WHEN fiforx_datacnt1(10 DOWNTO 8) /= "000" ELSE
                      fiforx_datacnt1(7 DOWNTO 0);

   inst_fifrx2 : fiforx_spi
   PORT MAP (
      rst      => NOT(rst_n),
      wr_clk   => clk_sys,
      rd_clk   => sclk,
      din      => l7_rx2,
      wr_en    => l7_rd2buf,
      rd_en    => rd_datarx_spi2,
      dout     => reg_fiforx2_spi,
      full     => OPEN,
      empty    => fiforx_empty2,
      rd_data_count => fiforx_datacnt2
   );                     
   -- Taille de la trame dans la FIFO : 255 si >= 256, sinon Nb octets dans la FIFO
   reg_rx2size_spi <= x"FF" WHEN fiforx_datacnt2(10 DOWNTO 8) /= "000" ELSE
                      fiforx_datacnt2(7 DOWNTO 0);

   -------------------------------------------------
   -- Signaux de gestion de l'I/F SPI vers la PROM
   -------------------------------------------------
      --------------------------------------------
   -- Process de gestion des écritures dans les registres
   --------------------------------------------
   write_regpromctl : PROCESS(sclk, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_promctl <= x"00";
         reg_promnbrd <= x"00";
      ELSIF (sclk'EVENT and sclk = '1') THEN
         IF (wr_reg = '1' AND adwr_spi = adreg_promctl) THEN
            reg_promctl <= shifter_spirx;
         ELSE
            reg_promctl(3) <= '0';
         END IF;
         IF (wr_reg = '1' AND adwr_spi = adreg_promnbrd) THEN
            reg_promnbrd <= shifter_spirx;
         END IF;
      END IF;
   END PROCESS;

   txprom_dat     <= shifter_spirx;
   txprom_val     <= wr_reg WHEN (adwr_spi =  adreg_promtx) ELSE '0';
   rxprom_next    <= rd_reg WHEN (adrd_spi =  adreg_promrx) ELSE '0';
   prom_type_com  <= reg_promctl(0);
   prom_exec_com  <= reg_promctl(3);
   prom_rstn      <= reg_promctl(4);
   prom_nbread    <= reg_promnbrd;

END rtl;

