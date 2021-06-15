-- SHIFT REGISTER TESTBENCH
-- AMER
-- 5/27
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shRegTb is 
end entity;

architecture tb of shRegTB is
    component shReg is
        generic(  n:     integer := 32);
        port(
                clk: IN  std_logic := '0';
                rst: IN  std_logic := '0';
              shDir: IN  std_logic := '0';   -- Shift direction
              shBit: OUT std_logic := '0';   -- Discarded bit after shifting (goes to CCR CARRY)
              shAmt: IN  std_logic_vector (4   downto 0) := ("00000");
             dataIN: IN  std_logic_vector (n-1 downto 0) := (others => '0');
            dataOut: OUT std_logic_vector (n-1 downto 0) := (others => '0')
        );
    end component;

    signal clk, rst, shDir, shBit: std_logic := '0';
    signal shAmt: std_logic_vector (4 downto 0) := (others => '0');





    signal dataIN:  std_logic_vector (31 downto 0)  := x"00000000";
    signal dataOut: std_logic_vector (31 downto 0)  := x"00000000";
    signal       q: std_logic_vector (4 downto 0) := (others => '0');

   
    begin
       uut: shReg port map(clk => clk, rst => rst, shDir => shDir, shBit => shBit, shAmt => shAmt, dataIN => dataIN, dataOut => dataOut);
       
        --clk <= not clk after 50 ps ;
        process
            begin
                clk <= not clk after 50 ps; -- ;
                dataIN <= x"ABCDABCD";
    
                --shDir <= not shDir after 50 ps;
                

                if(unsigned(q) = 31) then
                    q <= "00000";
                    shDir <= '1';
                    shAmt <= "00000";
                    Report "SWITCH DIR" severity note;
                end if;
                
                q <= std_logic_vector(unsigned(q) + 1);
                shAmt <= q;
                wait for 100 ps;
                Report "LOOP" severity note;
               -- q <= std_logic_vector(unsigned(q) + 1);

                --shAmt <= std_logic_vector(unsigned(q) + 1);
                
            end process;
   
end architecture;