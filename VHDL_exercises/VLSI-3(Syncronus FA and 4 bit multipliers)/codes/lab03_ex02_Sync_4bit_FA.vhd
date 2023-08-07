library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fa_clk is port(
    a: in std_logic;
    b: in std_logic;
    cin: in std_logic;
    s: out std_logic;
    cout: out std_logic;
    rst : in std_logic;
    clk : in std_logic
);
end fa_clk;

architecture behavioural of fa_clk is    

signal out_temp : std_logic_vector(1 downto 0) := (others => '0');
begin
    process(clk, rst)
    begin
        if rst = '0' then
            out_temp <= "00";
        elsif clk' event and clk = '1' then
            out_temp <= ('0' & a) + ('0' & b) + ('0' & cin);
        end if;
    end process;
    s <= out_temp(0);
    cout <= out_temp(1);
end behavioural;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dff3 is
    port(
        d : in  std_logic;
        q : out  std_logic;
        clk : in std_logic;
        rst : in std_logic
       );
end dff3;

architecture structural of dff3 is
    component dff is
        port(
          d : in  std_logic;
          q : out  std_logic;
          clk : in std_logic;
          rst : in std_logic
         );
        end component;
        
    component dff2 is
        port(
          d : in  std_logic;
          q : out  std_logic;
          clk : in std_logic;
          rst : in std_logic
         );
        end component;

signal buffer_bit : std_logic;

  begin
    delay2 : dff2 
    port map (
        d => d,
        q => buffer_bit,
        clk => clk,
        rst => rst
    );

    delay1 : dff 
    port map (
        d => buffer_bit,
        q => q,
        clk => clk,
        rst => rst
    );
    
    end architecture;
    
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dff2 is
    port(
        d : in  std_logic;
        q : out  std_logic;
        clk : in std_logic;
        rst : in std_logic
       );
end dff2;

architecture structural of dff2 is

    component dff is
        port(
          d : in  std_logic;
          q : out  std_logic;
          clk : in std_logic;
          rst : in std_logic
         );
        end component;

signal buffer_bit : std_logic;

  begin
    delay3 : dff
    port map (
        d => d,
        q => buffer_bit,
        clk => clk,
        rst => rst
    );

    delay4 : dff 
    port map (
        d => buffer_bit,
        q => q,
        clk => clk,
        rst => rst
    );
    
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dff is
  port(
       d : in  std_logic;
       q : out  std_logic;
       clk : in std_logic;
       rst : in std_logic
      );
end entity;

architecture behavioural of dff is  
begin
    process(clk, rst)
    begin
        if rst = '0' then
            q <= '0';
        elsif clk' event and clk = '1' then
            q <= d;
        end if;
    end process;
end behavioural;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fa_pipe is
  port(
       a : in  std_logic_vector(3 downto 0);
       b : in  std_logic_vector(3 downto 0);
       cin : in  std_logic;
       clk : in std_logic;
       rst : in std_logic;
       s : out std_logic_vector(3 downto 0);
       cout : out std_logic
      );
end fa_pipe;

architecture structural of fa_pipe is

  component fa_clk is
    port(
        a: in std_logic;
        b: in std_logic;
        cin: in std_logic;
        s: out std_logic; 
        rst : in std_logic;
        cout: out std_logic;
        clk : in std_logic
        );
  end component;
  
  component dff is
      port(
        d : in  std_logic;
        q : out  std_logic;
        clk : in std_logic;
        rst : in std_logic
        );
    end component;
  
    component dff2 is
      port(
        d : in  std_logic;
        q : out  std_logic;
        clk : in std_logic;
        rst : in std_logic
        );
    end component;

  component dff3 is
      port(
        d : in  std_logic;
        q : out  std_logic;
        clk : in std_logic;
        rst : in std_logic
        );
    end component;
  
  signal s_out : std_logic_vector(3 downto 0) := (others => '0');
  signal car_temp : std_logic_vector(4 downto 0) := (others => '0');
  signal s_temp : std_logic_vector(3 downto 0) := (others => '0');
  signal a_temp : std_logic_vector(3 downto 0) := (others => '0');
  signal b_temp : std_logic_vector(3 downto 0) := (others => '0');

begin
  
  a_temp(0) <= a(0);
  b_temp(0) <= b(0);
  car_temp(0) <= cin;
  

fa0: fa_clk
  port map (
       a => a_temp(0),
       b => b_temp(0),
       cin => car_temp(0),
       cout => car_temp(1),
       clk => clk,
       rst => rst,
       s => s_temp(0)
       );

fa1: fa_clk
  port map (
       a => a_temp(1),
       b => b_temp(1),
       cin => car_temp(1),
       cout => car_temp(2),
       clk => clk,
       rst => rst,
       s => s_temp(1)
       );
       
fa2: fa_clk
  port map (
       a => a_temp(2),
       b => b_temp(2),
       cin => car_temp(2),
       cout => car_temp(3),
       clk => clk,
       rst => rst,
       s => s_temp(2)
       );

fa3: fa_clk
  port map (
       a => a_temp(3),
       b => b_temp(3),
       cin => car_temp(3),
       cout => car_temp(4),
       clk => clk,
       rst => rst,
       s => s_temp(3)
       );
                      

  delay_s0 : dff3
    port map (
      d => s_temp(0),
      q => s_out(0),
      clk => clk,
      rst => rst
      );
      
  delay_s1 : dff2
  port map (
    d => s_temp(1),
    q => s_out(1),
    clk => clk,
    rst => rst
    ); 

  delay_s2 : dff
  port map (
     d => s_temp(2),
     q => s_out(2),
    clk => clk,
    rst => rst
    ); 
    
    delay_a1 : dff
    port map (
      d => a(1),
      q => a_temp(1),
      clk => clk,
      rst => rst
      ); 

   delay_a2 : dff2
    port map (
      d => a(2),
      q => a_temp(2),
      clk => clk,
      rst => rst
      ); 

   delay_a3 : dff3
    port map (
      d => a(3),
      q => a_temp(3),
      clk => clk,
      rst => rst
      ); 

      delay_b1 : dff
    port map (
      d => b(1),
      q => b_temp(1),
      clk => clk,
      rst => rst
      ); 

   delay_b2 : dff2
    port map (
      d => b(2),
      q => b_temp(2),
      clk => clk,
      rst => rst
      ); 

   delay_b3 : dff3
    port map (
      d => b(3),
      q => b_temp(3),
      clk => clk,
      rst => rst
      ); 
    s_out(3) <= s_temp(3);
    s <= s_out;      
    cout <= car_temp(4);
end architecture ; -- arch
