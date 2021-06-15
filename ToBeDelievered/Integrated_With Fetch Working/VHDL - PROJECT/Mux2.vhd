Library ieee;
use ieee.std_logic_1164.all;

entity Mux2 is 
Port (
Input0: IN std_logic_vector (31 downto 0);
Input1: IN std_logic_vector (31 downto 0);
S: IN std_logic;
Output: Out std_logic_vector (31 downto 0)
);
end entity;

Architecture  mymux2 of Mux2 is 
begin 
Output <= Input0 when s = '0'
else Input1 when s = '1';
end Architecture;
