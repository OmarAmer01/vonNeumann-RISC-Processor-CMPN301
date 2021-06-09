
-- Generic Ram
-- OMAR TAREK AHMED MOHAMED ALY AMER
-- 1180004
-- SUNDAY LAB

library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

entity InstructionMem is 
    port(
           clk:  IN  std_logic ;
           wen:  IN  std_logic                       := '0';
           rst:  IN  std_logic                       := '0';
         add:  IN  std_logic_vector (31 downto 0) := (others => '0');
       dataOUT:  OUT std_logic_vector (31 downto 0) := (others => '0')
    );
end entity;

architecture inst of InstructionMem is

    type ramType is array(0 to 15) of std_logic_vector(15 downto 0) ;
    signal ram : ramType := ((x"0000"), (x"1000"), 
                 (x"2000"), (x"3000"), (x"4000"), 
                 (x"5000"), (x"6000"), (x"7000"), 
                 (x"8000"), (x"9000"), (x"A000"), 
                 (x"B000"), (x"C000"), (x"D000"), 
                 (x"E000"), (x"F000"));   --// initialize 16 Values
    begin
        process(clk) is
           begin
               if(rising_edge(clk)) then
		dataOUT(31 downto 16) <=  ram(to_integer(unsigned(add)));
                dataOUT(15 downto 0) <=  ram(1+to_integer(unsigned(add)));
             end if;
          end process;
       
    end architecture;