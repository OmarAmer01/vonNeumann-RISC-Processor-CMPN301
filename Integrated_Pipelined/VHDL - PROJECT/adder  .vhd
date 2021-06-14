LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY adder IS
	PORT (a,b,cin : IN  std_logic;
		  s, cout : OUT std_logic );
END adder;

ARCHITECTURE behav OF adder IS
	BEGIN
		
				s <= a XOR b XOR cin;
				cout <= (a AND b) OR (cin AND (a XOR b));
		
END behav;