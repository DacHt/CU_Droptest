----------------------------------------------------------------------
-- Created by SmartDesign Thu Jun 22 17:22:48 2017
-- Version: v11.8 11.8.0.26
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library proasic3;
use proasic3.all;
library COREUART_LIB;
use COREUART_LIB.all;
use COREUART_LIB.CU_TOP_FPGA_UART_components.all;
----------------------------------------------------------------------
-- CU_TOP entity declaration
----------------------------------------------------------------------
entity CU_TOP is
    -- Port list
    port(
        -- Inputs
        CLK             : in  std_logic;
        FPGA_UART_RX    : in  std_logic;
        PWRONRESET      : in  std_logic;
        -- Outputs
        CUTTER          : out std_logic;
        FPGA_UART_TX    : out std_logic;
        L1_GPS_PWR      : out std_logic;
        LED1            : out std_logic;
        LED2            : out std_logic;
        MICRO_CLK       : out std_logic;
        PRESSURE_PWR    : out std_logic;
        SAT_PWR         : out std_logic;
        SENS_MEM_L5_PWR : out std_logic;
        VHF_PWR         : out std_logic
        );
end CU_TOP;
----------------------------------------------------------------------
-- CU_TOP architecture body
----------------------------------------------------------------------
architecture RTL of CU_TOP is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CLKINT
component CLKINT
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- CUTTER_PWM
component CUTTER_PWM
    -- Port list
    port(
        -- Inputs
        duty     : in  std_logic_vector(7 downto 0);
        duty_wrt : in  std_logic;
        ena      : in  std_logic;
        mclk     : in  std_logic;
        reset    : in  std_logic;
        -- Outputs
        pwm_out  : out std_logic_vector(0 to 0)
        );
end component;
-- CU_TOP_FPGA_UART_COREUART   -   Actel:DirectCore:COREUART:5.6.102
component CU_TOP_FPGA_UART_COREUART
    generic( 
        BAUD_VAL_FRCTN_EN : integer := 1 ;
        FAMILY            : integer := 15 ;
        RX_FIFO           : integer := 0 ;
        RX_LEGACY_MODE    : integer := 0 ;
        TX_FIFO           : integer := 0 
        );
    -- Port list
    port(
        -- Inputs
        BAUD_VAL          : in  std_logic_vector(12 downto 0);
        BAUD_VAL_FRACTION : in  std_logic_vector(2 downto 0);
        BIT8              : in  std_logic;
        CLK               : in  std_logic;
        CSN               : in  std_logic;
        DATA_IN           : in  std_logic_vector(7 downto 0);
        ODD_N_EVEN        : in  std_logic;
        OEN               : in  std_logic;
        PARITY_EN         : in  std_logic;
        RESET_N           : in  std_logic;
        RX                : in  std_logic;
        WEN               : in  std_logic;
        -- Outputs
        DATA_OUT          : out std_logic_vector(7 downto 0);
        FRAMING_ERR       : out std_logic;
        OVERFLOW          : out std_logic;
        PARITY_ERR        : out std_logic;
        RXRDY             : out std_logic;
        TX                : out std_logic;
        TXRDY             : out std_logic
        );
end component;
-- OR2
component OR2
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- system_clock
component system_clock
    -- Port list
    port(
        -- Inputs
        mclk   : in  std_logic;
        reset  : in  std_logic;
        -- Outputs
        m_time : out std_logic_vector(25 downto 0)
        );
end component;
-- UART_reset_monitor
component UART_reset_monitor
    -- Port list
    port(
        -- Inputs
        data_in   : in  std_logic_vector(7 downto 0);
        mclk      : in  std_logic;
        reset_in  : in  std_logic;
        txrdy     : in  std_logic;
        -- Outputs
        reset_out : out std_logic
        );
