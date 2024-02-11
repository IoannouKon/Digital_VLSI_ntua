-- 2* D flip flop 2 stall     
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

--dff3
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


 --   D flip flop 1 stall 
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


------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity fa is -- FA_extra
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Sin: in STD_LOGIC;
           C_in : in  STD_LOGIC;
           S : out  STD_LOGIC;
           C_out,A_next,B_next : out  STD_LOGIC;
           rst : in std_logic;
           clk : in std_logic                 
          );
end fa;

architecture behavioural of fa is    
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

signal out_temp : std_logic_vector(1 downto 0) := (others => '0');
signal gate : std_logic;
signal w1,w2,w3,w4,w5,w6 :std_logic;

begin
    gate <= A and B;
    process(clk, rst)
    begin
    
        if rst = '0' then
            out_temp <= "00";
        elsif clk' event and clk = '1' then
            out_temp <= ('0' & gate) + ('0' & Sin) + ('0'&C_in);
        end if;
    end process;
    
    S <= out_temp(0);     
   C_out <= out_temp(1);

  --  B_next 
         delay_B : dff
          port map (
              d =>B,
              q => B_next,
              clk => clk,
               rst => rst
               );
                                                       
   --  A_next 
        delay_A : dff2
          port map (
            d =>A,
            q => A_next,
            clk => clk,
           rst => rst
             );
                                                 
end behavioural;

---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity multiplier is
    port (
        A, B : in  std_logic_vector(3 downto 0);
        clk,rst: in std_logic;
        P    : out std_logic_vector(7 downto 0)
    );
end multiplier;

