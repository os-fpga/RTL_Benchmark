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
-- Object        : Entity work.esoc_port_processor_control
-- Last modified : Mon Apr 14 12:49:26 2014.
--------------------------------------------------------------------------------



library ieee, std, work;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.numeric_std.all;
use work.package_esoc_configuration.all;

entity esoc_port_processor_control is
  generic(
    esoc_port_nr : integer := 0);
  port(
    clk_control             : in     std_logic;
    clk_data                : in     std_logic;
    clk_search              : in     std_logic;
    ctrl_address            : in     std_logic_vector(15 downto 0);
    ctrl_rd                 : in     std_logic;
    ctrl_rddata             : out    std_logic_vector(31 downto 0);
    ctrl_vlan_id            : out    std_logic_vector(11 downto 0);
    ctrl_vlan_id_member_in  : in     std_logic_vector(0 downto 0);
    ctrl_vlan_id_member_out : out    std_logic_vector(0 downto 0);
    ctrl_vlan_id_wr         : out    std_logic;
    ctrl_wait               : out    std_logic;
    ctrl_wr                 : in     std_logic;
    ctrl_wrdata             : in     std_logic_vector(31 downto 0);
    inbound_done_cnt        : in     std_logic;
    inbound_drop_cnt        : in     std_logic;
    outbound_done_cnt       : in     std_logic;
    outbound_drop_cnt       : in     std_logic;
    reset                   : in     STD_LOGIC := '0';
    search_done_cnt         : in     std_logic;
    search_drop_cnt         : in     std_logic);
end entity esoc_port_processor_control;

--------------------------------------------------------------------------------
-- Object        : Architecture work.esoc_port_processor_control.esoc_port_processor_control
-- Last modified : Mon Apr 14 12:49:26 2014.
--------------------------------------------------------------------------------


architecture esoc_port_processor_control of esoc_port_processor_control is

---------------------------------------------------------------------------------------------------------------
-- registers
---------------------------------------------------------------------------------------------------------------
constant reg_port_proc_vlan_control_add: integer                                := 407;

constant reg_port_proc_outbound_done_count_add: integer                         := 406;
signal reg_port_proc_outbound_done_count: std_logic_vector(31 downto 0);
signal reg_port_proc_outbound_done_count_i: std_logic_vector(31 downto 0);
constant reg_port_proc_outbound_done_count_rst: std_logic_vector(31 downto 0)   := X"00000000";

constant reg_port_proc_outbound_drop_count_add: integer                         := 405;
signal reg_port_proc_outbound_drop_count: std_logic_vector(31 downto 0);
signal reg_port_proc_outbound_drop_count_i: std_logic_vector(31 downto 0);
constant reg_port_proc_outbound_drop_count_rst: std_logic_vector(31 downto 0)   := X"00000000";

constant reg_port_proc_inbound_done_count_add: integer                          := 404;
signal reg_port_proc_inbound_done_count: std_logic_vector(31 downto 0);
signal reg_port_proc_inbound_done_count_i: std_logic_vector(31 downto 0);
constant reg_port_proc_inbound_done_count_rst: std_logic_vector(31 downto 0)    := X"00000000";

constant reg_port_proc_inbound_drop_count_add: integer                          := 403;
signal reg_port_proc_inbound_drop_count: std_logic_vector(31 downto 0);
signal reg_port_proc_inbound_drop_count_i: std_logic_vector(31 downto 0);
constant reg_port_proc_inbound_drop_count_rst: std_logic_vector(31 downto 0)    := X"00000000";

constant reg_port_proc_search_done_count_add: integer                           := 402;
signal reg_port_proc_search_done_count: std_logic_vector(31 downto 0);
signal reg_port_proc_search_done_count_i: std_logic_vector(31 downto 0);
constant reg_port_proc_search_done_count_rst: std_logic_vector(31 downto 0)     := X"00000000";

