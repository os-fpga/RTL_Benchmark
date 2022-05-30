--============================================================================= 
--  TITRE : MANAGE DMA
--  DESCRIPTION : 
--    Gère les transferts DMA vers la passerelle
--    Les transferts DMA sont envoyés à partir de l'adresse dma_base_pa
--    Ils sont répartis sur 3 zones (Rx1, Rx2, Tx)
--    Chaque zone contient 32 buffers de 256 octets
--    Un transfert DMA peut faire au maximum 128 octets (32 mots). Si une trame
--    fait plus, il faut la transférer en 2 fois
--  FICHIER :        manage_dma.vhd 
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

ENTITY manage_dma IS
   PORT (
      -- Ports système
      clk_sys           : IN  STD_LOGIC;  -- Clock système à 62.5MHz
      rst_n             : IN  STD_LOGIC;  -- Reset général système
      store_enable      : IN  STD_LOGIC;  -- Autorise le stockage et la transmission par DMA des trames incidentes

      -- Interfaces de réception des trames Rx1
      data_storerx1     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Données à stocker.  
      val_storerx1      : IN  STD_LOGIC;                    -- Validant du bus data_store(signal write)
      sof_storerx1      : IN  STD_LOGIC;                    -- Indique un début de trame (nouvelle trame). Synchrone du 1er octet envoyé
      eof_storerx1      : IN  STD_LOGIC;                    -- Indique que la trame est finie
      crcok_storerx1    : IN  STD_LOGIC;                    -- Indique que le CRC est bon ou pas 

      -- Interfaces de réception des trames Rx2
      data_storerx2     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Données à stocker.  
      val_storerx2      : IN  STD_LOGIC;                    -- Validant du bus data_store(signal write)
      sof_storerx2      : IN  STD_LOGIC;                    -- Indique un début de trame (nouvelle trame). Synchrone du 1er octet envoyé
      eof_storerx2      : IN  STD_LOGIC;                    -- Indique que la trame est finie
      crcok_storerx2    : IN  STD_LOGIC;                    -- Indique que le CRC est bon ou pas

      -- Interfaces de réception des trames Tx
      data_storetx      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Données à stocker.  
      val_storetx       : IN  STD_LOGIC;                    -- Validant du bus data_store(signal write)
      sof_storetx       : IN  STD_LOGIC;                    -- Indique un début de trame (nouvelle trame). Synchrone du 1er octet envoyé
      eof_storetx       : IN  STD_LOGIC;                    -- Indique que la trame est finie

      -- Signaux de gestion des buffers d'enregistrement des trames RX
      newframe_rx1      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);-- Un '1' pour un nouveau buffer DMA remplit avec Rx1
      newframe_rx2      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);-- Un '1' pour un nouveau buffer DMA remplit avec Rx2
      newframe_tx       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);-- Un '1' pour un nouveau buffer DMA remplit avec Tx
      bufferrx1_full    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);-- Un '1' pour un nouveau buffer DMA libre pour Rx1
      bufferrx2_full    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);-- Un '1' pour un nouveau buffer DMA libre pour Rx2
      buffertx_full     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);-- Un '1' pour un nouveau buffer DMA libre pour Tx
      rx1_overflow      : OUT STD_LOGIC;                    -- Indique qu'une trame Rx1 n'a pas pu être stockée
      rx2_overflow      : OUT STD_LOGIC;                    -- Indique qu'une trame Rx2 n'a pas pu être stockée
      tx_overflow       : OUT STD_LOGIC;                    -- Indique qu'une trame Tx n'a pas pu être stockée
      rx1_badformat     : OUT STD_LOGIC;                    -- Indique une erreur CRC sur une trame reçue sur Rx1
      rx2_badformat     : OUT STD_LOGIC;                    -- Indique une erreur CRC sur une trame reçue sur Rx2

      -- Interface vers le DMA du module PCIe
      dma_inprogress    : OUT STD_LOGIC;                    -- Signale qu'un transfert DMA est en cours
      dma_req           : OUT STD_LOGIC;                    -- Demande de pourvoir faire une transfert DMA
      dma_size          : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Taille du DMA en mots de 32 bits
      dma_ack           : IN  STD_LOGIC;                    -- Acquittement à la demande de DMA
      dma_compl         : IN  STD_LOGIC;                    -- Indique que le transfert DMA précédent est fini
      dma_read          : IN  STD_LOGIC;                    -- Signal de lecture pour fetcher une donéne de plus vers le DMA
      dma_data          : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);-- Donnée envoyée par DMA
      dma_add_dest      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);-- Adresse de destination coté PC pour le DMA
      dma_base_pa       : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);-- Adresse de base coté PC pour les transferts DMA
      dma_timestamp     : IN STD_LOGIC_VECTOR(7 DOWNTO 0)   -- Numéro de cycle en cours MOD 256 pour dater les trames reçues
   );
      
