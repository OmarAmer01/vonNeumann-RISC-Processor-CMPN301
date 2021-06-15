library ieee;
use ieee.std_logic_1164.all;

entity FA is
    generic (n : integer);
    port (a, b : in std_logic_vector (n-1 downto 0);
    cin : in std_logic;
    s : out std_logic_vector (n-1 downto 0);
    cout : out std_logic);
    end entity;

architecture behav of FA is
    COMPONENT adder IS
                  PORT( a,b,cin : IN std_logic; s,cout : OUT std_logic);
          END COMPONENT;
         SIGNAL temp : std_logic_vector(n-1 DOWNTO 0);
         
         BEGIN
         f0: adder PORT MAP(a(0),b(0),cin,s(0),temp(0));
         loop1: FOR i IN 1 TO n-1 GENERATE
                 fx: adder PORT MAP(a(i),b(i),temp(i-1),s(i),temp(i));
         END GENERATE;
         Cout <= temp(n-1);
         
    end architecture;