constant reg_port_proc_search_drop_count_add: integer                           := 401;
signal reg_port_proc_search_drop_count: std_logic_vector(31 downto 0);
signal reg_port_proc_search_drop_count_i: std_logic_vector(31 downto 0);
constant reg_port_proc_search_drop_count_rst: std_logic_vector(31 downto 0)     := X"00000000";

constant reg_port_proc_stat_ctrl_add: integer                                   := 400;
signal reg_port_proc_stat_ctrl: std_logic_vector(31 downto 0);
constant reg_port_proc_stat_ctrl_rst: std_logic_vector(31 downto 0)             := X"00000000";

---------------------------------------------------------------------------------------------------------------
-- signals
---------------------------------------------------------------------------------------------------------------
signal search_cnt_update_ack_sync: std_logic_vector(esoc_meta_ffs-1 downto 0);
signal search_cnt_update_sync    : std_logic_vector(esoc_meta_ffs-1 downto 0);
signal search_cnt_update         : std_logic;
signal search_cnt_update_ack     : std_logic;

signal inbound_cnt_update_ack_sync: std_logic_vector(esoc_meta_ffs-1 downto 0);
signal inbound_cnt_update_sync    : std_logic_vector(esoc_meta_ffs-1 downto 0);
signal inbound_cnt_update         : std_logic;
signal inbound_cnt_update_ack     : std_logic;

signal outbound_cnt_update_ack_sync: std_logic_vector(esoc_meta_ffs-1 downto 0);
signal outbound_cnt_update_sync    : std_logic_vector(esoc_meta_ffs-1 downto 0);
signal outbound_cnt_update         : std_logic;
signal outbound_cnt_update_ack     : std_logic;

