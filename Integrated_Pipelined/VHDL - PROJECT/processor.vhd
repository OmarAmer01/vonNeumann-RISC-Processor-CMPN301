--- All Stages
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

component B1 is 
Port (
Input: IN std_logic_vector (4 downto 0);
Output: OUT std_logic
);
end component;


component Mux2 is 
Port (
Input0: IN std_logic_vector (31 downto 0);
Input1: IN std_logic_vector (31 downto 0);
S: IN std_logic;
Output: Out std_logic_vector (31 downto 0)
);
end component;

component Mux2_3bits is 
Port (
Input0: IN std_logic_vector (2 downto 0);
Input1: IN std_logic_vector (2 downto 0);
S: IN std_logic;
Output: Out std_logic_vector (2 downto 0)
);
end component;

component Mux4 is 
Port (
Input0: IN std_logic_vector (31 downto 0);
Input1: IN std_logic_vector (31 downto 0);
Input2: IN std_logic_vector (31 downto 0);
Input3: IN std_logic_vector (31 downto 0);
S: IN std_logic_vector (1 downto 0);
Output: Out std_logic_vector (31 downto 0)
);
end component;

component Adder2 is 

Port (
Input: IN std_logic_vector (31 downto 0);
x: IN std_logic_vector(1 downto 0);
Output: Out std_logic_vector (31 downto 0)
);
end component;

component alu is -- General Purpose ALU
        port(
               op1: IN  std_logic_vector (31 downto 0) := x"0000_0000";
               op2: IN  std_logic_vector (31 downto 0) := x"0000_0000";
               opCode: IN  std_logic_vector (3  downto 0) :=  "0000";
 		shAmt: IN  std_logic_vector (4  downto 0) :=  "00000";
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
            ctrlUnitIn: IN  std_logic_vector (3 downto 0);
            aluOpOut:   OUT std_logic_vector (3 downto 0)
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

component my_nDFF IS
GENERIC ( n : integer := 32);
PORT( Clk,Rst, ENBL : IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0);
rstAmount : IN std_logic_vector(n-1 downto 0));
END component;

component DFF IS
GENERIC ( n : integer := 32);
PORT( Clk,Rst, ENBL : IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0);
rstAmount : IN std_logic_vector(n-1 downto 0));
END component;

component RAM is
port(

 RAM_ADDR: in std_logic_vector(19 downto 0); -- Address to write/read RAM
 RAM_DATA_IN: in std_logic_vector(31 downto 0); -- Data to write into RAM
 RAM_WR: in std_logic; -- Write enable 
 RAM_CLOCK: in std_logic; -- clock input for RAM
 RST : in std_logic;
 RAM_DATA_OUT: out std_logic_vector(31 downto 0); -- Data output of RAM
RAM_1ST_lOCATION : out std_logic_vector(31 downto 0);
StackOp : IN std_logic_vector(1 downto 0 );
 STACK_DATA_OUT: out std_logic_vector(31 downto 0) 
);
end component;


component ControlUnit is 
port ( opCode: IN std_logic_vector (4 downto 0);
		signals: OUT std_logic_vector(21 downto 0)
);
end component ;

component decoder24 is 
Port (
s : IN std_logic_vector (1 downto 0);
L: Out std_logic_vector (3 downto 0)
);
end component;

component InstructionMem is 
    port(
           clk:  IN  std_logic  := '0';
           wen:  IN  std_logic  := '0';
           rst:  IN  std_logic := '0';
        add:  IN  std_logic_vector (31 downto 0) := (others => '0');
       dataOUT:  OUT std_logic_vector (31 downto 0) := (others => '0')
    );
end component;
 
component Regs_file is 
port (
waddr: IN std_logic_vector (2 downto 0);

raddr1: IN std_logic_vector (2 downto 0);
raddr2: IN std_logic_vector (2 downto 0);

WEn : In std_logic;
DataRead1 :OUT  std_logic_vector (31 downto 0);
DataRead2 : OUT std_logic_vector (31 downto 0);
DataWrite : IN std_logic_vector (31 downto 0);
clk : IN std_logic;
rst : IN std_logic_vector (7 downto 0)
);
end component ;

component Selector is port (
dataIN : IN std_logic_vector(31 downto 0);
dataOUT0 : OUT std_logic_vector(31 downto 0);
dataOUT1 : OUT std_logic_vector(31 downto 0);
Sel : IN std_Logic
);
end component ;

component Sub is 

Port (
Input: IN std_logic_vector (31 downto 0);
x: IN std_logic_vector(1 downto 0);
Output: Out std_logic_vector (31 downto 0)
);
end component;

   -- SIGNALS

