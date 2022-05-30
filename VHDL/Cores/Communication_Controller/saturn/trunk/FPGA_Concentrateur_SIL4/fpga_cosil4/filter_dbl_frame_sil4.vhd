--===========================================================================================
-- filter_dbl_frame_sil4
--  DESCRIPTION : 
--    Réceptionne les flux sur port 1 et port 2 en couche 2 et détermine
--    si la trame a déjà été reçue ou non
--    Si la trmae a déjà été reçue, elle n'est pas gardée en mémoire
--    Les trames sont dupliquées à terme pour êter envoyées à la fois vers PIC1 et PIC2
--       
--  FICHIER :        filter_dbl_frame_sil4.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  20/10/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION 
--  16/01/2015 DRA      SATURN   V1.1
--    Evolution du module ana_double_frame
--    Gestion du signal fsm1_ready pour n'envoyer des données que lorsque 
--    ana_double_frame est prêt à recevoir
--=============================================================================

--------------------------------------------------------------------------------
-- LIBRAIRIES:
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

--------------------------------------------------------------------------------
-- ENTITY DECLARATION:
--------------------------------------------------------------------------------
ENTITY filter_dbl_frame_sil4 IS
   PORT (
      -- Ports système
      clk_sys        : IN STD_LOGIC;   -- Clock Systeme
      rst_n          : IN STD_LOGIC;   -- Reset Systeme
      top_cycle      : IN  STD_LOGIC;  -- TOP cycle utilsié pour clearer la mémoire de stockage
      ena_filt_dble  : IN  STD_LOGIC;  -- Indique s'il faut ou non appliquer le filtrage
      
      -- Flux de donnée venant des ports 1 et 2 (avant filtrage)
      data_port1           : IN STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de données venant du coté 1
      soc_port1            : IN STD_LOGIC;                     -- Indique un début de trame sur le port1
      com_dispo1           : IN STD_LOGIC;                     -- Signal indiquant que des data sont pretes cote 1
      rd_port1             : OUT STD_LOGIC;                    -- Ordre de lecture vers le cote 1
      data_port2           : IN STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de données venant du coté 2
      soc_port2            : IN STD_LOGIC;                     -- Indique un début de trame sur le port2
      com_dispo2           : IN STD_LOGIC;                     -- Signal indiquant que des data sont pretes cote 2
      rd_port2             : OUT STD_LOGIC;                    -- Ordre de lecture vers le cote 2

      -- Flux de donnée port 1 et 2 filtré vers le PIC1
      data_filt1_uc1       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Flux de données filtré coté 1
      soc_filt1_uc1        : OUT STD_LOGIC;                    -- Indique un début de trame filtrée sur le port1
      frm_dispo_filt1_uc1  : OUT STD_LOGIC;                    -- Signal indiquant que des data filtrées sont pretes cote 1
      rd_filt1_uc1         : IN  STD_LOGIC;                    -- Ordre de lecture de données filtrées du cote 1
      data_filt2_uc1       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Flux de données filtré coté 2
      soc_filt2_uc1        : OUT STD_LOGIC;                    -- Indique un début de trame filtrée sur le port2
      frm_dispo_filt2_uc1  : OUT STD_LOGIC;                    -- Signal indiquant que des data filtrées sont pretes cote 2
      rd_filt2_uc1         : IN  STD_LOGIC;                    -- Ordre de lecture de données filtrées du cote 2

      -- Flux de donnée port 1 et 2 filtré vers le PIC2
      data_filt1_uc2       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Flux de données filtré coté 1
      soc_filt1_uc2        : OUT STD_LOGIC;                    -- Indique un début de trame filtrée sur le port1
      frm_dispo_filt1_uc2  : OUT STD_LOGIC;                    -- Signal indiquant que des data filtrées sont pretes cote 1
      rd_filt1_uc2         : IN  STD_LOGIC;                    -- Ordre de lecture de données filtrées du cote 1
      data_filt2_uc2       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Flux de données filtré coté 2
      soc_filt2_uc2        : OUT STD_LOGIC;                    -- Indique un début de trame filtrée sur le port2
      frm_dispo_filt2_uc2  : OUT STD_LOGIC;                    -- Signal indiquant que des data filtrées sont pretes cote 2
      rd_filt2_uc2         : IN  STD_LOGIC;                    -- Ordre de lecture de données filtrées du cote 2

      -- Signaux de monitoring de la fonction
      dpram_overflow1      : OUT STD_LOGIC;        -- Indique un débordement sur la DPRAM de stockage pour le flux 1
      dpram_overflow2      : OUT STD_LOGIC         -- Indique un débordement sur la DPRAM de stockage pour le flux 2
      );
