library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity up_down_counter_tb is
end up_down_counter_tb;

architecture Behavioral of up_down_counter_tb is
    -- Component declaration for the DUT (Design Under Test)
    component up_down_counter is
        Port (
            clk : in STD_LOGIC;
            enable : in STD_LOGIC;
            reset : in STD_LOGIC;
            updn : in STD_LOGIC;
            load : in STD_LOGIC;
            data_in : in STD_LOGIC_VECTOR(31 downto 0);
            data_out : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- Testbench signals
    signal clk_tb : STD_LOGIC := '0';
    signal enable_tb : STD_LOGIC := '1';
    signal reset_tb : STD_LOGIC := '0';
    signal updn_tb : STD_LOGIC := '0';
    signal load_tb : STD_LOGIC := '0';
    signal data_in_tb : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal data_out_tb : STD_LOGIC_VECTOR(31 downto 0);

    -- Clock process
    constant clk_period : time := 10 ns; -- Adjust according to your clock frequency

begin

    -- Instantiate the DUT
    dut : up_down_counter
        port map (
            clk => clk_tb,
            enable => enable_tb,
            reset => reset_tb,
            updn => updn_tb,
            load => load_tb,
            data_in => data_in_tb,
            data_out => data_out_tb
        );

    -- Clock generation process
    clk_process : process
    begin
        while now < 1000 ns loop -- Simulation duration
            clk_tb <= '0';
            wait for clk_period/2;
            clk_tb <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin
        -- Reset initialization
        reset_tb <= '1';
        wait for 12 ns;
        reset_tb <= '0';
        wait for 10 ns;
        
        -- Enable counter
        enable_tb <= '1';

        -- Load initial value
        load_tb <= '1';
        data_in_tb <= "00000000000000000000000000110011"; -- Example initial value
        wait for 20 ns;
        load_tb <= '0';

        -- Up/Down control
        updn_tb <= '0'; -- Count down
        wait for 20 ns;
        updn_tb <= '1'; -- Count up
        wait for 20 ns;
        updn_tb <= '0'; -- Count down
        wait for 20 ns;
        updn_tb <= '1'; -- Count up
        wait for 20 ns;
        
        load_tb <= '1';
        data_in_tb <= "11111111111111111111111111111100";
        wait for 10ns;
        
        load_tb <= '0';        
        updn_tb <= '1'; -- Count up
        wait for 20 ns;
-- Further test cases if needed

        wait;
    end process;

end Behavioral;
