library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab01_ex02_tb is
end lab01_ex02_tb;

architecture Behavioral of lab01_ex02_tb is

component lab01_ex02
port(
clk,rst,si,en,pl,flag: in std_logic;
din: in std_logic_vector(3 downto 0);
so: out std_logic;
dffout: out std_logic_vector(3 downto 0));
end component;

signal clk : STD_LOGIC := '0';
signal si : STD_LOGIC := '0';
signal rst : STD_LOGIC := '0';
signal en : STD_LOGIC := '0';
signal flag : STD_LOGIC := '0';


signal pl: STD_LOGIC := '0';

signal din : std_logic_vector(3 downto 0) := "1001";

signal so :  std_logic ;
signal dffout: std_logic_vector(3 downto 0);

constant T : time := 10 ns ; -- clock period

begin 
test: lab01_ex02

 port map( 
 clk => clk,
 rst => rst,
 si => si,
 en=>en,
 pl =>pl,
 din =>din,
 flag =>flag,
 so =>so,
 dffout => dffout 
 );
 
 stimulus: 
 process 
 
 begin 
 
 -- reset off 
 en <= '1';
 rst <= '0';
 for i in 0 to 1 loop
 clk <= not clk;
 wait for T;
 end loop;
 
 -- parallel load
  rst <= '1';
  pl <= '1';
  for i in 0 to 2 loop
  clk <= not clk;
  wait for T;
  end loop;
 
     -- enable on and si=0 
    rst <= '1';
    pl <= '0';
    en <= '1';
    si <= '0';
    for i in 0 to 2 loop
    clk <= not clk;
    wait for T;
    end loop;
   
      -- enable on and si=1
      rst <= '1';
      pl <= '0';
      en <= '1';
      si <= '1';
      for i in 0 to 2 loop
      clk <= not clk;
      wait for T;
      end loop;
      
    
       ---- flag = 1 
       flag <= '1';
       
         -- enable on and si=0 
         rst <= '1';
         pl <= '0';
         en <= '1';
         si <= '0';
         for i in 0 to 2 loop
         clk <= not clk;
         wait for T;
         end loop;
         
         
           -- enable on and si=1
           rst <= '1';
           pl <= '0';
           en <= '1';
           si <= '1';
           for i in 0 to 2 loop
           clk <= not clk;
           wait for T;
           end loop;
  
             -- reset = 0
                      rst <= '0';
                      for i in 0 to 2 loop
                      clk <= not clk;
                      wait for T;
                      end loop;
   wait;
   end process;
   
   end  Behavioral;
  
  
  
 
