----------------------------------------------------------------------
-- Created by SmartDesign Fri Apr 14 17:30:23 2017
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
-- CU_Main_tst entity declaration
----------------------------------------------------------------------
entity CU_Main_tst is
    -- Port list
    port(
        -- Inputs
        CLK  : in  std_logic;
        -- Outputs
        LED1 : out std_logic;
        LED2 : out std_logic
        );
end CU_Main_tst;
----------------------------------------------------------------------
-- CU_Main_tst architecture body
----------------------------------------------------------------------
architecture RTL of CU_Main_tst is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CU_Main
component CU_Main
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
signal LED2_net_0 : std_logic;
signal LED1_net_1 : std_logic;
signal LED2_net_1 : std_logic;

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 LED1_net_1 <= LED1_net_0;
 LED1       <= LED1_net_1;
 LED2_net_1 <= LED2_net_0;
 LED2       <= LED2_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CU_Main_0
CU_Main_0 : CU_Main
    port map( 
        -- Inputs
        CLK              => CLK,
        -- Outputs
        LED1             => LED1_net_0,
        CUTTER_EN        => OPEN,
        PR_OP_PWR        => OPEN,
        STX_PWR          => OPEN,
        V3_LINEAR_PWR    => OPEN,
        BEACON_PWR       => OPEN,
        LDO_FRONTEND_PWR => OPEN,
        LED2             => LED2_net_0 
        );

end RTL;
