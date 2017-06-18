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
-- 2017-05-28: D.R: Initial version, light led at 5 sec, turn off led at 10 sec. 
-- 2017-06-14: D.R: Droptest version
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
    mclk        : IN std_logic;                     -- Main clock
    clk_1hz     : IN std_logic;                     -- 1 Hz clock
    reset       : IN std_logic;                     -- Reset (when 1)

    --UART
    uart_data_in : IN std_logic_vector(7 downto 0);
    uart_txrdy   : IN std_logic;
    uart_rxrdy   : IN std_logic;
    
---------------------------------------------------    
--                  Outputs                      --
---------------------------------------------------
    --Cutter
    cutter_en       : OUT  std_logic;                     -- Cutter Enable (0=Off, 1=On)
    cutter_pwm_duty : OUT  std_logic_vector(7 downto 0);  -- Cutter PWM duty cycle (100% = 255, 0% = 0)
    
    --UART
    uart_data_out     : OUT std_logic_vector(7 downto 0); 
    uart_wen          : OUT std_logic;                          
    uart_oen          : OUT std_logic;
    uart_baud_val     : OUT std_logic_vector(12  downto 0);
    uart_baud_val_frac: OUT std_logic_vector(2  downto 0) := "000";

    --LED
    led1              : OUT std_logic;
    led2              : OUT std_logic
);
end WOLF_CONTROLLER;

architecture architecture_WOLF_CONTROLLER of WOLF_CONTROLLER is
--####################### Constants #####################################

--Cutter	
constant sec_cutter_enable      : integer := 2;    -- Seconds cutter should be enabled
constant sec_to_cutter_enable   : integer := 2;     -- Seconds from ejection to enable cutter.
constant cutter_duty            : integer := 50;    -- Cutter PWM duty cycle, controls current through heating filament(255 => More current, 0 => Less current)

--Uart
constant uart_baud_val_int      : integer := 212;   -- baudval = (mclk / (16 * baudrate)) - 1; set for 9600 baud

--####################### Signals   #####################################	
----------------------------------------------------------------------------------------------------------------------
--                  Control signals                                          |Comments                              --
----------------------------------------------------------------------------------------------------------------------
--uart
signal uart_data_buffer_in       : std_logic_vector(7 downto 0) :=(others => '0');
signal uart_ready                : std_logic                    := '0';
signal main_uart_transmit_flag   : std_logic                    := '0';
signal main_uart_data_out        : std_logic_vector(7 downto 0) :=(others => '0');

--Misson counter
signal sec_since_res : unsigned(12 downto 0) := (others => '0');            -- Variable to keep track of seconds since reset

----------------------------------------------------------------------------------------------------------------------- 
--                  State Machine Signals                                    |Comments                               --
-----------------------------------------------------------------------------------------------------------------------
type main_state is (START, IDLE, CUTTER_ENABLE, CUTTER_DISABLE, SLEEP);       
signal main_current_state : main_state;                                                
signal main_next_state    : main_state := START;                                  

type uart_state is (START, IDLE, RECEIVE, RESPONSE, TRANSMIT);       
signal uart_current_state : uart_state;                                            
signal uart_next_state    : uart_state := START;                                   
    
