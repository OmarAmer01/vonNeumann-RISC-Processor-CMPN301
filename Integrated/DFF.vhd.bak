Library ieee;
use ieee.std_logic_1164.all;

ENTITY dff IS
GENERIC ( n : integer := 32);
PORT( Clk,Rst, ENBL : IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0));
END entity;

ARCHITECTURE arch_dff OF dff IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1' THEN
q <= (OTHERS=>'0');
ELSIF rising_edge(Clk) THEN
IF ENBL = '1' THEN
q <= d;
END IF;
END IF;
END PROCESS;
END architecture;
