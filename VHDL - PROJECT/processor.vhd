-- MAIN UNIT
-- YASSER, SEIF, ANDREW, AMER
-- 6/4

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
    port(
        inP:  IN  std_logic_vector (31 downto 0) := x"0000_0000";
        clk:  IN  std_logic := '0';
        rst:  IN  std_logic := '0';
        outP: OUT std_logic_vector (31 downto 0) := x"0000_0000"
        -- n4of hndeef interrupt wla eh el donya
    );
end entity;

architecture behav of processor is

    -- SIGNALS

        -- ALU
    signal aluOp1, aluOp2, aluRes:    std_logic_vector (31 downto 0) := x"0000_0000";
    signal aluOpCodeIn:               std_logic_vector (4 downto 0)  :=  "00000";
    signal aluCout, aluNout, aluZout: std_logic := '0';

        -- CCR
    signal status, ccrOut: std_logic_vector (2 downto 0) := "000";

        -- CTRL UNIT SIGNALS
    signal ctrlALUop: std_logic_vector (4 downto 0) := "00000";

    -- COMPONENTS
    component alu is -- General Purpose ALU
        port(
               op1: IN  std_logic_vector (31 downto 0) := x"0000_0000";
               op2: IN  std_logic_vector (31 downto 0) := x"0000_0000";
            opCode: IN  std_logic_vector (4  downto 0) :=  "00000";
               res: OUT std_logic_vector (31 downto 0) := x"0000_0000";
                cf: OUT std_logic := '0';
                nf: OUT std_logic := '0';
                zf: OUT std_logic := '0'; 
               clk: IN  std_logic := '0';
               rst: IN  std_logic := '0'
        );
    end component;
    
    component ctrl is -- ALU opcode translator (from control unit to alu)
        port(
            ctrlUnitIn: IN  std_logic_vector (4 downto 0);
            aluOpOut:   OUT std_logic_vector (4 downto 0)
        );
    end component;

    component dReg is -- General Purpose Register
        generic (n:     integer := 8);
        port(    d: IN  std_logic_vector (n - 1 downto 0);
                en: IN  std_logic;
               rst: IN  std_logic;
               clk: IN  std_logic;
                 q: OUT std_logic_vector (n - 1 downto 0));
    
        end component;

    begin

    -- INSTANTIATIONS
    alUnit: alu port map(aluOp1, aluOp2, aluOpCodeIn, aluRes, aluCout, aluNout, aluZout, clk, rst);
    ccr: dReg generic map (3) port map(status, '1', rst, clk, ccrOut);
    aluOpDCD: ctrl port map (ctrlALUop, aluOpCodeIn); -- alu operation code decoder

    -- CCR CONFIGURATION
    status <= aluZout &  aluNout & aluCout;

end architecture;