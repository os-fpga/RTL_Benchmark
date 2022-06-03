--------------------------------------------------------------------------------
--
-- This VHDL file was generated by EASE/HDL 7.4 Revision 4 from HDL Works B.V.
--
-- Ease library  : work
-- HDL library   : work
-- Host name     : S212065
-- User name     : df768
-- Time stamp    : Tue Aug 19 08:05:18 2014
--
-- Designed by   : L.Maarsen
-- Company       : LogiXA
-- Project info  : eSoC
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Object        : Entity work.esoc_port_processor_search
-- Last modified : Mon Apr 14 12:49:39 2014.
--------------------------------------------------------------------------------



library ieee, std, work;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.numeric_std.all;
use work.package_esoc_configuration.all;

entity esoc_port_processor_search is
  generic(
    esoc_port_nr : integer := 0);
  port(
    clk_search           : in     std_logic;
    inbound_header       : in     std_logic_vector(111 downto 0);
    inbound_header_empty : in     std_logic;
    inbound_header_read  : out    std_logic;
    inbound_vlan_member  : in     STD_LOGIC_VECTOR(0 downto 0);
    reset                : in     std_logic;
    search_data          : out    STD_LOGIC_VECTOR(15 downto 0);
    search_done_cnt      : out    std_logic;
    search_drop_cnt      : out    std_logic;
    search_eof           : out    std_logic;
    search_gnt_wr        : in     std_logic;
    search_key           : out    std_logic_vector(63 downto 0);
    search_req           : out    std_logic;
    search_result        : in     std_logic_vector(esoc_port_count-1 downto 0);
    search_result_av     : in     std_logic;
    search_sof           : out    std_logic;
    search_write         : out    STD_LOGIC);
end entity esoc_port_processor_search;

--------------------------------------------------------------------------------
-- Object        : Architecture work.esoc_port_processor_search.esoc_port_processor_search
-- Last modified : Mon Apr 14 12:49:39 2014.
--------------------------------------------------------------------------------


architecture esoc_port_processor_search of esoc_port_processor_search is

type   search_states is (idle, send_key_1, send_key_2, wait_for_result);
signal search_state: search_states;

signal search_sof_o: std_logic;
signal search_eof_o: std_logic;
signal search_key_o: std_logic_vector(search_key'high downto 0);

signal inbound_header_empty_i: std_logic;

begin

-- control the shared bus to the search engine
search_sof <=  search_sof_o  when search_gnt_wr = '1' else 'Z';
search_eof <=  search_eof_o  when search_gnt_wr = '1' else 'Z';
search_key <=  search_key_o  when search_gnt_wr = '1' else (others => 'Z');

--=============================================================================================================
-- Process		  : 
-- Description	: 
--=============================================================================================================    
debug:      process(clk_search, reset)
            begin
              if reset = '1' then
                inbound_header_read    <= '0';
                inbound_header_empty_i <= '0';
                
                search_req          <= '0';
                search_sof_o        <= '0';
                search_eof_o        <= '0';
                search_key_o        <= (others => '0');
                                
                search_data         <= (others => '0');
                search_write        <= '0';
                
                search_done_cnt     <= '0';
                search_drop_cnt     <= '0';
                
                search_state        <= idle;
                
              elsif clk_search'event and clk_search = '1' then
                -- reset one clock active signals
                search_eof_o        <= '0';
                search_done_cnt     <= '0';
                search_drop_cnt     <= '0';
                search_write        <= '0';
                inbound_header_read <= '0';            
                
                -- delay the empty signal to proces the VLAN membership of the first packet correctly. When the header 
                -- data of first packet is written in de header FIFO the empty signal deasserts, but in parallel (outside 
                -- this entity) the VLAN ID RAM is addressed. This entity detects the deasserted EMTPY signal and expects 
                -- the corresponding VLAN membership info from the VLAN ID RAM, which is not available at that time!
                -- This is only applicable if the first header in the FIFO is from a tagged packet and the EMPTY latency of the
                -- FIFO is 0, the latter is not the case for Altera, so you can skip this delay by using the inbound_header_empty
                -- iso. the inbound_header_empty_i signal in the search_state idle .... check simulation!
                inbound_header_empty_i <= inbound_header_empty;
                
                case search_state is
                  when idle             =>  -- used to insert a clock delay
                                            search_state <= send_key_1;
                  
                  when send_key_1       =>  -- check for new header data,new header data means new packet is coming or already available
                                            if inbound_header_empty = '0' then
                                              -- Is the inbound port member of the VID of the tagged packet or 
                                              -- is the packet untagged and does the switch use the port default VID?
                                              if inbound_header(esoc_inbound_header_vlan_flag) = '0' or inbound_vlan_member = "1" then
                                                -- Request bus to the search engine, prepare to transfer VID and DA
                                                search_req   <= '1';
                                                search_sof_o <= '1';
                                                search_key_o(esoc_search_bus_vlan+11 downto esoc_search_bus_vlan) <= inbound_header(esoc_inbound_header_vlan+11 downto esoc_inbound_header_vlan);
                                                search_key_o(esoc_search_bus_mac+47 downto esoc_search_bus_mac)   <= inbound_header(esoc_inbound_header_dmac_lo+47 downto esoc_inbound_header_dmac_lo);
                                                search_state <= send_key_2;
                                                
                                              -- Packet is tagged and the inbound port is not member of the packet VID 
                                              else
                                                -- Write destination port (none) and acknowledge header data
                                                search_data         <= (others => '0');
                                                search_write        <= '1';
                                                inbound_header_read <= '1';
                                                search_drop_cnt     <= '1';
                                                search_state        <= idle;
                                              end if;
                                            end if;
                  
                  when send_key_2       =>  -- VID and DA Address accepted when granted, provide Port Number and SA Address for learning process
                                            if search_gnt_wr = '1' then
                                              search_key_o(esoc_search_bus_sport+15 downto esoc_search_bus_sport) <= (others => '0');
                                              search_key_o(esoc_search_bus_sport+esoc_port_nr) <= '1';
                                              search_key_o(esoc_search_bus_mac+47 downto esoc_search_bus_mac) <= inbound_header(esoc_inbound_header_smac_lo+47 downto esoc_inbound_header_smac_lo);
                                              search_sof_o <= '0';
                                              inbound_header_read <= '1';
                                              search_state <= wait_for_result;
                                            end if;
                                        
                  when wait_for_result  =>  -- Wait for result from search engine
                                            if search_result_av = '1' then
                                              -- Write destination ports, skip your self, acknowledge header data
                                              search_data(search_result'high downto 0) <= search_result;
                                              search_data(esoc_port_nr) <= '0';
                                              search_write        <= '1';
                                              
                                              search_done_cnt     <= '1';  
                                              search_req          <= '0';
                                              search_eof_o        <= '1';
                                              search_state        <= send_key_1;
                                            end if;
                  
                  when others           =>  search_state <= idle;
                end case;
              end if;
            end process;
end architecture esoc_port_processor_search ; -- of esoc_port_processor_search