end component;
-- WOLF_CONTROLLER
component WOLF_CONTROLLER
    -- Port list
    port(
        -- Inputs
        clk_1hz            : in  std_logic;
        mclk               : in  std_logic;
        reset              : in  std_logic;
        uart_data_in       : in  std_logic_vector(7 downto 0);
        uart_rxrdy         : in  std_logic;
        uart_txrdy         : in  std_logic;
        -- Outputs
        cutter_en          : out std_logic;
        cutter_pwm_duty    : out std_logic_vector(7 downto 0);
        led1               : out std_logic;
        led2               : out std_logic;
        uart_baud_val      : out std_logic_vector(12 downto 0);
        uart_baud_val_frac : out std_logic_vector(2 downto 0);
        uart_data_out      : out std_logic_vector(7 downto 0);
        uart_oen           : out std_logic;
        uart_wen           : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal CLKINT_0_Y                         : std_logic;
signal CLKINT_1_Y                         : std_logic;
signal CUTTER_net_0                       : std_logic_vector(0 to 0);
signal FPGA_UART_DATA_OUT                 : std_logic_vector(7 downto 0);
signal FPGA_UART_TX_net_0                 : std_logic;
signal FPGA_UART_TXRDY                    : std_logic;
signal LED1_net_0                         : std_logic;
signal LED1_0                             : std_logic;
signal LED1_2                             : std_logic;
signal LED1_3                             : std_logic;
signal LED2_net_0                         : std_logic;
signal LED2_1                             : std_logic_vector(25 to 25);
signal MICRO_CLK_net_0                    : std_logic_vector(1 to 1);
signal OR2_0_Y                            : std_logic;
signal WOLF_CONTROLLER_cutter_pwm_duty    : std_logic_vector(7 downto 0);
signal WOLF_CONTROLLER_uart_baud_val      : std_logic_vector(12 downto 0);
signal WOLF_CONTROLLER_uart_baud_val_frac : std_logic_vector(2 downto 0);
signal WOLF_CONTROLLER_uart_data_out      : std_logic_vector(7 downto 0);
signal CUTTER_net_1                       : std_logic;
signal LED2_1_net_0                       : std_logic;
signal FPGA_UART_TX_net_1                 : std_logic;
signal LED1_3_net_0                       : std_logic;
signal MICRO_CLK_net_1                    : std_logic;
signal m_time_slice_0                     : std_logic_vector(0 to 0);
signal m_time_slice_1                     : std_logic_vector(10 to 10);
signal m_time_slice_2                     : std_logic_vector(11 to 11);
signal m_time_slice_3                     : std_logic_vector(12 to 12);
signal m_time_slice_4                     : std_logic_vector(13 to 13);
signal m_time_slice_5                     : std_logic_vector(14 to 14);
signal m_time_slice_6                     : std_logic_vector(15 to 15);
signal m_time_slice_7                     : std_logic_vector(16 to 16);
signal m_time_slice_8                     : std_logic_vector(17 to 17);
signal m_time_slice_9                     : std_logic_vector(18 to 18);
signal m_time_slice_10                    : std_logic_vector(19 to 19);
signal m_time_slice_11                    : std_logic_vector(20 to 20);
signal m_time_slice_12                    : std_logic_vector(21 to 21);
signal m_time_slice_13                    : std_logic_vector(22 to 22);
signal m_time_slice_14                    : std_logic_vector(23 to 23);
signal m_time_slice_15                    : std_logic_vector(24 to 24);
signal m_time_slice_16                    : std_logic_vector(2 to 2);
signal m_time_slice_17                    : std_logic_vector(3 to 3);
signal m_time_slice_18                    : std_logic_vector(4 to 4);
signal m_time_slice_19                    : std_logic_vector(5 to 5);
signal m_time_slice_20                    : std_logic_vector(6 to 6);
signal m_time_slice_21                    : std_logic_vector(7 to 7);
signal m_time_slice_22                    : std_logic_vector(8 to 8);
signal m_time_slice_23                    : std_logic_vector(9 to 9);
signal m_time_net_0                       : std_logic_vector(25 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                            : std_logic;
signal VCC_net                            : std_logic;
----------------------------------------------------------------------
-- Inverted Signals
----------------------------------------------------------------------
signal RESET_N_IN_POST_INV0_0             : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net <= '0';
 VCC_net <= '1';
----------------------------------------------------------------------
-- Inversions
----------------------------------------------------------------------
 RESET_N_IN_POST_INV0_0 <= NOT OR2_0_Y;
----------------------------------------------------------------------
-- TieOff assignments
----------------------------------------------------------------------
 L1_GPS_PWR         <= '0';
 VHF_PWR            <= '0';
 SENS_MEM_L5_PWR    <= '0';
 SAT_PWR            <= '0';
 PRESSURE_PWR       <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 CUTTER_net_1       <= CUTTER_net_0(0);
 CUTTER             <= CUTTER_net_1;
 LED2_1_net_0       <= LED2_1(25);
 LED2               <= LED2_1_net_0;
 FPGA_UART_TX_net_1 <= FPGA_UART_TX_net_0;
 FPGA_UART_TX       <= FPGA_UART_TX_net_1;
 LED1_3_net_0       <= LED1_3;
 LED1               <= LED1_3_net_0;
 MICRO_CLK_net_1    <= MICRO_CLK_net_0(1);
 MICRO_CLK          <= MICRO_CLK_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 LED2_1(25)          <= m_time_net_0(25);
 MICRO_CLK_net_0(1)  <= m_time_net_0(1);
 m_time_slice_0(0)   <= m_time_net_0(0);
 m_time_slice_1(10)  <= m_time_net_0(10);
 m_time_slice_2(11)  <= m_time_net_0(11);
 m_time_slice_3(12)  <= m_time_net_0(12);
 m_time_slice_4(13)  <= m_time_net_0(13);
 m_time_slice_5(14)  <= m_time_net_0(14);
 m_time_slice_6(15)  <= m_time_net_0(15);
 m_time_slice_7(16)  <= m_time_net_0(16);
 m_time_slice_8(17)  <= m_time_net_0(17);
 m_time_slice_9(18)  <= m_time_net_0(18);
 m_time_slice_10(19) <= m_time_net_0(19);
 m_time_slice_11(20) <= m_time_net_0(20);
 m_time_slice_12(21) <= m_time_net_0(21);
 m_time_slice_13(22) <= m_time_net_0(22);
 m_time_slice_14(23) <= m_time_net_0(23);
 m_time_slice_15(24) <= m_time_net_0(24);
 m_time_slice_16(2)  <= m_time_net_0(2);
 m_time_slice_17(3)  <= m_time_net_0(3);
 m_time_slice_18(4)  <= m_time_net_0(4);
 m_time_slice_19(5)  <= m_time_net_0(5);
 m_time_slice_20(6)  <= m_time_net_0(6);
 m_time_slice_21(7)  <= m_time_net_0(7);
 m_time_slice_22(8)  <= m_time_net_0(8);
 m_time_slice_23(9)  <= m_time_net_0(9);
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CLKINT_0
CLKINT_0 : CLKINT
    port map( 
        -- Inputs
        A => CLK,
        -- Outputs
        Y => CLKINT_0_Y 
        );
-- CLKINT_1
CLKINT_1 : CLKINT
    port map( 
        -- Inputs
        A => PWRONRESET,
        -- Outputs
        Y => CLKINT_1_Y 
        );
-- CUTTER_PWM_inst_0
CUTTER_PWM_inst_0 : CUTTER_PWM
    port map( 
        -- Inputs
        mclk     => CLKINT_0_Y,
        reset    => OR2_0_Y,
        ena      => LED2_net_0,
        duty_wrt => VCC_net,
        duty     => WOLF_CONTROLLER_cutter_pwm_duty,
        -- Outputs
        pwm_out  => CUTTER_net_0 
        );
-- FPGA_UART   -   Actel:DirectCore:COREUART:5.6.102
FPGA_UART : CU_TOP_FPGA_UART_COREUART
    generic map( 
        BAUD_VAL_FRCTN_EN => ( 1 ),
        FAMILY            => ( 15 ),
        RX_FIFO           => ( 0 ),
        RX_LEGACY_MODE    => ( 0 ),
        TX_FIFO           => ( 0 )
        )
    port map( 
        -- Inputs
        BIT8              => VCC_net,
        CLK               => CLKINT_0_Y,
        CSN               => GND_net,
        ODD_N_EVEN        => VCC_net,
        OEN               => LED1_3,
        PARITY_EN         => GND_net,
        RESET_N           => RESET_N_IN_POST_INV0_0,
        RX                => FPGA_UART_RX,
        WEN               => LED1_2,
        BAUD_VAL          => WOLF_CONTROLLER_uart_baud_val,
        DATA_IN           => WOLF_CONTROLLER_uart_data_out,
        BAUD_VAL_FRACTION => WOLF_CONTROLLER_uart_baud_val_frac,
        -- Outputs
        OVERFLOW          => OPEN,
        PARITY_ERR        => OPEN,
        RXRDY             => LED1_0,
        TX                => FPGA_UART_TX_net_0,
        TXRDY             => FPGA_UART_TXRDY,
        FRAMING_ERR       => OPEN,
        DATA_OUT          => FPGA_UART_DATA_OUT 
        );
-- OR2_0
OR2_0 : OR2
    port map( 
        -- Inputs
        A => CLKINT_1_Y,
        B => LED1_net_0,
        -- Outputs
        Y => OR2_0_Y 
        );
-- system_clock_inst_0
system_clock_inst_0 : system_clock
    port map( 
        -- Inputs
        mclk   => CLKINT_0_Y,
        reset  => OR2_0_Y,
        -- Outputs
        m_time => m_time_net_0 
        );
-- UART_reset_monitor_inst_0
UART_reset_monitor_inst_0 : UART_reset_monitor
    port map( 
        -- Inputs
        mclk      => CLKINT_0_Y,
        reset_in  => CLKINT_1_Y,
        txrdy     => FPGA_UART_TXRDY,
        data_in   => FPGA_UART_DATA_OUT,
        -- Outputs
        reset_out => LED1_net_0 
        );
-- WOLF_CONTROLLER_inst_0
WOLF_CONTROLLER_inst_0 : WOLF_CONTROLLER
    port map( 
        -- Inputs
        mclk               => CLKINT_0_Y,
        clk_1hz            => LED2_1(25),
        reset              => OR2_0_Y,
        uart_txrdy         => FPGA_UART_TXRDY,
        uart_rxrdy         => LED1_0,
        uart_data_in       => FPGA_UART_DATA_OUT,
        -- Outputs
        cutter_en          => LED2_net_0,
        uart_wen           => LED1_2,
        uart_oen           => LED1_3,
        led1               => OPEN,
        led2               => OPEN,
        cutter_pwm_duty    => WOLF_CONTROLLER_cutter_pwm_duty,
        uart_data_out      => WOLF_CONTROLLER_uart_data_out,
        uart_baud_val      => WOLF_CONTROLLER_uart_baud_val,
        uart_baud_val_frac => WOLF_CONTROLLER_uart_baud_val_frac 
        );

end RTL;
