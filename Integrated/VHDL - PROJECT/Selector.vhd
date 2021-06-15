Library ieee;
use ieee.std_logic_1164.all;

entity Selector is port (
dataIN : IN std_logic_vector(31 downto 0);
dataOUT0 : OUT std_logic_vector(31 downto 0);
dataOUT1 : OUT std_logic_vector(31 downto 0);
Sel : IN std_Logic
);
end entity;
Architecture MySelector of Selector is 

component tri_state_buffer is 
GENERIC ( n : integer := 32);
Port (
A : IN std_logic_vector(n-1 downto 0);
B: Out std_logic_vector(n-1 downto 0);
EN : IN std_logic
);
end component;

begin 

dataOUT0 <= dataIN when (Sel='0') else (others=>'Z');
dataOUT1 <= dataIN when (Sel='1') else (others=>'Z');
end Architecture;