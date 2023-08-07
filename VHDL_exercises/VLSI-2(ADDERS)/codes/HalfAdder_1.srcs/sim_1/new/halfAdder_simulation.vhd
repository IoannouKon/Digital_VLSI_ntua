library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity haldAdder_tb is 
end entity;

architecture testbench of haldAdder_tb is
signal A,B,sum,carry : std_logic;
begin
 dut: entity work.haldAdder 
  port map(
      A => A ,
      B => B,
      carry => carry,
      sum => sum
      );
      
     stimulus: process
      begin
          A <= '0';
          B <= '0' ;
          wait for 10 ns;
          
           A <= '0';
           B <= '1';
          wait for 10 ns;
          
          A <= '1';
          B <= '0';
          wait for 10 ns;
          
          A <= '1';
          B <= '1';
          wait for 10 ns;
                
    
      end process;
      
  end architecture;
