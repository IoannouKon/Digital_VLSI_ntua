library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity parking_tb is
end parking_tb;

architecture Behavioral of parking_tb is

  -- Component Declaration
  component parking is
    Port (
      clk : in std_logic;
      reset : in std_logic;
      AB : in std_logic_vector(1 downto 0);
      cars : out std_logic_vector(15 downto 0)
    );
  end component;

  -- Signals
  signal clk_tb : std_logic := '0';
  signal reset_tb : std_logic := '0';
  signal AB_tb : std_logic_vector(1 downto 0) := "00";
  signal cars_tb : std_logic_vector(15 downto 0);

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: parking
    port map (
      clk => clk_tb,
      reset => reset_tb,
      AB => AB_tb,
      cars => cars_tb
    );

  -- Clock Process
  clk_process: process
  begin
    while now < 500 ns loop  -- Adjust the simulation time as needed
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
      wait for 5 ns;
    end loop;
    wait;
  end process;

  -- Stimulus Process
  stimulus: process
  begin
    -- Test case 1 CAR IN 
    reset_tb <= '0';
    AB_tb <= "11";
    wait for 10 ns;
    AB_tb <= "01";
    wait for 10 ns;
    AB_tb <= "00";
    wait for 10 ns;
    AB_tb <= "10";
    wait for 10 ns;
    AB_tb <= "11";
    wait for 10 ns;

    -- Random test cases  
    AB_tb <= "01";
    wait for 10 ns;
    AB_tb <= "10";
    wait for 10 ns;
    AB_tb <= "00";
    wait for 10 ns;
   
   
    -- Test case 1 CAR out
       
       AB_tb <= "11";
       wait for 10 ns;
       AB_tb <= "10";
       wait for 10 ns;
       AB_tb <= "00";
       wait for 10 ns;
       AB_tb <= "01";
       wait for 10 ns;
       AB_tb <= "11";
       wait for 10 ns;


    wait;
  end process;

end Behavioral;
