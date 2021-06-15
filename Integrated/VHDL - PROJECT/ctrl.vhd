-- ALU CONTROL UNIT
-- AMER
-- 6/2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrl is
    port(
        ctrlUnitIn: IN  std_logic_vector (3 downto 0);
        aluOpOut:   OUT std_logic_vector (3 downto 0)
    );
end entity;

architecture behav of ctrl is
    -- CONSTANTS
    constant NOP:     std_logic_vector (3 downto 0) := x"1" ;
    constant SETC:    std_logic_vector (3 downto 0) := x"2" ;
    constant CLRC:    std_logic_vector (3 downto 0) := x"3" ;
    constant NOTALU:  std_logic_vector (3 downto 0) := x"4" ;
    constant INC:     std_logic_vector (3 downto 0) := x"5" ;
    constant DEC:     std_logic_vector (3 downto 0) := x"6" ;
    constant ADD:     std_logic_vector (3 downto 0) := x"A" ;
    constant SUB:     std_logic_vector (3 downto 0) := x"C" ;
    constant ANDALU:  std_logic_vector (3 downto 0) := x"D" ;
    constant ORALU:   std_logic_vector (3 downto 0) := x"E" ;
    constant SHL:     std_logic_vector (3 downto 0) := x"F" ;
    constant SHR:     std_logic_vector (3 downto 0) := x"7" ;
    constant PASS:    std_logic_vector (3 downto 0) := x"8" ;

    begin
        aluOpOut <= SETC   when ctrlUnitIn = x"1" else
                    CLRC   when ctrlUnitIn = x"2" else
                    NOTALU when ctrlUnitIn = x"3" else
                    INC    when ctrlUnitIn = x"4" else
                    DEC    when ctrlUnitIn = x"5" else
                    PASS   when ctrlUnitIn = x"6" else
                    ADD    when ctrlUnitIn = x"7" else
                    SUB    when ctrlUnitIn = x"8" else
                    ANDALU when ctrlUnitIn = x"9" else
                    ORALU  when ctrlUnitIn = x"A" else
                    SHL    when ctrlUnitIn = x"B" else
                    SHR    when ctrlUnitIn = x"C" else
                    
                    NOP;   
                    
                    

end architecture;