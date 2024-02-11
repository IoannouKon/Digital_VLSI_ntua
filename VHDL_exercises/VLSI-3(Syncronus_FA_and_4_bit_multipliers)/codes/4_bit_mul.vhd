library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fa is -- FA_extra
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Sin: in STD_LOGIC;
           C_in : in  STD_LOGIC;
           S : out  STD_LOGIC;
           C_out : out  STD_LOGIC);
end fa;

architecture Behavioral of fa is
signal gate : std_logic;
begin
   gate <= A and B;
    S <= gate xor Sin xor C_in;
    C_out <= (gate and Sin) or (C_in and (gate xor Sin));
end Behavioral;

library ieee;
use ieee.std_logic_1164.all;

entity multiplier is
    port (
        A, B : in  std_logic_vector(3 downto 0);
        P    : out std_logic_vector(7 downto 0)
    );
end multiplier;

architecture behavioral of multiplier is

    component fa is
        port (
            A, B, C_in,Sin : in  std_logic;
            S, C_out  : out std_logic
        );
    end component;

    signal  S1, S2, S3,S5,S6,S7,S9,S10,S11,C1, C2, C3, C4, C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15 : std_logic;
 
 begin
    -- First row of FA components
    fa_0 : fa port map (Sin=> '0',A=>A(0),B=> B(0),C_in  => '0', S=> P(0), C_out => C1);
    fa_1 : fa port map (Sin=> '0',A=>A(1),B=> B(0),C_in=> C1,    S=> S1,   C_out=> C2);
    fa_2 : fa port map (Sin=> '0',A=>A(2),B=> B(0),C_in=> C2,    S=>S2,    C_out=> C3);
    fa_3 : fa port map (Sin=> '0',A=>A(3),B=> B(0),C_in=> C3,    S=> S3,   C_out=> C4);
    
    -- Second row of FA components
    fa_4 : fa port map (Sin=>S1,A=>A(0),B=> B(1),C_in=> '0',S=> P(1),C_out=> C5);
    fa_5 : fa port map (Sin=>S2,A=>A(1),B=> B(1),C_in=> C5, S=> S5,  C_out=> C6);
    fa_6 : fa port map (Sin=>S3,A=>A(2),B=> B(1),C_in=> C6, S=> S6,  C_out=> C7);
    fa_7 : fa port map (Sin=>C4,A=>A(3),B=> B(1),C_in=> C7, S=> S7,  C_out=> C8);
    
    -- Third row of FA components
     fa_8 : fa port map  (Sin=>S5,A=>A(0), B=> B(2),C_in=> '0',S=> P(2),C_out=> C9);
     fa_9 : fa port map  (Sin=>S6,A=>A(1), B=> B(2),C_in=> C9, S=> S9,  C_out=> C10);
     fa_10 : fa port map (Sin=>S7,A=>A(2), B=> B(2),C_in=> C10,S=> S10, C_out=> C11);
     fa_11 : fa port map (Sin=>C8,A=>A(3), B=> B(2),C_in=> C11, S=> S11, C_out=> C12);
   
    -- Fourth row of FA components
    fa_12 : fa port map  (Sin=>S9,A=>A(0), B=> B(3),C_in=> '0',S=> P(3), C_out=> C13);
    fa_13 : fa port map  (Sin=>S10,A=>A(1),B=> B(3),C_in=> C13,S=> P(4), C_out=> C14);
    fa_14 : fa port map  (Sin=>S11,A=>A(2),B=> B(3),C_in=> C14,S=> P(5), C_out=> C15);
    fa_15 : fa port map  (Sin=>C12,A=>A(3),B=> B(3),C_in=> C15,S=> P(6), C_out=> P(7));
  
    
  
end behavioral;




