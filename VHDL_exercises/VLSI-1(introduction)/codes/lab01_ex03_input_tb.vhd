library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity lab01_ex03_input_tb is
end lab01_ex03_input_tb;

architecture Testbench of lab01_ex03_input_tb is
component lab01_ex03_input is
        port ( clk : in STD_LOGIC;
               count_en : in STD_LOGIC;
               resetn : in STD_LOGIC;
               parall : in STD_LOGIC_VECTOR(2 downto 0);
               cout : out STD_LOGIC;
               sum : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    
    signal clk : STD_LOGIC := '0';
    signal count_en : STD_LOGIC := '0';
    signal resetn : STD_LOGIC := '0';
    signal parall : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
    signal cout : STD_LOGIC;
    signal sum : STD_LOGIC_VECTOR (2 downto 0);
    constant CLOCK_PERIOD : time := 10 ns;
begin
test : lab01_ex03_input
        port map ( clk => clk,
                   count_en => count_en, 
                   resetn => resetn,
                   parall => parall,
                   cout => cout,
                   sum => sum
                   );
                   
     stimulus : process
     begin
        --Start dummy count
        count_en <= '1';
        resetn <= '1';
        parall <= "110";
        clk <='0';
        for i in 0 to 4 loop
          clk <= not clk;
          wait for CLOCK_PERIOD;
        end loop;
        
        --Test count_en = 0
        count_en <= '0';
        for i in 0 to 9 loop
          clk <= not clk;
          wait for CLOCK_PERIOD;
        end loop;
       
        count_en <= '1';
        --Test count up to 6 
        for i in 0 to 17 loop
           clk <= not clk;
           wait for CLOCK_PERIOD;
        end loop;
        
        resetn <= '0';
        --Test reset='0'
        for i in 0 to 9 loop
           clk <= not clk;
           wait for CLOCK_PERIOD;
        end loop;
        wait;
     end process;
end Testbench;
