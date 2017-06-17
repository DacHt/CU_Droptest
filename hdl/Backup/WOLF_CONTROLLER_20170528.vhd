--------------------------------------------------------------------------------
-- Company: KTH
--
-- File: WOLF_CONTROLLER.vhd
-- File history:
--      v0.1: 2017-04-15: Initial verision for drop test only 
--
-- Description: 
-- Controller for the REXUS - WOLF exeriment. Handles the statemachine and status communication.
--
-- Backup version:
-- 2017-05-28: D.R: 19:20: First version, light led at 5 sec, turn off led at 10 sec.  
-- 
-- Targeted device: <Family::ProASIC3> <Die::A3P250> <Package::100 VQFP>
-- Author: David Rozenbeek
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity WOLF_CONTROLLER is
port (
---------------------------------------------------
--                  Inputs                       --
---------------------------------------------------
    clk_main    : IN std_logic;                     -- Main clock
    clk_1hz     : IN std_logic;                     -- 1 Hz clock
    reset       : IN std_logic;                     -- Reset (when 1)
    rocket_pin  : IN std_logic;                     -- rocket pin if mounted in RMU = 1, ejected = 0
---------------------------------------------------    
--                  Outputs                      --
---------------------------------------------------
    cutter_en: OUT  std_logic                      -- Cutter Enable (0=Off, 1=On)
);
end WOLF_CONTROLLER;

architecture architecture_WOLF_CONTROLLER of WOLF_CONTROLLER is
--####################### Constants #####################################	
constant sec_cutter_enable      : integer := 10;     -- Seconds cutter should be enabled
constant sec_to_cutter_enable   : integer := 5;      -- Seconds from ejection to enable cutter. 

--####################### Signals   #####################################	
----------------------------------------------------------------------------------------------------------------------
--                  Control signals                                          |Comments                              --
----------------------------------------------------------------------------------------------------------------------
signal rocket_pin_old                   : std_logic;                          --
    
-----------------------------------------------------------------------------------------------------------------------
--                  Mission counter                                          |Comments                               --
-----------------------------------------------------------------------------------------------------------------------
signal sec_since_eject : unsigned(12 downto 0) := (others => '0');            -- Variable to keep track of seconds since ejection

----------------------------------------------------------------------------------------------------------------------- 
--                  State Machine Signals                                    |Comments                               --
-----------------------------------------------------------------------------------------------------------------------
type state is (START, IDLE, EJECTED, CUTTER_ENABLE, CUTTER_DISABLE, SLEEP);   -- State declaration
signal current_state : state;                                                 -- Current state value
signal next_state    : state := START;                                        -- Next clock cycle state value

--################# Architecture Body ###########################
begin
-----------------------------------------------------------------
--                     Signal/Port mapping                     --
-----------------------------------------------------------------

-----------------------------------------------------------------
--                     Mission counter                         --
-- Description:                                                -- 
-- Keeps track of seconds since ejected, counts up to          --
-- 2^12 = 4096 seconds (68,3 min) and then overflows back to 0.--
-----------------------------------------------------------------
mission_counter: process(clk_1hz, rocket_pin, reset) 
begin
    if ( reset = '1' ) then 
        sec_since_eject <= (others => '0');
    else
        if ( rising_edge(clk_1hz) ) then 
            sec_since_eject <= sec_since_eject + 1;
        end if;
    end if;
end process;

-----------------------------------------------------------------
--                  Main State Machine                         --
-- Description:                                                --
-- Makes transitions betweens states                           --
-----------------------------------------------------------------
main_state_machine : process(clk_main, reset, sec_since_eject, current_state, clk_1hz)
begin 
    rocket_pin_old <= rocket_pin;
    
    if(reset = '1') then
        rocket_pin_old   <= '0';
        cutter_en <= '0';
        current_state <= START;
    elsif(rising_edge(clk_main)) then
        current_state <= next_state;

        case current_state is
        -- Starting state
        when START => 
            rocket_pin_old   <= '0';
            cutter_en <= '0';
            next_state <= IDLE;
        -- IDLE state
        when IDLE => 
           -- if ('1') then --rocket_pin = '0' AND rocket_pin_old = '0') then 
                next_state <= EJECTED;
            --else
            --    next_state <= current_state;
            --end if;
        when EJECTED => 
            -- Enable cutter after "sec_to_cutter_enable" from reset
            if (sec_since_eject >= To_unsigned(sec_to_cutter_enable, sec_since_eject'length)) then 
                next_state <= CUTTER_ENABLE;
            else
                next_state <= current_state;
            end if;
        -- Enable cutter
        when CUTTER_ENABLE =>
            cutter_en <= '1';
            next_state <= CUTTER_DISABLE;
        --Disable cutter
        when CUTTER_DISABLE =>
            -- Disable cutter after "sec_to_cutter_disable" from reset
            if (sec_since_eject >= To_unsigned(sec_cutter_enable, sec_since_eject'length)) then 
                cutter_en <= '0';
                next_state <= SLEEP;
            else
                next_state <= current_state;
            end if;
        -- SLEEP state, do nothing
        when SLEEP =>
            next_state <= current_state;
        -- Default go back to start
        when others =>
            next_state <= START;
        end case;
    end if;
end process main_state_machine;

end architecture_WOLF_CONTROLLER;
