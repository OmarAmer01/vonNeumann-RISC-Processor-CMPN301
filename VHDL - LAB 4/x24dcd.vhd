-- 2 x 4 Decoder with enable 
-- OMAR TAREK AHMED MOHAMED ALY AMER
-- 1180004
-- SUNDAY LABx

library IEEE;
use     IEEE.std_logic_1164.all;

entity x24dcd is

    port(en: IN  std_logic;
        sel: IN  std_logic_vector (1 downto 0);
     dcdOut: OUT std_logic_vector (3 downto 0));

    end entity;

architecture struc of x24dcd is
    begin
    dcdOut <= "0001" when sel = "00" and en = '1' else
              "0010" when sel = "01" and en = '1' else
              "0100" when sel = "10" and en = '1' else
              "1000" when sel = "11" and en = '1' else
              "0000" ;       


    end architecture;