library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity parking is
  Port (
    clk : in std_logic;
    reset : in std_logic;
    AB : in std_logic_vector(1 downto 0);
    cars : out std_logic_vector(15 downto 0)
  );
end parking;

architecture Behavioral of parking is
    signal counter : std_logic_vector(15 downto 0) := (others => '0');
    signal state : std_logic_vector(2 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
            state <= (others => '0');
        elsif rising_edge(clk) then 
            case state is
                when "000" =>
                    if AB = "01" then
                        state <= "001";
                    elsif AB = "10" then
                        state <= "100";
                    end if;
                when "001" =>
                    if AB = "00" then
                        state <= "010";
                    elsif AB = "01" then
                        state <= state;
                    else
                        state <= "000";
                    end if;
                when "010" =>
                    if AB = "10" then
                        state <= "011";
                    elsif AB = "00" then
                        state <= state;
                    else
                        state <= "000";
                    end if;
                when "011" =>
                    if AB = "11" then
                        state <= "000";
                        counter <= counter+1;
                    elsif AB = "10" then
                        state <= state;
                    else
                        state <= "000";
                    end if;
                when "100" =>
                    if AB = "00" then
                        state <= "101";
                    elsif AB = "10" then
                        state <= state;
                    else
                        state <= "000";
                    end if;
                when "101" =>
                    if AB = "01" then
                        state <= "110";
                    elsif AB = "00" then
                        state <= state;
                    else
                        state <= "000";
                    end if;
                when "110" =>
                    if AB = "11" then
                        state <= "000";
                        counter <= counter-1;
                    elsif AB = "01" then
                        state <= state;
                    else
                        state <= "000";
                    end if;
                when others =>
                    state <= "000";
            end case;
        end if;
 cars <= counter;
    end process;
end Behavioral;
