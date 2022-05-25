--============================================================================= 
--  TITRE : READMAC
--  DESCRIPTION : 
--       R�cup�re le DNA du composant et g�n�re l'adresse MAC du composant

--  FICHIER :        readmac.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  10/04/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION 
--  17/11/14   DRA      SATURN   V1.1
--             Suppression d'un coup de shift pour garder les 57 bits utiles en LSB
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;

ENTITY readmac IS
   GENERIC (
      -- Valeur utilis�e pour la simulation
      sim_dna_value : STD_LOGIC_VECTOR(59 DOWNTO 0) :=  X"023456789ABCDEF");
   PORT (
      -- Ports syst�me
      clk_sys  : IN  STD_LOGIC;  -- Clock syst�me
      rst_n    : IN  STD_LOGIC;  -- Reset g�n�ral syst�me
      
      -- R�sultat
      mac      : OUT  STD_LOGIC_VECTOR(63 downto 0);
      mac_rdy  : OUT  STD_LOGIC  -- Indique que l'adresse MAC a �t� r�cup�r�e
      );
END readmac;

ARCHITECTURE rtl of readmac is
   SIGNAL cptbit  : STD_LOGIC_VECTOR(5 downto 0);  -- compteur de bit
   SIGNAL shifter : STD_LOGIC_VECTOR(56 downto 0); -- Shifter pour r�ceptionner le DNA
   SIGNAL gnd     : STD_LOGIC;                     -- '0' logique
   SIGNAL read    : STD_LOGIC;                     -- Ordre de lecture du DNA
   SIGNAL read_r  : STD_LOGIC;                     -- Ordre de lecture retard�
   SIGNAL shift   : STD_LOGIC;                     -- Signal de shift d'un bit du DNA
   SIGNAL dout    : STD_LOGIC;                     -- Bit sorti du DNA
  
BEGIN
   gnd <= '0';
   
   --------------------------------------------
   -- Comptage des bits et registre � d�calage
   --------------------------------------------
   inst_cpt : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         cptbit <= (OTHERS => '0');
         read <= '1';
         read_r <= '1';
         mac_rdy <= '0';
      ELSIF (clk_sys'EVENT AND clk_sys = '1') THEN
         read <= '0';
         read_r <= read;                     -- On assure que le signal de lecture � dur� au moins 1 clk_sys
         IF (read_r = '0') THEN              -- Quand la lecture est finie
            IF (cptbit /= "111001") THEN     -- On shifte 57 bits
            -- Si on a pas r�cup�r� les 57 bits
               shift <= '1';                 -- On ordonne le shift au DNA
               shifter <= shifter(55 DOWNTO 0) & dout;   -- On prend un bit de plus
               cptbit <= cptbit + 1;
            ELSE
            -- Si ona r�cup�r� tous les bits
               shift <= '0';                 -- On annule le shift DNA
               mac_rdy <= '1';               -- On indique que le MAC est pr�t
            END IF;
         END IF;
      END IF;
   END PROCESS;
   mac <= "1111111" & shifter;               -- DNA sur 57 bits et MAC sur 64

   -- Instantiation de la ressource DNA du FPGA
   dn_port_inst : DNA_PORT
   GENERIC MAP (
      sim_dna_value => TO_BITVECTOR(sim_dna_value)
   )
   port map (
      dout => dout,
      clk => clk_sys,
      din => gnd,     
      read => read_r,
      shift => shift
   );

END rtl;

