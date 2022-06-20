--============================================================================= 
--  TITRE : ANA_DOUBLE_FRAME
--  DESCRIPTION : 
--    Analyse les flux entrant sur port 1 et port 2 en couche 2 et d�termine
--    si la trame a d�j� �t� re�ue ou non
--    Une trame est repr�sent�e par sa signature qui constitu�e des N premiers octets
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
--    Ajout du signal fsm1_ready pour indiquer que la FSM1 est pr�te � traiter
--    des donn�es
--    Ajout du test ELSIF (fsm_anasig2 = clear_sig_st) THEN dans les machines
--    dans les �tats compsig_st (�vite une situation de blocage particuli�re)
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ana_double_frame IS
   PORT (
      -- Ports syst�me
      clk_sys     : IN  STD_LOGIC;  -- Clock syst�me
      rst_n       : IN  STD_LOGIC;  -- Reset g�n�ral syst�me
      top_cycle   : IN  STD_LOGIC;  -- TOP cycle utilsi� pour clerer la m�moire de stockage

      -- Interface port 1
      sof1        : IN  STD_LOGIC;                   -- Indique le d�but d'une trame en r�ception sur dat_in
      dat_in1     : IN  STD_LOGIC_VECTOR(7 downto 0);-- Donn�es de la couche applicative (�pur�e de la couche layer 2)
      dont_keep1  : OUT STD_LOGIC;                   -- Signale que la trame en cours de r�ception a d�j� �t� re�ue sur l'autre port
      end_ana1    : OUT STD_LOGIC;                   -- Indique que l'analyse est termin�e pour la voie 1
      fsm1_ready  : OUT STD_LOGIC;                   -- A '1' lorsque la machine d'�tat 1 est pr�te � traiter une trame

      -- Interface port 2
      sof2        : IN  STD_LOGIC;                   -- Indique le d�but d'une trame en r�ception sur dat_in
      dat_in2     : IN  STD_LOGIC_VECTOR(7 downto 0);-- Donn�es de la couche applicative (�pur�e de la couche layer 2)
      dont_keep2  : OUT STD_LOGIC;                   -- Signale que la trame en cours de r�ception a d�j� �t� re�ue sur l'autre port
      end_ana2    : OUT STD_LOGIC                    -- Indique que l'analyse est termin�e pour la voie 2
      );
END ana_double_frame;

