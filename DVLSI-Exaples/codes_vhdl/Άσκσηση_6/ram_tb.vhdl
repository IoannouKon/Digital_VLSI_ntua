-- Testbench for RAM module

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ram is
end tb_ram;

architecture testbench of tb_ram is

  -- Component Declaration for the module under test
  component RAM
    Port (
      clk : in std_logic;
      CE : in std_logic;
      rw : in std_logic;
      data_in : in std_logic_vector(7 downto 0);
      addr : in std_logic_vector(11 downto 0);
      data_out : out std_logic_vector(7 downto 0)
    );
  end component;

  -- Signal declarations for testbench
  signal clk : std_logic := '0';
  signal CE : std_logic := '0';
  signal rw : std_logic := '0';
  signal data_in : std_logic_vector(7 downto 0) := (others => '0');
  signal addr : std_logic_vector(11 downto 0) := (others => '0');
  signal data_out : std_logic_vector(7 downto 0);

begin

  -- Instantiate the module
  uut: RAM
    Port Map (
      clk => clk,
      CE => CE,
      rw => rw,
      data_in => data_in,
      addr => addr,
      data_out => data_out
    );

  -- Clock process
  clk_process: process
  begin
    while now < 1000 ns loop  -- Set the desired simulation time
      clk <= '0';
      wait for 5 ns;  -- Adjust the clock period as needed
      clk <= '1';
      wait for 5 ns;  -- Adjust the clock period as needed
    end loop;
    wait;
  end process;


  stimulus_process: process
  begin
    -- Initialize inputs
    CE <= '0';
    rw <= '0';
    data_in <= (others => '0');
    addr <= (others => '0');

    -- Wait for some time before applying inputs
    wait for 12 ns;

 
    CE <= '1';
    rw <= '1';
    data_in <= "11001100";  -- Set desired input data
    addr <= "000000000000";  -- Set desired address
    wait for 10 ns;
    
    rw <= '1';
    data_in <= "11001101";  -- Set desired input data
    addr <= "000000000001";  -- Set desired address
    wait for 10 ns;
    
    rw <= '1';
    data_in <= "11001110";  -- Set desired input data
    addr <= "000000000010";  -- Set desired address
    wait for 10 ns;
    
    rw <= '1';
    data_in <= "11001111";  -- Set desired input data
    addr <= "000000000100";  -- Set desired address
    wait for 10 ns;
    
    
    CE <= '1';
    rw <= '0';
    addr <= "000000000000"; 
    wait for 10 ns;
    
    addr <= "000000000001"; 
    wait for 10 ns;
    
    addr <= "000000000010"; 
    wait for 10 ns;
    
    addr <= "000000000011";
    wait for 10 ns;
    
    addr <= "000000000100";  
    wait for 10 ns;

    wait;
  end process;

end testbench;
