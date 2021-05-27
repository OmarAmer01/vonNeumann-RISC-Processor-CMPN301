-- TRI-STATE BUFFER
-- OMAR TAREK AHMED MOHAMED ALY AMER
-- 1180004
-- SUNDAY LAB

library IEEE;
use     IEEE.std_logic_1164.all;

entity triB is
    generic (n: integer  := 8);
    port(x: IN  std_logic_vector (n-1 downto 0);
         y: OUT std_logic_vector (n-1 downto 0);
         en: IN  std_logic);
    end entity;

architecture struc of triB is
    begin
        with en select
            y <=  (others => 'Z')   when '0',
                  x  when  others;

    end architecture;