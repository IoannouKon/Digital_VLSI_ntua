library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity decoder_8_tb is
end entity;

architecture testbench of decoder_8_tb is
    signal enc: std_logic_vector(2 downto 0);
    signal dec: std_logic_vector(7 downto 0);
begin
    dut: entity work.decoder_8
        port map (
            enc => enc,
            dec => dec
        );

    stimulus: process
    begin
        enc <= "000";
        wait for 10 ns;
        
        enc <= "001";
        wait for 10 ns;
        
        enc <= "010";
        wait for 10 ns;
        
        enc <= "011";
        wait for 10 ns;
        
        enc <= "100";
        wait for 10 ns;
        
        enc <= "101";
        wait for 10 ns;
        
        enc <= "110";
        wait for 10 ns;
        
        enc <= "111";
        wait for 10 ns;
        
        wait;
    end process;
    
end architecture;
