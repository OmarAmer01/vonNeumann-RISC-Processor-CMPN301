Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder is 
GENERIC ( n : integer := 32);
Port (
Input: IN std_logic_vector (31 downto 0);
x: IN std_logic_vector(1 downto 0);
Output: Out std_logic_vector (31 downto 0)
);
end entity;

Architecture  myAdder of Adder is 

begin 

Output <= std_logic_vector(unsigned(Input)+unsigned(x));

end Architecture;
