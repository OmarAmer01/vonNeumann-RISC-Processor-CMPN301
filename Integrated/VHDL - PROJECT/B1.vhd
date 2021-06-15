Library ieee;
use ieee.std_logic_1164.all;

entity B1 is 
Port (
Input: IN std_logic_vector (4 downto 0);
Output: OUT std_logic
);
end entity;

Architecture  myB1 of B1 is 

signal AND1: std_logic;
signal AND2: std_logic;
signal AND3: std_logic;

begin 

AND1 <= Input(4) AND (NOT Input(3)) AND Input(2) AND (NOT Input(1));
AND2 <= Input(4) AND (NOT Input(3)) AND (NOT Input(2)) AND Input(1) AND Input(0);
AND3 <= (NOT Input(4)) AND Input(3) AND (NOT Input(2)) AND Input(1) AND Input(0);

Output <= AND1 OR AND2 OR AND3;

end Architecture;
