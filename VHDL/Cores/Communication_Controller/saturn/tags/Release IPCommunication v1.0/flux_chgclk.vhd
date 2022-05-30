--============================================================================= 
--  TITRE : flux_chgclk
--  DESCRIPTION : 
--       Passe un flux de donnée d'une horlgoe clks à clkd
--       Passe le flux à travers une FIFO à 2 horloges asynchrones
--  FICHIER :        flux_chgclk.vhd 
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
Library UNISIM;
use UNISIM.vcomponents.all;

ENTITY flux_chgclk IS
   PORT (
      -- Ports système
      clks     : IN  STD_LOGIC;                    -- Clock du flux entrant
      clkd     : IN  STD_LOGIC;                    -- Clock du flux sortant
      rst_n    : IN  STD_LOGIC;                    -- Reset général système
      
      datas    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Flux source
      vals     : IN  STD_LOGIC;                    -- Validant du flux source
      sofs     : IN  STD_LOGIC;                    -- Début de trame du flux source
      eofs     : IN  STD_LOGIC;                    -- Fin de trame du flux source
      crcoks   : IN  STD_LOGIC;                    -- Signal de trame bonne pour flux source

      datad    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Idem pour le flux destination
      vald     : OUT STD_LOGIC;
      sofd     : OUT STD_LOGIC;
      eofd     : OUT STD_LOGIC;
      crcokd   : OUT STD_LOGIC
      );
END flux_chgclk;

ARCHITECTURE rtl of flux_chgclk is
   SIGNAL vectin     : STD_LOGIC_VECTOR(10 DOWNTO 0); -- Pour fabriquer le vecteur d'entrée de la FIFO
   SIGNAL vectout    : STD_LOGIC_VECTOR(10 DOWNTO 0); -- Pour lire la FIFO
   SIGNAL empty      : STD_LOGIC;                     -- FIFO vide
   SIGNAL wren       : STD_LOGIC;                     -- Signal d'écriture dans la FIFO

   COMPONENT fifo_ckgclk
      PORT (
         rst    : IN STD_LOGIC;
         wr_clk : IN STD_LOGIC;
         rd_clk : IN STD_LOGIC;
         din    : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
         wr_en  : IN STD_LOGIC;
         rd_en  : IN STD_LOGIC;
         dout   : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
         full   : OUT STD_LOGIC;
         empty  : OUT STD_LOGIC
      );
   END COMPONENT;
  
BEGIN
   -- Le vecteur écrit dans la FIFO est composé des données et des signaux de controle EOF, SOF, CRCOK
   vectin <= crcoks & eofs & sofs & datas;
   wren <= vals OR eofs;   -- Le VAL n'est pas actif pendant le EOF, on force wren pour le EOF soit dans la FIFO

   inst_chgclk :  fifo_ckgclk
   PORT MAP(
      rst    => NOT(rst_n),
      wr_clk => clks,
      rd_clk => clkd,
      din    => vectin,
      wr_en  => wren,
      rd_en  => '1',
      dout   => vectout,
      full   => open,
      empty  => empty
   ); 

   -- Réaffectation des signaux en focntion du vecteur de sortie
   crcokd <= vectout(10);
   eofd   <= vectout(9);
   sofd   <= vectout(8);
   datad  <= vectout(7 DOWNTO 0);
   vald <= NOT(empty);     -- La FIFO non vide indique une donnée disponible

END rtl;

