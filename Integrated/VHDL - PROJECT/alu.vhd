-- ARITHMETIC LOGIC UNIT WITH BI-DIRECTIONAL SHIFT REGISTER AND SIGN EXTENSION UNITS
-- AMER
-- 6/2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity alu is
    port(
           op1: IN  std_logic_vector (31 downto 0) := x"0000_0000";
           op2: IN  std_logic_vector (31 downto 0) := x"0000_0000";
         opCode: IN  std_logic_vector (3  downto 0) :=  "0000";
         shAmt: IN  std_logic_vector (4  downto 0) :=  "00000";
           res: OUT std_logic_vector (31 downto 0) :=  x"0000_0000";
            cf: OUT std_logic := '0';
            nf: OUT std_logic := '0';
            zf: OUT std_logic := '0'; 
           clk: IN  std_logic := '0';
           rst: IN  std_logic := '0'
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

    component shReg is
        generic(  n:     integer := 32);
        port(
                clk: IN  std_logic := '0';
                rst: IN  std_logic := '0';
              shDir: IN  std_logic := '0';   -- Shift direction
  --            shBit: OUT std_logic := '0';   -- Discarded bit after shifting (goes to CCR CARRY)
              shAmt: IN  std_logic_vector (4   downto 0) := ("00000");
             dataIN: IN  std_logic_vector (n-1 downto 0) := (others => '0');
            dataOut: OUT std_logic_vector (n-1 downto 0) := (others => '0')
        );
    end component;

    -- CONSTANTS 
    constant NOP:     std_logic_vector (3 downto 0) := x"0";
    constant SETC:    std_logic_vector (3 downto 0) := x"1";
    constant CLRC:    std_logic_vector (3 downto 0) := x"2" ;
    constant NOTALU:  std_logic_vector (3 downto 0) := x"3" ;
    constant INC:     std_logic_vector (3 downto 0) := x"4" ;
    constant DEC:     std_logic_vector (3 downto 0) := x"5" ;
    constant ADD:     std_logic_vector (3 downto 0) := x"7" ;
    constant SUB:     std_logic_vector (3 downto 0) := x"8" ;
    constant ANDALU:  std_logic_vector (3 downto 0) := x"9" ;
    constant ORALU:   std_logic_vector (3 downto 0) := x"A" ;
    constant SHL:     std_logic_vector (3 downto 0) := x"B" ;
    constant SHR:     std_logic_vector (3 downto 0) := x"C" ;
    constant PASS:    std_logic_vector (3 downto 0) := x"6" ; -- PASS OP 1 AS IS
                                                              -- Required for functions such as OUT, IN, and MOV.
                                                              -- 3enena leek ya yasser beh <3

    -- SIGNALS
    signal aluOut:                       std_logic_vector (31 downto 0) := x"0000_0000";
    signal negOp1, negOp2, andL, orL:    std_logic_vector (31 downto 0) := x"0000_0000";
    signal addRes, op2Add:               std_logic_vector (31 downto 0) := x"0000_0000";
    signal addC, cin:                    std_logic := '1';
    signal cSig:                         std_logic := '0';
    signal shRegOut:                     std_logic_vector(31 downto 0) := x"0000_0000";
    signal shfBitC:                      std_logic := '0';
    signal shfDir:                       std_logic := '0';
   -- signal shfAmt:                       std_logic_vector(4 downto 0) :="00000";
    begin

    -- EXTERNAL ENTITIES
        fa32: FA    generic map (32) port map (op1, op2Add, cin, addRes, addC);
          sh: shReg generic map (32) port map (clk, rst, shfDir ,shAmt(4 downto 0), op1, shRegOut);

    -- MAIN ALU      
        with opCode    select aluOut  <=
            aluOut     when NOP,            -- NOP
            aluOut     when SETC,           -- SETC
            aluOut     when CLRC,           -- CLRC
            negOp1     when NOTALU,         -- NOT                   
            addRes     when INC,            -- INC  
            addRes     when DEC,            -- DEC
            addRes     when ADD,            -- ADD
            addRes     when SUB,            -- SUB
            andL       when ANDALU,         -- AND
            orL        when ORALU,          -- OR
            shRegOut   when SHL,            -- SHL
            shRegOut   when SHR,            -- SHR
            op1        when PASS,           -- PASS OP 1 AS IS
            aluOut     when others;         -- INVALID
                            

    -- FLAGS
    zf <= '1' when aluOut = x"0000_0000" else '0';
    cf <= cSig;
    nf <= aluOut(31);

    cSig <= '1' when
        opCode = SETC
    else addC    when 
        opCode = INC or
        opCode = DEC or
        opCode = ADD or
        opCOde = SUB
    else '0'     when
        opCode = CLRC   or
        opCode = ANDALU or
        opCode = ORALU 
    else shfBitC when
        opCode = SHR or
        opCode = SHL
    else '0';
        
    -- INVERTED INPUTS
    negOp1 <= not op1;
    negOp2 <= not op2;

    -- LOGIC UNIT CONFIGURATIONS
    andL <= op1 and op2;
    orL  <= op1 or  op2;

    -- FULL ADDER CONFIGURATIONS
    op2Add <= negOp2            when (opCode = SUB)
              else op2          when (opCode = ADD)
              else x"0000_0001" when (opCode = INC)
              else x"FFFF_FFFF" when (opCode = DEC);

    cin <= '1' when (opCode = SUB) else '0';


    -- SHIFT REGISTER CONFIGURATIONS
    shfDir <= '1' when opCode = SHR else '0';
    --shfDir <= shAmt(5);
    --shfAmt <= op2 (4 downto 0); ---------------------- should be ShfAmt should be an input to ALU 
                                                      -- Done ya yasser basha
    -- RESULT
    res <= aluOut;

end architecture;