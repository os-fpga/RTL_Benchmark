--============================================================================= 
--  TITRE : serial_tx
--  DESCRIPTION : 
--        Sérialise un mot 8 bits sur 10 bits. La durée d'un bit est 
--        égale à tc_divclk+1 pulse de clk_sys		

--  FICHIER :        serial_tx.vhd 
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

ENTITY serial_tx IS
   GENERIC (
      nbbit_div : INTEGER := 10); -- Nombre de bits pour coder le diviseur d'horloge
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;  -- Clock système
      rst_n    : IN  STD_LOGIC;  -- Reset général système

      -- Interface série
      tc_divclk: IN  STD_LOGIC_VECTOR (nbbit_div-1 DOWNTO 0); -- Diviseur de l'horloge système pour le baudrate
      tx       : OUT  STD_LOGIC; -- Transmission série
      
      -- Interface parallèle
      ser_rdy  : OUT STD_LOGIC;  -- Le sérialisateur est prêt à traiter un nouveau car
      start_ser: IN  STD_LOGIC;  -- Déclenche la sérialisation du mot présent sur tx_dat
      tx_dat   : IN  STD_LOGIC_VECTOR (7 DOWNTO 0)  -- Prochaine donnée à sérialiser
      );
END serial_tx;

ARCHITECTURE rtl of serial_tx is
   SIGNAL cptbit_tx        : STD_LOGIC_VECTOR(3 downto 0);  -- Compteur de bits dans un caractère en émission
   SIGNAL divclk_tx        : STD_LOGIC_VECTOR(nbbit_div-1 downto 0);  -- Diviseur d'horloge pour mesurer un bit en émission
   SIGNAL ser_rdy_buf      : STD_LOGIC;                     -- Le sérialisateur est prêt à traiter un nouveau car
   SIGNAL shifter_tx       : STD_LOGIC_VECTOR(9 downto 0);  -- Registre à décalage pour la transmission
   
BEGIN

   --------------------------------------------
   -- Sérialise sur 10 bits une donnée 8 bits en entrée 
   --------------------------------------------
   ser : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         cptbit_tx <= (OTHERS => '0');
         divclk_tx <= (OTHERS => '0');
         ser_rdy_buf <= '1';
         shifter_tx <= (OTHERS => '1');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (ser_rdy_buf = '1') THEN
         -- Si le sérialisateur est libre (i.e. il n'est pas déjà en train de sérialiser)
            IF (start_ser = '1') THEN
            -- Sur réception d'un ordre de sérialisation
               ser_rdy_buf <= '0';                 -- On indique que le sérialsiateur est occupé
               shifter_tx <= '1' & tx_dat & '0';   -- On charge le registre à décalage avec le start, les 8 bits de data et le stop
               cptbit_tx <= (OTHERS => '0');       -- On init le compteur de bit
               divclk_tx <= (OTHERS => '0');       -- On init le diviseur d'horloge
            END IF;
         ELSE
         -- Si on est en cours de sérialsiation
            IF (divclk_tx = tc_divclk) THEN
            -- Pour chaque durée de 1 bit
               shifter_tx <= '1' & shifter_tx(9 downto 1);  -- On décale LSB first en insérant des 1 (ligne IDLE)
               cptbit_tx <= cptbit_tx + 1;                  -- un bit de plus traité
               IF (cptbit_tx = "1001") THEN
               -- Lorsqu'on a transmis les 10 bits
                  ser_rdy_buf <= '1';                        -- On revient en disponible
               ELSIF (cptbit_tx = "1000") THEN              
               -- A la fin d'émission du 9 ème bit
                  divclk_tx <= CONV_STD_LOGIC_VECTOR(1, divclk_tx'length); -- On initiaslie le compteur à 1 pour que le signal
                                                                           -- ser_rdy soit synhcrone du dernier clk_sys du dernier bit
               ELSE
               -- Pour tous les autres bits, on compte le nombre de cycles exact pour la durée de 1 bit
                  divclk_tx <= (OTHERS => '0');
               END IF;
            ELSE
               divclk_tx <= divclk_tx + 1;
            END IF;
         END IF;
      END IF;
   END PROCESS;
   ser_rdy <= ser_rdy_buf;
   tx <= shifter_tx(0);

END rtl;

