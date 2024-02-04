library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity fsm is
  Port (
    clk : in std_logic;
    reset : in std_logic;
    input : in std_logic;
    output : out std_logic_vector(1 downto 0) := (others => '0')
  );
end fsm;

architecture Behavioral of fsm is
    signal pr_state ,nx_state: std_logic_vector(1 downto 0):= (others => '0');  
  --  signal output_sig : std_logic_vector(1 downto 0) := (others => '0');  
begin
 -- output <=pr_state;
    process(clk, reset)
    begin
        if reset = '1' then
            nx_state <= (others => '0');
        elsif rising_edge(clk) then 
            case pr_state is
                when "00" =>
                    if input = '1' then
                       nx_state <= "01";
                        output <="01";
                    end if;
                when "01" =>
                    if input = '0' then
                        nx_state <= "10";
                        output <="10";
                    else
                       nx_state <= "11";
                        output <="11";
                    end if;
                when "10" =>
                    if input = '0' then
                        nx_state <= pr_state;
                        output <= pr_state;
                    else
                        nx_state <= "11";
                         output <= "11";
                    end if;
                when "11" =>
                    if input = '0' then
                        nx_state <= "01";
                        output <= "01";
                    else
                        nx_state <= "00";
                         output <= "00";
                    end if;
                when others =>
                    nx_state <= "00";
                     output <= "00";
            end case;
        end if;
         pr_state <= nx_state;
    end process;
end Behavioral;


