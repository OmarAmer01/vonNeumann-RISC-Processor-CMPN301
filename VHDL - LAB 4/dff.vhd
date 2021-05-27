-- D Flip-Flop
-- OMAR TAREK AHMED MOHAMED ALY AMER
-- 1180004
-- SUNDAY LAB

library IEEE;
use     IEEE.std_logic_1164.all;

entity dff is
    port(d: IN  std_logic;
        en: IN  std_logic;
       clk: IN  std_logic;
         q: OUT std_logic);
    end entity;

architecture beahv of dff is
    begin
        process(clk, en)
        begin
            if en = '0' then

               q <= '0';

            elsif rising_edge(clk) then

               q <=  d ;
           
        
            end if;
                
        end process;

    end architecture;