Library ieee;
use ieee.std_logic_1164.all;

entity tri_state_buffer is 
GENERIC ( n : integer := 32);
Port (
A : IN std_logic_vector(n-1 downto 0);
B: Out std_logic_vector(n-1 downto 0);
EN : IN std_logic
);
end entity;

architecture struct of tri_state_buffer is
begin
  B <= A when (EN = '1') else (others=>'Z');
end architecture;
