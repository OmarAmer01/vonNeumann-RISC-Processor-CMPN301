-- ARITHMETIC LOGIC UNIT
-- AMER
-- 6/2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity au is
    port(
           op1: IN  std_logic_vector (31 downto 0) := x"0000_0000";
           op2: IN  std_logic_vector (31 downto 0) := x"0000_0000";
        opCode: IN  std_logic_vector (4  downto 0) := "00000";
           res: OUT std_logic_vector (31 downto 0) :=  x"0000_0000";
            cf: OUT std_logic := '0';
            nf: OUT std_logic := '0';
            zf: OUT std_logic := '0'
    );
end entity;

architecture behav of au is
    constant MAX: unsigned := x"FFFF_FFFF";

    constant NOP:     std_logic_vector (4  downto 0) := '0' & x"1";
    constant SETC:    std_logic_vector (4  downto 0) := '0' & x"2";
    constant CLRC:    std_logic_vector (4  downto 0) := '0' & x"3" ;
    constant NOTRDST: std_logic_vector (4  downto 0) := '0' & x"4" ;
    constant INCRDST: std_logic_vector (4  downto 0) := '0' & x"5" ;
    constant DECRDST: std_logic_vector (4  downto 0) := '0' & x"6" ;


    signal aluOut:    std_logic_vector (32 downto 0) := "0" & x"0000_0000";
    signal negOp1:    std_logic_vector (31 downto 0) :=       x"0000_0000";
    begin
        with opCode select aluOut  <=
           "0" & x"0000_0000"        when NOP, -- NOP
           "1" & aluOut(31 downto 0) when SETC, -- SETC
           "0" & aluOut(31 downto 0) when CLRC, -- CLRC
           "0" & not op1 when NOTRDST,          -- NOT
          "0" & std_logic_vector(unsigned(op1) + 1) when INCRDST,
          "0" & std_logic_vector(unsigned(op1) - 1) when DECRDST,
           aluOut when others;                     -- INVALID


    -- FLAGS
    zf <= '1' when aluOut (31 downto 0) = x"0000_0000" else '0';
    cf <= '1' when ((opCode = INCRDST) and (op1 = x"FFFF_FFFF")) or ((opCode = DECRDST) and (op1 = x"0000_0000")) else '0';
    nf <= aluOut(31);
        

    -- MISC
    negOp1 <= not op1;
        
    res <= aluOut(31 downto 0);

end architecture;