-- Version: v11.8 11.8.0.26

library ieee;
use ieee.std_logic_1164.all;
library proasic3;
use proasic3.all;

entity CU_Main_Test is

    port( PAD : in    std_logic;
          Y   : out   std_logic
        );

end CU_Main_Test;

architecture DEF_ARCH of CU_Main_Test is 

  component INBUF
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;


begin 


    \INBUF[0]\ : INBUF
      port map(PAD => PAD, Y => Y);
    

end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:11.8.0.26
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:PA3LC
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_IO_INBUF
-- LPM_HINT:INBUF
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:C:/Users/rozen/Dropbox/EE_BSC_2017/G8/vhdl/CU_Droptest/smartgen\CU_Main_Test
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:IS4X4M1
-- SMARTGEN_PACKAGE:vq100
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:1
-- TYPE:
-- TRIEN_POLARITY:0
-- CLR_POLARITY:0

-- _End_Comments_

