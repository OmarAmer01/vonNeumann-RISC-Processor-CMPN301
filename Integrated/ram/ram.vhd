
-- VHDL project: VHDL code for a single-port RAM 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;


entity RAM is
port(

 RAM_ADDR: in std_logic_vector(19 downto 0); -- Address to write/read RAM-------edit address  19 downto 0
 RAM_DATA_IN: in std_logic_vector(31 downto 0); -- Data to write into RAM
 RAM_WR: in std_logic; -- Write enable 
 RAM_CLOCK: in std_logic; -- clock input for RAM
 RST : in std_logic;
 RAM_DATA_OUT: out std_logic_vector(31 downto 0) -- Data output of RAM
);
end RAM;

architecture Behavioral of RAM is

type RAM_ARRAY is array (0 to 32) of std_logic_vector (15 downto 0);----(0 to 1048576 )
-- initial values in the RAM
signal RAM: RAM_ARRAY :=(others => x"1111"); 
begin
process(RAM_CLOCK)
begin
 if (RST ='1') then 
 RAM <= (others=>(others=>'0'));
 end if ;
 if(rising_edge(RAM_CLOCK)) then
 if(RAM_WR='1') then -- when write enable = 1, 
 -- write input data into RAM at the provided address
 RAM(to_integer(unsigned(RAM_ADDR))) <= RAM_DATA_IN (15 downto 0);
 RAM(to_integer(unsigned(RAM_ADDR))+1) <= RAM_DATA_IN (31 downto 16);
 -- The index of the RAM array type needs to be integer so
 -- converts RAM_ADDR from std_logic_vector -> Unsigned -> Interger using numeric_std library
 end if;
 end if;
end process;
 -- Data to be read out 
 RAM_DATA_OUT (15 downto 0) <= RAM(to_integer(unsigned(RAM_ADDR)));     ----- error 
 RAM_DATA_OUT (31 downto 16) <= RAM(to_integer(unsigned(RAM_ADDR))+1);
end Behavioral;