-- ALU
signal aluOp1, aluOp2, aluRes:    std_logic_vector (31 downto 0) := x"0000_0000";
signal aluOpCodeIn :std_logic_vector (3 downto 0)  :=  "0000";
signal aluCout, aluNout, aluZout: std_logic := '0';
signal DataMem :std_logic_vector (31 downto 0) := x"0000_0000";

-- CCR
signal status, ccrOut: std_logic_vector (2 downto 0) := "000";

-- Control Op
signal ctrlALUop: std_logic_vector (4 downto 0) := "00000";

-- Register file 
signal WriteReg: std_logic_vector(2 downto 0);
signal Reg1 : std_logic_vector(31 downto 0);
signal Reg2 : std_logic_vector(31 downto 0);
signal reset : std_logic_vector (7 downto 0 );
signal WriteDataReg: std_logic_vector(31 downto 0);
    -- COMPONENTS
-- PC signals
signal PcStart : std_logic_vector(31 downto 0) := (OTHERS=>'0'); -- initialization
signal PcOut :std_logic_vector(31 downto 0) := (OTHERS=>'0');
signal PcCall: std_logic_vector (31 downto 0) := (OTHERS=>'0');
signal newPC: std_logic_vector(31 downto 0);
signal B1Res: std_logic;
signal AddPC: std_logic_vector (2 downto 0);

--Instruction memory signal
signal Instruction : std_logic_vector(31 downto 0); 
signal extended : std_logic_vector(31 downto 0);

-- Control Unit 
signal controls : std_logic_vector(21 downto 0);

-- Jump 
 signal DecodedJump : std_logic_vector(3 downto 0);
 signal jumpFlags : std_logic_vector(2 downto 0);
 signal jumpRes : std_logic;
 signal branch: std_logic;
 signal branchAdd: std_logic_vector(31 downto 0);

-- SP 
signal SPstart : std_logic_vector(31 downto 0); --:= x"00000007";
signal SPout : std_logic_vector(31 downto 0);-- := x"000FFFFE";
signal Add2 : std_logic_vector(31 downto 0);
signal Sub2 : std_logic_vector(31 downto 0);
signal Stack_TOP : std_logic_vector(31 downto 0);

--Memory 
signal MemAdd : std_logic_vector(31 downto 0) :=x"00000001";
signal MemDataOut : std_logic_vector(31 downto 0);
signal MemDataOut2 : std_logic_vector(31 downto 0);
signal WriteBack : std_logic_vector(31 downto 0);

constant rstSP : std_logic_vector(31 downto 0):= x"00000007";
signal rstPC : std_logic_vector(31 downto 0):= x"00000000";
signal Notclk: std_logic;

---Buffers signals
signal  FetchIn: std_logic_vector(95 downto 0);
signal  FetchRes: std_logic_vector(95 downto 0);
signal  DecodeIn: std_logic_vector(227 downto 0);
signal  DecodeRes: std_logic_vector(227 downto 0);
signal  ExecuteIn: std_logic_vector(189 downto 0);
signal  ExecuteRes: std_logic_vector(189 downto 0);
signal  WBIn: std_logic_vector(157 downto 0);
signal  WBRes: std_logic_vector(157 downto 0);


begin
Notclk <= not (clk);
    -- INSTANTIATIONS
  
    
    Add2PC : Adder2 port map (PcOut, AddPC( 1 downto 0),newPC);
    MuxPcAdd: Mux2_3bits port map ("001" , "010" , B1Res ,AddPC);
    Block1: B1 port map (Instruction(31 downto 27),B1Res);
    Pc: my_nDFF generic map(32) port map( clk , rst , '1',PcStart,PcOut,rstPC );
    InstructMem: InstructionMem port map (clk, '1' , rst , PcOut  ,Instruction);
    Add1: Adder2 port map (PcOut,"01",pcCall);
   
------- Fetch Unit-------
  --  FetchIn <= newPC & Instruction & pcCall;
 --   Fetch: my_nDFF generic map(32) port map( Notclk , rst , '1',newPC,FetchRes(95 downto 64),x"00000000");
    Fetch1: my_nDFF generic map(32) port map( Notclk , rst , '1',Instruction,FetchRes ( 63 downto 32),x"00000000");
    Fetch2: my_nDFF generic map(32) port map( Notclk , rst , '1',pcCall,FetchRes ( 31 downto 0),x"00000000");


    CU:  ControlUnit  port map (FetchRes(63 downto 59), controls);
    MuxWriteDest: Mux2_3bits port map(DecodeRes(227 downto 225), DecodeRes(224 downto 222),DecodeRes(136),WriteReg);------------should be in execute stage
    RegisterFile: Regs_file port map(WBRes ( 135 downto 133),FetchRes(58 downto 56), FetchRes(55 downto 53),WBRes(137),Reg1,Reg2, WriteDataReg,clk,reset);      
