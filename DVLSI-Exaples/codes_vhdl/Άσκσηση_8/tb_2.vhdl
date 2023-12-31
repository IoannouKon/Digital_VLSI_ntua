library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_tb is
--  Port ( );
end fsm_tb;

architecture Behavioral of fsm_tb is

component  fsm is
  Port ( 
      clk: in std_logic;
      input: in STD_logic;
      reset: in std_logic;
      output: out std_logic_vector(1 downto 0)
      );
end component fsm;

signal clk: std_logic;
signal inp: STD_logic;
signal rst: std_logic;
signal outp:std_logic_vector(1 downto 0);

begin

UUT: fsm port map(
        clk=>clk,
        reset=>rst,
        input=>inp,
        output=>outp
    );

clk_sim: process
begin
    clk<='0';
    wait for 5 ns;
    clk<='1';
    wait for 5 ns;
end process;

stim: process
begin
    rst<='1';
    wait for 10 ns;
    rst<='0';
    inp<='0';
    wait for 20 ns;
    inp<='1';
    wait for 10 ns;
    inp<='0';
    wait for 10 ns;
    inp<='0';
    wait for 10 ns;
    inp<='1';
    wait for 10 ns;
    inp<='0';
    wait for 10 ns;
    inp<='1';
    wait for 10 ns;
    inp<='1';
    wait for 10 ns;
    wait;    
    


end process;

end Behavioral;