END filter_dbl_frame_sil4;

--------------------------------------------------------------------------------
-- ARCHITECTURE:
--------------------------------------------------------------------------------
ARCHITECTURE rtl of filter_dbl_frame_sil4 IS
   CONSTANT nbbit_add : INTEGER := 12;     -- Nb bit du bus adresse de stockage des données en DPRAM

   -- Machine d'état de réception des trames port 1 et port 2
   TYPE filterfsm_type IS (idle_st, pump_st, wait_eof_st, wait_res_ana_st);
   SIGNAL filterfsm1    : filterfsm_type;
   SIGNAL filterfsm2    : filterfsm_type;

   SIGNAL addrwr1_uc1    : STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Pointeur d'adresse en ecriture DPRAM coté 1
   SIGNAL old_addwr1_uc1 : STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Pointeur de première adresse vide en DPRAM coté 1
   SIGNAL addrwr1_uc2    : STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Pointeur d'adresse en ecriture DPRAM coté 1
   SIGNAL old_addwr1_uc2 : STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Pointeur de première adresse vide en DPRAM coté 1
   SIGNAL cpt_adread1_uc1: STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Compteur d'adresse en lecture DPRAM coté 1
   SIGNAL adread1_uc1    : STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Pointeur d'adresse en lecture DPRAM coté 1
   SIGNAL cpt_adread1_uc2: STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Compteur d'adresse en lecture DPRAM coté 1
   SIGNAL adread1_uc2    : STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Pointeur d'adresse en lecture DPRAM coté 1
   SIGNAL sof1           : STD_LOGIC;                              -- Pour indiquer au moduel d'analyse le début de la trame
   SIGNAL voie1_ready    : STD_LOGIC;                              -- Indique que la voie1 est prête à traiter des données
   SIGNAL dont_keep1     : STD_LOGIC;                              -- Indique qu'il ne faut pas garder la trame
   SIGNAL end_ana1       : STD_LOGIC;                              -- Indique la fin de la routine d'analyse de double trame
   SIGNAL overflow1_uc1  : STD_LOGIC;                              -- Signal de débordement mémoire coté 1
   SIGNAL lat_ovrflw1_uc1: STD_LOGIC;                              -- Signal de latch d'un débordement
   SIGNAL overflow1_uc2  : STD_LOGIC;                              -- Signal de débordement mémoire coté 1
   SIGNAL lat_ovrflw1_uc2: STD_LOGIC;                              -- Signal de latch d'un débordement
   SIGNAL rd_port1_buf: STD_LOGIC;                             -- Signal de lecture du flux non filtré sur le port 1
   SIGNAL data_wr1   : STD_LOGIC_VECTOR(8 DOWNTO 0);           -- Bus data d'écriture en DPRAM 1
   SIGNAL data_rd1_uc1   : STD_LOGIC_VECTOR(8 DOWNTO 0);           -- Bus data de lecture en DPRAM 1
   SIGNAL data_rd1_uc2   : STD_LOGIC_VECTOR(8 DOWNTO 0);           -- Bus data de lecture en DPRAM 1
   SIGNAL addrwr2_uc1    : STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Pointeur d'adresse en ecriture DPRAM coté 2
   SIGNAL old_addwr2_uc1 : STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Pointeur de première adresse vide en DPRAM coté 2
   SIGNAL addrwr2_uc2    : STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Pointeur d'adresse en ecriture DPRAM coté 2
   SIGNAL old_addwr2_uc2 : STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Pointeur de première adresse vide en DPRAM coté 2
   SIGNAL cpt_adread2_uc1: STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Compteur d'adresse en lecture DPRAM coté 1
   SIGNAL adread2_uc1    : STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Pointeur d'adresse en lecture DPRAM coté 2
   SIGNAL cpt_adread2_uc2: STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Compteur d'adresse en lecture DPRAM coté 1
   SIGNAL adread2_uc2    : STD_LOGIC_VECTOR(nbbit_add-1 downto 0); -- Pointeur d'adresse en lecture DPRAM coté 2
   SIGNAL sof2           : STD_LOGIC;                              -- Pour indiquer au module d'analyse le début de la trame
   SIGNAL dont_keep2     : STD_LOGIC;                              -- Indique qu'il ne faut pas garder la trame
   SIGNAL end_ana2       : STD_LOGIC;                              -- Indique la fin de la routine d'analyse de double trame
   SIGNAL overflow2_uc1  : STD_LOGIC;                              -- Signal de débordement mémoire coté 2
   SIGNAL lat_ovrflw2_uc1: STD_LOGIC;                              -- Signal de latch d'un débordement
   SIGNAL overflow2_uc2  : STD_LOGIC;                              -- Signal de débordement mémoire coté 2
   SIGNAL lat_ovrflw2_uc2: STD_LOGIC;                              -- Signal de latch d'un débordement
   SIGNAL rd_port2_buf: STD_LOGIC;                             -- Signal de lecture du flux non filtré sur le port 2
   SIGNAL data_wr2   : STD_LOGIC_VECTOR(8 DOWNTO 0);           -- Bus data d'écriture en DPRAM 2
   SIGNAL data_rd2_uc1   : STD_LOGIC_VECTOR(8 DOWNTO 0);           -- Bus data de lecture en DPRAM 2
   SIGNAL data_rd2_uc2   : STD_LOGIC_VECTOR(8 DOWNTO 0);           -- Bus data de lecture en DPRAM 2

   SIGNAL wea        : STD_LOGIC_VECTOR(0 DOWNTO 0);           -- Vecteur d'écriture dans les DPRAM

   COMPONENT ana_double_frame IS
   PORT (
      clk_sys     : IN  STD_LOGIC;
      rst_n       : IN  STD_LOGIC;
      top_cycle   : IN  STD_LOGIC;
      sof1        : IN  STD_LOGIC;
      dat_in1     : IN  STD_LOGIC_VECTOR(7 downto 0);
      dont_keep1  : OUT STD_LOGIC;
      end_ana1    : OUT STD_LOGIC;
      fsm1_ready  : OUT STD_LOGIC;
      sof2        : IN  STD_LOGIC;
      dat_in2     : IN  STD_LOGIC_VECTOR(7 downto 0);
      dont_keep2  : OUT STD_LOGIC;
      end_ana2    : OUT STD_LOGIC
      );
   END COMPONENT;

   COMPONENT dpram_filt
   PORT (
      clka     : IN STD_LOGIC;
      wea      : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra    : IN STD_LOGIC_VECTOR(nbbit_add-1 DOWNTO 0);
      dina     : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      clkb     : IN STD_LOGIC;
      addrb    : IN STD_LOGIC_VECTOR(nbbit_add-1 DOWNTO 0);
      doutb    : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
      );
   END COMPONENT;   

   
