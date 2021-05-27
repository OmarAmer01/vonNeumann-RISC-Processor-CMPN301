-- REGISTER FILE
-- OMAR TAREK AHMED MOHAMED ALY AMER
-- 1180004
-- SUNDAY LAB



library IEEE;
use     IEEE.std_logic_1164.all;

entity topRegFile is
    port(data: INOUT std_logic_vector (31 downto 0);
        rAddr: IN    std_logic_vector (1  downto 0);
        wAddr: IN    std_logic_vector (1  downto 0);
          ren: IN    std_logic;
          clk: IN    std_logic;
          wen: IN    std_logic;
          rst: IN    std_logic);
    end entity;

architecture top of topRegFile is

    component dReg is
        generic (n:     integer := 8);
    
        port(    d: IN  std_logic_vector (n - 1 downto 0);
                en: IN  std_logic;
               rst: IN  std_logic;
               clk: IN  std_logic;
                 q: OUT std_logic_vector (n - 1 downto 0));
    
        end component;

    component x24dcd is

        port(en: IN  std_logic;
            sel: IN  std_logic_vector (1 downto 0);
         dcdOut: OUT std_logic_vector (3 downto 0));
        
            end component;

    component triB is

        generic (n: integer  := 8);
        port(x: IN  std_logic_vector (n-1 downto 0);
             y: OUT std_logic_vector (n-1 downto 0);
            en: IN  std_logic);

    end component;

    signal rrSel: std_logic_vector (3 downto 0) := "0000"; -- rrSel = register read  selector
    signal rwSel: std_logic_vector (3 downto 0) := "0000"; -- rwSel = register write selector

    signal r0out, r1out, r2out, r3out: std_logic_vector (31 downto 0) ;

    begin
        -- DECODERS
        dcdR:     x24dcd port map(ren, rAddr, rrSel);
        dcdW:     x24dcd port map(wen, wAddr, rwSel);

        -- TRI-STATE BUFFERS    
        r0triOut: triB generic map(32) port map(r0out, data, rrSel(0));
        r1triOut: triB generic map(32) port map(r1out, data, rrSel(1));
        r2triOut: triB generic map(32) port map(r2out, data, rrSel(2));
        r3triOut: triB generic map(32) port map(r3out, data, rrSel(3));

        -- REGISTERS
        r0:       dReg generic map(32) port map(data, rwSel(0), rst, clk, r0out);
        r1:       dReg generic map(32) port map(data, rwSel(1), rst, clk, r1out);
        r2:       dReg generic map(32) port map(data, rwSel(2), rst, clk, r2out);
        r3:       dReg generic map(32) port map(data, rwSel(3), rst, clk, r3out);

        
        

end architecture ; 