architecture behavioral of multiplier is

    component fa is
        port (
            A, B, C_in,Sin,clk,rst: in  std_logic;
            S, C_out,A_next,B_next  : out std_logic
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

    signal  S1, S2, S3,S5,S6,S7,S9,S10,S11,C1, C2, C3, C4, C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15 : std_logic;
    signal A_temp, B_temp: std_logic_vector(3 downto 0);
    signal P_temp: std_logic_vector(7 downto 0);
    signal B21, B31, B32: std_logic;
    signal A_next,B_next:  std_logic_vector(15 downto 0);
    signal w1,w2,w3,w4,w5,w6,w7 : std_logic;
    signal temp_C4,temp_C8,temp_C12: std_logic;
    
 begin
    -- First row of FA components
    fa_0 : fa port map (clk=>clk,rst=>rst,Sin=> '0',A=>A_temp(0),B=> B_temp(0),C_in  => '0', S=> P_temp(0), C_out => C1,A_next => A_next(0),B_next =>B_next(0));
    fa_1 : fa port map (clk=>clk,rst=>rst,Sin=> '0',A=>A_temp(1),B=> B_next(0),C_in=> C1,    S=> S1  ,C_out=> C2  ,A_next => A_next(1),B_next =>B_next(1));
    fa_2 : fa port map (clk=>clk,rst=>rst,Sin=> '0',A=>A_temp(2),B=> B_next(1),C_in=> C2,    S=> S2   ,C_out=> C3  ,A_next => A_next(2),B_next =>B_next(2));
    fa_3 : fa port map (clk=>clk,rst=>rst,Sin=> '0',A=>A_temp(3),B=> B_next(2),C_in=> C3,    S=> S3  ,C_out=> temp_C4 ,A_next => A_next(3),B_next =>B_next(3));
    
    -- Second row of FA components
    fa_4 : fa port map (clk=>clk,rst=>rst,Sin=>S1,A=>A_next(0),B=> B_temp(1),C_in=> '0',S=> P_temp(1),C_out=> C5,A_next => A_next(4),B_next =>B_next(4));
    fa_5 : fa port map (clk=>clk,rst=>rst,Sin=>S2,A=>A_next(1),B=> B_next(4),C_in=> C5, S=> S5,  C_out=> C6,A_next => A_next(5),B_next =>B_next(5));
    fa_6 : fa port map (clk=>clk,rst=>rst,Sin=>S3,A=>A_next(2),B=> B_next(5),C_in=> C6, S=> S6,  C_out=> C7,A_next => A_next(6),B_next =>B_next(6));
    fa_7 : fa port map (clk=>clk,rst=>rst,Sin=>C4,A=>A_next(3),B=> B_next(6),C_in=> C7, S=> S7,  C_out=> temp_C8,A_next => A_next(7),B_next =>B_next(7));
    
    -- Third row of FA components
     fa_8 : fa port map  (clk=>clk,rst=>rst,Sin=>S5,A=>A_next(4), B=> B_temp(2),C_in=> '0',S=> P_temp(2),C_out=> C9,A_next => A_next(8),B_next =>B_next(8));
     fa_9 : fa port map  (clk=>clk,rst=>rst,Sin=>S6,A=>A_next(5), B=> B_next(8),C_in=> C9, S=> S9,  C_out=> C10,A_next => A_next(9),B_next =>B_next(9));
     fa_10 : fa port map (clk=>clk,rst=>rst,Sin=>S7,A=>A_next(6), B=> B_next(9),C_in=> C10,S=> S10, C_out=> C11,A_next => A_next(10),B_next =>B_next(10));
     fa_11 : fa port map (clk=>clk,rst=>rst,Sin=>C8,A=>A_next(7), B=> B_next(10),C_in=> C11, S=> S11, C_out=> temp_C12,A_next => A_next(11),B_next =>B_next(11));
   
    -- Fourth row of FA components
    fa_12 : fa port map  (clk=>clk,rst=>rst,Sin=>S9,A=>A_next(8), B=> B_temp(3),C_in=> '0',S=> P_temp(3), C_out=> C13, A_next => A_next(12),B_next =>B_next(12));
    fa_13 : fa port map  (clk=>clk,rst=>rst,Sin=>S10,A=>A_next(9),B=> B_next(12),C_in=> C13,S=> P_temp(4), C_out=> C14, A_next => A_next(13),B_next =>B_next(13));
    fa_14 : fa port map  (clk=>clk,rst=>rst,Sin=>S11,A=>A_next(10),B=> B_next(13),C_in=> C14,S=> P_temp(5), C_out=> C15,A_next => A_next(14),B_next =>B_next(14));
    fa_15 : fa port map  (clk=>clk,rst=>rst,Sin=>C12,A=>A_next(11),B=> B_next(14),C_in=> C15,S=> P_temp(6), C_out=> P_temp(7),A_next => A_next(15),B_next =>B_next(15));
    
    
    
  --Διαγωνίοι delay  1 dff στον καθένα
  delay_C4: dff
       port map (
           d => temp_C4,
           q => C4,
           clk => clk,
           rst => rst
       );     
       
  delay_C8: dff
     port map (
     d => temp_C8,
     q => C8,
     clk => clk,
     rst => rst
         );
         
  delay_C12: dff
              port map (
              d => temp_C12,
              q => C12,
              clk => clk,
              rst => rst
                  )  ;     
    
    
    --A delay stuff
    A_temp(0) <= A(0);
    delay_a1_1: dff
    port map (
        d => A(1),
        q => A_temp(1),
        clk => clk,
        rst => rst
    );
    delay_a2_2: dff2
        port map (
            d => A(2),
            q => A_temp(2),
            clk => clk,
            rst => rst
        );
    delay_a3_3: dff3
       port map (
           d => A(3),
           q => A_temp(3),
           clk => clk,
           rst => rst
       );
       
     --B_stuff
       B_temp(0) <= B(0);
       
    --Β(1) 2_dff
    delay_b1_2: dff2
        port map (
            d => B(1),
            q => B_temp(1),
            clk => clk,
            rst => rst
        );
        
    -- B(2) 4_dff   
    delay_b2_4_vol1: dff2
        port map (
            d => B(2),
            q => B21,
            clk => clk,
            rst => rst
        );
    delay_b2_4_vol2: dff2
        port map (
            d => B21,
            q => B_temp(2),
            clk => clk,
            rst => rst
        );

     -- B(3) 6_dff
    delay_b3_6_vol1: dff2
        port map (
            d => B(3),
            q => B31,
            clk => clk,
            rst => rst
        );
    delay_b3_6_vol2: dff2
        port map (
            d => B31,
            q => B32,
            clk => clk,
            rst => rst
        );
    delay_b3_6_vol3: dff2
        port map (
            d => B32,
            q => B_temp(3),
            clk => clk,
            rst => rst
        );
        
--P_temp
P(6) <= P_temp(6);
P(7) <= P_temp(7);

delay_P5 : dff
   port map (
     d => P_temp(5),
     q => P(5),
     clk => clk,
     rst => rst
              );
                      
delay_P4 : dff2
  port map (
    d => P_temp(4),
    q => P(4),
    clk => clk,
    rst => rst
        );                   
    
    
delay_P3 : dff3
    port map (
    d => P_temp(3),
    q => P(3),
    clk => clk,
    rst => rst
         );

                
delay_P2_A : dff3
port map (
d => P_temp(2),
q => w1,
clk => clk,
rst => rst
           );                                 
delay_P2_B : dff2
port map (
   d => w1,
   q => P(2),
   clk => clk,
   rst => rst                                                                                    
  );  
                      
                      
delay_P1_A : dff3
port map (
     d => P_temp(1),
     q => w2,
     clk => clk,
      rst => rst
          );                                            
delay_P1_B : dff3
  port map (
        d => w2,
        q => w3,
        clk => clk,
        rst => rst                                                                                    
);                                                                              
delay_P1_C : dff
 port map (
    d => w3,
    q => P(1),
    clk => clk,
    rst => rst                                                                                    
   );  
                               
delay_P0_A : dff3
  port map (
    d => P_temp(0),
    q => w4,
    clk => clk,
    rst => rst
            );                                                 
delay_P0_B : dff3
    port map (
        d => w4,
        q => w5,
        clk => clk,
        rst => rst                                                                                    
              );                                                                             
delay_P0_C : dff3
  port map (
      d => w5,
      q => P(0),
      clk => clk,
      rst => rst                                                                                    
             ); 

end behavioral;
