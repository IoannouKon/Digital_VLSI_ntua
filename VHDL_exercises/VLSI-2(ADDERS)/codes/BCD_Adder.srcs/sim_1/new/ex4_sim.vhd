library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity lab02_ex04_tb is 
end entity;
-- A0A1A2A3 + B0B1B2B3 
architecture testbench of lab02_ex04_tb is

signal Cin: std_logic := '0';
signal X: std_logic_vector(3 downto 0) := "0000";
signal Y: std_logic_vector(3 downto 0) := "0000";
signal Sum: std_logic_vector(3 downto 0);
signal Carry: std_logic;

begin
dut: entity work.BCD_Adder
  port map(
      X => X ,
      Y => Y,
      Cin =>Cin,
      Carry => Carry,
      Sum => Sum
      );
  stimulus: process
        begin 
            Cin<= '0';
            for i in 0 to 9 loop
                X <= std_logic_vector(to_unsigned(i, 4));
                for j in 0 to 9 loop
                    Y <= std_logic_vector(to_unsigned(j, 4));
                    wait for 5ns;
                 end loop;
           end loop; 
           
           Cin<= '1';
           for i in 0 to 9 loop
               X <= std_logic_vector(to_unsigned(i, 4));
               for j in 0 to 9 loop
                   Y <= std_logic_vector(to_unsigned(j, 4));
                   wait for 5ns;
                end loop;
          end loop; 
   end process; 
end architecture;