-- ARITHMETIC LOGIC UNIT
-- AMER
-- 6/2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity alu is
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

architecture behav of alu is

    component FA is
        generic (n:    integer := 32);
        port (a, b: IN std_logic_vector (n-1 downto 0);
               cin: IN std_logic;
                 s: OUT std_logic_vector (n-1 downto 0);
              cout: OUT std_logic);
    end component;

    constant MAX: unsigned := x"FFFF_FFFF";

    constant NOP:     std_logic_vector (4 downto 0) := '0' & x"1";
    constant SETC:    std_logic_vector (4 downto 0) := '0' & x"2";
    constant CLRC:    std_logic_vector (4 downto 0) := '0' & x"3" ;
    constant NOTALU:  std_logic_vector (4 downto 0) := '0' & x"4" ;
    constant INC:     std_logic_vector (4 downto 0) := '0' & x"5" ;
    constant DEC:     std_logic_vector (4 downto 0) := '0' & x"6" ;
    constant ADD:     std_logic_vector (4 downto 0) := '0' & x"A" ;
    constant SUB:     std_logic_vector (4 downto 0) := '0' & x"C" ;
    constant ANDALU:  std_logic_vector (4 downto 0) := '0' & x"D" ;
    constant ORALU:   std_logic_vector (4 downto 0) := '0' & x"E" ;

    signal aluOut:                       std_logic_vector (31 downto 0) := x"0000_0000";
    signal negOp1, negOp2, andL, orL:    std_logic_vector (31 downto 0) := x"0000_0000";
    signal addRes, op2Add:               std_logic_vector (31 downto 0) := x"0000_0000";
    signal addC, cin:                     std_logic := '1';
    signal cSig:                         std_logic := '0';

    begin

        fa32: FA generic map (32) port map (op1, op2Add, cin, addRes, addC );

        with opCode select aluOut  <=
            x"0000_0000"        when NOP,            -- NOP
            aluOut              when SETC,           -- SETC
            aluOut              when CLRC,           -- CLRC
            negOp1              when NOTALU,        -- NOT                   
            addRes              when INC,            -- INC  
            addRes              when DEC,            -- DEC
            addRes              when ADD,            -- ADD
            addRes              when SUB,            -- SUB
            andL                when ANDALU,         -- AND
            orL                 when ORALU,          -- OR
            aluOut              when others;         -- INVALID
                            

    -- FLAGS
    zf <= '1' when aluOut = x"0000_0000" else '0';
    cf <= cSig;
    nf <= aluOut(31);

    cSig <= '1' when
        opCode = SETC
    else addC when 
        opCode = INC or
        opCode = DEC or
        opCode = ADD or
        opCOde = SUB
    else '0'  when
        opCode = CLRC   or
        opCode = ANDALU or
        opCode = ORALU  
    else '0';
    



        
    -- INVERTED INPUTS
    negOp1 <= not op1;
    negOp2 <= not op2;

    -- LOGIC
    andL <= op1 and op2;
    orL  <= op1 or  op2;

    -- FULL ADDER CONFIGURATIONS
    op2Add <= negOp2            when (opCode = SUB)
              else op2          when (opCode = ADD)
              else x"0000_0001" when (opCode = INC)
              else x"FFFF_FFFF" when (opCode = DEC);

    cin <= '1' when (opCode = SUB) else '0';

    -- RESULT
    res <= aluOut;

end architecture;