END manage_dma;

ARCHITECTURE rtl of manage_dma is
   -- Signaux de gestion des trames Rx
   SIGNAL frame_disporx1: STD_LOGIC;                     -- Indique qu'une trame Rx1 est dipos pour un transfert DMA
   SIGNAL frame_datarx1 : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Donnée lue dans la DPRA pour transfert DMA Rx1
   SIGNAL frame_rdrx1   : STD_LOGIC;                     -- Lit une donnée de plus dans la DPRAM Rx1
   SIGNAL frame_disporx2: STD_LOGIC;                     -- Indique qu'une trame Rx2 est dipos pour un transfert DMA
   SIGNAL frame_datarx2 : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Donnée lue dans la DPRA pour transfert DMA Rx2
   SIGNAL frame_rdrx2   : STD_LOGIC;                     -- Lit une donnée de plus dans la DPRAM Rx2
   SIGNAL frame_dispotx : STD_LOGIC;                     -- Indique qu'une trame Tx est dipos pour un transfert DMA
   SIGNAL frame_datatx  : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Donnée lue dans la DPRA pour transfert DMA Tx
   SIGNAL frame_rdtx    : STD_LOGIC;                     -- Lit une donnée de plus dans la DPRAM Tx

   SIGNAL sel_voierx    : STD_LOGIC_VECTOR(1 DOWNTO 0);  -- Sélecteur de voie 0:Rx1, 1:Rx2, 2:Tx
   SIGNAL dma_datamux   : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Multiplexage des données à transférer selon la voie
   SIGNAL dma_rest      : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Nombre de mots de 32 bits restant à transférer
   SIGNAL new_frame     : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Un '1' signale le numéro de buffer qui veint d'être rempli par DMA
   SIGNAL buf_selected  : STD_LOGIC_VECTOR(4 DOWNTO 0);  -- Numéro du 1er buffer disponible en fonction de la voie traitée
   SIGNAL buf_selectmem : STD_LOGIC_VECTOR(4 DOWNTO 0);  -- Mémorisation du numéro de buffer sélectionné à un instant donné
   -- Machine d'état de gestion des DMA
   TYPE fsm_dma_type IS (idledma_st, calc_dma_size_st, wait_dma_ack_st, wait_dma_compl_st, update_flag_st);
   SIGNAL fsm_dma       : fsm_dma_type;

   SIGNAL rx1_tobeproc  : STD_LOGIC;   -- A 1 lorsque la voie Rx1 demande un transfert DMA
   SIGNAL rx2_tobeproc  : STD_LOGIC;   -- A 1 lorsque la voie Rx2 demande un transfert DMA
   SIGNAL tx_tobeproc   : STD_LOGIC;   -- A 1 lorsque la voie Tx demande un transfert DMA

   COMPONENT store_framerxdma
   PORT(
      clk_sys     : IN  STD_LOGIC;
      rst_n       : IN  STD_LOGIC;
      store_enable: IN  STD_LOGIC;
      data_store  : IN  STD_LOGIC_VECTOR(7 downto 0);
      val_store   : IN  STD_LOGIC;
      sof_store   : IN  STD_LOGIC;
      eof_store   : IN  STD_LOGIC;
      crcok_store : IN  STD_LOGIC;
      frame_dispo : OUT STD_LOGIC;
      frame_data  : OUT STD_LOGIC_VECTOR(31 downto 0);
      frame_rd    : IN  STD_LOGIC;
      overflow    : OUT STD_LOGIC;
      bad_format  : OUT STD_LOGIC;
      timestamp   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0)
     );
   END COMPONENT;
  
   COMPONENT store_frametxdma
   PORT(
      clk_sys     : IN  STD_LOGIC;
      rst_n       : IN  STD_LOGIC;
      store_enable: IN  STD_LOGIC;
      data_store  : IN  STD_LOGIC_VECTOR(7 downto 0);
      val_store   : IN  STD_LOGIC;
      sof_store   : IN  STD_LOGIC;
      eof_store   : IN  STD_LOGIC;
      frame_dispo : OUT STD_LOGIC;
      frame_data  : OUT STD_LOGIC_VECTOR(31 downto 0);
      frame_rd    : IN  STD_LOGIC;
      overflow    : OUT STD_LOGIC;
      timestamp   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0)
     );
   END COMPONENT;
  
