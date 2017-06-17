-- Version: v11.8 11.8.0.26
-- File used only for Simulation

library ieee;
use ieee.std_logic_1164.all;
library proasic3;
use proasic3.all;

entity CU_Main is

    port( CLK              : in    std_logic;
          BEACON_PWR       : out   std_logic;
          CUTTER_EN        : out   std_logic;
          LDO_FRONTEND_PWR : out   std_logic;
          LED1             : out   std_logic;
          LED2             : out   std_logic;
          PR_OP_PWR        : out   std_logic;
          STX_PWR          : out   std_logic;
          V3_LINEAR_PWR    : out   std_logic
        );

end CU_Main;

architecture DEF_ARCH of CU_Main is 

  component DFN1
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component XOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component NOR3C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OR2A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OR3B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AX1C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AND3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOTRI_OB_EB
    port( D    : in    std_logic := 'U';
          E    : in    std_logic := 'U';
          DOUT : out   std_logic;
          EOUT : out   std_logic
        );
  end component;

  component INV
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN0E0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component AOI1B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN0E1
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component AX1
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component NOR2A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component NOR2B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOPAD_TRI
    port( D   : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component OR3C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOIN_IB
    port( YIN : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component XNOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOPAD_IN
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component AND2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal CLKINT_0_Y, CLK_c, LED1_c, LED2_c, 
        \system_clock_0/s_time[1]_net_1\, 
        \system_clock_0/s_time[0]_net_1\, 
        \system_clock_0/s_time[3]_net_1\, 
        \system_clock_0/DWACT_FINC_E[0]\, 
        \system_clock_0/m_time_i[11]\, 
        \system_clock_0/m_time[11]\, 
        \system_clock_0/m_time_i[12]\, 
        \system_clock_0/m_time[12]\, 
        \system_clock_0/m_time_i[13]\, 
        \system_clock_0/m_time[13]\, 
        \system_clock_0/m_time_i[14]\, 
        \system_clock_0/m_time[14]\, 
        \system_clock_0/m_time_i[15]\, 
        \system_clock_0/m_time[15]\, 
        \system_clock_0/m_time_i[16]\, 
        \system_clock_0/m_time[16]\, 
        \system_clock_0/m_time_i[17]\, 
        \system_clock_0/m_time[17]\, \system_clock_0/m_time_i[1]\, 
        \system_clock_0/m_time[1]\, \system_clock_0/m_time_i[7]\, 
        \system_clock_0/m_time[7]\, \system_clock_0/m_time_i[9]\, 
        \system_clock_0/m_time[9]\, \system_clock_0/m_time_i[10]\, 
        \system_clock_0/m_time[10]\, \system_clock_0/l_m6_0_a2_7\, 
        \system_clock_0/l_m6_0_a2_2\, 
        \system_clock_0/l_m6_0_a2_1\, 
        \system_clock_0/l_m6_0_a2_6\, 
        \system_clock_0/l_m6_0_a2_4\, \system_clock_0/m_time[8]\, 
        \system_clock_0/un14_flag_3\, 
        \system_clock_0/s_time[6]_net_1\, 
        \system_clock_0/un14_flag_1\, 
        \system_clock_0/un14_flag_2\, 
        \system_clock_0/s_time[4]_net_1\, 
        \system_clock_0/l_N_13_mux\, \system_clock_0/N_25\, 
        \system_clock_0/N_39_i\, \system_clock_0/N_23\, 
        \system_clock_0/m_time[6]\, \system_clock_0/N_38_i\, 
        \system_clock_0/N_21\, \system_clock_0/m_time[4]\, 
        \system_clock_0/m_time[5]\, \system_clock_0/N_37_i\, 
        \system_clock_0/N_36_i\, \system_clock_0/m_time[2]\, 
        \system_clock_0/m_time[3]\, \system_clock_0/N_35_i\, 
        \system_clock_0/l_time_RNO_0[16]_net_1\, 
        \system_clock_0/l_time_RNIUEA34[14]_net_1\, 
        \system_clock_0/l_time_RNIQEBK3[13]_net_1\, 
        \system_clock_0/l_time_RNINFC53[12]_net_1\, 
        \system_clock_0/l_time_RNILHDM2[11]_net_1\, 
        \system_clock_0/l_time_RNIKKE72[10]_net_1\, 
        \system_clock_0/N_27\, \system_clock_0/N_26\, 
        \system_clock_0/N_24\, \system_clock_0/l_time_n7\, 
        \system_clock_0/un14_l_time\, 
        \system_clock_0/s_time_3[7]\, \system_clock_0/I_20\, 
        \system_clock_0/s_time_3[6]\, \system_clock_0/I_17\, 
        \system_clock_0/s_time_3[5]\, \system_clock_0/I_14\, 
        \system_clock_0/s_time_3[4]\, \system_clock_0/I_12\, 
        \system_clock_0/s_time_3[3]\, \system_clock_0/I_9\, 
        \system_clock_0/s_time_3[2]\, \system_clock_0/I_7\, 
        \system_clock_0/s_time_3[1]\, \system_clock_0/I_5\, 
        \system_clock_0/flag_net_1\, \system_clock_0/I_4\, 
        \system_clock_0/s_time[2]_net_1\, \system_clock_0/N_2\, 
        \system_clock_0/DWACT_FINC_E[2]\, \system_clock_0/N_3\, 
        \system_clock_0/DWACT_FINC_E[1]\, \system_clock_0/N_4\, 
        \system_clock_0/N_6\, \STX_PWR_pad/U0/NET1\, 
        \STX_PWR_pad/U0/NET2\, \V3_LINEAR_PWR_pad/U0/NET1\, 
        \V3_LINEAR_PWR_pad/U0/NET2\, \LED2_pad/U0/NET1\, 
        \LED2_pad/U0/NET2\, \LDO_FRONTEND_PWR_pad/U0/NET1\, 
        \LDO_FRONTEND_PWR_pad/U0/NET2\, \PR_OP_PWR_pad/U0/NET1\, 
        \PR_OP_PWR_pad/U0/NET2\, \BEACON_PWR_pad/U0/NET1\, 
        \BEACON_PWR_pad/U0/NET2\, \LED1_pad/U0/NET1\, 
        \LED1_pad/U0/NET2\, \CUTTER_EN_pad/U0/NET1\, 
        \CUTTER_EN_pad/U0/NET2\, \VCC\, \CLK_pad/U0/NET1\, \GND\, 
        AFLSDF_VCC, AFLSDF_GND : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;

begin 

    AFLSDF_GND <= GND_power_net1;
    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    AFLSDF_VCC <= VCC_power_net1;

    \system_clock_0/flag\ : DFN1
      port map(D => \system_clock_0/un14_l_time\, CLK => 
        CLKINT_0_Y, Q => \system_clock_0/flag_net_1\);
    
    \system_clock_0/l_time_RNO[2]\ : XOR2
      port map(A => \system_clock_0/m_time[1]\, B => 
        \system_clock_0/m_time[2]\, Y => \system_clock_0/N_35_i\);
    
    \system_clock_0/l_time[3]\ : DFN0
      port map(D => \system_clock_0/N_36_i\, CLK => CLKINT_0_Y, Q
         => \system_clock_0/m_time[3]\);
    
    \system_clock_0/l_time_RNINQEP1[9]\ : NOR3C
      port map(A => \system_clock_0/m_time[9]\, B => 
        \system_clock_0/m_time[10]\, C => 
        \system_clock_0/l_m6_0_a2_4\, Y => 
        \system_clock_0/l_m6_0_a2_6\);
    
    \system_clock_0/l_time_RNIKKE72[10]\ : OR2A
      port map(A => \system_clock_0/m_time[10]\, B => 
        \system_clock_0/N_27\, Y => 
        \system_clock_0/l_time_RNIKKE72[10]_net_1\);
    
    \system_clock_0/l_time_RNIFSK51[6]\ : OR2A
      port map(A => \system_clock_0/m_time[6]\, B => 
        \system_clock_0/N_23\, Y => \system_clock_0/N_24\);
    
    \system_clock_0/l_time_RNIQVBV[5]\ : OR3B
      port map(A => \system_clock_0/m_time[4]\, B => 
        \system_clock_0/m_time[5]\, C => \system_clock_0/N_21\, Y
         => \system_clock_0/N_23\);
    
    CLKINT_0 : CLKINT
      port map(A => CLK_c, Y => CLKINT_0_Y);
    
    \system_clock_0/l_time_RNO[3]\ : AX1C
      port map(A => \system_clock_0/m_time[2]\, B => 
        \system_clock_0/m_time[1]\, C => 
        \system_clock_0/m_time[3]\, Y => \system_clock_0/N_36_i\);
    
    \system_clock_0/un1_s_time_I_18\ : AND3
      port map(A => \system_clock_0/s_time[3]_net_1\, B => 
        \system_clock_0/s_time[4]_net_1\, C => LED2_c, Y => 
        \system_clock_0/DWACT_FINC_E[2]\);
    
    \BEACON_PWR_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \GND\, E => \VCC\, DOUT => 
        \BEACON_PWR_pad/U0/NET1\, EOUT => 
        \BEACON_PWR_pad/U0/NET2\);
    
    \system_clock_0/un1_s_time_I_9\ : XOR2
      port map(A => \system_clock_0/N_6\, B => 
        \system_clock_0/s_time[3]_net_1\, Y => 
        \system_clock_0/I_9\);
    
    \system_clock_0/un1_s_time_I_14\ : XOR2
      port map(A => \system_clock_0/N_4\, B => LED2_c, Y => 
        \system_clock_0/I_14\);
    
    \system_clock_0/l_time_RNO[11]\ : INV
      port map(A => \system_clock_0/m_time[11]\, Y => 
        \system_clock_0/m_time_i[11]\);
    
    \system_clock_0/un1_s_time_I_8\ : AND3
      port map(A => \system_clock_0/s_time[0]_net_1\, B => 
        \system_clock_0/s_time[1]_net_1\, C => 
        \system_clock_0/s_time[2]_net_1\, Y => 
        \system_clock_0/N_6\);
    
    \system_clock_0/l_time_RNIVU641[16]\ : NOR3C
      port map(A => \system_clock_0/m_time[12]\, B => 
        \system_clock_0/m_time[16]\, C => 
        \system_clock_0/m_time[8]\, Y => 
        \system_clock_0/l_m6_0_a2_4\);
    
    \system_clock_0/l_time[9]\ : DFN0E0
      port map(D => \system_clock_0/m_time_i[9]\, CLK => 
        CLKINT_0_Y, E => \system_clock_0/N_26\, Q => 
        \system_clock_0/m_time[9]\);
    
    \system_clock_0/s_time_RNO[5]\ : AOI1B
      port map(A => \system_clock_0/un14_flag_3\, B => 
        \system_clock_0/un14_flag_2\, C => \system_clock_0/I_14\, 
        Y => \system_clock_0/s_time_3[5]\);
    
    \system_clock_0/l_time_RNO[9]\ : INV
      port map(A => \system_clock_0/m_time[9]\, Y => 
        \system_clock_0/m_time_i[9]\);
    
    \system_clock_0/l_time[7]\ : DFN0E0
      port map(D => \system_clock_0/m_time_i[7]\, CLK => 
        CLKINT_0_Y, E => \system_clock_0/N_24\, Q => 
        \system_clock_0/m_time[7]\);
    
    \system_clock_0/l_time[5]\ : DFN0
      port map(D => \system_clock_0/N_38_i\, CLK => CLKINT_0_Y, Q
         => \system_clock_0/m_time[5]\);
    
    \V3_LINEAR_PWR_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \GND\, E => \VCC\, DOUT => 
        \V3_LINEAR_PWR_pad/U0/NET1\, EOUT => 
        \V3_LINEAR_PWR_pad/U0/NET2\);
    
    \system_clock_0/l_time_RNO[12]\ : INV
      port map(A => \system_clock_0/m_time[12]\, Y => 
        \system_clock_0/m_time_i[12]\);
    
    \system_clock_0/un1_s_time_I_5\ : XOR2
      port map(A => \system_clock_0/s_time[0]_net_1\, B => 
        \system_clock_0/s_time[1]_net_1\, Y => 
        \system_clock_0/I_5\);
    
    \system_clock_0/s_time[1]\ : DFN0E1
      port map(D => \system_clock_0/s_time_3[1]\, CLK => 
        CLKINT_0_Y, E => \system_clock_0/flag_net_1\, Q => 
        \system_clock_0/s_time[1]_net_1\);
    
    \system_clock_0/l_time[12]\ : DFN0E0
      port map(D => \system_clock_0/m_time_i[12]\, CLK => 
        CLKINT_0_Y, E => 
        \system_clock_0/l_time_RNILHDM2[11]_net_1\, Q => 
        \system_clock_0/m_time[12]\);
    
    \system_clock_0/l_time_RNO[5]\ : AX1
      port map(A => \system_clock_0/N_21\, B => 
        \system_clock_0/m_time[4]\, C => 
        \system_clock_0/m_time[5]\, Y => \system_clock_0/N_38_i\);
    
    \system_clock_0/s_time[3]\ : DFN0E1
      port map(D => \system_clock_0/s_time_3[3]\, CLK => 
        CLKINT_0_Y, E => \system_clock_0/flag_net_1\, Q => 
        \system_clock_0/s_time[3]_net_1\);
    
    \system_clock_0/l_time_RNI9I815[7]\ : NOR2A
      port map(A => \system_clock_0/l_m6_0_a2_7\, B => 
        \system_clock_0/N_25\, Y => \system_clock_0/l_N_13_mux\);
    
    \system_clock_0/l_time_RNI91UT[14]\ : NOR2B
      port map(A => \system_clock_0/m_time[15]\, B => 
        \system_clock_0/m_time[14]\, Y => 
        \system_clock_0/l_m6_0_a2_1\);
    
    \system_clock_0/l_time[4]\ : DFN0
      port map(D => \system_clock_0/N_37_i\, CLK => CLKINT_0_Y, Q
         => \system_clock_0/m_time[4]\);
    
    \system_clock_0/un1_s_time_I_20\ : XOR2
      port map(A => \system_clock_0/N_2\, B => LED1_c, Y => 
        \system_clock_0/I_20\);
    
    \V3_LINEAR_PWR_pad/U0/U0\ : IOPAD_TRI
      port map(D => \V3_LINEAR_PWR_pad/U0/NET1\, E => 
        \V3_LINEAR_PWR_pad/U0/NET2\, PAD => V3_LINEAR_PWR);
    
    \system_clock_0/s_time_RNIF0T8[0]\ : NOR2B
      port map(A => \system_clock_0/s_time[3]_net_1\, B => 
        \system_clock_0/s_time[0]_net_1\, Y => 
        \system_clock_0/un14_flag_2\);
    
    \LED2_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => LED2_c, E => \VCC\, DOUT => 
        \LED2_pad/U0/NET1\, EOUT => \LED2_pad/U0/NET2\);
    
    \CUTTER_EN_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \GND\, E => \VCC\, DOUT => 
        \CUTTER_EN_pad/U0/NET1\, EOUT => \CUTTER_EN_pad/U0/NET2\);
    
    \system_clock_0/l_time_RNIKOFO1[9]\ : OR2A
      port map(A => \system_clock_0/m_time[9]\, B => 
        \system_clock_0/N_26\, Y => \system_clock_0/N_27\);
    
    \system_clock_0/l_time_RNIJ9QI[3]\ : OR3C
      port map(A => \system_clock_0/m_time[2]\, B => 
        \system_clock_0/m_time[1]\, C => 
        \system_clock_0/m_time[3]\, Y => \system_clock_0/N_21\);
    
    \system_clock_0/l_time_RNI4STT[11]\ : NOR2B
      port map(A => \system_clock_0/m_time[13]\, B => 
        \system_clock_0/m_time[11]\, Y => 
        \system_clock_0/l_m6_0_a2_2\);
    
    \system_clock_0/un1_s_time_I_4\ : INV
      port map(A => \system_clock_0/s_time[0]_net_1\, Y => 
        \system_clock_0/I_4\);
    
    \CUTTER_EN_pad/U0/U0\ : IOPAD_TRI
      port map(D => \CUTTER_EN_pad/U0/NET1\, E => 
        \CUTTER_EN_pad/U0/NET2\, PAD => CUTTER_EN);
    
    \LDO_FRONTEND_PWR_pad/U0/U0\ : IOPAD_TRI
      port map(D => \LDO_FRONTEND_PWR_pad/U0/NET1\, E => 
        \LDO_FRONTEND_PWR_pad/U0/NET2\, PAD => LDO_FRONTEND_PWR);
    
    \system_clock_0/un1_s_time_I_10\ : AND3
      port map(A => \system_clock_0/s_time[0]_net_1\, B => 
        \system_clock_0/s_time[1]_net_1\, C => 
        \system_clock_0/s_time[2]_net_1\, Y => 
        \system_clock_0/DWACT_FINC_E[0]\);
    
    \system_clock_0/l_time_RNIQEBK3[13]\ : OR2A
      port map(A => \system_clock_0/m_time[13]\, B => 
        \system_clock_0/l_time_RNINFC53[12]_net_1\, Y => 
        \system_clock_0/l_time_RNIQEBK3[13]_net_1\);
    
    \system_clock_0/s_time_RNIL6T8[4]\ : NOR2B
      port map(A => LED2_c, B => \system_clock_0/s_time[4]_net_1\, 
        Y => \system_clock_0/un14_flag_1\);
    
    \LED1_pad/U0/U0\ : IOPAD_TRI
      port map(D => \LED1_pad/U0/NET1\, E => \LED1_pad/U0/NET2\, 
        PAD => LED1);
    
    \system_clock_0/l_time[10]\ : DFN0E0
      port map(D => \system_clock_0/m_time_i[10]\, CLK => 
        CLKINT_0_Y, E => \system_clock_0/N_27\, Q => 
        \system_clock_0/m_time[10]\);
    
    \system_clock_0/un1_s_time_I_7\ : AX1C
      port map(A => \system_clock_0/s_time[1]_net_1\, B => 
        \system_clock_0/s_time[0]_net_1\, C => 
        \system_clock_0/s_time[2]_net_1\, Y => 
        \system_clock_0/I_7\);
    
    \system_clock_0/s_time[7]\ : DFN0E1
      port map(D => \system_clock_0/s_time_3[7]\, CLK => 
        CLKINT_0_Y, E => \system_clock_0/flag_net_1\, Q => LED1_c);
    
    \system_clock_0/s_time[5]\ : DFN0E1
      port map(D => \system_clock_0/s_time_3[5]\, CLK => 
        CLKINT_0_Y, E => \system_clock_0/flag_net_1\, Q => LED2_c);
    
    \BEACON_PWR_pad/U0/U0\ : IOPAD_TRI
      port map(D => \BEACON_PWR_pad/U0/NET1\, E => 
        \BEACON_PWR_pad/U0/NET2\, PAD => BEACON_PWR);
    
    \system_clock_0/l_time[2]\ : DFN0
      port map(D => \system_clock_0/N_35_i\, CLK => CLKINT_0_Y, Q
         => \system_clock_0/m_time[2]\);
    
    \system_clock_0/l_time[13]\ : DFN0E0
      port map(D => \system_clock_0/m_time_i[13]\, CLK => 
        CLKINT_0_Y, E => 
        \system_clock_0/l_time_RNINFC53[12]_net_1\, Q => 
        \system_clock_0/m_time[13]\);
    
    \CLK_pad/U0/U1\ : IOIN_IB
      port map(YIN => \CLK_pad/U0/NET1\, Y => CLK_c);
    
    \system_clock_0/l_time_RNIUEA34[14]\ : OR2A
      port map(A => \system_clock_0/m_time[14]\, B => 
        \system_clock_0/l_time_RNIQEBK3[13]_net_1\, Y => 
        \system_clock_0/l_time_RNIUEA34[14]_net_1\);
    
    \system_clock_0/l_time[8]\ : DFN0
      port map(D => \system_clock_0/l_time_n7\, CLK => CLKINT_0_Y, 
        Q => \system_clock_0/m_time[8]\);
    
    \system_clock_0/l_time[17]\ : DFN0E1
      port map(D => \system_clock_0/m_time_i[17]\, CLK => 
        CLKINT_0_Y, E => \system_clock_0/l_N_13_mux\, Q => 
        \system_clock_0/m_time[17]\);
    
    \LED1_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => LED1_c, E => \VCC\, DOUT => 
        \LED1_pad/U0/NET1\, EOUT => \LED1_pad/U0/NET2\);
    
    \system_clock_0/s_time_RNO[1]\ : AOI1B
      port map(A => \system_clock_0/un14_flag_3\, B => 
        \system_clock_0/un14_flag_2\, C => \system_clock_0/I_5\, 
        Y => \system_clock_0/s_time_3[1]\);
    
    \system_clock_0/l_time_RNO[15]\ : INV
      port map(A => \system_clock_0/m_time[15]\, Y => 
        \system_clock_0/m_time_i[15]\);
    
    \system_clock_0/s_time_RNO[6]\ : AOI1B
      port map(A => \system_clock_0/un14_flag_3\, B => 
        \system_clock_0/un14_flag_2\, C => \system_clock_0/I_17\, 
        Y => \system_clock_0/s_time_3[6]\);
    
    \system_clock_0/s_time_RNO[4]\ : AOI1B
      port map(A => \system_clock_0/un14_flag_3\, B => 
        \system_clock_0/un14_flag_2\, C => \system_clock_0/I_12\, 
        Y => \system_clock_0/s_time_3[4]\);
    
    \system_clock_0/s_time[4]\ : DFN0E1
      port map(D => \system_clock_0/s_time_3[4]\, CLK => 
        CLKINT_0_Y, E => \system_clock_0/flag_net_1\, Q => 
        \system_clock_0/s_time[4]_net_1\);
    
    \system_clock_0/un1_s_time_I_12\ : AX1C
      port map(A => \system_clock_0/s_time[3]_net_1\, B => 
        \system_clock_0/DWACT_FINC_E[0]\, C => 
        \system_clock_0/s_time[4]_net_1\, Y => 
        \system_clock_0/I_12\);
    
    \PR_OP_PWR_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \GND\, E => \VCC\, DOUT => 
        \PR_OP_PWR_pad/U0/NET1\, EOUT => \PR_OP_PWR_pad/U0/NET2\);
    
    \system_clock_0/s_time_RNO[7]\ : AOI1B
      port map(A => \system_clock_0/un14_flag_3\, B => 
        \system_clock_0/un14_flag_2\, C => \system_clock_0/I_20\, 
        Y => \system_clock_0/s_time_3[7]\);
    
    \system_clock_0/l_time_RNO[8]\ : XNOR2
      port map(A => \system_clock_0/m_time[8]\, B => 
        \system_clock_0/N_25\, Y => \system_clock_0/l_time_n7\);
    
    \system_clock_0/l_time[6]\ : DFN0
      port map(D => \system_clock_0/N_39_i\, CLK => CLKINT_0_Y, Q
         => \system_clock_0/m_time[6]\);
    
    \system_clock_0/l_time[11]\ : DFN0E0
      port map(D => \system_clock_0/m_time_i[11]\, CLK => 
        CLKINT_0_Y, E => 
        \system_clock_0/l_time_RNIKKE72[10]_net_1\, Q => 
        \system_clock_0/m_time[11]\);
    
    \LDO_FRONTEND_PWR_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \GND\, E => \VCC\, DOUT => 
        \LDO_FRONTEND_PWR_pad/U0/NET1\, EOUT => 
        \LDO_FRONTEND_PWR_pad/U0/NET2\);
    
    \system_clock_0/l_time_RNI5QTB1[7]\ : OR2A
      port map(A => \system_clock_0/m_time[7]\, B => 
        \system_clock_0/N_24\, Y => \system_clock_0/N_25\);
    
    \PR_OP_PWR_pad/U0/U0\ : IOPAD_TRI
      port map(D => \PR_OP_PWR_pad/U0/NET1\, E => 
        \PR_OP_PWR_pad/U0/NET2\, PAD => PR_OP_PWR);
    
    \system_clock_0/l_time_RNO[1]\ : INV
      port map(A => \system_clock_0/m_time[1]\, Y => 
        \system_clock_0/m_time_i[1]\);
    
    \system_clock_0/l_time[15]\ : DFN0E0
      port map(D => \system_clock_0/m_time_i[15]\, CLK => 
        CLKINT_0_Y, E => 
        \system_clock_0/l_time_RNIUEA34[14]_net_1\, Q => 
        \system_clock_0/m_time[15]\);
    
    \system_clock_0/l_time_RNO[6]\ : XNOR2
      port map(A => \system_clock_0/N_23\, B => 
        \system_clock_0/m_time[6]\, Y => \system_clock_0/N_39_i\);
    
    \system_clock_0/l_time_RNO[4]\ : XNOR2
      port map(A => \system_clock_0/N_21\, B => 
        \system_clock_0/m_time[4]\, Y => \system_clock_0/N_37_i\);
    
    \CLK_pad/U0/U0\ : IOPAD_IN
      port map(PAD => CLK, Y => \CLK_pad/U0/NET1\);
    
    \system_clock_0/l_time_RNO[10]\ : INV
      port map(A => \system_clock_0/m_time[10]\, Y => 
        \system_clock_0/m_time_i[10]\);
    
    \system_clock_0/un1_s_time_I_16\ : AND3
      port map(A => \system_clock_0/DWACT_FINC_E[0]\, B => 
        \system_clock_0/DWACT_FINC_E[1]\, C => LED2_c, Y => 
        \system_clock_0/N_3\);
    
    \system_clock_0/l_time_RNO[7]\ : INV
      port map(A => \system_clock_0/m_time[7]\, Y => 
        \system_clock_0/m_time_i[7]\);
    
    \system_clock_0/l_time_RNO[17]\ : INV
      port map(A => \system_clock_0/m_time[17]\, Y => 
        \system_clock_0/m_time_i[17]\);
    
    \system_clock_0/l_time[14]\ : DFN0E0
      port map(D => \system_clock_0/m_time_i[14]\, CLK => 
        CLKINT_0_Y, E => 
        \system_clock_0/l_time_RNIQEBK3[13]_net_1\, Q => 
        \system_clock_0/m_time[14]\);
    
    \system_clock_0/flag_RNO\ : NOR2B
      port map(A => \system_clock_0/l_N_13_mux\, B => 
        \system_clock_0/m_time[17]\, Y => 
        \system_clock_0/un14_l_time\);
    
    \system_clock_0/s_time[2]\ : DFN0E1
      port map(D => \system_clock_0/s_time_3[2]\, CLK => 
        CLKINT_0_Y, E => \system_clock_0/flag_net_1\, Q => 
        \system_clock_0/s_time[2]_net_1\);
    
    \system_clock_0/l_time_RNO[13]\ : INV
      port map(A => \system_clock_0/m_time[13]\, Y => 
        \system_clock_0/m_time_i[13]\);
    
    \system_clock_0/l_time[16]\ : DFN0E0
      port map(D => \system_clock_0/m_time_i[16]\, CLK => 
        CLKINT_0_Y, E => \system_clock_0/l_time_RNO_0[16]_net_1\, 
        Q => \system_clock_0/m_time[16]\);
    
    \LED2_pad/U0/U0\ : IOPAD_TRI
      port map(D => \LED2_pad/U0/NET1\, E => \LED2_pad/U0/NET2\, 
        PAD => LED2);
    
    \system_clock_0/l_time_RNILHDM2[11]\ : OR2A
      port map(A => \system_clock_0/m_time[11]\, B => 
        \system_clock_0/l_time_RNIKKE72[10]_net_1\, Y => 
        \system_clock_0/l_time_RNILHDM2[11]_net_1\);
    
    \system_clock_0/l_time_RNO[14]\ : INV
      port map(A => \system_clock_0/m_time[14]\, Y => 
        \system_clock_0/m_time_i[14]\);
    
    \system_clock_0/l_time_RNI4OAL3[9]\ : NOR3C
      port map(A => \system_clock_0/l_m6_0_a2_2\, B => 
        \system_clock_0/l_m6_0_a2_1\, C => 
        \system_clock_0/l_m6_0_a2_6\, Y => 
        \system_clock_0/l_m6_0_a2_7\);
    
    \system_clock_0/un1_s_time_I_17\ : XOR2
      port map(A => \system_clock_0/N_3\, B => 
        \system_clock_0/s_time[6]_net_1\, Y => 
        \system_clock_0/I_17\);
    
    \system_clock_0/l_time_RNINFC53[12]\ : OR2A
      port map(A => \system_clock_0/m_time[12]\, B => 
        \system_clock_0/l_time_RNILHDM2[11]_net_1\, Y => 
        \system_clock_0/l_time_RNINFC53[12]_net_1\);
    
    \system_clock_0/un1_s_time_I_13\ : AND3
      port map(A => \system_clock_0/DWACT_FINC_E[0]\, B => 
        \system_clock_0/s_time[3]_net_1\, C => 
        \system_clock_0/s_time[4]_net_1\, Y => 
        \system_clock_0/N_4\);
    
    \system_clock_0/s_time_RNIEHQH[6]\ : NOR3C
      port map(A => \system_clock_0/s_time[6]_net_1\, B => LED1_c, 
        C => \system_clock_0/un14_flag_1\, Y => 
        \system_clock_0/un14_flag_3\);
    
    \system_clock_0/s_time[0]\ : DFN0E1
      port map(D => \system_clock_0/I_4\, CLK => CLKINT_0_Y, E
         => \system_clock_0/flag_net_1\, Q => 
        \system_clock_0/s_time[0]_net_1\);
    
    \system_clock_0/l_time_RNO[16]\ : INV
      port map(A => \system_clock_0/m_time[16]\, Y => 
        \system_clock_0/m_time_i[16]\);
    
    \system_clock_0/un1_s_time_I_15\ : AND2
      port map(A => \system_clock_0/s_time[3]_net_1\, B => 
        \system_clock_0/s_time[4]_net_1\, Y => 
        \system_clock_0/DWACT_FINC_E[1]\);
    
    \system_clock_0/s_time[6]\ : DFN0E1
      port map(D => \system_clock_0/s_time_3[6]\, CLK => 
        CLKINT_0_Y, E => \system_clock_0/flag_net_1\, Q => 
        \system_clock_0/s_time[6]_net_1\);
    
    \system_clock_0/l_time_RNISO6I1[8]\ : OR2A
      port map(A => \system_clock_0/m_time[8]\, B => 
        \system_clock_0/N_25\, Y => \system_clock_0/N_26\);
    
    \system_clock_0/s_time_RNO[2]\ : AOI1B
      port map(A => \system_clock_0/un14_flag_3\, B => 
        \system_clock_0/un14_flag_2\, C => \system_clock_0/I_7\, 
        Y => \system_clock_0/s_time_3[2]\);
    
    \system_clock_0/un1_s_time_I_19\ : AND3
      port map(A => \system_clock_0/DWACT_FINC_E[0]\, B => 
        \system_clock_0/DWACT_FINC_E[2]\, C => 
        \system_clock_0/s_time[6]_net_1\, Y => 
        \system_clock_0/N_2\);
    
    \STX_PWR_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \GND\, E => \VCC\, DOUT => 
        \STX_PWR_pad/U0/NET1\, EOUT => \STX_PWR_pad/U0/NET2\);
    
    \system_clock_0/l_time[1]\ : DFN0
      port map(D => \system_clock_0/m_time_i[1]\, CLK => 
        CLKINT_0_Y, Q => \system_clock_0/m_time[1]\);
    
    \system_clock_0/s_time_RNO[3]\ : AOI1B
      port map(A => \system_clock_0/un14_flag_3\, B => 
        \system_clock_0/un14_flag_2\, C => \system_clock_0/I_9\, 
        Y => \system_clock_0/s_time_3[3]\);
    
    \STX_PWR_pad/U0/U0\ : IOPAD_TRI
      port map(D => \STX_PWR_pad/U0/NET1\, E => 
        \STX_PWR_pad/U0/NET2\, PAD => STX_PWR);
    
    \system_clock_0/l_time_RNO_0[16]\ : OR2A
      port map(A => \system_clock_0/m_time[15]\, B => 
        \system_clock_0/l_time_RNIUEA34[14]_net_1\, Y => 
        \system_clock_0/l_time_RNO_0[16]_net_1\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
