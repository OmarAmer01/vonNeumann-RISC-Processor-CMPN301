Library ieee;
use ieee.std_logic_1164.all;

ENTITY DFF IS
GENERIC ( n : integer := 32);
PORT( Clk,Rst, ENBL : IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0);
rstAmount : IN std_logic_vector(n-1 downto 0));
END DFF;

ARCHITECTURE DFF OF DFF
IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1' THEN
q <=rstAmount ;
ELSIF  ENBL = '1' THEN
q <= d;
END IF;

END PROCESS;
END DFF;
