--------------------------------------------------------------------------------
-- Company: KTH     
--
-- File: CUTTER_PWM.vhd
-- File history:
--      <V1.0>: <2017-06-08>: <Initial version>
--      
-- Description: 
-- PWM Controller for thermo cutter, code copied from internet from this link:
-- https://eewiki.net/pages/viewpage.action?pageId=20939345
-- Original author: Scott Larson
--
-- Targeted device: <Family::ProASIC3> <Die::A3P250> <Package::100 VQFP>
-- Author: David Rozenbeek
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


ENTITY CUTTER_PWM IS
  GENERIC(
      sys_clk         : INTEGER := 32_768_000; --system clock frequency in Hz
      pwm_freq        : INTEGER := 1_024_000;  --PWM switching frequency in Hz
      bits_resolution : INTEGER := 8;          --bits of resolution setting the duty cycle
      phases          : INTEGER := 1);         --number of output pwms and phases
  PORT(
      mclk      : IN  STD_LOGIC;                                    --system clock
      reset     : IN  STD_LOGIC;                                    --asynchronous reset
      ena       : IN  STD_LOGIC;                                    --Enable signal
      duty_wrt  : IN  STD_LOGIC;                                    --latches in new duty cycle
      duty      : IN  STD_LOGIC_VECTOR(bits_resolution-1 DOWNTO 0); --duty cycle
      pwm_out   : OUT STD_LOGIC_VECTOR(phases-1 DOWNTO 0));         --pwm outputs
END CUTTER_PWM;

ARCHITECTURE logic OF CUTTER_PWM IS
  CONSTANT  period     :  INTEGER := sys_clk/pwm_freq;                      --number of clocks in one pwm period
  TYPE counters IS ARRAY (0 TO phases-1) OF INTEGER RANGE 0 TO period - 1;  --data type for array of period counters
  SIGNAL  count        :  counters := (OTHERS => 0);                        --array of period counters
  SIGNAL   half_duty_new  :  INTEGER RANGE 0 TO period/2 := 0;              --number of clocks in 1/2 duty cycle
  TYPE half_duties IS ARRAY (0 TO phases-1) OF INTEGER RANGE 0 TO period/2; --data type for array of half duty values
  SIGNAL  half_duty    :  half_duties := (OTHERS => 0);                     --array of half duty values (for each phase)
BEGIN
  PROCESS(mclk, reset)
  BEGIN
    IF(reset = '1') THEN                                                            --asynchronous reset
      count <= (OTHERS => 0);                                                       --clear counter
      pwm_out <= (OTHERS => '0');                                                   --clear pwm outputs
    ELSIF(mclk'EVENT AND mclk = '1') THEN                                           --rising system clock edge
      IF(ENA = '1') THEN    
          IF(duty_wrt = '1') THEN                                                   --latch in new duty cycle
            half_duty_new <= conv_integer(duty)*period/(2**bits_resolution)/2;      --determine clocks in 1/2 duty cycle
          END IF;
          FOR i IN 0 to phases-1 LOOP                                               --create a counter for each phase
            IF(count(0) = period - 1 - i*period/phases) THEN                        --end of period reached
              count(i) <= 0;                                                        --reset counter
              half_duty(i) <= half_duty_new;                                        --set most recent duty cycle value
            ELSE                                                                    --end of period not reached
              count(i) <= count(i) + 1;                                             --increment counter
            END IF;
          END LOOP;
          FOR i IN 0 to phases-1 LOOP                                               --control outputs for each phase
            IF(count(i) = half_duty(i)) THEN                                        --phase's falling edge reached
              pwm_out(i) <= '0';                                                    --deassert the pwm output
            ELSIF(count(i) = period - half_duty(i)) THEN                            --phase's rising edge reached
              pwm_out(i) <= '1';                                                    --assert the pwm output
            END IF;
          END LOOP;
      ELSE
        pwm_out(0) <= '0'; 
      END IF;
    END IF;
  END PROCESS;
END logic;

