-- DFF Register
-- OMAR TAREK AHMED MOHAMED ALY AMER
-- 1180004
-- SUNDAY LAB

library IEEE;
use     IEEE.std_logic_1164.all;

entity dReg is
    generic (n:     integer := 8);

    port(    d: IN  std_logic_vector (n - 1 downto 0);
            en: IN  std_logic;
           rst: IN  std_logic;
           clk: IN  std_logic;
             q: OUT std_logic_vector (n - 1 downto 0));

    end entity;
    
architecture behav of dReg is

    begin
        process(clk, en, rst)
        
            begin
                if rst = '1' then
                    q <= (others => '0');

                elsif (rising_edge(clk)and en = '1') then
                    q <= d;
                


                end if;
            end process;
    
    end architecture ; 