BEGIN
   -- Signaux de DEBUG
   latchout : PROCESS(clk_sys)
   BEGIN
      IF (clk_sys'EVENT and clk_sys = '1') THEN
         dpram_overflow1 <= overflow1_uc1 OR overflow1_uc2;
         dpram_overflow2 <= overflow2_uc1 OR overflow2_uc2;
      END IF;
   END PROCESS;

   ------------------------------------------------
   -- Lecture du flux coté 1
   ------------------------------------------------
   -- Le signal de read doit être annulé sur le début de la trmae suivante (SOC = '1') ou bien si la mémoire est vide
   rd_port1 <= (rd_port1_buf AND com_dispo1 AND NOT(soc_port1)) WHEN (filterfsm1 = wait_eof_st) ELSE 
                rd_port1_buf;

   fsm1: PROCESS (clk_sys, rst_n)
   BEGIN
      IF(rst_n = '0') THEN
         filterfsm1 <= idle_st;
         rd_port1_buf <= '0';
         addrwr1_uc1 <= (OTHERS => '0');
         old_addwr1_uc1 <= (OTHERS => '0');
         addrwr1_uc2 <= (OTHERS => '0');
         old_addwr1_uc2 <= (OTHERS => '0');
         sof1 <= '0';
         lat_ovrflw1_uc1 <= '0';
         lat_ovrflw1_uc2 <= '0';
      ELSIF clk_sys'EVENT and clk_sys ='1' THEN
         CASE filterfsm1 IS
            WHEN idle_st =>
            -- Etat d'attente d'une trame valide à traiter coté1
               addrwr1_uc1 <= old_addwr1_uc1;
               addrwr1_uc2 <= old_addwr1_uc2;
               IF (soc_port1 = '1' AND com_dispo1 = '1' AND voie1_ready = '1') THEN
               -- Si on a une trame valide sur le coté 1 et que la machine d'état du module d'analyse est disponible
                  rd_port1_buf <= '1';             -- On active la lecture sur le coté 1
                  lat_ovrflw1_uc1 <= '0';
                  lat_ovrflw1_uc2 <= '0';
                  sof1 <= '1';                     -- On indique au module de filtrage un début de trame
                  filterfsm1 <= pump_st;
               END IF;

            WHEN pump_st =>
            -- Etat d'attente le temps d'amorcer le RD
               addrwr1_uc1 <= addrwr1_uc1 + 1;       -- On garde la première donnée
               addrwr1_uc2 <= addrwr1_uc2 + 1;       -- On garde la première donnée
               filterfsm1 <= wait_eof_st;    -- On va attendre la fin de la trame

            WHEN wait_eof_st =>
            -- Etat d'attente de la fin de trame
               IF (lat_ovrflw1_uc1 = '0') THEN
               -- Tant qu'on a pas d'overflow
                  addrwr1_uc1 <= addrwr1_uc1 + 1;    -- On continue de garder les données entrantes
               END IF;
               IF (lat_ovrflw1_uc2 = '0') THEN
               -- Tant qu'on a pas d'overflow
                  addrwr1_uc2 <= addrwr1_uc2 + 1;    -- On continue de garder les données entrantes
               END IF;
               sof1 <= '0';
               IF (soc_port1 = '1' OR com_dispo1 = '0') THEN
               -- Si on a un nouveau début de trame ou bien qu'il n'y a plus de données
                  rd_port1_buf <= '0';           -- On arrête de lire
                  filterfsm1 <= wait_res_ana_st;
               END IF;
               IF (overflow1_uc1 = '1') THEN
                  lat_ovrflw1_uc1 <= '1';
               END IF;
               IF (overflow1_uc2 = '1') THEN
                  lat_ovrflw1_uc2 <= '1';
               END IF;

            WHEN wait_res_ana_st =>
               IF (end_ana1 = '1') THEN
               -- On attend la fin de l'analyse de la trame pour savoir ce qu'on en fait
                  IF (dont_keep1 = '0' OR ena_filt_dble = '0') THEN
                  -- Si on doit garder la trame 
                     IF (lat_ovrflw1_uc1 = '0') THEN
                     -- et qu'on a pas eu de condition d'overflow en cours de route
                        old_addwr1_uc1 <= addrwr1_uc1 - 1; -- On garde la case précédente car le pointeur a incrémenté un coup de trop
                     END IF;
                     IF (lat_ovrflw1_uc2 = '0') THEN
                     -- et qu'on a pas eu de condition d'overflow en cours de route
                        old_addwr1_uc2 <= addrwr1_uc2 - 1; -- On garde la case précédente car le pointeur a incrémenté un coup de trop
                     END IF;
                  END IF;
                  filterfsm1 <= idle_st;
               END IF;
               
            WHEN OTHERS =>
               NULL;

         END CASE;
      END IF;
   END PROCESS;         

   ------------------------------------------------
   -- Lecture du flux coté 2
   ------------------------------------------------
   -- Le signal de read doit être annulé sur le début de la trmae suivante (SOC = '1') ou bien si la mémoire est vide
   rd_port2 <= (rd_port2_buf AND com_dispo2 AND NOT(soc_port2)) WHEN (filterfsm2 = wait_eof_st) ELSE 
                rd_port2_buf;


   fsm2 : PROCESS (clk_sys, rst_n)
   BEGIN
      IF(rst_n = '0') THEN
         filterfsm2 <= idle_st;
         rd_port2_buf <= '0';
         addrwr2_uc1 <= (OTHERS => '0');
         old_addwr2_uc1 <= (OTHERS => '0');
         addrwr2_uc2 <= (OTHERS => '0');
         old_addwr2_uc2 <= (OTHERS => '0');
         sof2 <= '0';
         lat_ovrflw2_uc1 <= '0';
         lat_ovrflw2_uc2 <= '0';
      ELSIF clk_sys'EVENT and clk_sys ='1' THEN
         CASE filterfsm2 IS
            WHEN idle_st =>
            -- Etat d'attente d'une trame valide à traiter coté2 et que la machine d'état du module d'analyse est disponible
               addrwr2_uc1 <= old_addwr2_uc1;
               addrwr2_uc2 <= old_addwr2_uc2;
               IF (soc_port2 = '1' AND com_dispo2 = '1' AND voie1_ready = '1') THEN
               -- Si on a une trame valide sur le coté 2
                  rd_port2_buf <= '1';            -- On active les lectures sur le coté 2
                  lat_ovrflw2_uc1 <= '0';
                  lat_ovrflw2_uc2 <= '0';
                  sof2 <= '1';                     -- On indique au module de filtrage un début de trame
                  filterfsm2 <= pump_st; 
               END IF;

            WHEN pump_st =>
            -- Etat d'attente le temps d'amorcer le RD
               addrwr2_uc1 <= addrwr2_uc1 + 1;       -- On garde la première donnée
               addrwr2_uc2 <= addrwr2_uc2 + 1;       -- On garde la première donnée
               filterfsm2 <= wait_eof_st;    -- On va attendre la fin de la trame

            WHEN wait_eof_st =>
            -- Etat d'attente de la fin de trame
               IF (lat_ovrflw2_uc1 = '0') THEN
               -- Tant qu'on a pas d'overflow
                  addrwr2_uc1 <= addrwr2_uc1 + 1;    -- On continue de garder les données entrantes
               END IF;
               IF (lat_ovrflw2_uc2 = '0') THEN
               -- Tant qu'on a pas d'overflow
                  addrwr2_uc2 <= addrwr2_uc2 + 1;    -- On continue de garder les données entrantes
               END IF;
               sof2 <= '0';               
               IF (soc_port2 = '1' OR com_dispo2 = '0') THEN
               -- Si on a un nouveau début de trame ou bien qu'il n'y a plus de données
                  rd_port2_buf <= '0';
                  filterfsm2 <= wait_res_ana_st;
               END IF;
               IF (overflow2_uc1 = '1') THEN
                  lat_ovrflw2_uc1 <= '1';
               END IF;
               IF (overflow2_uc2 = '1') THEN
                  lat_ovrflw2_uc2 <= '1';
               END IF;

            WHEN wait_res_ana_st =>
               IF (end_ana2 = '1') THEN
               -- On attend la fin de l'analyse de la trame pour savoir ce qu'on en fait
                  IF (dont_keep2 = '0' OR ena_filt_dble = '0') THEN
                  -- Si on doit garder la trame                   
                     IF (lat_ovrflw2_uc1 = '0') THEN
                     -- et qu'on a pas eu de condition d'overflow en cours de route
                        old_addwr2_uc1 <= addrwr2_uc1 - 1; -- On garde la case précédente car le pointeur a incrémenté un coup de trop
                     END IF;
                     IF (lat_ovrflw2_uc2 = '0') THEN
                     -- et qu'on a pas eu de condition d'overflow en cours de route
                        old_addwr2_uc2 <= addrwr2_uc2 - 1; -- On garde la case précédente car le pointeur a incrémenté un coup de trop
                     END IF;
                  END IF;
                  filterfsm2 <= idle_st;
               END IF;

            WHEN OTHERS =>
               NULL;

         END CASE;
      END IF;
   END PROCESS;         


   --------------------------------------------
   -- Gestion du compteur d'adresse en lecture pour les cotés 1 et 2
   --------------------------------------------
   cptr12 : PROCESS(clk_sys, rst_n)
   BEGIN
     IF (rst_n = '0') THEN
       cpt_adread1_uc1 <= (others => '0');
       cpt_adread2_uc1 <= (others => '0');
       cpt_adread1_uc2 <= (others => '0');
       cpt_adread2_uc2 <= (others => '0');
     ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
       IF (rd_filt1_uc1 = '1') THEN
         cpt_adread1_uc1 <= cpt_adread1_uc1 + 1;
       END IF;
       IF (rd_filt2_uc1 = '1') THEN
         cpt_adread2_uc1 <= cpt_adread2_uc1 + 1;
       END IF;
       IF (rd_filt1_uc2 = '1') THEN
         cpt_adread1_uc2 <= cpt_adread1_uc2 + 1;
       END IF;
       IF (rd_filt2_uc2 = '1') THEN
         cpt_adread2_uc2 <= cpt_adread2_uc2 + 1;
       END IF;
     END IF;
   END PROCESS;
   -- On a des conditions d'overflow si les pointeurs d'criture rattrapent les pointeurs de lecture
  -- overflow1 <= '1' WHEN (addrwr1 = cpt_adread1_uc1-5) OR (addrwr1 = cpt_adread1_uc2-5) ELSE '0';
  -- overflow2 <= '1' WHEN (addrwr2 = cpt_adread2_uc1-5) OR (addrwr2 = cpt_adread2_uc2-5) ELSE '0';
   overflow1_uc1 <= '1' WHEN (addrwr1_uc1 = cpt_adread1_uc1-5)  ELSE '0';
   overflow1_uc2 <= '1' WHEN (addrwr1_uc2 = cpt_adread1_uc2-5)  ELSE '0';
   overflow2_uc1 <= '1' WHEN (addrwr2_uc1 = cpt_adread2_uc1-5)  ELSE '0';
   overflow2_uc2 <= '1' WHEN (addrwr2_uc2 = cpt_adread2_uc2-5)  ELSE '0';
  
   inst_id_frame: ana_double_frame
   PORT MAP(
      clk_sys     => clk_sys,
      rst_n       => rst_n,
      top_cycle   => top_cycle,
      dat_in1     => data_port1(7 DOWNTO 0),
      sof1        => sof1,
      dont_keep1  => dont_keep1,
      end_ana1    => end_ana1,
      fsm1_ready  => voie1_ready,
      dat_in2     => data_port2(7 DOWNTO 0),
      sof2        => sof2,
      dont_keep2  => dont_keep2,
      end_ana2    => end_ana2
   );

   ----------------------------------------
   -- Gestion des DPRAM de stockage en attendant le filtrage
   ----------------------------------------
   wea(0) <= '1';

   -- Permet d'avoir un fonctionnement style FWFT avec un seul cycle entre le rd et la donnée
   adread1_uc1 <= cpt_adread1_uc1 WHEN (rd_filt1_uc1 = '0') ELSE cpt_adread1_uc1 + 1;
   adread1_uc2 <= cpt_adread1_uc2 WHEN (rd_filt1_uc2 = '0') ELSE cpt_adread1_uc2 + 1;
   data_wr1 <= soc_port1 & data_port1;    -- Vecteur à écrire dans la DPRAM
   data_filt1_uc1 <= data_rd1_uc1(7 DOWNTO 0);    -- Dégroupage du vecteur lue dans la DPRAM
   soc_filt1_uc1  <= data_rd1_uc1(8);
   data_filt1_uc2 <= data_rd1_uc2(7 DOWNTO 0);    -- Dégroupage du vecteur lue dans la DPRAM
   soc_filt1_uc2  <= data_rd1_uc2(8);
   inst_dpram_port1_uc1 : dpram_filt
      PORT MAP (
      clka  => clk_sys,
      wea   => wea,
      addra => addrwr1_uc1,
      dina  => data_wr1,
      clkb  => clk_sys,
      addrb => adread1_uc1,
      doutb => data_rd1_uc1
   );
   -- On indique une trame dispo dans la DPRAM si le pointeur de lecture n'est pas au niveau de la première case libre
   frm_dispo_filt1_uc1 <= '0' WHEN (cpt_adread1_uc1 = old_addwr1_uc1) ELSE '1';

   inst_dpram_port1_uc2 : dpram_filt
      PORT MAP (
      clka  => clk_sys,
      wea   => wea,
      addra => addrwr1_uc2,
      dina  => data_wr1,
      clkb  => clk_sys,
      addrb => adread1_uc2,
      doutb => data_rd1_uc2
   );
   -- On indique une trame dispo dans la DPRAM si le pointeur de lecture n'est pas au niveau de la première case libre
   frm_dispo_filt1_uc2 <= '0' WHEN (cpt_adread1_uc2 = old_addwr1_uc2) ELSE '1';

   -- Permet d'avoir un fonctionnement style FWFT avec un seul cycle entre le rd et la donnée
   adread2_uc1 <= cpt_adread2_uc1 WHEN (rd_filt2_uc1 = '0') ELSE cpt_adread2_uc1 + 1;
   adread2_uc2 <= cpt_adread2_uc2 WHEN (rd_filt2_uc2 = '0') ELSE cpt_adread2_uc2 + 1;
   data_wr2 <= soc_port2 & data_port2;    -- Vecteur à écrire dans la DPRAM
   data_filt2_uc1 <= data_rd2_uc1(7 DOWNTO 0);    -- Dégroupage du vecteur lue dans la DPRAM
   soc_filt2_uc1  <= data_rd2_uc1(8);
   data_filt2_uc2 <= data_rd2_uc2(7 DOWNTO 0);    -- Dégroupage du vecteur lue dans la DPRAM
   soc_filt2_uc2  <= data_rd2_uc2(8);
   inst_dpram_port2_uc1 : dpram_filt
      PORT MAP (
      clka     => clk_sys,
      wea      => wea,
      addra    => addrwr2_uc1,
      dina     => data_wr2,
      clkb     => clk_sys,
      addrb    => adread2_uc1,
      doutb    => data_rd2_uc1
   );
   -- On indique une trame dispo dans la DPRAM si le pointeur de lecture n'est pas au niveau de la première case libre
   frm_dispo_filt2_uc1 <= '0' WHEN (cpt_adread2_uc1 = old_addwr2_uc1) ELSE '1';

   inst_dpram_port2_uc2 : dpram_filt
      PORT MAP (
      clka     => clk_sys,
      wea      => wea,
      addra    => addrwr2_uc2,
      dina     => data_wr2,
      clkb     => clk_sys,
      addrb    => adread2_uc2,
      doutb    => data_rd2_uc2
   );
   -- On indique une trame dispo dans la DPRAM si le pointeur de lecture n'est pas au niveau de la première case libre
   frm_dispo_filt2_uc2 <= '0' WHEN (cpt_adread2_uc2 = old_addwr2_uc2) ELSE '1';
    
END rtl;   
         
      