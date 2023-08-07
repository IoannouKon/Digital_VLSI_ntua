library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity bit4_Adder_tb is 
end entity;
-- A0A1A2A3 + B0B1B2B3 
architecture testbench of bit4_Adder_tb is

signal Cin: std_logic ;
signal As: std_logic_vector(3 downto 0) := "0000";
signal Bs: std_logic_vector(3 downto 0) := "0000";
signal s: std_logic_vector(3 downto 0);
signal cout: std_logic;

begin
dut: entity work.bit4_Adder 
  port map(
      As => As ,
      Bs => Bs,
      Cin =>Cin,
      cout => cout,
      s => s
      );
  stimulus: process
        begin 
        
       Cin<= '0';
            for i in 0 to 15 loop
                As <= std_logic_vector(to_unsigned(i, 4));
                for j in 0 to 15 loop
                    Bs <= std_logic_vector(to_unsigned(j, 4));
                    wait for 5ns;
                 end loop;
           end loop; 
        
           
           Cin<= '1';
           for i in 0 to 15 loop
               As <= std_logic_vector(to_unsigned(i, 4));
               for j in 0 to 15 loop
                   Bs <= std_logic_vector(to_unsigned(j, 4));
                   wait for 5ns;
                end loop;
          end loop; 
   end process; 
end architecture;