ARCHITECTURE rtl of ana_double_frame is
   -- D�finition du nombre de ligne utilsi�e dans la DPRAM
   CONSTANT nb_lignedp     : STD_LOGIC_VECTOR(7 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(200, 8);
   -- D�finition des diff�rents type de trame qu'on peut g�rer
   CONSTANT no_typfrm      : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"FA";
   CONSTANT sync_typfrm    : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"00";
   CONSTANT reqnosec_typfrm: STD_LOGIC_VECTOR(7 DOWNTO 0) := x"08";
   CONSTANT repnosec_typfrm: STD_LOGIC_VECTOR(7 DOWNTO 0) := x"80";

   -- Machine d'�tat de r�cup�ration des signatures
   TYPE fsm_anasig_type IS (idle_st, get_sig_st, compsig_st, wait_dpupdate_st, cherche_dpram_st, clear_sig_st, 
                            store_sig_st, wait_sync_fsm_st, clear_dpram_st);

   -- Signaux pour analsyer le cot� 1
   SIGNAL fsm_anasig1   : fsm_anasig_type;
   SIGNAL shifter1   : STD_LOGIC_VECTOR(79 DOWNTO 0);-- Registre � d�calage pour r�cup�rer les premiers octets de la trame 
   SIGNAL signature1 : STD_LOGIC_VECTOR(79 DOWNTO 0);-- Vecteur de sauvegarde de la signature de la trame en cours de Rx
   SIGNAL cpt_byt1   : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Compteur d'octets voie 1
   SIGNAL first_empty1:STD_LOGIC_VECTOR(7 DOWNTO 0); -- Pour m�moriser la 1�re place libre dans la DPRAM
   SIGNAL first_found1:STD_LOGIC;                    -- Indique que le 1er vide a �t� trouv�
   SIGNAL cpt_add1   : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Compteur d'addresse pour parcourir la DPRAM
   SIGNAL we_sig1    : STD_LOGIC_VECTOR(0 DOWNTO 0); -- Signal d'�criture dans la DPRAM
   SIGNAL sigrd_dp1  : STD_LOGIC_VECTOR(80 DOWNTO 0);-- Pour r�cup�rer les signaures dans la DPRAM
   SIGNAL sigwr_dp1  : STD_LOGIC_VECTOR(80 DOWNTO 0);-- Pour farbiquer le vecteur � �crire en DPRAM
   SIGNAL clr_sig1   : STD_LOGIC;                    -- Indique que l'on souhaite clearer une entr�e de la DPRAM

   -- Signaux pour analyser le cot� 2
   SIGNAL fsm_anasig2   : fsm_anasig_type;
   SIGNAL shifter2   : STD_LOGIC_VECTOR(79 DOWNTO 0);-- Registre � d�calage pour r�cup�rer les premiers octets de la trame 
   SIGNAL signature2 : STD_LOGIC_VECTOR(79 DOWNTO 0);-- Vecteur de sauvegarde de la signature de la trame en cours de Rx
   SIGNAL cpt_byt2   : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Compteur d'octets voie 2
   SIGNAL last_empty2:STD_LOGIC_VECTOR(7 DOWNTO 0); -- Pour m�moriser la 1�re place libre dans la DPRAM
   SIGNAL cpt_add2   : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Compteur d'addresse pour parcourir la DPRAM
   SIGNAL we_sig2    : STD_LOGIC_VECTOR(0 DOWNTO 0); -- Signal d'�criture dans la DPRAM
   SIGNAL sigrd_dp2  : STD_LOGIC_VECTOR(80 DOWNTO 0);-- Pour r�cup�rer les signaures dans la DPRAM
   SIGNAL sigwr_dp2  : STD_LOGIC_VECTOR(80 DOWNTO 0);-- Pour farbiquer le vecteur � �crire en DPRAM
   SIGNAL clr_sig2   : STD_LOGIC;                    -- Indique que l'on souhaite clearer une entr�e de la DPRAM

   SIGNAL top_cyc_r  : STD_LOGIC;                    -- Pour d�tecter le front montant de top_cyc
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
   -- Registres � d�calage pour fabriquer les signatures des trames
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
   -- Machine d'�tat d'analyse de la signature cot� 1
   --------------------------------------------
   fsm1_ready <= '1' WHEN (fsm_anasig1 = idle_st) ELSE '0';
   anasig1 : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         fsm_anasig1 <= idle_st;                -- Pour assurer une purge de la RAM au d�marrage
         cpt_byt1 <= (OTHERS => '0');
         first_empty1 <= (OTHERS => '0');
         first_found1 <= '0';
         cpt_add1 <= (OTHERS => '0');
         signature1 <= (OTHERS => '0');
         we_sig1 <= "1";
         clr_sig1 <= '1';
         dont_keep1 <= '0';
         end_ana1 <= '0';
         first_clear <= '0';                    -- Pour assurer une purge des DPRAM au d�marrage
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_anasig1 IS
            WHEN idle_st =>
            -- Etat d'attente d'un d�but de trame
               cpt_add1 <= (OTHERS => '0');
               we_sig1 <= "0";
               first_found1 <= '0';
               signature1(79 DOWNTO 72) <= no_typfrm;  -- On initialsie la signature avec un type inconnu pour pas �tre r�utilis�
               IF ((top_cycle = '1' AND top_cyc_r = '0') OR (first_clear = '0')) THEN
               -- Sur front montant de top_cycle
                  clr_sig1 <= '1';              -- On va clearer la DPRAM
                  we_sig1 <= "1";               -- On �crit tout le temps
                  first_clear <= '1';
                  fsm_anasig1 <= clear_dpram_st;
               ELSIF (sof1 = '1') THEN
                  cpt_byt1 <= (OTHERS => '0');
                  end_ana1 <= '0';
                  fsm_anasig1 <= get_sig_st;
               END IF;
               
            WHEN get_sig_st =>
            -- Etat de r�cup�ration de la signature en fonction du type de trame. Le type est le premier octet re�u
            -- et est donc dans une cellule diff�rente selon le nombre d'octets re�u
               cpt_byt1 <= cpt_byt1 + 1;
               IF (shifter1(55 DOWNTO 48) = sync_typfrm AND cpt_byt1 = "0110") THEN
               -- Si c'est une trame de synchro et qu'on a re�u 7 caract�res
                  signature1 <= shifter1(55 DOWNTO 0) & x"000000";   -- La signature fait 56 bits cal�s sur les MSB
                  fsm_anasig1 <= compsig_st;
               ELSIF ((shifter1(39 DOWNTO 32) = reqnosec_typfrm OR shifter1(39 DOWNTO 32) = repnosec_typfrm) AND cpt_byt1 = "0100") THEN
               -- Si c'est une requ�te ou une r�ponse non s�curitaire
                  signature1 <= shifter1(39 DOWNTO 0) & x"0000000000";-- La signature fait 40 bits cal�s sur les MSB
                  fsm_anasig1 <= compsig_st;
               ELSIF (cpt_byt1 = "1001") THEN
               -- Pour tous les autre types de trame
                  signature1 <= shifter1(79 DOWNTO 0);   -- La signature fait 80 bits cal�s sur les MSB
                  fsm_anasig1 <= compsig_st;
               END IF;
         
            WHEN compsig_st =>
            -- Etat de comparaison avec la signature de l'autre voie
               IF (signature1 = signature2) THEN
               -- Si la signature qu'on vient de recevoir sur port 1 est �gale � la signature sur port 2
                  IF (fsm_anasig2 = compsig_st) THEN
                  -- Si les 2 machines en sont au m�me point, la voie 1 garde la trame, la voie la jette
                     fsm_anasig1 <= idle_st;             -- Pas besoin de toucher � la DPRAM
                     end_ana1 <= '1';
                     dont_keep1 <= '0';                  -- On garde la voie 1
                  ELSIF (fsm_anasig2 = store_sig_st) THEN
                  -- Si la machine voie 2 est dans l'�tat de stockage de la signature
                     fsm_anasig1 <= idle_st;             -- Pas besoin de toucher � la DPRAM
                     end_ana1 <= '1';
                     dont_keep1 <= '1';                  -- On va garder la voie 2
                  ELSIF (fsm_anasig2 = clear_sig_st) THEN
                  -- Si la machine voie 2 est dans l'�tat de clear de la signature
                  -- Cas tr�s particulier de r�ception de 2 trames avec la m�me signature re�ues
                  -- sur les 2 ports. La 2�me du premier couple peut conduire � un clear dans la DPRAM alors
                  -- qu'on re�oit la premi�re du second couple qu'il faut alors stocker
                     fsm_anasig1 <= wait_dpupdate_st;    -- On va traiter la trame
                  ELSIF (fsm_anasig2 /= idle_st) THEN
                  -- Si les 2 machines ne sont pas au m�me point (c'est que fsm_anasig2 est en avance)
                  -- Si elle n'est pas en idle, elle n'a pas encore stock� sa signature dans la DPRAM
                     fsm_anasig1 <= wait_sync_fsm_st;    -- On va attendre que fsm2 soit au point d'enregistrement
                  ELSE
                  -- Cas o� fsm_anasig2 est revenu � idle mais n'a pas encore annul� signature2 (dure 1 cycle)
                  -- Si la machine 2 est dans idle, elle a d�j� stock� sa signature en DPRAM. Pendant un cycle (le temps
                  -- que la machine 2 cleare sa signature, on peut �tre ici)
                     fsm_anasig1 <= wait_dpupdate_st;    -- On va donc parcourir la m�moire normalement
                  END IF;
               ELSE
               -- Si les 2 signatures ne sont pas �quivalentes
                  fsm_anasig1 <= wait_dpupdate_st;       -- On va parcourir la DPRAM pour chercher la signature
               END IF;

            WHEN wait_dpupdate_st =>
            -- Etat d'attente que l'�ventuelle derni�re �criture sur le port B soit r�percut�e sur le port A
               cpt_add1 <= cpt_add1 + 1;
               fsm_anasig1 <= cherche_dpram_st;
 
            WHEN cherche_dpram_st =>
            -- Etat de parcours de la DPRAM pour chercher la signature
            -- en rentrant dans cet �tat la premi�re fois, la don�ne � l'adress x"00" est d�j� disponible sur le bus data
               IF (sigrd_dp1 = ('1' & signature1)) THEN
               -- Si la signature est d�j� dans la DPRAM et �crite par la voie 2 (MSB � '1')
                  fsm_anasig1 <= clear_sig_st;        -- On va clearer cette entr�e
               ELSIF (cpt_add1 = nb_lignedp) THEN
               -- Si on a atteind la derni�re ligne du tableau, c'est qu'on a pas trouv� la signature
                  fsm_anasig1 <= store_sig_st;        -- On va la stocker
               ELSE
                  cpt_add1 <= cpt_add1 + 1;
               END IF;
               IF (first_found1 = '0' AND sigrd_dp1(79 DOWNTO 72) = no_typfrm) THEN
               -- Si on a pas encore r�cup�rer la premi�re case vide et que la case actuelle est vide
                  first_found1 <= '1';
                  first_empty1 <= cpt_add1 - 1;        -- On m�morise l'adresse de la premi�re case vide (-1 car l'adresse a toujours un coup d'avance)
               END IF;

            WHEN clear_sig_st =>
            -- Etat de suppression d'une entr�e dans la DPRAM (i.e. la trame a d�j� �t� re�ue)
               dont_keep1 <= '1';               -- On signale de ne pas garder la trame
               end_ana1 <= '1';
               clr_sig1 <= '1';                 -- On va clearer l'entr�e dans la DPRAM
               cpt_add1 <= cpt_add1 - 1;        -- On peut aller clearer l'entr�e correspondante (-1 car l'adresse a toujours un coup d'avance)
               we_sig1 <= "1";
               fsm_anasig1 <= idle_st;       -- Que la trame soit bonne ou pas on a fini
               
            WHEN store_sig_st =>
            -- Etat d'enregistrement de la signature
               dont_keep1 <= '0';               -- On signale de garder la trame
               end_ana1 <= '1';
               cpt_add1 <= first_empty1;        -- On va �crire dans la premi�re case libre
               clr_sig1 <= '0';                 -- On va �crire la signature
               IF (signature1 /= signature2) THEN
               -- On est en train d'attendre la fin de la trame.
               -- Si en cours de route, on re�oit la m�me signature sur l'autre voie, il n'y a plus besoin d'�crire dans la DPRAM
                  we_sig1 <= "1";
               END IF;
               fsm_anasig1 <= idle_st;


            WHEN wait_sync_fsm_st =>
            -- Etat d'attente que l'autre machine voit qu'on a la m�me signature qu'elle
            -- On est ici parcequ'on a une signature �gale � la signautre sur l'aute voie, mais l'autre voie est ent rain de chercher
            -- dans la DPRAM
               IF (fsm_anasig2 = store_sig_st) THEN
               -- Si l'autre voie s'appr�te � stocker
                  end_ana1 <= '1';
                  dont_keep1 <= '1';         -- On ne garde pas la trame (elle est gard�e par l'autre voie)
                  fsm_anasig1 <= idle_st;
               ELSIF (fsm_anasig2 = clear_sig_st) THEN
                  end_ana1 <= '1';
                  dont_keep1 <= '0';         -- On garde celle la puisqu'elle est supprim�e par l'autre voie
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
   -- Machine d'�tat d'analyse de la signature cot� 2
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
            -- Etat d'attente d'un d�but de trame
               cpt_add2 <= (OTHERS => '0');
               we_sig2 <= "0";
               signature2(79 DOWNTO 72) <= no_typfrm;  -- On initialise la signature avec un type inconnu pour pas �tre r�utilis�
               IF (sof2 = '1') THEN
                  cpt_byt2 <= (OTHERS => '0');
                  end_ana2 <= '0';
                  fsm_anasig2 <= get_sig_st;
               END IF;
               
            WHEN get_sig_st =>
            -- Etat de r�cup�ration de la signature en fonction du type de trame. Le type est le premier octet re�u
            -- et est donc dans une cellule diff�rente selon le nombre d'octets re�u
               cpt_byt2 <= cpt_byt2 + 1;
               IF (shifter2(55 DOWNTO 48) = sync_typfrm AND cpt_byt2 = "0110") THEN
               -- Si c'est une trame de synchro et qu'on a re�u 7 caract�res
                  signature2 <= shifter2(55 DOWNTO 0) & x"000000";   -- La signature fait 56 bits cal�s sur les MSB
                  fsm_anasig2 <= compsig_st;
               ELSIF ((shifter2(39 DOWNTO 32) = reqnosec_typfrm OR shifter2(39 DOWNTO 32) = repnosec_typfrm) AND cpt_byt2 = "0100") THEN
               -- Si c'est une requ�te ou une r�ponse non s�curitaire
                  signature2 <= shifter2(39 DOWNTO 0) & x"0000000000";-- La signature fait 40 bits cal�s sur les MSB
                  fsm_anasig2 <= compsig_st;
               ELSIF (cpt_byt2 = "1001") THEN
               -- Pour tous les autre types de trame
                  signature2 <= shifter2(79 DOWNTO 0);   -- La signature fait 80 bits cal�s sur les MSB
                  fsm_anasig2 <= compsig_st;
               END IF;
         
            WHEN compsig_st =>
            -- Etat de comparaison avec la signature de l'autre voie
               IF (signature1 = signature2) THEN
               -- Si la signature qu'on vient de recevoir sur port 2 est �gale � la signature sur port 1
                  IF (fsm_anasig1 = compsig_st) THEN
                  -- Si les 2 machines en sont au m�me point, la voie 1 garde la trame, la voie 2 la jette
                     fsm_anasig2 <= idle_st;             -- Pas besoin de toucher � la DPRAM
                     end_ana2 <= '1';
                     dont_keep2 <= '1';                  -- On jette la voie 2
                  ELSIF (fsm_anasig1 = store_sig_st) THEN
                  -- Si la machine voie 1 est dans l'�tat de stockage de la signature
                     fsm_anasig2 <= idle_st;             -- Pas besoin de toucher � la DPRAM
                     end_ana2 <= '1';
                     dont_keep2 <= '1';                  -- On va garder la voie 1, on jette la voie 2
                  ELSIF (fsm_anasig1 = clear_sig_st) THEN
                  -- Si la machine voie 1 est dans l'�tat de clear de la signature
                  -- Cas tr�s particulier de r�ception de 2 trames avec la m�me signature re�ues
                  -- sur les 2 ports. La 2�me du premier couple peut conduire � un clear dans la DPRAM alors
                  -- qu'on re�oit la premi�re du second couple qu'il faut alors stocker
                     fsm_anasig2 <= wait_dpupdate_st;    -- On va traiter la trame
                  ELSIF (fsm_anasig1 /= idle_st) THEN
                  -- Si les 2 machines ne sont pas au m�me point (c'est que fsm_anasig1 est en avance)
                  -- Si elle n'est pas en idle, elle n'a pas encore stock� sa signature dans la DPRAM
                     fsm_anasig2 <= wait_sync_fsm_st;    -- On va attendre que fsm1 soit au point d'enregistrement
                  ELSE
                  -- Cas o� fsm_anasig1 est revenu � idle mais n'a pas encore annul� signature1 (dure 1 cycle)
                  -- Si la machine 1 est dans idle, elle a d�j� stock� sa signature en DPRAM. Pendant un cycle (le temps
                  -- que la machine 1 cleare sa signature, on peut �tre ici)
                     fsm_anasig2 <= wait_dpupdate_st;    -- On va donc parcourir la m�moire normalement
                  END IF;
               ELSE
               -- Si les 2 signatures ne sont pas �quivalentes
                  fsm_anasig2 <= wait_dpupdate_st;       -- On va parcourir la DPRAM pour chercher la signature
               END IF;

            WHEN wait_dpupdate_st =>
            -- Etat d'attente que l'�ventuelle derni�re �criture sur le port A soit r�percut�e sur le port B
               cpt_add2 <= cpt_add2 + 1;
               fsm_anasig2 <= cherche_dpram_st;
 
            WHEN cherche_dpram_st =>
            -- Etat de parcours de la DPRAM pour chercher la signature
            -- en rentrant dans cet �tat la premi�re fois, la don�ne � l'adress x"00" est d�j� disponible sur le bus data
               IF (sigrd_dp2 = ('0' & signature2)) THEN
               -- Si la signature est d�j� dans la DPRAM et �crite par la voie 1 (MSB � '0')
                  fsm_anasig2 <= clear_sig_st;        -- On va clearer cette entr�e
               ELSIF (cpt_add2 = nb_lignedp) THEN
               -- Si on a atteind la derni�re ligne du tableau, c'est qu'on a pas trouv� la signature
                  fsm_anasig2 <= store_sig_st;        -- On va la stocker
               ELSE
                  cpt_add2 <= cpt_add2 + 1;
               END IF;
               IF (sigrd_dp2(79 DOWNTO 72) = no_typfrm) THEN
               -- Si la case est vide on va la garder en m�moire
                  last_empty2 <= cpt_add2 - 1;        -- On m�morise l'adresse de la derni�re case vide (-1 car l'adresse a toujours un coup d'avance)
               END IF;

            WHEN clear_sig_st =>
            -- Etat de suppression d'une entr�e dans la DPRAM (i.e. la trame a d�j� �t� re�ue)
               end_ana2 <= '1';
               dont_keep2 <= '1';               -- On signale de ne pas garder la trame
               clr_sig2 <= '1';                 -- On va clearer l'entr�e dans la DPRAM
               cpt_add2 <= cpt_add2 - 1;  -- On peut aller clearer l'entr�e correspondante (-1 car l'adresse a toujours un coup d'avance)
               we_sig2 <= "1";
               fsm_anasig2 <= idle_st;       -- Que la trame soit bonne ou pas on a fini
               
            WHEN store_sig_st =>
            -- Etat d'enregistrement de la signature
               end_ana2 <= '1';
               dont_keep2 <= '0';               -- On signale de garder la trame
               cpt_add2 <= last_empty2;         -- On va �crire dans la premi�re case libre
               clr_sig2 <= '0';                 -- On va �crire la signature
               IF (signature1 /= signature2) THEN
               -- On est en train d'attendre la fin de la trame.
               -- Si en cours de route, on re�oit la m�me signature sur l'autre voie, il n'y a plus besoin d'�crire dans la DPRAM
                  we_sig2 <= "1";
               END IF;
               fsm_anasig2 <= idle_st; 

            WHEN wait_sync_fsm_st =>
            -- Etat d'attente que l'autre machine voit qu'on a la m�me signature qu'elle
            -- On est ici parcequ'on a une signature �gale � la signautre sur l'aute voie, mais l'autre voie est ent rain de chercher
            -- dans la DPRAM
               IF (fsm_anasig1 = store_sig_st) THEN
               -- Si l'autre voie s'appr�te � stocker
                  end_ana2 <= '1';
                  dont_keep2 <= '1';         -- On ne garde pas la trame (elle est gard�e par l'autre voie)
                  fsm_anasig2 <= idle_st;
               ELSIF (fsm_anasig1 = clear_sig_st) THEN
                  end_ana2 <= '1';
                  dont_keep2 <= '0';         -- On ne garde pas la trame elle est gard�e par l'autre voie
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
   sigwr_dp1(80) <= '0';            -- Le MSB dans la DPRAM indique la voie qui a re�u la trame
   sigwr_dp1(79 DOWNTO 72) <= no_typfrm WHEN clr_sig1 = '1' ELSE signature1(79 DOWNTO 72);
   sigwr_dp1(71 DOWNTO 0)  <= signature1(71 DOWNTO 0);

   sigwr_dp2(80) <= '1';            -- Le MSB dans la DPRAM indique la voie qui a re�u la trame
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

