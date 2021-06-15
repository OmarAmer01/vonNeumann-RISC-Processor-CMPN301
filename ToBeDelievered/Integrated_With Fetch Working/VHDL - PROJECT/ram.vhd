
-- VHDL project: VHDL code for a single-port RAM 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;


entity RAM is
port(

 RAM_ADDR: in std_logic_vector(19 downto 0); -- Address to write/read RAM
 RAM_DATA_IN: in std_logic_vector(31 downto 0); -- Data to write into RAM
 RAM_WR: in std_logic; -- Write enable 
 RAM_CLOCK: in std_logic; -- clock input for RAM
 RST : in std_logic;
 RAM_DATA_OUT: out std_logic_vector(31 downto 0); -- Data output of RAM
 RAM_1ST_lOCATION : out std_logic_vector(31 downto 0);
 StackOp : IN std_logic_vector(1 downto 0 );
 STACK_DATA_OUT: out std_logic_vector(31 downto 0)
);
end RAM;

architecture Behavioral of RAM is

type RAM_ARRAY is array (0 to 1048576) of std_logic_vector (15 downto 0);----(0 to 1048576 )
-- initial values in the RAM
signal RAM: RAM_ARRAY :=( others => x"0000"); 
signal RAM_ADDR1 : std_logic_vector(19 downto 0);
signal RAM_ADDR2 : integer ;
begin
RAM_ADDR1<= RAM_ADDR(19 downto 0);
process(RAM_CLOCK)
begin
 if(rising_edge(RAM_CLOCK)) then
 if(RAM_WR='1') then 
 if ( StackOp = "10" ) then 
 RAM(to_integer(unsigned(RAM_ADDR1))) <= RAM_DATA_IN (15 downto 0);
 RAM(to_integer(unsigned(RAM_ADDR1))-1) <= RAM_DATA_IN (31 downto 16);
 else 
 RAM(to_integer(unsigned(RAM_ADDR1))) <= RAM_DATA_IN (15 downto 0);
 RAM(to_integer(unsigned(RAM_ADDR1))+1) <= RAM_DATA_IN (31 downto 16);
end if; 
 end if;
 end if;
end process;

process (RAM_CLOCK)
begin 
--if(Cha_edge(RAM_CLOCK)) then
RAM_ADDR2 <=to_integer(unsigned(RAM_ADDR1));
if (RAM_ADDR2>=1) then 
STACK_DATA_OUT (15 downto 0) <= RAM(to_integer(unsigned(RAM_ADDR1)))  ;
STACK_DATA_OUT (31 downto 16) <= RAM(to_integer(unsigned(RAM_ADDR1))-1);
--end if;
end if;
end process;

 RAM_DATA_OUT (15 downto 0) <= RAM(to_integer(unsigned(RAM_ADDR1)));     ----- error 
 RAM_DATA_OUT (31 downto 16) <= RAM(to_integer(unsigned(RAM_ADDR1))+1);
RAM_1ST_lOCATION <= x"0000" & RAM(0); 
end Behavioral;