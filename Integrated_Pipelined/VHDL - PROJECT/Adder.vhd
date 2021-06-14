Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder2 is 

Port (
Input: IN std_logic_vector (31 downto 0);
x: IN std_logic_vector(1 downto 0);
Output: Out std_logic_vector (31 downto 0)
);
end entity;

Architecture  myAdder of Adder2 is 

begin 

Output <= std_logic_vector(unsigned(Input)+unsigned(x));

end Architecture;
