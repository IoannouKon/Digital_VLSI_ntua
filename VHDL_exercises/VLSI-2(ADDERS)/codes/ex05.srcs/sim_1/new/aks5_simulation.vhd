library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity lab02_ex05_tb is
end lab02_ex05_tb;


architecture Testbench of lab02_ex05_tb is
signal Cin5: std_logic := '0';
signal X5: std_logic_vector(15 downto 0) := "0000000000000000";
signal Y5: std_logic_vector(15 downto 0) := "0000000000000000";
signal Sum5: std_logic_vector(15 downto 0);
signal Carry5: std_logic;

begin
dut: entity work.lab02_ex05
    port map(
    X5 => X5,
    Y5 => Y5,
    Cin5 => Cin5,
    Carry5 => Carry5,
    Sum5 => Sum5
    );
    stimulus: process
        begin
            Cin5<= '0';
            for i in 0 to 31 loop
                X5 <= std_logic_vector(to_unsigned(5*i, 16));
                for j in 0 to 31 loop
                    Y5 <= std_logic_vector(to_unsigned(5*j+1, 16));
                    wait for 5ns;
                 end loop;
           end loop; 
           
           Cin5<= '1';
           for i in 0 to 31 loop
               X5 <= std_logic_vector(to_unsigned(5*i, 16));
               for j in 0 to 31 loop
                   Y5 <= std_logic_vector(to_unsigned(5*j+1, 16));
                   wait for 5ns;
                end loop;
          end loop; 
   end process; 
end Testbench;
