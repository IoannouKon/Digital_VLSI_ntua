--DFFinput
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity dff_16 is
    Port ( d : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (15 downto 0));
end dff_16 ;

architecture Behavioral of dff_16  is

begin
    process(clk, rst) begin
        if rst='1' then
            Q<="0000000000000000";
        elsif rising_edge(clk) then
            Q<=D;
        end if;
    end process;
end Behavioral;


