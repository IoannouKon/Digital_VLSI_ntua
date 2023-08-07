library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity FIR_tb is
end FIR_tb;

architecture Behavioral of FIR_tb is

    -- Constants
    constant CLK_PERIOD : time := 10 ns;
    constant CLK_PERIOD_ALL: time:=8*CLK_PERIOD;

    -- Signals
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal en_ram_rom : std_logic := '0';
    signal x : std_logic_vector(7 downto 0) := (others => '0');
    signal y_final : std_logic_vector(18 downto 0);
    signal rom_out, ram_out: std_logic_vector(7 downto 0);
    -- signal RAM_IN: std_logic_vector(7 downto 0);
    signal rom_add, ram_add, counter_control : std_logic_vector(2 downto 0);
    signal mac_init : std_logic;
    signal valid_out : std_logic;
    signal we_out : std_logic := '1';
    signal valid_in: std_logic := '0';

begin

    -- Instantiate the DUT
    DUT: entity work.FIR
    Port map (
        clk => clk,
        rst => rst,
        en_ram_rom => en_ram_rom,
        x => x,
        y_final => y_final,
        rom_out => rom_out,
        ram_out => ram_out,
        rom_add => rom_add,
        ram_add => ram_add,
        we_out => we_out,
        mac_init => mac_init,
        valid_in => valid_in,
        valid_out => valid_out,
        counter_control => counter_control
     -- RAM_IN => RAM_IN
    );