------- Decode Unit-------
    DecodeIn <= FetchRes(58 downto 56)&FetchRes(55 downto 53)& inP & FetchRes(95 downto 64) & controls & Reg1 & Reg2 &FetchRes ( 31 downto 0)& extended & FetchRes(52 downto 48) & WriteReg;
    Decode: my_nDFF generic map(228) port map (Notclk , rst , '1',DecodeIn,DecodeRes, (others => '0'));

    MuxAluOp1: Mux4 port map (DecodeRes(135 downto 104),DecodeRes ( 39 downto 8),DecodeRes(221 downto 190),DecodeRes(135 downto 104),DecodeRes(153 downto 152),aluOp1);
    MuxAluOp2 : Mux2 port map (DecodeRes(103 downto 72) ,DecodeRes ( 39 downto 8), DecodeRes(151 ),aluOp2);
    MuxWriteData: Mux2 port map (DecodeRes(135 downto 104),DecodeRes( 71 downto 40),DecodeRes(143),DataMem);
    alUnit: alu port map(aluOp1, aluOp2,DecodeRes(157 downto 154), DecodeRes(7 downto 3), aluRes, aluCout, aluNout, aluZout, clk, rst);
    
------Execute Unit-----
    ExecuteIn <= DecodeRes ( 189 downto 158) & DecodeRes ( 157 downto 136) & aluRes & status & DataMem & aluOp1 & WriteReg &x"00000000" & "00";
    Execute: my_nDFF generic map(190) port map (Notclk , rst , '1',ExecuteIn,ExecuteRes, (others => '0'));


    ccr: my_nDFF generic map (3) port map(clk, rst , '1',ExecuteRes ( 103 downto 101), ccrOut,"000");
    JumpDecode: decoder24 port map (ExecuteRes(149 downto 148),DecodedJump);
    BranchRes: Mux2 port map (newPC,ExecuteRes ( 68 downto 37),branch ,branchAdd);
    Ret: Mux2 port map (branchAdd,WriteBack , WBRes(142),PcStart);--------------
   

    
    SP: my_nDFF generic map(32) port map ( Notclk,rst,'1',SPstart, SPout,rstSP); 
    SPadd: Adder2 port map (SPout , "10" , Add2);
    SPsub: Sub port map (SPout, "10" , Sub2);
    StackMux: Mux4 port map (SPout,Add2,Sub2,SPout,ExecuteRes(140 downto 139),SPstart); 

--- Memory Unit and Write back
    WBIn <= ExecuteRes ( 157 downto 136) & ExecuteRes ( 36 downto 34) & ExecuteRes ( 135 downto 104) & MemDataOut& Stack_TOP & x"000000000" & '0';
    WB: my_nDFF generic map(158) port map( Notclk , rst , '1',WBIn,WBRes,(others => '0'));


    MemAddress: Mux4 port map (WBRes ( 132 downto 101),ExecuteRes ( 135 downto 104),SPout,Add2, ExecuteRes(147 downto 146),MemAdd);
    memory: RAM port map(MemAdd(19 downto 0),ExecuteRes ( 100 downto 69), ExecuteRes(144 ), clk,'0',MemDataOut,rstPC,ExecuteRes(140 downto 139),Stack_TOP);--------------memory address changes
    StackTop: Mux2 port map (WBRes ( 100 downto 69),WBRes (68 downto 37),WBRes(139),MemDataOut2);
    WriteBackMux: Mux2 port map (MemDataOut2,ExecuteRes ( 135 downto 104),WBRes(141 ),WriteBack);
    OutSelect: Selector port map (WriteBack,WriteDataReg,outP,WBRes(138 ) );


    -- CCR CONFIGURATION
    status <= aluNout &  aluCout & aluZout;	
    extended <= x"0000" & FetchRes(52 downto 37);    -- zero extend
    reset <= rst & rst & rst & rst & rst & rst & rst & rst;  --- reset of register file 
    jumpFlags(0 downto 0) <= DecodedJump(1 downto 1 ) and ccrOut(0 downto 0); ------ JZ result
    jumpFlags(1 downto 1) <= DecodedJump(2 downto 2 ) and ccrOut(1 downto 1); ------ JC result
    jumpFlags(2 downto 2) <= DecodedJump(3 downto 3 ) and ccrOut(2 downto 2); ------ JN result
    jumpRes <= jumpFlags(2) or jumpFlags(1 ) or jumpFlags(0 ) or DecodedJump(0  ) ;
    branch <= jumpRes and ExecuteRes(150);

end architecture;