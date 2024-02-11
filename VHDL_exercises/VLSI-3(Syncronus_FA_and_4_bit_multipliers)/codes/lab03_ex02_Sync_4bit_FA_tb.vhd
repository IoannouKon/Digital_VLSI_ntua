library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fa_pipe_tb is
end entity;

architecture bench of fa_pipe_tb is

  component fa_pipe is
    port (
        a : in  std_logic_vector(3 downto 0);
        b : in  std_logic_vector(3 downto 0);
        cin : in  std_logic;
        clk : in std_logic;
        rst : in std_logic;
        s : out std_logic_vector(3 downto 0);
        cout : out std_logic
        );
  end component;

  signal a: std_logic_vector(3 downto 0) := (others => '0');
  signal b: std_logic_vector(3 downto 0) := (others => '0');
  signal cin: std_logic;
  signal rst : std_logic;
  signal s: std_logic_vector(3 downto 0);
  signal cout: std_logic;
  signal clk: std_logic;

begin
   mapping : fa_pipe
    port map (
              a => a,
              b => b,
              cin => cin,
              s => s,
              rst => rst,
              cout => cout,
              clk => clk
             );

  stimulus : process
  begin
  rst <= '0';
  a <= "0000";
  b <= "0000";
  cin <= '0';
  wait for 10ns;
  rst <= '1';  
  
    for k in std_logic range '0' to '1' loop
        cin <= k;
        for i in 0 to 15 loop
           a <= std_logic_vector(to_unsigned(i, 4));
            for j in 0 to 15 loop
                b <= std_logic_vector(to_unsigned(j, 4));
                    wait for 10ns;
                end loop;
            end loop;
    end loop;
    cin <= '0';
    a <= "0000";
    b <= "0000";
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

