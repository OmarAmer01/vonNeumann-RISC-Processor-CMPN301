-- SHIFT REGISTER
-- AMER
-- 5/27

library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;

entity shReg is
    generic(  n:     integer := 32);
    port(
            clk: IN  std_logic := '0';
            rst: IN  std_logic := '0';
         shfDir: IN  std_logic := '0';   -- Shift direction
          shBit: OUT std_logic := '0';   -- Discarded bit after shifting (goes to CCR CARRY)
         shfAmt: IN  std_logic_vector (4   downto 0) := ("00000");
         dataIN: IN  std_logic_vector (n-1 downto 0) := (others => '0');
        dataOut: OUT std_logic_vector (n-1 downto 0) := (others => '0')
    );
end entity;

architecture behav of shReg is 
    begin
        process(clk, rst)
            begin
                if       (rst = '1')     then
                    shBit   <= '0';
                    dataOut <= (others => '0');                

                elsif    (shfDir = '1')  then -- 1 --> SHIFT RIGHT
                    dataOut <= '0' & dataIN (n-1 downto to_integer(unsigned(shfAmt)));
                    shBit   <= dataIN (to_integer(unsigned(shfAmt) + 1));
                    
                else                          -- 0 --> SHIFT LEFT
                    dataOut <= dataIN (n-2 downto 0) & '0';
                    shBit   <= dataIN (n-1);

                end if;
            end process;
    end architecture;