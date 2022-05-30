--============================================================================= 
--  TITRE : FRAME_STORE
--  DESCRIPTION : 
--       Stocke les données applicatives des trames reçues dans une DPRAM
--       Si la trame est mauvaise, le pointeur d'écriture dans la DPRAM est 
--       ramené à sa position initiale 
--       Le MSB (9ème bit de la DPRAM) est à 1 en début de trame

--  FICHIER :        frame_store.vhd 
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
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;

entity frame_store is
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;                    -- Clock système
      rst_n    : IN  STD_LOGIC;                    -- Reset général système

      -- Interfaces vers le le module LAYER2_RX
      sof      : IN  STD_LOGIC;                   -- Indique le début d'une trame en réception sur dat_in
      eof      : IN  STD_LOGIC;                   -- Indique la fin d'une trame en réception sur dat_in
      l2_ok    : IN  STD_LOGIC;                   -- Indique que la trame reçue est correcte d'un point de vue layer 2
      dat_in   : IN  STD_LOGIC_VECTOR(7 downto 0);-- Données de la couche applicative (épurée de la couche layer 2)
      val_in   : IN  STD_LOGIC;                   -- Validant du bus dat_in

      -- Interfaces vers le module interface PIC
      dat_out  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Données utiles de la couche applicative (commande, @, data)
      soc_out  : OUT STD_LOGIC;                    -- Indique que l'octet sur dat_out est le 1e d'une commande
      rd_datout: IN  STD_LOGIC;                    -- Signal de lecture d'un nouvel octet applicatif
      new_frame: OUT STD_LOGIC;                    -- Indique qu'une nouvelle trame est disponible
      com_dispo: OUT STD_LOGIC;                    -- Inidque qu'il y'a des données de commande à traiter dans la DPRAM
      l7_ok    : OUT STD_LOGIC;                    -- Indique que la nouvelle trame est conforme du point de vue layer 7
      overflow : OUT STD_LOGIC                     -- Indique un overflow du buffer de stockage des commandes
      );
end frame_store;

architecture  rtl of frame_store is
   SIGNAL   adread   : STD_LOGIC_VECTOR(9 DOWNTO 0);  -- Signal d'adresse pour la lecture en DPRAM
   SIGNAL   cpt_adread: STD_LOGIC_VECTOR(9 DOWNTO 0); -- Compteur d'adresse pour la lecture en DPRAM
   SIGNAL   adwrite  : STD_LOGIC_VECTOR(9 DOWNTO 0);  -- Compteur d'adresse dynamique pour l'écriture en DPRAM
   SIGNAL   old_adw  : STD_LOGIC_VECTOR(9 DOWNTO 0);  -- Pour mémoriser la première location vide dans la DPRAM
   SIGNAL   wea      : STD_LOGIC_VECTOR(0 DOWNTO 0);  -- Pour transformer le signal d'écriture dans la DPRAM en VECTOR
   SIGNAL   dpram_dw : STD_LOGIC_VECTOR(8 DOWNTO 0);  -- Pour fabriquer le vecteur d'écriture dans la DPRAM
   SIGNAL   dpram_dr : STD_LOGIC_VECTOR(8 DOWNTO 0);  -- Vecteur de lecture dans la DPRAM

   SIGNAL   overflow_buf  : STD_LOGIc;                -- Indique que le buffer de stockage des commandes a débordé

   -- Machine d'état de gestion du module
   TYPE layer7_type IS (idle_st, recdat_st, overflow_st);
   SIGNAL fsm_layer7      : layer7_type;

   COMPONENT dpram
   PORT (
      clka     : IN STD_LOGIC;
      wea      : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra    : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      dina     : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      clkb     : IN STD_LOGIC;
      addrb    : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      doutb    : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
   );
   END COMPONENT;   
   
