-- SHIFT REGISTER
-- AMER
-- 5/27

library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;

entity shReg is
    generic(  n:     integer := 8);
    port(
            clk: IN  std_logic := '0';
            rst: IN  std_logic := '0';
          shDir: IN  std_logic := '0';   -- Shift direction
--       shBit: OUT std_logic := '0';   -- Discarded bit after shifting (goes to CCR CARRY)
          shAmt: IN  std_logic_vector (4   downto 0) := ("00000");
         dataIN: IN  std_logic_vector (n-1 downto 0) := (others => '0');
        dataOut: OUT std_logic_vector (n-1 downto 0) := (others => '0')
    );
end entity;

architecture behav of shReg is 
    signal zeros: std_logic_vector (n-1 downto 0) := (others => '0');
    begin
       
  --      process(clk, rst)
       --     begin
              --  if    (rst = '1')    then
                   -- shBit   <= '0';
               --     dataOut <= (others => '0');                
           --     elsif(shAmt = "00000") then
            --        dataOut <= dataIN;
           --         
         --       elsif (shDir = '1') then -- 1 --> SHIFT RIGHT
           --         dataOut <=  zeros(to_integer(unsigned(shAmt) - 1) downto 0) & dataIN(n-1 downto to_integer(unsigned(shAmt)));
           --         shBit   <= dataIN(to_integer(unsigned(shAmt) - 1));
                
         --       else -- SHIFT LEFT <--
         --           dataOut <= dataIN(to_integer(n - 1 - unsigned(shAmt)) downto 0) & zeros(to_integer(unsigned(shAmt) - 1) downto 0);
               --     shBit   <= dataIN(to_integer(n -unsigned(shAmt)));

         --       end if;
        --    end process;
process ( clk, rst) 
begin
if  (rst = '1')  then
dataOut <= (others => '0');  
elsif (shAmt = "00000") then 
dataOut <= dataIN;
elsif  (shDir = '1') then 
dataOut <= zeros(to_integer(unsigned(shAmt) - 1) downto 0) & dataIN(n-1 downto to_integer(unsigned(shAmt))) ;
else 
dataOut <= dataIN(to_integer(n - 1 - unsigned(shAmt)) downto 0) & zeros(to_integer(unsigned(shAmt) - 1) downto 0);
end if;
end process;
end architecture;