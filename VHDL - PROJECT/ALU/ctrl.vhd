-- ALU CONTROL UNIT
-- AMER
-- 6/2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrl is
    port(
        ctrlUnitIn: IN  std_logic_vector (4 downto 0);
        aluOpOut:   OUT std_logic_vector (4 downto 0)
    );
end entity;

architecture behav of ctrl is
    -- CONSTANTS
    constant NOP:     std_logic_vector (4 downto 0) := '0' & x"1" ;
    constant SETC:    std_logic_vector (4 downto 0) := '0' & x"2" ;
    constant CLRC:    std_logic_vector (4 downto 0) := '0' & x"3" ;
    constant NOTALU:  std_logic_vector (4 downto 0) := '0' & x"4" ;
    constant INC:     std_logic_vector (4 downto 0) := '0' & x"5" ;
    constant DEC:     std_logic_vector (4 downto 0) := '0' & x"6" ;
    constant ADD:     std_logic_vector (4 downto 0) := '0' & x"A" ;
    constant SUB:     std_logic_vector (4 downto 0) := '0' & x"C" ;
    constant ANDALU:  std_logic_vector (4 downto 0) := '0' & x"D" ;
    constant ORALU:   std_logic_vector (4 downto 0) := '0' & x"E" ;
    constant SHL:     std_logic_vector (4 downto 0) := '0' & x"F" ;
    constant SHR:     std_logic_vector (4 downto 0) := '0' & x"7" ;

    begin
        aluOpOut <= SETC   when ctrlUnitIn = '0' & x"2"  else
                    CLRC   when ctrlUnitIn = '0' & x"3"  else
                    NOTALU when ctrlUnitIn = '0' & x"4"  else
                    INC    when ctrlUnitIn = '0' & x"5"  else
                    DEC    when ctrlUnitIn = '0' & x"6"  else
                    ADD    when ctrlUnitIn = '0' & x"A"  else
                    SUB    when ctrlUnitIn = '0' & x"C"  else
                    ANDALU when ctrlUnitIn = '0' & x"D"  else
                    ORALU  when ctrlUnitIn = '0' & x"E"  else
                    SHL    when ctrlUnitIn = '0' & x"F"  else
                    SHR    when ctrlUnitIn = '1' & x"0" else
                    NOP;   
                    
                    

end architecture;