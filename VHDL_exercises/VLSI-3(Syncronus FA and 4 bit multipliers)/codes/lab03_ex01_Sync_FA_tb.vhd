library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fa_clk_tb is
end entity;

architecture Testbench of fa_clk_tb is

  component fa_clk is
    port (
        a: in std_logic;
        b: in std_logic;
        cin: in std_logic;
        sout: out std_logic;
        rst : in std_logic;
        cout: out std_logic;
        clk: in std_logic
        );
  end component;

  signal a: std_logic;
  signal b: std_logic;
  signal cin: std_logic;
  signal rst : std_logic;
  signal sout: std_logic;
  signal cout: std_logic;
  signal clk: std_logic;
    

begin

   mapping : fa_clk
    port map (
              a => a,
              b => b,
              cin => cin,
              sout => sout,
              rst => rst,
              cout => cout,
              clk => clk
             );

  stimulus : process
  begin
  
  -- check disabled --
  
  rst <= '0';
  a <= '0';
  b <= '0';
  cin <= '0';
  rst <= '1';
  
  for i in 0 to 16 loop
    for i in std_logic range '0' to '1' loop
       a <= i;
        for j in std_logic range '0' to '1' loop
            b <= j;
            for k in std_logic range '0' to '1' loop
                cin <= k;
                wait for 10ns;
            end loop;
        end loop;
    end loop;
    end loop;
    wait;
  end process;
  
  generate_clock : process
   begin
     clk <= '1';
     wait for 5ns;
     clk <= '0';
     wait for 5ns;
   end process;
  
end architecture;
