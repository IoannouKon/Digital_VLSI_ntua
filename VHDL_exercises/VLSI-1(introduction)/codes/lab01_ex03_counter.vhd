library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity lab01_ex03_counter is
    Port ( clk : in STD_LOGIC;
           count_en : in STD_LOGIC;
           resetn : in STD_LOGIC;
           cout : out STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (2 downto 0));
end lab01_ex03_counter;

architecture Behavioral of lab01_ex03_counter is
signal count: std_logic_vector(2 downto 0);
begin
    process(clk, resetn)
    begin
        if resetn='0' then
            count <= (others=>'0'); -- Code for reset
        elsif clk'event and clk='1' then --clock rising edge
            if count_en='1' then  -- Count up when count_en=1 
                count<=count+1;
            end if;
        end if;
    end process;
    sum <= count; -- Output signals
    cout <= '1' when count=7 and count_en='1' else '0';
end Behavioral;
