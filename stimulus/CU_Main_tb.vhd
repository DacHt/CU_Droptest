
----------------------------------------------------------------------
-- Created by SmartDesign Fri Apr 14 17:06:17 2017
-- Version: v11.8 11.8.0.26
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library proasic3;
use proasic3.all;
----------------------------------------------------------------------
-- CU_Main_tb entity declaration
----------------------------------------------------------------------
entity CU_Main_tb is
    -- Port list
    port(
        -- Inputs
        CLK  : in  std_logic;
        -- Outputs
        LED1 : out std_logic
        );
end CU_Main_tb;
----------------------------------------------------------------------
-- CU_Main_tb architecture body
----------------------------------------------------------------------
architecture RTL of CU_Main_tb is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- blinkytest
component blinkytest
    -- Port list
    port(
        -- Inputs
        CLK              : in  std_logic;
        -- Outputs
        BEACON_PWR       : out std_logic;
        CUTTER_EN        : out std_logic;
        LDO_FRONTEND_PWR : out std_logic;
        LED1             : out std_logic;
        LED2             : out std_logic;
        PR_OP_PWR        : out std_logic;
        STX_PWR          : out std_logic;
        V3_LINEAR_PWR    : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal LED1_net_0 : std_logic;
signal LED1_net_1 : std_logic;

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 LED1_net_1 <= LED1_net_0;
 LED1       <= LED1_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- blinkytest_0
blinkytest_0 : blinkytest
    port map( 
        -- Inputs
        CLK              => CLK,
        -- Outputs
        LED1             => LED1_net_0,
        CUTTER_EN        => OPEN,
        STX_PWR          => OPEN,
        LED2             => OPEN,
        PR_OP_PWR        => OPEN,
        V3_LINEAR_PWR    => OPEN,
        BEACON_PWR       => OPEN,
        LDO_FRONTEND_PWR => OPEN 
        );

-- CLOCK --
CLOCK <= not CLOCK AFTER 50 ps;

main_p : process
begin
    wait for 2 ns;
end process main_p;

 
end RTL;
