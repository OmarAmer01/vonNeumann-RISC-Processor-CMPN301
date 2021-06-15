library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is 
port ( opCode: IN std_logic_vector (4 downto 0);
		signals: OUT std_logic_vector(21 downto 0)
);
end entity ;

ARCHITECTURE My_ControlUnit OF ControlUnit is 
begin  
signals <= "0001000000000000000000" when opCode = "00010"
else "0010000000000000000000" when opCode="00011"
else "0011000000000000100010" when opCode="00100"
else "0100000000000000100010" when opCode="00101"
else "0101000000000000100010" when opCode="00110"
else "0110000000000000100100" when opCode="00111"
else "0110100000000000100010" when opCode="01000"
else "0110000000000000100011" when opCode="01001"
else "0111000000000000100011" when opCode="01010"
else "0111001000000000100010" when opCode="01011"
else "1000000000000000100011" when opCode="01100"
else "1001000000000000100011" when opCode="01101"
else "1010000000000000100011" when opCode="01110"
else "1011000000000000100010" when opCode="01111"----------
else "1100000000000000100010" when opCode="10000"----------
else "0000000000100100010000" when opCode="10001"
else "0000000000111000001010" when opCode="10010"
else "0110010000000000100010" when opCode="10011"
else "0111010000001000000010" when opCode="10100"
else "0111010000000100000000" when opCode="10101"
else "0000000101000000000000" when opCode="10110"
else "0000000110000000000000" when opCode="10111"
else "0000000111000000000000" when opCode="11000"
else "0000000100000000000000" when opCode="11001"
else "1101000100100110010000" when opCode="11010"
else "1110000000111001001000" when opCode="11011"
--else "1111000000001001000000" when opCode="11100"
else (others=>'0');
end ARCHITECTURE;