signal ctrl_rddata_i: std_logic_vector(ctrl_rddata'high downto 0);
signal ctrl_wait_i: std_logic;
signal ctrl_bus_enable: std_logic;

begin

--=============================================================================================================
-- Process		  : access registers when addressed or provide data  to the ctrl_rddata_i bus
-- Description	: 
--=============================================================================================================    
registers:  process(clk_control, reset)
            begin
              if reset = '1' then
                reg_port_proc_stat_ctrl <= reg_port_proc_stat_ctrl_rst;
                
                ctrl_vlan_id <= (others => '0');
                ctrl_vlan_id_member_out <= (others => '0');
                ctrl_vlan_id_wr <= '0';
                
                ctrl_rddata_i   <= (others => '0');
                ctrl_wait_i     <= '1';
                ctrl_bus_enable <= '0';
                              
              elsif clk_control'event and clk_control = '1' then
                ctrl_wait_i     <= '1';
                ctrl_bus_enable <= '0';
                ctrl_vlan_id_wr <= '0';
                
                -- continu if memory space of this entity is addressed
                if (to_integer(unsigned(ctrl_address)) >= esoc_port_nr * esoc_port_base_offset + esoc_port_proc_base) and (to_integer(unsigned(ctrl_address)) < esoc_port_nr * esoc_port_base_offset + esoc_port_proc_base + esoc_port_proc_size) then
                  -- claim the bus for ctrl_wait and ctrl_rddata
                  ctrl_bus_enable <= '1';
                                  
                  -- 
	                -- READ CYCLE started, unit addressed?
	                --
	                if ctrl_rd = '1' then
	                	-- Check register address and provide data when addressed
	                  case to_integer(unsigned(ctrl_address))- esoc_port_nr * esoc_port_base_offset is
                      when reg_port_proc_vlan_control_add           =>  ctrl_rddata_i <= (others => '0');
                                                                        ctrl_rddata_i(30 downto 30) <= ctrl_vlan_id_member_in;
                                                                        ctrl_wait_i <= '0';
                      
                      when reg_port_proc_outbound_done_count_add    =>  if outbound_cnt_update_ack = '1' then
                                                                          ctrl_rddata_i <= reg_port_proc_outbound_done_count;
                                                                          ctrl_wait_i <= '0';
                                                                        end if;
                      
                      when reg_port_proc_outbound_drop_count_add    =>  if outbound_cnt_update_ack = '1' then
                                                                          ctrl_rddata_i <= reg_port_proc_outbound_drop_count;
                                                                          ctrl_wait_i <= '0';
                                                                        end if;
                      
                      when reg_port_proc_inbound_done_count_add     =>  if inbound_cnt_update_ack = '1' then
                                                                          ctrl_rddata_i <= reg_port_proc_inbound_done_count;
                                                                          ctrl_wait_i <= '0';
                                                                        end if;
                      
                      when reg_port_proc_inbound_drop_count_add     =>  if inbound_cnt_update_ack = '1' then
                                                                          ctrl_rddata_i <= reg_port_proc_inbound_drop_count;
                                                                          ctrl_wait_i <= '0';
                                                                        end if;
                      
                      when reg_port_proc_search_done_count_add      =>  if search_cnt_update_ack = '1' then  
                                                                          ctrl_rddata_i <= reg_port_proc_search_done_count;
                                                                          ctrl_wait_i <= '0';
                                                                        end if;
                       
                      when reg_port_proc_search_drop_count_add      =>  if search_cnt_update_ack = '1' then  
                                                                          ctrl_rddata_i <= reg_port_proc_search_drop_count;
                                                                          ctrl_wait_i <= '0';
                                                                        end if;
                       
                      when reg_port_proc_stat_ctrl_add              =>  ctrl_rddata_i <= reg_port_proc_stat_ctrl;
                                                                        ctrl_wait_i <= '0';
                                                          
                      when others                                   =>  NULL;
                    end case;
                                
                  --
                  -- WRITE CYCLE started, unit addressed?
                  --
                  elsif ctrl_wr = '1' then
                  	-- Check address and accept data when addressed
                  	case to_integer(unsigned(ctrl_address))- esoc_port_nr * esoc_port_base_offset is
                      when reg_port_proc_vlan_control_add           =>  ctrl_vlan_id_wr  <= ctrl_wrdata(31);
                                                                        ctrl_vlan_id_member_out <= ctrl_wrdata(30 downto 30);
                                                                        ctrl_vlan_id <= ctrl_wrdata(11 downto 0);
                                                                        ctrl_wait_i <= '0';
                                                          
                      when reg_port_proc_stat_ctrl_add              =>  reg_port_proc_stat_ctrl <= ctrl_wrdata;
                                                                        ctrl_wait_i <= '0';

                      when others                                   =>  NULL;
                    end case;
                  end if;
                end if;
              end if;
            end process;
            
            -- Create tristate outputs
            ctrl_wait   <= ctrl_wait_i    when ctrl_bus_enable = '1' else 'Z';
            ctrl_rddata <= ctrl_rddata_i  when ctrl_bus_enable = '1' else (others => 'Z');
            
--=============================================================================================================
-- Process		  : Update counters and transfer values from search clock domain to control clock domain
-- Description	: 
--=============================================================================================================    
sync1a: process(clk_search, reset)
        begin
          if reset = '1' then
            reg_port_proc_search_done_count_i <= reg_port_proc_search_done_count_rst;
            reg_port_proc_search_drop_count_i <= reg_port_proc_search_drop_count_rst;
              
          elsif clk_search'event and clk_search = '1' then
            -- Update DONE counter
            if search_done_cnt = '1' then
              reg_port_proc_search_done_count_i <= std_logic_vector(to_unsigned(to_integer(unsigned(reg_port_proc_search_done_count_i)) + 1,reg_port_proc_search_done_count_i'length));
            end if;
            
            -- Update DROP counter
            if search_drop_cnt = '1' then
              reg_port_proc_search_drop_count_i <= std_logic_vector(to_unsigned(to_integer(unsigned(reg_port_proc_search_drop_count_i)) + 1,reg_port_proc_search_drop_count_i'length));
            end if;
          end if;
        end process;

sync1b: process(clk_search, reset)
        begin
          if reset = '1' then
            search_cnt_update  <= '0';
            search_cnt_update_ack_sync <= (others => '0');
            reg_port_proc_search_done_count <= reg_port_proc_search_done_count_rst;
            reg_port_proc_search_drop_count <= reg_port_proc_search_drop_count_rst;

          elsif clk_search'event and clk_search = '1' then
            -- synchronise update acknowledge indication
            search_cnt_update_ack_sync <= search_cnt_update_ack & search_cnt_update_ack_sync(search_cnt_update_ack_sync'high downto 1);
          
            -- no running update? start updating the other clock domain, use a copy of the counters, because they can change during the update!
            if search_cnt_update = '0' and search_cnt_update_ack_sync(0) = '0' then
              search_cnt_update <= '1';
              reg_port_proc_search_done_count <= reg_port_proc_search_done_count_i;
              reg_port_proc_search_drop_count <= reg_port_proc_search_drop_count_i;
            
            -- finalize update when acknowledge is received
            elsif search_cnt_update_ack_sync(0) = '1' then
              search_cnt_update <= '0';
            end if;
          end if;
        end process;

sync1c: process(clk_control, reset)
        begin
          if reset = '1' then
            search_cnt_update_sync  <= (others => '0');
          
          -- synchronise counter update indication
          elsif clk_control'event and clk_control = '1' then
            search_cnt_update_sync <= search_cnt_update & search_cnt_update_sync(search_cnt_update_sync'high downto 1);
          end if;
        end process;  
        
        -- send update acknowledge
        search_cnt_update_ack <=  search_cnt_update_sync(0); 

--=============================================================================================================
-- Process		  : Update counters and transfer values from data clock domain to control clock domain
-- Description	: 
--=============================================================================================================    
sync2a: process(clk_data, reset)
        begin
          if reset = '1' then
            reg_port_proc_inbound_done_count_i <= reg_port_proc_inbound_done_count_rst;
            reg_port_proc_inbound_drop_count_i <= reg_port_proc_inbound_drop_count_rst;
              
          elsif clk_data'event and clk_data = '1' then
            -- Update DONE counter
            if inbound_done_cnt = '1' then
              reg_port_proc_inbound_done_count_i <= std_logic_vector(to_unsigned(to_integer(unsigned(reg_port_proc_inbound_done_count_i)) + 1,reg_port_proc_inbound_done_count_i'length));
            end if;
            
            -- Update DROP counter
            if inbound_drop_cnt = '1' then
              reg_port_proc_inbound_drop_count_i <= std_logic_vector(to_unsigned(to_integer(unsigned(reg_port_proc_inbound_drop_count_i)) + 1,reg_port_proc_inbound_drop_count_i'length));
            end if;
          end if;
        end process;

sync2b: process(clk_data, reset)
        begin
          if reset = '1' then
            inbound_cnt_update  <= '0';
            inbound_cnt_update_ack_sync <= (others => '0');
            reg_port_proc_inbound_done_count <= reg_port_proc_inbound_done_count_rst;
            reg_port_proc_inbound_drop_count <= reg_port_proc_inbound_drop_count_rst;

          elsif clk_data'event and clk_data = '1' then
            -- synchronise update acknowledge indication
            inbound_cnt_update_ack_sync <= inbound_cnt_update_ack & inbound_cnt_update_ack_sync(inbound_cnt_update_ack_sync'high downto 1);
          
            -- no running update? start updating the other clock domain, use a copy of the counters, because they can change during the update!
            if inbound_cnt_update = '0' and inbound_cnt_update_ack_sync(0) = '0' then
              inbound_cnt_update <= '1';
              reg_port_proc_inbound_done_count <= reg_port_proc_inbound_done_count_i;
              reg_port_proc_inbound_drop_count <= reg_port_proc_inbound_drop_count_i;
            
            -- finalize update when acknowledge is received
            elsif inbound_cnt_update_ack_sync(0) = '1' then
              inbound_cnt_update <= '0';
            end if;
          end if;
        end process;

sync2c: process(clk_control, reset)
        begin
          if reset = '1' then
            inbound_cnt_update_sync  <= (others => '0');
          
          -- synchronise counter update indication
          elsif clk_control'event and clk_control = '1' then
            inbound_cnt_update_sync <= inbound_cnt_update & inbound_cnt_update_sync(inbound_cnt_update_sync'high downto 1);
          end if;
        end process;  
        
        -- send update acknowledge
        inbound_cnt_update_ack <=  inbound_cnt_update_sync(0);  
        
--=============================================================================================================
-- Process		  : Update counters and transfer values from data clock domain to control clock domain
-- Description	: 
--=============================================================================================================    
sync3a: process(clk_data, reset)
        begin
          if reset = '1' then
            reg_port_proc_outbound_done_count_i <= reg_port_proc_outbound_done_count_rst;
            reg_port_proc_outbound_drop_count_i <= reg_port_proc_outbound_drop_count_rst;
              
          elsif clk_data'event and clk_data = '1' then
            -- Update DONE counter
            if outbound_done_cnt = '1' then
              reg_port_proc_outbound_done_count_i <= std_logic_vector(to_unsigned(to_integer(unsigned(reg_port_proc_outbound_done_count_i)) + 1,reg_port_proc_outbound_done_count_i'length));
            end if;
            
            -- Update DROP counter
            if outbound_drop_cnt = '1' then
              reg_port_proc_outbound_drop_count_i <= std_logic_vector(to_unsigned(to_integer(unsigned(reg_port_proc_outbound_drop_count_i)) + 1,reg_port_proc_outbound_drop_count_i'length));
            end if;
          end if;
        end process;

sync3b: process(clk_data, reset)
        begin
          if reset = '1' then
            outbound_cnt_update  <= '0';
            outbound_cnt_update_ack_sync <= (others => '0');
            reg_port_proc_outbound_done_count <= reg_port_proc_outbound_done_count_rst;
            reg_port_proc_outbound_drop_count <= reg_port_proc_outbound_drop_count_rst;

          elsif clk_data'event and clk_data = '1' then
            -- synchronise update acknowledge indication
            outbound_cnt_update_ack_sync <= outbound_cnt_update_ack & outbound_cnt_update_ack_sync(outbound_cnt_update_ack_sync'high downto 1);
          
            -- no running update? start updating the other clock domain, use a copy of the counters, because they can change during the update!
            if outbound_cnt_update = '0' and outbound_cnt_update_ack_sync(0) = '0' then
              outbound_cnt_update <= '1';
              reg_port_proc_outbound_done_count <= reg_port_proc_outbound_done_count_i;
              reg_port_proc_outbound_drop_count <= reg_port_proc_outbound_drop_count_i;
            
            -- finalize update when acknowledge is received
            elsif outbound_cnt_update_ack_sync(0) = '1' then
              outbound_cnt_update <= '0';
            end if;
          end if;
        end process;

sync3c: process(clk_control, reset)
        begin
          if reset = '1' then
            outbound_cnt_update_sync  <= (others => '0');
          
          -- synchronise counter update indication
          elsif clk_control'event and clk_control = '1' then
            outbound_cnt_update_sync <= outbound_cnt_update & outbound_cnt_update_sync(outbound_cnt_update_sync'high downto 1);
          end if;
        end process;  
        
        -- send update acknowledge
        outbound_cnt_update_ack <=  outbound_cnt_update_sync(0);                
end architecture esoc_port_processor_control ; -- of esoc_port_processor_control

