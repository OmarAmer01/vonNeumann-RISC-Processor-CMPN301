-- Generic Ram
-- OMAR TAREK AHMED MOHAMED ALY AMER
-- 1180004
-- SUNDAY LAB

library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

entity ram is 
    generic (n: integer  := 8);
    port(
           clk:  IN  std_logic                       := '0';
           wen:  IN  std_logic                       := '0';
           --rst:  IN  std_logic                       := '0';
           add:  IN  std_logic_vector (5  downto 0)  := "000000";
        dataIN:  IN  std_logic_vector (n-1 downto 0) := (others => '0');
       dataOUT:  OUT std_logic_vector (n-1 downto 0) := (others => '0')
    );
end entity;

architecture syncRam of ram is

    type ramType is array(63 downto 0) of std_logic_vector(n-1 downto 0) ;
    signal ram : ramType := (others => (others => '1'));

    signal dOut : std_logic_vector (n-1 downto 0) := (others => '0');
    begin
        dOut <=  ram(to_integer(unsigned(add)));
        dataOUT <= dOut;
        process(clk) is
            begin

                --if(rst = '1') then
                    --ram <= (others=>(others=>'1'));

                if(rising_edge(clk)) then
                    if(wen = '1') then
                        ram(to_integer(unsigned(add))) <= dataIN;
                    end if;

                end if;

            end process;
        
        
    end architecture;