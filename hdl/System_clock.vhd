-- System_clock.vhd
--------------------------------
-- Generates all timing for the system
--------------------------------
-- Authors:
-- Åke Forslund
-- Terry Edberg
-- Göran Olsson
--------------------------------
-- Reused for WOLF experiment. 

-- Time vector:
--M_TIME 0	    32768	KHz
--M_TIME 1	    16384	KHz
--M_TIME 2	    8192	KHz
--M_TIME 3	    4096	KHz
--M_TIME 4	    2048	KHz
--M_TIME 5	    1024	KHz
--M_TIME 6	    512	    KHz
--M_TIME 7	    256	    KHz
--M_TIME 8	    128	    KHz
--M_TIME 9	    64	    KHz
--M_TIME 10	    32	    KHz
--M_TIME 11	    16	    KHz
--M_TIME 12	    8	    KHz
--M_TIME 13	    4	    KHz
--M_TIME 14	    2	    KHz
--M_TIME 15	    1	    KHz
--M_TIME 16	    500	    Hz
--M_TIME 17	    250	    Hz
--M_TIME 18     128     Hz
--M_TIME 19	    64	    Hz
--M_TIME 20	    32	    Hz
--M_TIME 21	    16	    Hz
--M_TIME 22	    8	    Hz
--M_TIME 23	    4	    Hz
--M_TIME 24	    2	    Hz
--M_TIME 25	    1	    Hz

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY system_clock is

PORT(mclk, reset    : in std_logic; -- mclk is 32.768 MHz
     m_time         : out std_logic_vector(25 downto 0) );
END system_clock;


ARCHITECTURE behaviour of system_clock is

signal s_time   : std_logic_vector(7 downto 0) := (others => '0');
signal l_time   : std_logic_vector(17 downto 1) := (others => '0');
signal flag     : std_logic;


begin
m_time(25 downto 0) <= s_time & l_time & mclk;
-- Intermediate counter, 18 bit
 
process(mclk, reset)
begin
    if reset /= '0' then
        l_time <= (others => '0');
    elsif falling_edge(mclk) then
        l_time <= l_time + 1;
    end if;             
end process;

process(mclk, reset)
begin
    if reset /= '0' then
        flag <= '0';
    elsif rising_edge(mclk) then
        if l_time = '1' & x"FFFF" then
            flag <= '1';
        else
            flag <= '0';
        end if;   
    end if;
end process;

-- Slow counter, 8 bit, counts 0...249; MSB at 1 Hz
process(mclk, reset)
begin
    if reset /= '0' then
        s_time <= (others => '0');
    elsif falling_edge(mclk) then
        if flag = '1' then
            if (s_time(7 downto 3) = x"1F") and(s_time(0) = '1') then  -- 249; Don't check the zero bits
                s_time <= (others => '0');
            else
                s_time <= s_time + 1;
            end if;
        end if;   
    end if;
end process;

end behaviour;