--################# Architecture Body ###########################
begin
-----------------------------------------------------------------
--                     Signal/Port mapping                     --
-----------------------------------------------------------------
cutter_pwm_duty <= std_logic_vector(to_unsigned(cutter_duty, cutter_pwm_duty'length));
uart_baud_val <= std_logic_vector(to_unsigned(uart_baud_val_int, uart_baud_val'length));

-----------------------------------------------------------------
--                     Mission counter                         --
-- Description:                                                -- 
-- Keeps track of seconds since reset, counts up to            --
-- 2^12 = 4096 seconds (68,3 min) and then overflows back to 0.--
-----------------------------------------------------------------
mission_counter: process(clk_1hz, reset) 
begin
    if ( reset = '1' ) then 
        sec_since_res <= (others => '0');
    else
        if ( rising_edge(clk_1hz) ) then 
            sec_since_res <= sec_since_res + 1;
        end if;
    end if;
end process;

-----------------------------------------------------------------
--                  Uart State Machine                         --
-- Description:                                                --
-- Uart state machine                                          --
-----------------------------------------------------------------
uart_state_machine : process(mclk, reset)
begin
    if(reset = '1') then
        uart_next_state <= START;
        uart_data_out <= (others => '0');
        uart_wen <= '1';
        uart_oen <= '1';
        uart_ready <= '0';
    else
        if(rising_edge(mclk)) then
            uart_current_state <= uart_next_state;
            
            case uart_current_state is
            when START => 
                uart_data_out <= (others => '0');
                uart_wen <= '1';
                uart_oen <= '1';
                uart_ready <= '0';
                uart_next_state <= IDLE;
            when IDLE => -- Wait for receving command
                uart_ready <= '1';
                if(uart_rxrdy = '1') then
                    uart_ready <= '0';
                    uart_next_state <= RECEIVE;
                elsif(main_uart_transmit_flag='1') then
                    uart_ready <= '0';
                    uart_data_out <= main_uart_data_out;
                    uart_next_state <= TRANSMIT;
                else
                    uart_next_state <= uart_current_state;
                end if;
            when RECEIVE => -- Recevie the byte
                uart_data_buffer_in <= uart_data_in;
                uart_oen <= '0';
                uart_next_state <= RESPONSE;
            
            when RESPONSE => 
                uart_data_out <= uart_data_buffer_in;
                uart_next_state <= TRANSMIT;

            when TRANSMIT =>
                if(uart_txrdy = '1') then
                    uart_wen <= '0';
                    uart_next_state <= START;
                else
                    uart_next_state <= uart_current_state;
                end if;
            end case;
        end if;
    end if;
end process uart_state_machine;

-----------------------------------------------------------------
--                  Main State Machine                         --
-- Description:                                                --
-- Main state machine of the WOLF mission controller           --
-----------------------------------------------------------------
main_state_machine : process(mclk, reset)
begin 
    if(reset = '1') then
        cutter_en <= '0';
        main_uart_transmit_flag <= '0';   
        main_uart_data_out <= x"00";
        main_next_state <= START;
    elsif(rising_edge(mclk)) then
        
        main_current_state <= main_next_state;

        case main_current_state is
        -- Starting state
        when START => 
            cutter_en <= '0';
            main_uart_transmit_flag <= '0';  
            if(uart_ready = '1') then 
                main_next_state <= IDLE;
                main_uart_data_out <= x"01";
                main_uart_transmit_flag <= '1';
            end if;
        -- IDLE state
        when IDLE => 
            main_uart_transmit_flag <= '0';
            -- Enable cutter after "sec_to_cutter_enable" from reset
            if (sec_since_res >= To_unsigned(sec_to_cutter_enable, sec_since_res'length)) then 
                if(uart_ready = '1') then                 
                    main_next_state <= CUTTER_ENABLE;
                    main_uart_data_out <= x"02";
                    main_uart_transmit_flag <= '1';
                end if;
            else
                main_next_state <= main_current_state;
            end if;
        -- Enable cutter
        when CUTTER_ENABLE =>
            main_uart_transmit_flag <= '0';
      
            if(uart_ready = '1') then 
                cutter_en <= '1';
                main_uart_data_out <= x"03";
                main_uart_transmit_flag <= '1';
                main_next_state <= CUTTER_DISABLE;
            end if;
        --Disable cutter
        when CUTTER_DISABLE =>
            -- Disable cutter after "sec_cutter_enable" 
            main_uart_transmit_flag <= '0';
            
            if (sec_since_res >= To_unsigned((sec_to_cutter_enable + sec_cutter_enable), sec_since_res'length)) then 
                if(uart_ready = '1') then             
                    cutter_en <= '0';
                    main_uart_data_out <= x"04";
                    main_uart_transmit_flag <= '1';
                    main_next_state <= SLEEP;
                end if;
            else
                main_next_state <= main_current_state;
            end if;
        -- SLEEP state, do nothing
        when SLEEP =>
            main_uart_transmit_flag <= '0';   
        end case;
    end if;
end process main_state_machine;

end architecture_WOLF_CONTROLLER;