begin
   --------------------------------------------
   -- Gestion du comtpeur d'adresse en lecture
   --------------------------------------------
   cptr : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         cpt_adread <= (others => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (rd_datout = '1') THEN
         -- Sur chaue ordre de lecture
            cpt_adread <= cpt_adread + 1;    -- On incrméente le pointeur de lecture de la DPRAM
         END IF;
      END IF;
   END PROCESS;
   -- Le pointeur de lecture en DPRAM est soit le compteur, soit la location suiante
   -- Permet d'avoir un fonctionnement style FWFT avec un seul cycle entre le rd et la donnée
   adread <= cpt_adread WHEN (rd_datout = '0') ELSE cpt_adread+1;
   -- Si le pointeur en lecture est différent du pointeur en écriture, on indique qu'il 
   -- y'a des données à traiter
   com_dispo <= '0' WHEN (cpt_adread = old_adw) ELSE '1';
   -- On considère un overflow du buffer de stockage des commandes lorsque le pointeur de write a presque
   -- rattrapé le pointeur de read
   overflow_buf <= '1' WHEN (adwrite = cpt_adread-4) AND (wea(0) = '1') ELSE '0';
   overflow <= overflow_buf;
   
   --------------------------------------------
   -- Machine d'état d'analyse du flux
   --------------------------------------------
   man_fsm : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         old_adw <= (others => '0');
         adwrite <= (others => '0');
         fsm_layer7 <= idle_st;
         l7_ok <= '0';
         new_frame <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_layer7 IS
            WHEN idle_st =>
               l7_ok <= '0';
               new_frame <= '0';
               old_adw <= adwrite;     -- On mémorise l'adresse de départ
               IF (val_in = '1' AND sof = '1') THEN
               -- Si on reçoit la 1ère donnée d'une trame, elle est ne train de s'écrire dans adwrite
                  adwrite <= adwrite+1;   -- on prpépare l'adresse suivante pour le prochain octet
                  fsm_layer7 <= recdat_st;
               END IF;
               
            WHEN recdat_st =>
            -- Etat d'enregistrement des données
               IF (eof = '1') THEN
               -- Si on reçoit le signalde fin de trame
                  new_frame <= '1';       -- On signale une nouvelle trame au module suivant
                  l7_ok <= l2_ok;         -- Si le format de la couche 2 est correct, la trame est bonne
                  IF (l2_ok = '1') THEN
                  -- Si la trame est bonne
                     adwrite <= adwrite-2;-- On supprime les 2 derniers octets qui sont le CRC du layer 2
                  ELSE
                  -- Si la trame es tmauvaise (l2_ok = '0') 
                     adwrite <= old_adw;  -- On ramèné le pointeur d'écriture au début et on va ttendre le sof suivant
                  END IF;                 
                  fsm_layer7 <= idle_st;
               ELSIF (overflow_buf = '1') THEN
                  fsm_layer7 <= overflow_st;
               ELSIF (val_in = '1') THEN
               -- Si ona reçu un octet de plus
                  adwrite <= adwrite + 1;    -- on va l'écrire à l'adresse suivante
               END IF;

            WHEN overflow_st =>
            -- On a eu un overflow
               IF (eof = '1') THEN
               -- On attend le signal de fin de trame
                  new_frame <= NOT(l2_ok);  -- On ne signale une nouvelle trame que si elle est erronnée (pour les stats)
                  l7_ok <= '0';             -- Si on signale une trame, c'est qu'elle est erronnée
                  adwrite <= old_adw;       -- On ramène le pointeur wr à sa position d'origine
                  fsm_layer7 <= idle_st;
               END IF;
 
            WHEN OTHERS =>
               fsm_layer7 <= idle_st;
         END CASE;
      END IF;
   END PROCESS;

   wea(0) <= val_in;                -- signal d'écriture dans la DPRAM
   dpram_dw <= sof & dat_in;        -- Le vecteur d'écriture contient en MSB le signal de début de trame
   dat_out <= dpram_dr(7 DOWNTO 0); -- En lecture de la DPRAM, les 8 MSB sont les données
   soc_out <= dpram_dr(8);          -- Le MSB est le signal de début de commande
   inst_dpram : dpram
   PORT MAP (
      clka => clk_sys,
      wea => wea,
      addra => adwrite,
      dina => dpram_dw,
      clkb => clk_sys,
      addrb => adread,
      doutb => dpram_dr
   );
   
end rtl;

