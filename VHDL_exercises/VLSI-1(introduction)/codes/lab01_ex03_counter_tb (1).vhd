library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity lab01_ex03_counter_tb is
end lab01_ex03_counter_tb;

architecture Testbench of lab01_ex03_counter_tb is
    component lab01_ex03_counter is
        port ( clk : in STD_LOGIC;
               count_en : in STD_LOGIC;
               resetn : in STD_LOGIC;
               cout : out STD_LOGIC;
               sum : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    
    signal clk : STD_LOGIC := '0';
    signal count_en : STD_LOGIC := '0';
    signal resetn : STD_LOGIC := '0';
    signal cout : STD_LOGIC;
    signal sum : STD_LOGIC_VECTOR (2 downto 0); 
    
    constant CLOCK_PERIOD : time := 10 ns;   
            
begin
    test : lab01_ex03_counter
        port map ( clk => clk,
                   count_en => count_en, 
                   resetn => resetn,
                   cout => cout,
                   sum => sum
                   );
                   
     stimulus : process
     begin
        --dummy start counter
        count_en <= '1';
        resetn <= '1';
        clk <='0';
        for i in 0 to 4 loop
          clk <= not clk;
          wait for CLOCK_PERIOD;
        end loop;
        
        --test count_en = 0
        count_en <= '0';
        for i in 0 to 9 loop
          clk <= not clk;
          wait for CLOCK_PERIOD;
        end loop;
        
        count_en <= '1';
        --Test count up
        for i in 0 to 17 loop
           clk <= not clk;
           wait for CLOCK_PERIOD;
        end loop;
        
        resetn <= '0';
        --Test zero reset
        for i in 0 to 9 loop
           clk <= not clk;
           wait for CLOCK_PERIOD;
        end loop;
        wait;
     end process;
end Testbench;
