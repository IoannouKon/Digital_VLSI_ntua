
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- half Adder (1)
entity haldAdder is
  Port (
  A: in std_logic ;
  B: in std_logic ;
  sum: out std_logic ;
  carry: out std_logic  
   );
end haldAdder;

architecture dataflow of haldAdder is
begin
carry <= A AND B ;
sum <= A XOR B;
end architecture;



-- Full Adder (2)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity FullAdder is
  Port (
  A,B,Cin: in std_logic ;
  sum,carry: out std_logic 
   );
end  FullAdder;

architecture structural of FullAdder is

component haldAdder 
  port (
  A: in std_logic;
  B: in std_logic;
  sum: out std_logic;
  carry:out std_logic
  );
end component;

signal s1,c1,c2 : std_logic := '0';

begin
HA1 : haldAdder port map (A,B,s1,c1);
HA2 : haldAdder port map (s1,Cin,sum,c2);
carry <= c1 OR c2;
end architecture;


