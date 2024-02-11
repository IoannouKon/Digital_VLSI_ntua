library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity multiplier_tb is
end multiplier_tb;

architecture behavioral of multiplier_tb is

    component multiplier is
        port (
            A, B : in  std_logic_vector(3 downto 0);
            clk,rst: in std_logic;
            P    : out std_logic_vector(7 downto 0)
        );
    end component;

    signal A, B : std_logic_vector(3 downto 0);
    signal clk, rst : std_logic;
    signal P : std_logic_vector(7 downto 0);

begin

    dut : multiplier
        port map (
            A => A,
            B => B,
            clk => clk,
            rst => rst,
            P => P
        );

    stimulus : process
    begin
      rst <= '0';
      A <= "0000";
      B <= "0000";
      wait for 10ns;
      rst <= '1'; 
      
   
           
      
      
  
              for i in 0 to 15 loop
                 A <= std_logic_vector(to_unsigned(i, 4));
                  for j in 0 to 15 loop
                      B <= std_logic_vector(to_unsigned(j, 4));
                          wait for 10ns;
                      end loop;
                  end loop;
          
         
          A <= "0000";
          B <= "0000";
          wait;
        end process;
        
        generate_clock : process
         begin
           clk <= '0';
           wait for 5ns;
           clk <= '1';
           wait for 5ns;
         end process;
      end architecture;
