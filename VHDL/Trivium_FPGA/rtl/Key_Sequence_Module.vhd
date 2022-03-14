library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Key_Sequence_Module is
    Generic ( DATA_LENGTH : integer := 80 );
    Port( z      : out std_logic;
          finish : out std_logic;
              
          clock : in std_logic;
          init  : in std_logic;
              
          K  : in STD_LOGIC_VECTOR (DATA_LENGTH-1 downto 0);
          IV : in STD_LOGIC_VECTOR (DATA_LENGTH-1 downto 0)
          );
end Key_Sequence_Module;

architecture RTL of Key_Sequence_Module is

    -----------------------------
    --------- CONSTANTS ---------
    -----------------------------
    constant INIT_STATE_LENGTH : integer := 288;

    -----------------------------
    ---------- SIGNALS ----------
    -----------------------------
    
    -- Init state
    signal init_done : boolean;
    
    signal temp_out : std_logic;

begin
    
    -- Main process
    main_process : process(init, clock, init_done)
        variable s : std_logic_vector (INIT_STATE_LENGTH-1 downto 0);
        variable t1, t2, t3 : std_logic := '0';
        variable i : integer;
    begin
        if(rising_edge(init)) then
            s(79  downto 0)   := K(79 downto 0);
            s(92  downto 80)  := (others => '0');
            s(172 downto 93)  := IV(79 downto 0);
            s(175 downto 173) := (others => '0');
            s(283 downto 176) := (others => '0');
            s(287 downto 284) := (others => '1');
            for i in 1 to 4 * 288 loop
                t1 := s(65) xor (s(90) and s(91)) xor s(92) xor s(170);
                t2 := s(161) xor (s(174) and s(175)) xor s(176) xor s(263); 
                t3 := s(242) xor (s(285) and s(286)) xor s(287) xor s(68);
                
                s(92 downto 1) := s(91 downto 0); s(0) := t3;
                s(176 downto 94) := s(175 downto 93); s(93) := t1;
                s(287 downto 178) := s(286 downto 177); s(177) := t2;
            end loop;
            init_done <= true;
        end if;
        if(rising_edge(clock) and init_done) then
            t1 := s(65) xor s(92);
            t2 := s(161) xor s(176);
            t3 := s(242) xor s(287);
                    
            temp_out <= t1 xor t2 xor t3;
                    
            t1 := s(65) xor (s(90) and s(91)) xor s(92) xor s(170);
            t2 := s(161) xor (s(174) and s(175)) xor s(176) xor s(263); 
            t3 := s(242) xor (s(285) and s(286)) xor s(287) xor s(68);
                                    
            s(92 downto 1) := s(91 downto 0); s(0) := t3;
            s(176 downto 94) := s(175 downto 93); s(93) := t1;
            s(287 downto 178) := s(286 downto 177); s(177) := t2;
        end if;
    end process main_process;
    
    finish <= '1' when rising_edge(clock) and init_done;
    z <= temp_out when rising_edge(clock) and init_done;
    
end RTL;
