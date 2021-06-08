LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity PC is
port(	Branch,clk,Is16Bit  : IN std_logic;
	BranchAddress : IN std_logic_vector(31 downto 0);
	PcAddress : OUT std_Logic_vector(31 downto 0));
end entity;

ARCHITECTURE arch_PC OF PC IS
Component dff is
	GENERIC ( n : integer := 32);
	PORT( 	Clk,Rst, ENBL : IN std_logic;
		d : IN std_logic_vector(n-1 DOWNTO 0);
		q : OUT std_logic_vector(n-1 DOWNTO 0));
end Component;

signal DataIn : std_logic_vector(31 downto 0) := (OTHERS=>'0');

begin

Process(clk)
begin
if rising_edge(clk) then
	if (Branch ='1') then
	DataIn <= BranchAddress;
	Elsif Is16Bit ='1' then
	DataIn <= std_logic_vector(unsigned(DataIn) + 1);
	Elsif Is16Bit ='0' then
	DataIn <= std_logic_vector(unsigned(DataIn) + 2);
	end if;
end if;
end process;


PcReg: dff port map(clk ,'0' , '1' ,DataIn,PcAddress);
end architecture;