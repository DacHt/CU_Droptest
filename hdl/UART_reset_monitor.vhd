--------------------------------------------------------------------------------
-- Company: KTH
--
-- File: UART_reset_monitor.vhd
-- File history:
--      <v0.1>: <2017-06-18>: Initital verison
--
-- Description: 
--
-- Monitors the UART rx channels for a reset command ('r') from RMU. If commands is recevied it set the 
-- reset signal high for 1 sec to reset the whole system.
--
-- Targeted device: <Family::ProASIC3> <Die::A3P250> <Package::100 VQFP>
-- Author: David Rozenbeek
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UART_reset_monitor is
port (
---------------------------------------------------
--                  Inputs                       --
---------------------------------------------------
    mclk        : IN std_logic;                         -- Master clock
    reset_in    : IN std_logic;                         -- Reset
    txrdy       : IN std_logic;                         -- Set to high when command is recevied 
    data_in     : IN std_logic_vector(7 downto 0);       -- Data_in from UART
---------------------------------------------------
--                  Inputs                       --
---------------------------------------------------
    reset_out   : OUT std_logic := '0'                  -- Reset signal out 
 );
end UART_reset_monitor;

architecture architecture_UART_reset_monitor of UART_reset_monitor is
--####################### Constants #####################################
constant reset_clk_cyc_duration     : integer := 10; -- Amount of clock cycles the reset should last
constant reset_command              : integer := 82; -- Reset ascii character to monitor for 82 = 'R'

--####################### Signals   #####################################	
----------------------------------------------------------------------------------------------------------------------
--                  Control signals                                          |Comments                              --
----------------------------------------------------------------------------------------------------------------------
signal reset_counter : unsigned(4 downto 0) := (others => '0');               -- Variable to keep track of clock cycles

----------------------------------------------------------------------------------------------------------------------- 
--                  State Machine Signals                                    |Comments                               --
-----------------------------------------------------------------------------------------------------------------------
type reset_state is (START, IDLE, RECEIVE, RESET);       
signal reset_current_state : reset_state;                                                
signal reset_next_state    : reset_state := START;                                  

begin
-----------------------------------------------------------------
--                  Reset State Machine                        --
-- Description:                                                --
-- Reset state machine                                         --
-----------------------------------------------------------------
uart_state_machine : process(mclk, reset_in)
begin
    if(reset_in = '1') then
        reset_out <= '0';
        reset_counter <= (others => '0');
    else
        if(rising_edge(mclk)) then
            reset_current_state <= reset_next_state;            
            case reset_current_state is
            when START =>
                reset_out <= '0';
                reset_counter <= (others => '0');
                reset_next_state <= IDLE;
            when IDLE => -- Wait for receving command
                if(txrdy ='1') then
                    reset_next_state <= RECEIVE;
                end if;
            when RECEIVE => -- Recevie the byte
                if(data_in = std_logic_vector(to_unsigned(reset_command, data_in'length))) then
                    reset_next_state <= RESET;
                else
                    reset_next_state <= START;
                end if;
            when RESET =>
                reset_out <= '1';
                if (reset_counter >= To_unsigned(reset_clk_cyc_duration, reset_counter'length)) then 
                    reset_next_state <= START;
                else
                    reset_counter <= reset_counter + 1;
                end if;
            end case;
        end if;
    end if;
end process uart_state_machine;


-- architecture body
end architecture_UART_reset_monitor;
