--============================================================================= 
--  TITRE : ANA_DOUBLE_FRAME
--  DESCRIPTION : 
--    Analyse les flux entrant sur port 1 et port 2 en couche 2 et détermine
--    si la trame a déjà été reçue ou non
--    Une trame est représentée par sa signature qui constituée des N premiers octets
--       
--  FICHIER :        ana_double_frame.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  20/10/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION 
--  16/01/2015 DRA      SATURN   V1.1
--    Ajout du signal fsm1_ready pour indiquer que la FSM1 est prête à traiter
--    des données
--    Ajout du test ELSIF (fsm_anasig2 = clear_sig_st) THEN dans les machines
--    dans les états compsig_st (évite une situation de blocage particulière)
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ana_double_frame IS
   PORT (
      -- Ports système
      clk_sys     : IN  STD_LOGIC;  -- Clock système
      rst_n       : IN  STD_LOGIC;  -- Reset général système
      top_cycle   : IN  STD_LOGIC;  -- TOP cycle utilsié pour clerer la mémoire de stockage

      -- Interface port 1
      sof1        : IN  STD_LOGIC;                   -- Indique le début d'une trame en réception sur dat_in
      dat_in1     : IN  STD_LOGIC_VECTOR(7 downto 0);-- Données de la couche applicative (épurée de la couche layer 2)
      dont_keep1  : OUT STD_LOGIC;                   -- Signale que la trame en cours de réception a déjà été reçue sur l'autre port
      end_ana1    : OUT STD_LOGIC;                   -- Indique que l'analyse est terminée pour la voie 1
      fsm1_ready  : OUT STD_LOGIC;                   -- A '1' lorsque la machine d'état 1 est prête à traiter une trame

      -- Interface port 2
      sof2        : IN  STD_LOGIC;                   -- Indique le début d'une trame en réception sur dat_in
      dat_in2     : IN  STD_LOGIC_VECTOR(7 downto 0);-- Données de la couche applicative (épurée de la couche layer 2)
      dont_keep2  : OUT STD_LOGIC;                   -- Signale que la trame en cours de réception a déjà été reçue sur l'autre port
      end_ana2    : OUT STD_LOGIC                    -- Indique que l'analyse est terminée pour la voie 2
      );
END ana_double_frame;

