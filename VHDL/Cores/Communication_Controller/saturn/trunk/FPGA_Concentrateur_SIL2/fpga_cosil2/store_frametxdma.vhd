--============================================================================= 
--  TITRE : STORE_FRAMETXDMA
--  DESCRIPTION : 
--        Stocke une trame �mise par le PIC dans un buffer tournant
--        On �crit le nombre d 'octets au d�but de la zone 
--  FICHIER :        store_frametxdma.vhd 
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

LIBRARY work;
USE work.package_saturn.ALL;

ENTITY store_frametxdma IS
   PORT (
      clk_sys        : IN  STD_LOGIC;                    -- Horloge syst�me
      rst_n          : IN  STD_LOGIC;                    -- Reset g�n�ral syst�me
      store_enable   : IN  STD_LOGIC;                    -- Autorise le stockage des trames incidentes
      -- Interface de r�ception des trames Rx
      data_store     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Donn�es � stocker.  
      val_store      : IN  STD_LOGIC;                    -- Validant du bus data_store(signal write)
      sof_store      : IN  STD_LOGIC;                    -- Indique und d�but de trame (nouvelle trame). Synchrone du 1er octet envoy�
      eof_store      : IN  STD_LOGIC;                    -- Indique que la trame est finie (plus de donn�es � envoyer)
   
      -- Interface de restitution des trames enregistr�es
      frame_dispo    : OUT STD_LOGIC;                    -- Indique qu'il y'a au moins une trame dispo � �mettre
      frame_data     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);-- Donn�es � �mettre (lue comme une FIFO en FWFT)
      frame_rd       : IN  STD_LOGIC;                    -- Signal de lecture d'une donn�e
      overflow       : OUT STD_LOGIC;                    -- Indique que le pointeur d'�criture a rattraper celui de lecture
      timestamp      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0)  -- Pour timestamper la r�cetion des trames 
   );
END store_frametxdma;

