Library ieee;
use ieee.std_logic_1164.all;

entity Regs_file is 
port (
waddr: IN std_logic_vector (2 downto 0);
raddr: IN std_logic_vector (2 downto 0);

WEn : In std_logic;
REn : In std_logic;
Data : INOUT std_logic_vector (31 downto 0);
clk : IN std_logic;
rst : IN std_logic_vector (7 downto 0)
);
end entity ;

Architecture Regs_struct of Regs_file is 


component decoder is 
Port (
s : IN std_logic_vector (2 downto 0);
L: Out std_logic_vector (7 downto 0);
Enable : IN std_logic
);
end component;

component my_nDFF IS
GENERIC ( n : integer := 32);
PORT( Clk,Rst ,ENBL : IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0));
END component;

component tri_state_buffer is
GENERIC ( n : integer := 32); 
Port (
A : IN std_logic_vector (n-1 downto 0);
B: Out std_logic_vector (n-1 downto 0);
EN : IN std_logic
);
end component;

signal Sdecod : std_logic_vector (7 downto 0);
signal Ddecode : std_logic_vector (7 downto 0);
signal regester0:  std_logic_vector (31 downto 0);
signal regester1:  std_logic_vector (31 downto 0);
signal regester2:  std_logic_vector (31 downto 0);
signal regester3:  std_logic_vector (31 downto 0);
signal regester4:  std_logic_vector (31 downto 0);
signal regester5:  std_logic_vector (31 downto 0);
signal regester6:  std_logic_vector (31 downto 0);
signal regester7:  std_logic_vector (31 downto 0);

begin 

reg0 : my_nDFF port map (clk,rst(0), Sdecod(0), Data, regester0);
reg1 : my_nDFF port map (clk,rst(1), Sdecod(1), Data, regester1);
reg2 : my_nDFF port map (clk,rst(2), Sdecod(2), Data, regester2);
reg3 : my_nDFF port map (clk,rst(3), Sdecod(3), Data, regester3);
reg4 : my_nDFF port map (clk,rst(4), Sdecod(4), Data, regester4);
reg5 : my_nDFF port map (clk,rst(5), Sdecod(5), Data, regester5);
reg6 : my_nDFF port map (clk,rst(6), Sdecod(6), Data, regester6);
reg7 : my_nDFF port map (clk,rst(7), Sdecod(7), Data, regester7);

Sdecoder: decoder port map (waddr, Sdecod, WEn);
Ddecoder: decoder port map (raddr, Ddecode, REn);

B0: tri_state_buffer port map (regester0, Data, Ddecode(0));
B1: tri_state_buffer port map (regester1, Data, Ddecode(1));
B2: tri_state_buffer port map (regester2, Data, Ddecode(2));
B3: tri_state_buffer port map (regester3, Data, Ddecode(3));
B4: tri_state_buffer port map (regester4, Data, Ddecode(4));
B5: tri_state_buffer port map (regester5, Data, Ddecode(5));
B6: tri_state_buffer port map (regester6, Data, Ddecode(6));
B7: tri_state_buffer port map (regester7, Data, Ddecode(7));

end Architecture ;
