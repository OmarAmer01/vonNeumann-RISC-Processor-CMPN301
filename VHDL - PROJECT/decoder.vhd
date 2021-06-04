Library ieee;
use ieee.std_logic_1164.all;

entity decoder is 
Port (
s : IN std_logic_vector (2 downto 0);
L: Out std_logic_vector (7 downto 0);
Enable : IN std_logic
);
end entity;

Architecture  mydecoder of decoder is 
begin 
L <= "00000000" when Enable ='0'
else "00000001" when Enable = '1' and s="000"
else "00000010" when Enable = '1' and s="001"
else "00000100" when Enable = '1' and s="010"
else "00001000" when Enable = '1' and s="011"
else "00010000" when Enable = '1' and s="100"
else "00100000" when Enable = '1' and s="101"
else "01000000" when Enable = '1' and s="110"
else "10000000" when Enable = '1' and s="111";
end Architecture ;