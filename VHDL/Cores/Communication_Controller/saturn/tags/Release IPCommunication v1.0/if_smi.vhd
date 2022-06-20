--============================================================================= 
--  TITRE : IF_SPI
--  DESCRIPTION : 
--        Implémente une interface SPI master avec une vitesse de clk_sys / div_rate 
--        Le bus parallèle accepte en entrée un flux de données à écrire et fourni 
--        en sortie un flux de données lues.
--        Il supporte 3 types de commandes selon type_com et sur ordre de exec_com
--          type_com    |           opération
--             0        | Emet sur SPI la totalité des octets fournis précédemment sur TX_DAT
--             1        | Emet sur SPI la totalité des octets fournis précédemment sur TX_DAT
--                      | et récupère en lecture sur SPI nb_read octet et les met à disposition
--                      | sur RX_DAT
--  FICHIER :        if_spi.vhd 
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

ENTITY if_smi IS
   GENERIC (
      div_rate    : INTEGER := 6      -- Diviseur d'horloge système pour obtenir le débit SMI = 2^div_rate
      );
   PORT (
      -- Ports système
      clk_sys     : IN  STD_LOGIC;     -- Clock système à 64 MHz
      rst_n       : IN  STD_LOGIC;     -- Reset génrél système

      -- Interface série
      mdc         : OUT STD_LOGIC;     -- Signal MDC de l'IF SMI
      mdio        : INOUT STD_LOGIC;    -- Signal MDIO de l'IF SMI
      
      smi_datwr   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      smi_datrd   : OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
      smi_com     : IN STD_LOGIC
      );
END if_smi;

ARCHITECTURE rtl of if_smi is
   SIGNAL div_clk       : STD_LOGIC_VECTOR(div_rate-1 DOWNTO 0);  -- Compteur pur diviser l'horloge système
   SIGNAL rise_clk      : STD_LOGIC;                              -- Front montant de l'horloge SMI
   SIGNAL fall_clk      : STD_LOGIC;                              -- Front descendant de l'horloge SMI
   SIGNAL mask_clk      : STD_LOGIC;                              -- Signal de masque de l'horloge SMI
   SIGNAL cpt_bit       : STD_LOGIC_VECTOR(6 DOWNTO 0);           -- Compteur de bit pour le ser/deser
   SIGNAL shifter_tx    : STD_LOGIC_VECTOR(63 DOWNTO 0);          -- SER Tx
   SIGNAL shifter_rx    : STD_LOGIC_VECTOR(15 DOWNTO 0);          -- DESER Rx
   SIGNAL txena         : STD_LOGIC;                              -- Pour sortir le MDIO du 'Z'
   SIGNAL sendcom       : STD_LOGIC;                              -- Fenêtre d'envoi d'une commande
   SIGNAL com_rdwrn     : STD_LOGIC;                              -- Pour mémoriser le type de commande RD ou WR
   
BEGIN
   ------------------------------------------
   -- Process de generation de la clock SMI
   ------------------------------------------
   gen_clk : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         div_clk <= (OTHERS => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         div_clk <= div_clk + 1;
      END IF;
   END PROCESS;
   
   mdc <= 'Z' WHEN (mask_clk = '0') ELSE div_clk(div_clk'LEFT);     -- La clock est active en fonction de la machine d'état
   -- rise_clk est actif au cycle qui précède le front montant effectif
   rise_clk <= '1' WHEN (div_clk = CONV_STD_LOGIC_VECTOR(2**(div_rate-1)-1, div_rate)) ELSE '0';
   -- fall_clk est actif au cycle qui précède le front descendant effectif
   fall_clk <= '1' WHEN (div_clk = CONV_STD_LOGIC_VECTOR(2**div_rate-1, div_rate)) ELSE '0';

   mdio <= 'Z' WHEN (txena = '0') ELSE shifter_tx(63);
   smi_datrd <= shifter_rx;

   rx : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         shifter_rx <= (others => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (mask_clk = '1' AND rise_clk = '1') THEN
            shifter_rx <= shifter_rx(14 DOWNTO 0) & mdio;
         END IF;
      END IF;
   END PROCESS;

   com: PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         sendcom <= '0';
         txena <= '0';
         com_rdwrn <= '0';
         mask_clk <= '0';
         shifter_tx <= (others => '1');
         cpt_bit <= (OTHERS => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (sendcom = '1') THEN
            IF (fall_clk = '1') THEN
               IF (cpt_bit = "0000000") THEN
                  mask_clk <= '1';
                  txena <= '1';
                  cpt_bit <= cpt_bit + 1;
               ELSE
                  IF (cpt_bit /= "1000000") THEN
                     cpt_bit <= cpt_bit + 1;
                     shifter_tx <= shifter_tx(62 downto 0) & '0';
                  ELSE
                     mask_clk <= '0';
                     sendcom <= '0';
                     txena <= '0';
                  END IF;
--                  IF (cpt_bit = "0110000") AND (com_rdwrn = '1') THEN
                  IF (cpt_bit = "0101110") AND (com_rdwrn = '1') THEN
                     txena <= '0';
                  END IF;
               END IF;
            END IF;
         ELSE
            IF (smi_com = '1') THEN
               cpt_bit <= (OTHERS => '0');
               sendcom <= '1';         -- On mémorise la réception de la commande
               shifter_tx <= x"FFFFFFFF" & smi_datwr; --"0101" & "00000" & "11011" & "00" & "1000000000000000";
               IF (smi_datwr(29 DOWNTO 28) = "01") THEN
                  com_rdwrn <= '0';
               ELSIF (smi_datwr(29 DOWNTO 28) = "00") THEN
                  com_rdwrn <= smi_datwr(27);   -- Cas particulier des registres spéciaux du SWITCH
               ELSE
                  com_rdwrn <= '1';
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

END rtl;

