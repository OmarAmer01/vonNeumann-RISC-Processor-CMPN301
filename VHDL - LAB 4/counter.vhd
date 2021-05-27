-- Generic Counter
-- OMAR TAREK AHMED MOHAMED ALY AMER
-- 1180004
-- SUNDAY LAB

library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;


entity genCounter is

    generic (
        n: integer := 6
    );

    port(
        clk, en, rst: IN  std_logic;
        data:         OUT std_logic_vector (n-1 downto 0)
    );

end entity;

architecture ctr of genCounter is
    signal q:   std_logic_vector (n-1 downto 0) := (others => '0');

    begin
        process(clk)
        begin

            if(rst = '1') then 
                q <= (others => '0');
            

            elsif(en = '1' and rising_edge(clk)) then

                q <= std_logic_vector(unsigned(q) + 1);

                end if;

        end process;

        data <= q;

end architecture;


