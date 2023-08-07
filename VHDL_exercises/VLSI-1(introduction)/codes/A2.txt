-- Engineer: 
-- 
-- Create Date: 12.03.2023 18:34:34
-- Design Name: 
-- Module Name: test_1 - dataflow
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_8 is
port(
 enc : in std_logic_vector(2 downto 0); -- input
 dec : out std_logic_vector(7 downto 0) -- ouput
);
end entity;


architecture dataflow_arch of decoder_8 is
begin

dec(0) <= not enc(0) and not enc(1) and not enc(2);
dec(1) <=  enc(0) and not enc(1) and not (enc(2));
dec(2) <= not enc(0) and  enc(1) and not enc(2);
dec(3) <=  enc(0) and  enc(1) and not enc(2);
dec(4) <= not enc(0) and not enc(1) and  enc(2);
dec(5) <= enc(0) and not enc(1) and  enc(2);
dec(6) <= not enc(0) and  enc(1) and   enc(2);
dec(7) <= enc(0) and  enc(1) and  enc(2);

end architecture;



architecture Behavioral_arch of decoder_8 is
begin

process(enc) 
 begin 
 
 case enc is
 
   when  "000" => 
   dec <= "00000001";

   when  "001" => 
   dec <= "00000010";
    
   when  "010" => 
   dec <= "00000100";
  
   when  "011" => 
   dec <= "00001000";
  
   when  "100" => 
   dec <= "00010000";
   
   when  "101" => 
   dec <= "00100000";
    
   when  "110" => 
   dec <= "01000000";
     
   when  "111" => 
   dec <= "10000000";
   
   when others => 
   dec <= (others => '-');
   
   end case;
  end process; 
 
end Behavioral_arch ;



