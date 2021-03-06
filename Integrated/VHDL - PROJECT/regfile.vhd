Library ieee;
use ieee.std_logic_1164.all;

entity Regs_file is 
port (
waddr: IN std_logic_vector (2 downto 0);

raddr1: IN std_logic_vector (2 downto 0);
raddr2: IN std_logic_vector (2 downto 0);

WEn : In std_logic;
--REn : In std_logic;
DataRead1 :OUT  std_logic_vector (31 downto 0);
DataRead2 : OUT std_logic_vector (31 downto 0);
DataWrite : IN std_logic_vector (31 downto 0);
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
q : OUT std_logic_vector(n-1 DOWNTO 0);
rstAmount : IN std_logic_vector(n-1 downto 0));
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

signal Ddecode1 : std_logic_vector (7 downto 0);
signal Ddecode2 : std_logic_vector (7 downto 0);
signal regester0:  std_logic_vector (31 downto 0);
signal regester1:  std_logic_vector (31 downto 0);
signal regester2:  std_logic_vector (31 downto 0);
signal regester3:  std_logic_vector (31 downto 0);
signal regester4:  std_logic_vector (31 downto 0);
signal regester5:  std_logic_vector (31 downto 0);
signal regester6:  std_logic_vector (31 downto 0);
signal regester7:  std_logic_vector (31 downto 0);

begin 

-- writing 
reg0 : my_nDFF port map (clk,rst(0), Sdecod(0), DataWrite, regester0, x"00000000");
reg1 : my_nDFF port map (clk,rst(1), Sdecod(1), DataWrite, regester1, x"00000000");
reg2 : my_nDFF port map (clk,rst(2), Sdecod(2), DataWrite, regester2, x"00000000");
reg3 : my_nDFF port map (clk,rst(3), Sdecod(3), DataWrite, regester3, x"00000000");
reg4 : my_nDFF port map (clk,rst(4), Sdecod(4), DataWrite, regester4, x"00000000");
reg5 : my_nDFF port map (clk,rst(5), Sdecod(5), DataWrite, regester5, x"00000000");
reg6 : my_nDFF port map (clk,rst(6), Sdecod(6), DataWrite, regester6, x"00000000");
reg7 : my_nDFF port map (clk,rst(7), Sdecod(7), DataWrite, regester7, x"00000000");

Sdecoder: decoder port map (waddr, Sdecod, WEn);

Ddecoder1: decoder port map (raddr1, Ddecode1, '1');
Ddecoder2: decoder port map (raddr2, Ddecode2, '1');

B0: tri_state_buffer port map (regester0, DataRead1, Ddecode1(0));
B1: tri_state_buffer port map (regester1, DataRead1, Ddecode1(1));
B2: tri_state_buffer port map (regester2, DataRead1, Ddecode1(2));
B3: tri_state_buffer port map (regester3, DataRead1, Ddecode1(3));
B4: tri_state_buffer port map (regester4, DataRead1, Ddecode1(4));
B5: tri_state_buffer port map (regester5, DataRead1, Ddecode1(5));
B6: tri_state_buffer port map (regester6, DataRead1, Ddecode1(6));
B7: tri_state_buffer port map (regester7, DataRead1, Ddecode1(7));


B8: tri_state_buffer port map (regester0, DataRead2, Ddecode2(0));
B9: tri_state_buffer port map (regester1, DataRead2, Ddecode2(1));
B10: tri_state_buffer port map (regester2, DataRead2, Ddecode2(2));
B11: tri_state_buffer port map (regester3, DataRead2, Ddecode2(3));
B12: tri_state_buffer port map (regester4, DataRead2, Ddecode2(4));
B13: tri_state_buffer port map (regester5, DataRead2, Ddecode2(5));
B14: tri_state_buffer port map (regester6, DataRead2, Ddecode2(6));
B15: tri_state_buffer port map (regester7, DataRead2, Ddecode2(7));

end Architecture ;