ARCHITECTURE rtl of ana_double_frame is
   -- Définition du nombre de ligne utilsiée dans la DPRAM
   CONSTANT nb_lignedp     : STD_LOGIC_VECTOR(7 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(200, 8);
   -- Définition des différents type de trame qu'on peut gérer
   CONSTANT no_typfrm      : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"FA";
   CONSTANT sync_typfrm    : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"00";
   CONSTANT reqnosec_typfrm: STD_LOGIC_VECTOR(7 DOWNTO 0) := x"08";
   CONSTANT repnosec_typfrm: STD_LOGIC_VECTOR(7 DOWNTO 0) := x"80";

   -- Machine d'état de récupération des signatures
   TYPE fsm_anasig_type IS (idle_st, get_sig_st, compsig_st, wait_dpupdate_st, cherche_dpram_st, clear_sig_st, 
                            store_sig_st, wait_sync_fsm_st, clear_dpram_st);

   -- Signaux pour analsyer le coté 1
   SIGNAL fsm_anasig1   : fsm_anasig_type;
   SIGNAL shifter1   : STD_LOGIC_VECTOR(79 DOWNTO 0);-- Registre à décalage pour récupérer les premiers octets de la trame 
   SIGNAL signature1 : STD_LOGIC_VECTOR(79 DOWNTO 0);-- Vecteur de sauvegarde de la signature de la trame en cours de Rx
   SIGNAL cpt_byt1   : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Compteur d'octets voie 1
   SIGNAL first_empty1:STD_LOGIC_VECTOR(7 DOWNTO 0); -- Pour mémoriser la 1ère place libre dans la DPRAM
   SIGNAL first_found1:STD_LOGIC;                    -- Indique que le 1er vide a été trouvé
   SIGNAL cpt_add1   : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Compteur d'addresse pour parcourir la DPRAM
   SIGNAL we_sig1    : STD_LOGIC_VECTOR(0 DOWNTO 0); -- Signal d'écriture dans la DPRAM
   SIGNAL sigrd_dp1  : STD_LOGIC_VECTOR(80 DOWNTO 0);-- Pour récupérer les signaures dans la DPRAM
   SIGNAL sigwr_dp1  : STD_LOGIC_VECTOR(80 DOWNTO 0);-- Pour farbiquer le vecteur à écrire en DPRAM
   SIGNAL clr_sig1   : STD_LOGIC;                    -- Indique que l'on souhaite clearer une entrée de la DPRAM

   -- Signaux pour analyser le coté 2
   SIGNAL fsm_anasig2   : fsm_anasig_type;
   SIGNAL shifter2   : STD_LOGIC_VECTOR(79 DOWNTO 0);-- Registre à décalage pour récupérer les premiers octets de la trame 
   SIGNAL signature2 : STD_LOGIC_VECTOR(79 DOWNTO 0);-- Vecteur de sauvegarde de la signature de la trame en cours de Rx
   SIGNAL cpt_byt2   : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Compteur d'octets voie 2
   SIGNAL last_empty2:STD_LOGIC_VECTOR(7 DOWNTO 0); -- Pour mémoriser la 1ère place libre dans la DPRAM
   SIGNAL cpt_add2   : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Compteur d'addresse pour parcourir la DPRAM
   SIGNAL we_sig2    : STD_LOGIC_VECTOR(0 DOWNTO 0); -- Signal d'écriture dans la DPRAM
   SIGNAL sigrd_dp2  : STD_LOGIC_VECTOR(80 DOWNTO 0);-- Pour récupérer les signaures dans la DPRAM
   SIGNAL sigwr_dp2  : STD_LOGIC_VECTOR(80 DOWNTO 0);-- Pour farbiquer le vecteur à écrire en DPRAM
   SIGNAL clr_sig2   : STD_LOGIC;                    -- Indique que l'on souhaite clearer une entrée de la DPRAM

   SIGNAL top_cyc_r  : STD_LOGIC;                    -- Pour détecter le front montant de top_cyc
   SIGNAL first_clear: STD_LOGIC;                    -- Pour forcer le clear de la DPRAM au reset

   COMPONENT dpram_dbleframe
   PORT (
      clka  : IN STD_LOGIC;
      wea   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      dina  : IN STD_LOGIC_VECTOR(80 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(80 DOWNTO 0);
      clkb  : IN STD_LOGIC;
      web   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      dinb  : IN STD_LOGIC_VECTOR(80 DOWNTO 0);
      doutb : OUT STD_LOGIC_VECTOR(80 DOWNTO 0)
   );
   END COMPONENT;
BEGIN
   --------------------------------------------
   -- Registres à décalage pour fabriquer les signatures des trames
   --------------------------------------------
   reg_dec : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         shifter1 <= (OTHERS => '0');
         shifter2 <= (OTHERS => '0');
         top_cyc_r <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         shifter1 <= shifter1(71 DOWNTO 0) & dat_in1;
         shifter2 <= shifter2(71 DOWNTO 0) & dat_in2;
         top_cyc_r <= top_cycle;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- Machine d'état d'analyse de la signature coté 1
   --------------------------------------------
   fsm1_ready <= '1' WHEN (fsm_anasig1 = idle_st) ELSE '0';
   anasig1 : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         fsm_anasig1 <= idle_st;                -- Pour assurer une purge de la RAM au démarrage
         cpt_byt1 <= (OTHERS => '0');
         first_empty1 <= (OTHERS => '0');
         first_found1 <= '0';
         cpt_add1 <= (OTHERS => '0');
         signature1 <= (OTHERS => '0');
         we_sig1 <= "1";
         clr_sig1 <= '1';
         dont_keep1 <= '0';
         end_ana1 <= '0';
         first_clear <= '0';                    -- Pour assurer une purge des DPRAM au démarrage
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_anasig1 IS
            WHEN idle_st =>
            -- Etat d'attente d'un début de trame
               cpt_add1 <= (OTHERS => '0');
               we_sig1 <= "0";
               first_found1 <= '0';
               signature1(79 DOWNTO 72) <= no_typfrm;  -- On initialsie la signature avec un type inconnu pour pas être réutilisé
               IF ((top_cycle = '1' AND top_cyc_r = '0') OR (first_clear = '0')) THEN
               -- Sur front montant de top_cycle
                  clr_sig1 <= '1';              -- On va clearer la DPRAM
                  we_sig1 <= "1";               -- On écrit tout le temps
                  first_clear <= '1';
                  fsm_anasig1 <= clear_dpram_st;
               ELSIF (sof1 = '1') THEN
                  cpt_byt1 <= (OTHERS => '0');
                  end_ana1 <= '0';
                  fsm_anasig1 <= get_sig_st;
               END IF;
               
            WHEN get_sig_st =>
            -- Etat de récupération de la signature en fonction du type de trame. Le type est le premier octet reçu
            -- et est donc dans une cellule différente selon le nombre d'octets reçu
               cpt_byt1 <= cpt_byt1 + 1;
               IF (shifter1(55 DOWNTO 48) = sync_typfrm AND cpt_byt1 = "0110") THEN
               -- Si c'est une trame de synchro et qu'on a reçu 7 caractères
                  signature1 <= shifter1(55 DOWNTO 0) & x"000000";   -- La signature fait 56 bits calés sur les MSB
                  fsm_anasig1 <= compsig_st;
               ELSIF ((shifter1(39 DOWNTO 32) = reqnosec_typfrm OR shifter1(39 DOWNTO 32) = repnosec_typfrm) AND cpt_byt1 = "0100") THEN
               -- Si c'est une requête ou une réponse non sécuritaire
                  signature1 <= shifter1(39 DOWNTO 0) & x"0000000000";-- La signature fait 40 bits calés sur les MSB
                  fsm_anasig1 <= compsig_st;
               ELSIF (cpt_byt1 = "1001") THEN
               -- Pour tous les autre types de trame
                  signature1 <= shifter1(79 DOWNTO 0);   -- La signature fait 80 bits calés sur les MSB
                  fsm_anasig1 <= compsig_st;
               END IF;
         
            WHEN compsig_st =>
            -- Etat de comparaison avec la signature de l'autre voie
               IF (signature1 = signature2) THEN
               -- Si la signature qu'on vient de recevoir sur port 1 est égale à la signature sur port 2
                  IF (fsm_anasig2 = compsig_st) THEN
                  -- Si les 2 machines en sont au même point, la voie 1 garde la trame, la voie la jette
                     fsm_anasig1 <= idle_st;             -- Pas besoin de toucher à la DPRAM
                     end_ana1 <= '1';
                     dont_keep1 <= '0';                  -- On garde la voie 1
                  ELSIF (fsm_anasig2 = store_sig_st) THEN
                  -- Si la machine voie 2 est dans l'état de stockage de la signature
                     fsm_anasig1 <= idle_st;             -- Pas besoin de toucher à la DPRAM
                     end_ana1 <= '1';
                     dont_keep1 <= '1';                  -- On va garder la voie 2
                  ELSIF (fsm_anasig2 = clear_sig_st) THEN
                  -- Si la machine voie 2 est dans l'état de clear de la signature
                  -- Cas très particulier de réception de 2 trames avec la même signature reçues
                  -- sur les 2 ports. La 2ème du premier couple peut conduire à un clear dans la DPRAM alors
                  -- qu'on reçoit la première du second couple qu'il faut alors stocker
                     fsm_anasig1 <= wait_dpupdate_st;    -- On va traiter la trame
                  ELSIF (fsm_anasig2 /= idle_st) THEN
                  -- Si les 2 machines ne sont pas au même point (c'est que fsm_anasig2 est en avance)
                  -- Si elle n'est pas en idle, elle n'a pas encore stocké sa signature dans la DPRAM
                     fsm_anasig1 <= wait_sync_fsm_st;    -- On va attendre que fsm2 soit au point d'enregistrement
                  ELSE
                  -- Cas où fsm_anasig2 est revenu à idle mais n'a pas encore annulé signature2 (dure 1 cycle)
                  -- Si la machine 2 est dans idle, elle a déjà stocké sa signature en DPRAM. Pendant un cycle (le temps
                  -- que la machine 2 cleare sa signature, on peut être ici)
                     fsm_anasig1 <= wait_dpupdate_st;    -- On va donc parcourir la mémoire normalement
                  END IF;
               ELSE
               -- Si les 2 signatures ne sont pas équivalentes
                  fsm_anasig1 <= wait_dpupdate_st;       -- On va parcourir la DPRAM pour chercher la signature
               END IF;

            WHEN wait_dpupdate_st =>
            -- Etat d'attente que l'éventuelle dernière écriture sur le port B soit répercutée sur le port A
               cpt_add1 <= cpt_add1 + 1;
               fsm_anasig1 <= cherche_dpram_st;
 
            WHEN cherche_dpram_st =>
            -- Etat de parcours de la DPRAM pour chercher la signature
            -- en rentrant dans cet état la première fois, la donéne à l'adress x"00" est déjà disponible sur le bus data
               IF (sigrd_dp1 = ('1' & signature1)) THEN
               -- Si la signature est déjà dans la DPRAM et écrite par la voie 2 (MSB à '1')
                  fsm_anasig1 <= clear_sig_st;        -- On va clearer cette entrée
               ELSIF (cpt_add1 = nb_lignedp) THEN
               -- Si on a atteind la dernière ligne du tableau, c'est qu'on a pas trouvé la signature
                  fsm_anasig1 <= store_sig_st;        -- On va la stocker
               ELSE
                  cpt_add1 <= cpt_add1 + 1;
               END IF;
               IF (first_found1 = '0' AND sigrd_dp1(79 DOWNTO 72) = no_typfrm) THEN
               -- Si on a pas encore récupérer la première case vide et que la case actuelle est vide
                  first_found1 <= '1';
                  first_empty1 <= cpt_add1 - 1;        -- On mémorise l'adresse de la première case vide (-1 car l'adresse a toujours un coup d'avance)
               END IF;

            WHEN clear_sig_st =>
            -- Etat de suppression d'une entrée dans la DPRAM (i.e. la trame a déjà été reçue)
               dont_keep1 <= '1';               -- On signale de ne pas garder la trame
               end_ana1 <= '1';
               clr_sig1 <= '1';                 -- On va clearer l'entrée dans la DPRAM
               cpt_add1 <= cpt_add1 - 1;        -- On peut aller clearer l'entrée correspondante (-1 car l'adresse a toujours un coup d'avance)
               we_sig1 <= "1";
               fsm_anasig1 <= idle_st;       -- Que la trame soit bonne ou pas on a fini
               
            WHEN store_sig_st =>
            -- Etat d'enregistrement de la signature
               dont_keep1 <= '0';               -- On signale de garder la trame
               end_ana1 <= '1';
               cpt_add1 <= first_empty1;        -- On va écrire dans la première case libre
               clr_sig1 <= '0';                 -- On va écrire la signature
               IF (signature1 /= signature2) THEN
               -- On est en train d'attendre la fin de la trame.
               -- Si en cours de route, on reçoit la même signature sur l'autre voie, il n'y a plus besoin d'écrire dans la DPRAM
                  we_sig1 <= "1";
               END IF;
               fsm_anasig1 <= idle_st;


            WHEN wait_sync_fsm_st =>
            -- Etat d'attente que l'autre machine voit qu'on a la même signature qu'elle
            -- On est ici parcequ'on a une signature égale à la signautre sur l'aute voie, mais l'autre voie est ent rain de chercher
            -- dans la DPRAM
               IF (fsm_anasig2 = store_sig_st) THEN
               -- Si l'autre voie s'apprête à stocker
                  end_ana1 <= '1';
                  dont_keep1 <= '1';         -- On ne garde pas la trame (elle est gardée par l'autre voie)
                  fsm_anasig1 <= idle_st;
               ELSIF (fsm_anasig2 = clear_sig_st) THEN
                  end_ana1 <= '1';
                  dont_keep1 <= '0';         -- On garde celle la puisqu'elle est supprimée par l'autre voie
                  fsm_anasig1 <= idle_st;
                END IF;
 
            WHEN clear_dpram_st =>
              cpt_add1 <= cpt_add1 + 1;
              IF (cpt_add1 = nb_lignedp) THEN
               -- On cleare toutes les lignes du tableau
                  fsm_anasig1 <= idle_st;
                  we_sig1 <= "0";
               END IF;
            
            WHEN OTHERS =>
               fsm_anasig1 <= idle_st;

         END CASE;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- Machine d'état d'analyse de la signature coté 2
   --------------------------------------------
   anasig2 : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         fsm_anasig2 <= idle_st;
         cpt_byt2 <= (OTHERS => '0');
         last_empty2 <= (OTHERS => '0');
         cpt_add2 <= (OTHERS => '0');
         signature2 <= (OTHERS => '0');         
         we_sig2 <= "0";
         clr_sig2 <= '0';
         dont_keep2 <= '0';
         end_ana2 <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_anasig2 IS
            WHEN idle_st =>
            -- Etat d'attente d'un début de trame
               cpt_add2 <= (OTHERS => '0');
               we_sig2 <= "0";
               signature2(79 DOWNTO 72) <= no_typfrm;  -- On initialise la signature avec un type inconnu pour pas être réutilisé
               IF (sof2 = '1') THEN
                  cpt_byt2 <= (OTHERS => '0');
                  end_ana2 <= '0';
                  fsm_anasig2 <= get_sig_st;
               END IF;
               
            WHEN get_sig_st =>
            -- Etat de récupération de la signature en fonction du type de trame. Le type est le premier octet reçu
            -- et est donc dans une cellule différente selon le nombre d'octets reçu
               cpt_byt2 <= cpt_byt2 + 1;
               IF (shifter2(55 DOWNTO 48) = sync_typfrm AND cpt_byt2 = "0110") THEN
               -- Si c'est une trame de synchro et qu'on a reçu 7 caractères
                  signature2 <= shifter2(55 DOWNTO 0) & x"000000";   -- La signature fait 56 bits calés sur les MSB
                  fsm_anasig2 <= compsig_st;
               ELSIF ((shifter2(39 DOWNTO 32) = reqnosec_typfrm OR shifter2(39 DOWNTO 32) = repnosec_typfrm) AND cpt_byt2 = "0100") THEN
               -- Si c'est une requête ou une réponse non sécuritaire
                  signature2 <= shifter2(39 DOWNTO 0) & x"0000000000";-- La signature fait 40 bits calés sur les MSB
                  fsm_anasig2 <= compsig_st;
               ELSIF (cpt_byt2 = "1001") THEN
               -- Pour tous les autre types de trame
                  signature2 <= shifter2(79 DOWNTO 0);   -- La signature fait 80 bits calés sur les MSB
                  fsm_anasig2 <= compsig_st;
               END IF;
         
            WHEN compsig_st =>
            -- Etat de comparaison avec la signature de l'autre voie
               IF (signature1 = signature2) THEN
               -- Si la signature qu'on vient de recevoir sur port 2 est égale à la signature sur port 1
                  IF (fsm_anasig1 = compsig_st) THEN
                  -- Si les 2 machines en sont au même point, la voie 1 garde la trame, la voie 2 la jette
                     fsm_anasig2 <= idle_st;             -- Pas besoin de toucher à la DPRAM
                     end_ana2 <= '1';
                     dont_keep2 <= '1';                  -- On jette la voie 2
                  ELSIF (fsm_anasig1 = store_sig_st) THEN
                  -- Si la machine voie 1 est dans l'état de stockage de la signature
                     fsm_anasig2 <= idle_st;             -- Pas besoin de toucher à la DPRAM
                     end_ana2 <= '1';
                     dont_keep2 <= '1';                  -- On va garder la voie 1, on jette la voie 2
                  ELSIF (fsm_anasig1 = clear_sig_st) THEN
                  -- Si la machine voie 1 est dans l'état de clear de la signature
                  -- Cas très particulier de réception de 2 trames avec la même signature reçues
                  -- sur les 2 ports. La 2ème du premier couple peut conduire à un clear dans la DPRAM alors
                  -- qu'on reçoit la première du second couple qu'il faut alors stocker
                     fsm_anasig2 <= wait_dpupdate_st;    -- On va traiter la trame
                  ELSIF (fsm_anasig1 /= idle_st) THEN
                  -- Si les 2 machines ne sont pas au même point (c'est que fsm_anasig1 est en avance)
                  -- Si elle n'est pas en idle, elle n'a pas encore stocké sa signature dans la DPRAM
                     fsm_anasig2 <= wait_sync_fsm_st;    -- On va attendre que fsm1 soit au point d'enregistrement
                  ELSE
                  -- Cas où fsm_anasig1 est revenu à idle mais n'a pas encore annulé signature1 (dure 1 cycle)
                  -- Si la machine 1 est dans idle, elle a déjà stocké sa signature en DPRAM. Pendant un cycle (le temps
                  -- que la machine 1 cleare sa signature, on peut être ici)
                     fsm_anasig2 <= wait_dpupdate_st;    -- On va donc parcourir la mémoire normalement
                  END IF;
               ELSE
               -- Si les 2 signatures ne sont pas équivalentes
                  fsm_anasig2 <= wait_dpupdate_st;       -- On va parcourir la DPRAM pour chercher la signature
               END IF;

            WHEN wait_dpupdate_st =>
            -- Etat d'attente que l'éventuelle dernière écriture sur le port A soit répercutée sur le port B
               cpt_add2 <= cpt_add2 + 1;
               fsm_anasig2 <= cherche_dpram_st;
 
            WHEN cherche_dpram_st =>
            -- Etat de parcours de la DPRAM pour chercher la signature
            -- en rentrant dans cet état la première fois, la donéne à l'adress x"00" est déjà disponible sur le bus data
               IF (sigrd_dp2 = ('0' & signature2)) THEN
               -- Si la signature est déjà dans la DPRAM et écrite par la voie 1 (MSB à '0')
                  fsm_anasig2 <= clear_sig_st;        -- On va clearer cette entrée
               ELSIF (cpt_add2 = nb_lignedp) THEN
               -- Si on a atteind la dernière ligne du tableau, c'est qu'on a pas trouvé la signature
                  fsm_anasig2 <= store_sig_st;        -- On va la stocker
               ELSE
                  cpt_add2 <= cpt_add2 + 1;
               END IF;
               IF (sigrd_dp2(79 DOWNTO 72) = no_typfrm) THEN
               -- Si la case est vide on va la garder en mémoire
                  last_empty2 <= cpt_add2 - 1;        -- On mémorise l'adresse de la dernière case vide (-1 car l'adresse a toujours un coup d'avance)
               END IF;

            WHEN clear_sig_st =>
            -- Etat de suppression d'une entrée dans la DPRAM (i.e. la trame a déjà été reçue)
               end_ana2 <= '1';
               dont_keep2 <= '1';               -- On signale de ne pas garder la trame
               clr_sig2 <= '1';                 -- On va clearer l'entrée dans la DPRAM
               cpt_add2 <= cpt_add2 - 1;  -- On peut aller clearer l'entrée correspondante (-1 car l'adresse a toujours un coup d'avance)
               we_sig2 <= "1";
               fsm_anasig2 <= idle_st;       -- Que la trame soit bonne ou pas on a fini
               
            WHEN store_sig_st =>
            -- Etat d'enregistrement de la signature
               end_ana2 <= '1';
               dont_keep2 <= '0';               -- On signale de garder la trame
               cpt_add2 <= last_empty2;         -- On va écrire dans la première case libre
               clr_sig2 <= '0';                 -- On va écrire la signature
               IF (signature1 /= signature2) THEN
               -- On est en train d'attendre la fin de la trame.
               -- Si en cours de route, on reçoit la même signature sur l'autre voie, il n'y a plus besoin d'écrire dans la DPRAM
                  we_sig2 <= "1";
               END IF;
               fsm_anasig2 <= idle_st; 

            WHEN wait_sync_fsm_st =>
            -- Etat d'attente que l'autre machine voit qu'on a la même signature qu'elle
            -- On est ici parcequ'on a une signature égale à la signautre sur l'aute voie, mais l'autre voie est ent rain de chercher
            -- dans la DPRAM
               IF (fsm_anasig1 = store_sig_st) THEN
               -- Si l'autre voie s'apprête à stocker
                  end_ana2 <= '1';
                  dont_keep2 <= '1';         -- On ne garde pas la trame (elle est gardée par l'autre voie)
                  fsm_anasig2 <= idle_st;
               ELSIF (fsm_anasig1 = clear_sig_st) THEN
                  end_ana2 <= '1';
                  dont_keep2 <= '0';         -- On ne garde pas la trame elle est gardée par l'autre voie
                  fsm_anasig2 <= idle_st;
               END IF;

            WHEN OTHERS =>
               fsm_anasig2 <= idle_st;

         END CASE;
      END IF;
   END PROCESS;

   ----------------------------------------------------------
   -- Instanciation de la DPRAM de stockage des signatures
   ----------------------------------------------------------
   sigwr_dp1(80) <= '0';            -- Le MSB dans la DPRAM indique la voie qui a reçu la trame
   sigwr_dp1(79 DOWNTO 72) <= no_typfrm WHEN clr_sig1 = '1' ELSE signature1(79 DOWNTO 72);
   sigwr_dp1(71 DOWNTO 0)  <= signature1(71 DOWNTO 0);

   sigwr_dp2(80) <= '1';            -- Le MSB dans la DPRAM indique la voie qui a reçu la trame
   sigwr_dp2(79 DOWNTO 72) <= no_typfrm WHEN clr_sig2 = '1' ELSE signature2(79 DOWNTO 72);
   sigwr_dp2(71 DOWNTO 0)  <= signature2(71 DOWNTO 0);

   inst_dbledp : dpram_dbleframe
   PORT MAP(
      clka  => clk_sys,
      wea   => we_sig1,
      addra => cpt_add1,
      dina  => sigwr_dp1,
      douta => sigrd_dp1,
      clkb  => clk_sys,
      web   => we_sig2,
      addrb => cpt_add2,
      dinb  => sigwr_dp2,
      doutb => sigrd_dp2
   );
   
END rtl;