ARCHITECTURE rtl of store_frametxdma is
   CONSTANT nbbit_add8 : integer := 12;                  -- Nombre de bit du bus d'adresse du buffer
   CONSTANT vecnull    : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
   
   SIGNAL cpt_adwr : STD_LOGIC_VECTOR(nbbit_add8-1 DOWNTO 0);  -- Compteur et pointeur d'�criture
   SIGNAL cpt_adrd : STD_LOGIC_VECTOR(nbbit_add8-2-1 DOWNTO 0);-- Compteur de lecture
   SIGNAL old_adwr : STD_LOGIC_VECTOR(nbbit_add8-2-1 DOWNTO 0);-- 1er empalcement libre dans la m�moire
   SIGNAL adread   : STD_LOGIC_VECTOR(nbbit_add8-2-1 DOWNTO 0);-- Pointeur de lecture
   SIGNAL cpt_byte : STD_LOGIC_VECTOR(7 DOWNTO 0);             -- Compteur d'octet dans une trame
   SIGNAL data_wr  : STD_LOGIC_VECTOR(7 DOWNTO 0);             -- Donn�e � �crire dans la DPRAM
   SIGNAL wr_dpram : STD_LOGIC;                                -- Signal d'�criture dans la DPRAM
   SIGNAL wea      : STD_LOGIC_VECTOR(0 DOWNTO 0);

   TYPE fsm_write_type IS (idlewr_st, write_payload_st, store_cpt_st, clr_msbsize_st, gest_over_st); -- Machine d'�tat d'�criture d'une trame
   SIGNAL fsm_write : fsm_write_type;

   -- DPRAM de stockage
   COMPONENT dpram_storerx
      PORT (
         clka  : IN STD_LOGIC;
         wea   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
         addra : IN STD_LOGIC_VECTOR(nbbit_add8-1 DOWNTO 0);
         dina  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
         clkb  : IN STD_LOGIC;
         web   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
         addrb : IN STD_LOGIC_VECTOR(nbbit_add8-2-1 DOWNTO 0);
         dinb  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
   END COMPONENT;
   
BEGIN
   
   --------------------------------------------
   -- Gestion du compteur d'adresse de la DPRAM en lecture
   --------------------------------------------
   cptr : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         cpt_adrd <= (others => '0');
         frame_dispo <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (frame_rd = '1') THEN
         -- A chaque don�ne lue
            cpt_adrd <= cpt_adrd + 1;
         END IF;
         IF (cpt_adrd /= old_adwr) THEN
         -- Si le pointeur en lecture est diff�rent du pointeur en �criture, on indique qu'il 
         -- y'a des donn�es � traiter
            frame_dispo <= '1';
         ELSE
            frame_dispo <= '0';
         END IF;
      END IF;
   END PROCESS;
   -- Permet d'avoir un fonctionnement style FWFT avec un seul cycle entre le rd et la donn�e
   adread <= cpt_adrd WHEN (frame_rd = '0') ELSE cpt_adrd+1;

   --------------------------------------------
   -- Machine d'�tat d'�criture du flux
   --------------------------------------------
   wr_fsm : PROCESS(clk_sys, rst_n)
      VARIABLE temp : STD_LOGIC_VECTOR(nbbit_add8-1 DOWNTO 0);
   BEGIN
      IF (rst_n = '0') THEN
         fsm_write <= idlewr_st;
         cpt_adwr <= (others => '0');
         old_adwr <= (others => '0');
         cpt_byte <= (others => '0');
         overflow <= '0';
         wr_dpram <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_write IS
            WHEN idlewr_st =>
            -- Etat d'attente d'un SOF
               overflow <= '0';
               IF (val_store = '1' AND sof_store = '1' AND store_enable = '1') THEN
               -- Sur SOF et que le store est autoris�
                  cpt_adwr <= (old_adwr + 1) & "00";  -- On r�serve un espace pour stocker la longueur
                  data_wr <= data_store;              -- On va �crire la premi�re donn�e
                  wr_dpram <= '1';                    -- On va �crire
                  cpt_byte <= x"01";                  -- On a 1 octet utile
                  fsm_write <= write_payload_st;
               ELSE
                  wr_dpram <= '0';
               END IF;
               
            WHEN write_payload_st =>
            -- Etat d'attente du EOF
               IF (wr_dpram = '1') AND ((cpt_adwr(nbbit_add8-1 DOWNTO 2) = cpt_adrd-4) OR 
                                        (cpt_adwr(nbbit_add8-1 DOWNTO 2) = cpt_adrd-3)) THEN
               -- On a un overflow si on �crit et que le pointeur wr a rattrap� le pointeur rd
               -- On teste par rapprot � 2 valeurs du pointeurs de lecture car sinon, le fonctionnement
               -- en FWFT peut faire qu'on loupe une valeur
                  overflow <= '1';
                  wr_dpram <= '0';
                  IF (eof_store = '1') THEN
                  -- Si c'est �galement le dernier mot de la trame
                     fsm_write <= idlewr_st;
                  ELSE
                  -- Si c'est pas le derneir, on va attendre la fin de la trame
                     fsm_write <= gest_over_st;
                  END IF;
               ELSE
                  IF (val_store = '1') THEN
                  -- A cqhaue nouvelle donn�e
                     cpt_adwr <= cpt_adwr + 1;     -- On va l'�crire � l'adresse suivante
                     cpt_byte <= cpt_byte + 1;     -- On la compte
                     data_wr <= data_store;        -- On l'�crit telle quelle
                     wr_dpram <= '1';
                     IF (eof_store = '1') THEN
                     -- Si c'�tait la derni�re de la trame
                        fsm_write <= store_cpt_st;
                     END IF;
                  ELSE
                     wr_dpram <= '0';
                  END IF;
               END IF;

            WHEN store_cpt_st =>
            -- Etat de stockage du nombre d'octets dans le LSB 1er mot de 32 bits 
               cpt_adwr <= old_adwr & "00";     -- On va stocker le nombre d'octets utiles dans les LSB du au d�but
               data_wr <= cpt_byte;             -- On garde toutes les donn�es �crites
               temp := cpt_adwr;                -- On arrondit le nouveau pointeur d'�criture au multiple de 4 sup�rieur
               old_adwr <= temp(nbbit_add8-1 DOWNTO 2) + 1;
               wr_dpram <= '1';
               fsm_write<= clr_msbsize_st;

            WHEN clr_msbsize_st =>
            -- Etat de fabrication des MSB du 1er mot de 32 bits
            -- La premi�re zone m�moire du bloc contient:
            -- LSB : Taille du bloc
            -- LSB+1 : 0
            -- LSB+2 : 0
            -- MSB : Timestamp
               cpt_adwr(1 DOWNTO 0) <= cpt_adwr(1 DOWNTO 0) + 1;
               IF (cpt_adwr(1 DOWNTO 0) = "10") THEN
               -- On va �crire le time stamp dans les 8 MSB de la 1�re zone
                  data_wr <= timestamp;
                  fsm_write <= idlewr_st;
               ELSE
               -- On cleare les LSB+1 et LSB+2
                  data_wr <= x"00";
               END IF;
            
            WHEN gest_over_st =>
               overflow <= '0';
               wr_dpram <= '0';
               IF (eof_store = '1') THEN
               -- On attend le signal de fin trame pour recommencer � traiter
                  fsm_write <= idlewr_st;
               END IF;
               
            WHEN OTHERS =>
               fsm_write <= idlewr_st;
         END CASE;
      END IF;
   END PROCESS;

   wea(0) <= wr_dpram;
   store : dpram_storerx
      PORT MAP (
         clka => clk_sys,
         wea => wea,
         addra => cpt_adwr,
         dina => data_wr,
         douta => OPEN,
         clkb => clk_sys,
         web => vecnull(0 DOWNTO 0),
         addrb => adread,
         dinb => vecnull,
         doutb => frame_data
      );
END rtl;

