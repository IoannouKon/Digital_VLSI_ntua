-- half Adder (1)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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


-- 4-bit Parallel Adder (3)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit4_Adder is
  Port (
  As: in std_logic_vector(3 downto 0);
  Bs: in std_logic_vector(3 downto 0);
  Cin: in std_logic;
  s: out std_logic_vector(3 downto 0);
  cout: out std_logic
   );
end  bit4_Adder;

architecture structural of bit4_Adder is

component FullAdder 
  port (
  A: in std_logic;
  B: in std_logic;
  Cin: in std_logic;
  sum: out std_logic;
  carry:out std_logic
  );
end component;

signal c0: std_logic;
signal c1: std_logic;
signal c2: std_logic;

begin
FA1 : FullAdder  port map (A=>As(0),B=>Bs(0),Cin=>Cin,sum=>s(0),carry=>c0);
FA2 : FullAdder  port map (A=>As(1),B=>Bs(1),Cin=>c0,sum=>s(1),carry=>c1);
FA3 : FullAdder  port map (A=>As(2),B=>Bs(2),Cin=>c1,sum=>s(2),carry=>c2);
FA4 : FullAdder  port map (A=>As(3),B=>Bs(3),Cin=>c2,sum=>s(3),carry=>cout);

end architecture;