--     Clock Process
    clk_process : process
    begin
        while now < 10000 ns loop
            clk <= '0';
            wait for CLK_PERIOD/2;
            clk <= '1';
            wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process clk_process;

    -- validin Process
    validin_process : process
    begin
        while now < 10000 ns loop
            valid_in <= '1';
            wait for 1*CLK_PERIOD;
            valid_in <= '0';
            wait for 20*CLK_PERIOD;
        end loop;
    end process validin_process;
   

    -- Stimulus Process
    stim_process : process
        variable x_data : std_logic_vector(7 downto 0);
    begin
        rst <= '0';
        en_ram_rom <= '1';
        
        x_data := std_logic_vector(to_unsigned(167,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL ;
        x_data := std_logic_vector(to_unsigned(9,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(217,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(239,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL ;
        x_data := std_logic_vector(to_unsigned(173,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(193,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(190,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL ;
        x_data := std_logic_vector(to_unsigned(100,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(167,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(43,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL ;
        x_data := std_logic_vector(to_unsigned(180,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(8,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(70,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL ;
        x_data := std_logic_vector(to_unsigned(11,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(24,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(210,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL ;
        x_data := std_logic_vector(to_unsigned(177,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(81,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(243,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        x_data := std_logic_vector(to_unsigned(8,8));
        x <= x_data;
        wait for CLK_PERIOD_ALL;
        
--        va
--        x_data := std_logic_vector(to_unsigned(50,8));
--        x <= x_data;
--        wait for CLK_PERIOD_ALL;
--        x_data := std_logic_vector(to_unsigned(60,8));
--        x <= x_data;
--        wait for CLK_PERIOD_ALL;
--        x_data := std_logic_vector(to_unsigned(70,8));
--        x <= x_data;
--        wait for CLK_PERIOD_ALL;

                        
                

--        for i in 1 to 10 loop  -- Generate 10 test cases
--            x_data := std_logic_vector(to_unsigned(i, 8));  -- Convert integer to std_logic_vector
--            x <= x_data;
--           wait for 7*CLK_PERIOD ;
--            x_data := std_logic_vector(to_unsigned(i+10, 8));  -- Convert integer to std_logic_vector
--            x <= x_data;
--           wait for 7*CLK_PERIOD ;
--           x_data := std_logic_vector(to_unsigned(i+6, 8));  -- Convert integer to std_logic_vector
--            x <= x_data;
--            wait for 7*CLK_PERIOD ;
--            x_data := std_logic_vector(to_unsigned(i+2, 8));  -- Convert integer to std_logic_vector
--            x <= x_data;
--           wait for 7*CLK_PERIOD ;        
--        end loop;
        
--        for i in 20 to 22 loop  -- Generate 10 test cases with large X values
--            x_data := std_logic_vector(to_unsigned(10*i, 8));  -- Convert integer to std_logic_vector
--            x <= x_data;
--           wait for 7*CLK_PERIOD ;
--            x_data := std_logic_vector(to_unsigned(10*i+10, 8));  -- Convert integer to std_logic_vector
--            x <= x_data;
--           wait for 7*CLK_PERIOD ;
--           x_data := std_logic_vector(to_unsigned(10*i+20, 8));  -- Convert integer to std_logic_vector
--            x <= x_data;
--            wait for 7*CLK_PERIOD ;
--            x_data := std_logic_vector(to_unsigned(10*i+35, 8));  -- Convert integer to std_logic_vector
--            x <= x_data;
--           wait for 7*CLK_PERIOD ;        
--        end loop;
        
--        en_ram_rom <= '0';
        
--        for i in 10 to 12 loop  -- Generate 10 test cases
--            x_data := std_logic_vector(to_unsigned(i, 8));  -- Convert integer to std_logic_vector
--            x <= x_data;
--           wait for 7*CLK_PERIOD ;
--            x_data := std_logic_vector(to_unsigned(i+10, 8));  -- Convert integer to std_logic_vector
--            x <= x_data;
--           wait for 7*CLK_PERIOD ;
--           x_data := std_logic_vector(to_unsigned(i+6, 8));  -- Convert integer to std_logic_vector
--            x <= x_data;
--            wait for 7*CLK_PERIOD ;
--            x_data := std_logic_vector(to_unsigned(i+2, 8));  -- Convert integer to std_logic_vector
--            x <= x_data;
--           wait for 7*CLK_PERIOD ;    
--       end loop;
                   
--         en_ram_rom <= '1';    
--         rst <= '1';    
             
--    for i in 12 to 14 loop  -- Generate 10 test cases
--         x_data := std_logic_vector(to_unsigned(i, 8));  -- Convert integer to std_logic_vector
--         x <= x_data;
--        wait for 7*CLK_PERIOD ;
--         x_data := std_logic_vector(to_unsigned(i+10, 8));  -- Convert integer to std_logic_vector
--         x <= x_data;
--        wait for 7*CLK_PERIOD ;
--        x_data := std_logic_vector(to_unsigned(i+6, 8));  -- Convert integer to std_logic_vector
--         x <= x_data;
--         wait for 7*CLK_PERIOD ;
--         x_data := std_logic_vector(to_unsigned(i+2, 8));  -- Convert integer to std_logic_vector
--         x <= x_data;
--        wait for 7*CLK_PERIOD ;    
--    end loop;  
                                   
--         en_ram_rom <= '1';    
--         rst <= '0';    
         
--         for i in 14 to 20 loop  -- Generate 10 test cases
--             x_data := std_logic_vector(to_unsigned(i, 8));  -- Convert integer to std_logic_vector
--             x <= x_data;
--            wait for 7*CLK_PERIOD ;
--             x_data := std_logic_vector(to_unsigned(i+10, 8));  -- Convert integer to std_logic_vector
--             x <= x_data;
--            wait for 7*CLK_PERIOD ;
--            x_data := std_logic_vector(to_unsigned(i+6, 8));  -- Convert integer to std_logic_vector
--             x <= x_data;
--             wait for 7*CLK_PERIOD ;  
--             x_data := std_logic_vector(to_unsigned(i+2, 8));  -- Convert integer to std_logic_vector
--             x <= x_data;
--            wait for 7*CLK_PERIOD ;    
--        end loop;                                          
        wait;
    end process stim_process;

end Behavioral;