BEGIN
   --------------------------------
   -- Module de stockage des trames reçues sur Rx1
   --------------------------------
   storerx1 : store_framerxdma 
   PORT MAP (
      clk_sys => clk_sys,
      rst_n => rst_n,
      store_enable => store_enable,
      data_store => data_storerx1,
      val_store => val_storerx1,
      sof_store => sof_storerx1,
      eof_store => eof_storerx1,
      crcok_store => crcok_storerx1,
      frame_dispo => frame_disporx1,
      frame_data => frame_datarx1,
      frame_rd => frame_rdrx1,
      overflow => rx1_overflow,
      bad_format => rx1_badformat,
      timestamp => dma_timestamp
        );

   --------------------------------
   -- Module de stockage des trames reçues sur Rx2
   --------------------------------
   storerx2 : store_framerxdma 
   PORT MAP (
      clk_sys => clk_sys,
      rst_n => rst_n,
      store_enable => store_enable,
      data_store => data_storerx2,
      val_store => val_storerx2,
      sof_store => sof_storerx2,
      eof_store => eof_storerx2,
      crcok_store => crcok_storerx2,
      frame_dispo => frame_disporx2,
      frame_data => frame_datarx2,
      frame_rd => frame_rdrx2,
      overflow => rx2_overflow,
      bad_format => rx2_badformat,
      timestamp => dma_timestamp
        );

   --------------------------------
   -- Module de stockage des trames reçues sur Tx
   --------------------------------
   storetx : store_frametxdma 
   PORT MAP (
      clk_sys => clk_sys,
      rst_n => rst_n,
      store_enable => store_enable,
      data_store => data_storetx,
      val_store => val_storetx,
      sof_store => sof_storetx,
      eof_store => eof_storetx,
      frame_dispo => frame_dispotx,
      frame_data => frame_datatx,
      frame_rd => frame_rdtx,
      overflow => tx_overflow,
      timestamp => dma_timestamp
        );

   ----------------------------------------------
   -- Multiplexage des signaux selon al voie en cours de traitement
   ----------------------------------------------
   -- Donnée envoyée vers le DMA
   dma_datamux    <= frame_datarx1 WHEN (sel_voierx = "00") ELSE 
                     frame_datarx2 WHEN (sel_voierx = "01") ELSE
                     frame_datatx;
                     
   -- Pour les DMA, il faut inverser l'ordre little / big endian.
   dma_data       <= dma_datamux(7  DOWNTO  0) & dma_datamux(15 DOWNTO 8) & 
                     dma_datamux(23 DOWNTO 16) & dma_datamux(31 DOWNTO 24); --dma_datamux;

   -- On lit le bon buffer selon la voie sélectionnée
   frame_rdrx1    <= dma_read WHEN (sel_voierx = "00") ELSE '0';
   frame_rdrx2    <= dma_read WHEN (sel_voierx = "01") ELSE '0';
   frame_rdtx     <= dma_read WHEN (sel_voierx = "10") ELSE '0';
   
   -- Indique au module mémroy map quel bufefr de quelle zone a été rempli
   newframe_rx1   <= new_frame WHEN (sel_voierx = "00") ELSE x"00000000";
   newframe_rx2   <= new_frame WHEN (sel_voierx = "01") ELSE x"00000000";
   newframe_tx    <= new_frame WHEN (sel_voierx = "10") ELSE x"00000000";

   -- demande de transfert DMA = au moins une trame stockée et au moins 1 buffer de libre dans la zone concernée
   rx1_tobeproc <= '1' WHEN (frame_disporx1 = '1' AND bufferrx1_full /= x"FFFFFFFF") ELSE '0';
   rx2_tobeproc <= '1' WHEN (frame_disporx2 = '1' AND bufferrx2_full /= x"FFFFFFFF") ELSE '0';
   tx_tobeproc  <= '1' WHEN (frame_dispotx = '1'  AND buffertx_full  /= x"FFFFFFFF") ELSE '0';

   ------------------------------------------
   -- Machine d'état de gestion du transfert DMA
   ------------------------------------------
   man_dma : PROCESS(clk_sys, rst_n)
      VARIABLE temp : STD_LOGIC_VECTOR(5 DOWNTO 0); -- Pour les calculs de taille intermédiaires
   BEGIN
      IF (rst_n = '0') THEN
         sel_voierx     <= "00";
         dma_req        <= '0';
         dma_size       <= (OTHERS => '0');
         dma_rest       <= (OTHERS => '0');
         buf_selectmem  <= (OTHERS => '0');
         new_frame      <= (OTHERS => '0');
         dma_inprogress <= '0';
         fsm_dma        <= idledma_st;
      ELSIF (clk_sys'event AND clk_sys = '1') THEN
         CASE fsm_dma IS
            WHEN idledma_st =>
            -- Etat d'attente de demande d'un transfert. Gestion des 3 zones en Round Robin
               dma_req   <= '0';             -- Pas de demande pour l'instant
               new_frame <= (OTHERS => '0'); -- Pour s'assurer que le signal ne dure qu'un clk
               IF ((rx1_tobeproc = '1') AND 
                  ((rx2_tobeproc = '0' AND tx_tobeproc = '0') OR  sel_voierx /= "00")) THEN
               -- On s'assure qu'on traite par alternance une voie et puis l'autre. On traite la voie 1 que si y'a
               -- des données a traiter et que : soit les autres voies sont vides soit on a traité une autre voie au coup d'avant
                  sel_voierx <= "00";              -- On sélectionne la voie 0 (Rx1)
                  dma_inprogress <= '1';           -- On indique que le DMA est en cours
                  fsm_dma    <= calc_dma_size_st;  -- On va calculer la tailel du DMA
               ELSIF ((rx2_tobeproc = '1') AND (tx_tobeproc = '0' OR sel_voierx /= "01")) THEN
               -- On va traiter Rx2 si y'a une demande et qu'on a pas traité du Rx2 au coup d'avant
                  sel_voierx <= "01";
                  dma_inprogress <= '1';
                  fsm_dma    <= calc_dma_size_st;
               ELSIF (tx_tobeproc = '1') THEN
               -- On va traiter du Tx si y'a une demande
                  sel_voierx <= "10";
                  dma_inprogress <= '1';
                  fsm_dma    <= calc_dma_size_st;
               ELSE
                  dma_inprogress <= '0';
               END IF;

            WHEN calc_dma_size_st =>
               -- Le premier mot contient la longueur utile de la trame. On rajoute 4 octets
               -- à la taille à transmettre pour tenir compte du premier mot qu'il faut aussi transmettre
               -- temp ne peut pas déborder car la trame utile ne peut pas excéder 250 octets
               IF (dma_datamux(1 DOWNTO 0) = "00") THEN
               -- Si le nombre d'octets à transmettre est multiple de 4
                  temp := dma_datamux(7 DOWNTO 2) + 1;   -- On rajoute que le premier mot
               ELSE
               -- Vu qu'on transmet par groupe de 4 octets, on arrondi au nombre de mots supérieur
                  temp := dma_datamux(7 DOWNTO 2) + 1 + 1; --
               END IF;
               IF (temp > "100000") THEN
               -- Si le bloc à transmettre fait plus de 128 octets (32 mots)
                  dma_size <= x"20";                     -- on envoie 128 octets
                  dma_rest <= "000" & temp(4 DOWNTO 0);  -- Et on mémorise le nombre de mots à transmettre au coup suivant
               ELSE
                  dma_size <= "00" & temp;               -- Sinon on fait un seul DMA
                  dma_rest <= (OTHERS => '0');           -- Le reste est donc nul
               END IF;
               dma_req <= '1';                           -- On demande un transfert
               -- L'adresse du transfert = @ de base + zone * 8Ko + buffer * 256
               dma_add_dest <= dma_base_pa(31 DOWNTO 15) & sel_voierx & buf_selected & "00000000";
               buf_selectmem <= buf_selected;            -- On mémorise le 1er buffer dispo au moment du transfert
               fsm_dma <= wait_dma_ack_st;

            WHEN wait_dma_ack_st =>
            -- Etat d'attente de l'acquittement envoyé parl e module PCIe
               IF (dma_ack = '1') THEN
                  dma_req <= '0';
                  fsm_dma <= wait_dma_compl_st;
               END IF;

            WHEN wait_dma_compl_st =>
            -- Etat d'attente que le dma soit fini
               IF (dma_compl = '1') THEN
               -- Si le transfert DMA est fini
                  IF (dma_rest /= "00000000") THEN
                  -- Si on a un deuxième bloc à transférer
                     dma_size <= dma_rest;
                     dma_rest <= (OTHERS => '0');
                     dma_req <= '1';
                     dma_add_dest <= dma_base_pa(31 DOWNTO 15) & sel_voierx & buf_selectmem & "10000000";
                     fsm_dma <= wait_dma_ack_st;
                  ELSE
                  -- Si on a fini
                     dma_inprogress <= '0';                          -- On indique que le DMA est dispo
                     fsm_dma <= update_flag_st;
                     new_frame(CONV_INTEGER(buf_selectmem)) <= '1';  -- On signale quel buffer a été rempli
                  END IF;
               END IF;
               
            WHEN update_flag_st =>
            -- Etat d'attente (1 cycle) que les flags bufferrx1_full, bufferrx2_full ou buffertx_full soit mis à jour.
               new_frame <= (OTHERS => '0');
               fsm_dma <= idledma_st;

            WHEN OTHERS =>
               fsm_dma <= idledma_st;
         END CASE;
      END IF;
   END PROCESS;
   
   -------------------------------------------------
   -- Calcul du premier buffer vide et de l'indice associé
   -------------------------------------------------
   sel_buffree : PROCESS(bufferrx1_full, bufferrx2_full, buffertx_full, sel_voierx)
      VARIABLE mux_buf : STD_LOGIC_VECTOR(31 DOWNTO 0);
   BEGIN
      -- En fonction de la voie choisie, on regarde le bon statut de bufefr
      IF (sel_voierx = "00") THEN
         mux_buf := bufferrx1_full;
      ELSIF (sel_voierx = "01") THEN
         mux_buf := bufferrx2_full;
      ELSE
         mux_buf := buffertx_full;
      END IF;
      IF (mux_buf(0) = '0') THEN
      -- On cherche le 1er bit à '0' (i.e. 1er buffer vide) dans le vecteur sélectionné
         buf_selected <= CONV_STD_LOGIC_VECTOR(0, 5);
      ELSIF (mux_buf(1) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(1, 5);
      ELSIF (mux_buf(2) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(2, 5);
      ELSIF (mux_buf(3) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(3, 5);
      ELSIF (mux_buf(4) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(4, 5);
      ELSIF (mux_buf(5) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(5, 5);
      ELSIF (mux_buf(6) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(6, 5);
      ELSIF (mux_buf(7) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(7, 5);
      ELSIF (mux_buf(8) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(8, 5);
      ELSIF (mux_buf(9) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(9, 5);
      ELSIF (mux_buf(10) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(10, 5);
      ELSIF (mux_buf(11) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(11, 5);
      ELSIF (mux_buf(12) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(12, 5);
      ELSIF (mux_buf(13) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(13, 5);
      ELSIF (mux_buf(14) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(14, 5);
      ELSIF (mux_buf(15) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(15, 5);
      ELSIF (mux_buf(16) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(16, 5);
      ELSIF (mux_buf(17) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(17, 5);
      ELSIF (mux_buf(18) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(18, 5);
      ELSIF (mux_buf(19) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(19, 5);
      ELSIF (mux_buf(20) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(20, 5);
      ELSIF (mux_buf(21) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(21, 5);
      ELSIF (mux_buf(22) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(22, 5);
      ELSIF (mux_buf(23) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(23, 5);
      ELSIF (mux_buf(24) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(24, 5);
      ELSIF (mux_buf(25) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(25, 5);
      ELSIF (mux_buf(26) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(26, 5);
      ELSIF (mux_buf(27) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(27, 5);
      ELSIF (mux_buf(28) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(28, 5);
      ELSIF (mux_buf(29) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(29, 5);
      ELSIF (mux_buf(30) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(30, 5);
      ELSIF (mux_buf(31) = '0') THEN
         buf_selected <= CONV_STD_LOGIC_VECTOR(31, 5);
      ELSE
      -- En cas d'overflow (i.e. pas de buffer libre, on sélectionne le dernier)
      -- Mais ce cas ne doit pas arrivé car dans ce cas, la mahcine reste en ideldma_st
         buf_selected <= CONV_STD_LOGIC_VECTOR(31, 5);      
      END IF;
   END PROCESS;
   
   
END rtl;

