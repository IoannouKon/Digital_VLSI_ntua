library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity FullAdder_tb is 
end entity;

architecture testbench of FullAdder_tb is
signal A,B,Cin,sum,carry : std_logic;
begin
 dut: entity work.FullAdder 
  port map(
      A => A ,
      B => B,
      Cin =>Cin,
      carry => carry,
      sum => sum
      );
      
     stimulus: process
      begin
          A <= '0';
          B <= '0' ;
          Cin <= '0';
          wait for 10 ns;
          
           A <= '0';
           B <= '0';
           Cin <= '1';
          wait for 10 ns;
          
          A <= '0';
          B <= '1';
          Cin <= '0';
          wait for 10 ns;
          
          A <= '0';
          B <= '1';
          Cin <= '1';
          wait for 10 ns;
          
           A <= '1';
                   B <= '0' ;
                   Cin <= '0';
                   wait for 10 ns;
                   
                    A <= '1';
                    B <= '0';
                    Cin <= '1';
                   wait for 10 ns;
                   
                   A <= '1';
                   B <= '1';
                   Cin <= '0';
                   wait for 10 ns;
                   
                   A <= '1';
                   B <= '1';
                   Cin <= '1';
                   wait for 10 ns;
                
    
      end process;
      
  end architecture;
