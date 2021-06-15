
-- Generic Ram
-- OMAR TAREK AHMED MOHAMED ALY AMER
-- 1180004
-- SUNDAY LAB

library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

entity InstructionMem is 
    port(
           clk:  IN  std_logic ;
           wen:  IN  std_logic                       := '0';
           rst:  IN  std_logic                       := '0';
         add:  IN  std_logic_vector (31 downto 0) := (others => '0');
       dataOUT:  OUT std_logic_vector (31 downto 0) := (others => '0')
    );
end entity;


architecture inst of InstructionMem is
signal add2: std_logic_vector (19 downto 0);
    type ramType is array(0 to 1048576) of std_logic_vector(15 downto 0) ;
--signal ram : ramType := ((x"4000"), (x"D000"), - Call and Ret
   --          (x"2800"), (x"4000"), (x"2800"), 
 --            (x"2800"), (x"2800"), (x"2800"), 
  --           (x"D800"), (x"7020"), (x"7821"), 
  --             (x"8101"), (x"2100"), (x"3900"), 
    --          (x"1000"), (x"1800"));  

--signal ram : ramType := ((x"2800"), (x"2800"), ------ Stack Operations
     --            (x"8800"), (x"2800"), (x"8800"), 
    --             (x"2800"), (x"9200"), (x"9100"), 
    --             (x"8800"), (x"7020"), (x"7821"), 
      --           (x"8101"), (x"2100"), (x"3900"), 
     --            (x"1000"), (x"1800"));  


-- signal ram : ramType := ((x"9800"), (x"0060"), ---- Memory Operations
  --               (x"A100"), (x"0020"), (x"A800"), 
   --              (x"0020"), (x"7821"), (x"8101"), 
    --             (x"7821"), (x"7020"), (x"7821"), 
     --            (x"8101"), (x"2100"), (x"3900"), 
      --           (x"1000"), (x"1800"));  

    signal ram : ramType := ((x"4000"), (x"2800"), ---- ALU operations
                 (x"4820"), (x"3000"), (x"5020"), 
                 (x"5800"), (x"0040"), (x"6020"), 
                 (x"6820"), (x"7020"), (x"7821"), 
                 (x"8101"), (x"2100"), (x"3900"), 
                (x"1000"), (x"1800"), others => x"0000");   --// initialize 16 Values
    begin
add2 <= add(19 downto 0);
        process(clk) is
           begin
               if(rising_edge(clk)) then
		dataOUT(31 downto 16) <=  ram(to_integer(unsigned(add2)));
                dataOUT(15 downto 0) <=  ram(1+to_integer(unsigned(add2)));
            end if;
          end process;
       
    end architecture;