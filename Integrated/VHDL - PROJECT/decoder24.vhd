Library ieee;
use ieee.std_logic_1164.all;

entity decoder24 is 
Port (
s : IN std_logic_vector (1 downto 0);
L: Out std_logic_vector (3 downto 0)
);
end entity;

Architecture  mydecoder24 of decoder24 is 
begin 
L <= "0001" when s="00"
else "0010" when s="01"
else "0100" when s="10"
else "1000" when s="11";
end Architecture;