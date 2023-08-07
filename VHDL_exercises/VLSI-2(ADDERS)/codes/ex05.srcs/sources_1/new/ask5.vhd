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

-- BCD Adder (4)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 

entity BCD_Adder is
  Port (
  X : in std_logic_vector ( 3 downto 0) ;
  Y : in std_logic_vector ( 3 downto 0) ;
  Cin : in std_logic;
  Sum  :  out std_logic_vector ( 3 downto 0) ;
  Carry : out std_logic 
   );
end BCD_Adder;

architecture structural of BCD_Adder is

component  bit4_Adder
  port (
    As: in std_logic_vector(3 downto 0);
    Bs: in std_logic_vector(3 downto 0);
    Cin: in std_logic;
    s: out std_logic_vector(3 downto 0);
    cout: out std_logic
  );
end component;

signal sum_up, X_down,Y_down: std_logic_vector(3 downto 0) ;
signal carry_up,Carry_temp, carry_down: std_logic;
begin

 BITS4_ADDER1 :  bit4_Adder  port map (As => X, Bs => Y, Cin => Cin, s => sum_up, cout => carry_up);
 Carry_temp <= (sum_up(3) and sum_up(2))  or (sum_up(3) and sum_up(1)) or carry_up ;
 Carry <= Carry_temp;
 X_down <= '0' & Carry_temp & Carry_temp & '0';
 BITS4_ADDER2 :  bit4_Adder  port map (As => X_down, Bs => sum_up, Cin => '0', s => Sum, cout => carry_down);

end architecture;


--BCD parallel adder(5)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab02_ex05 is
Port (
  X5 : in std_logic_vector ( 15 downto 0) ;
  Y5 : in std_logic_vector ( 15 downto 0) ;
  Cin5 : in std_logic;
  Sum5  :  out std_logic_vector ( 15 downto 0) ;
  Carry5 : out std_logic 
   );
end lab02_ex05;

architecture Structural of lab02_ex05 is

component BCD_Adder
  Port (
  X : in std_logic_vector ( 3 downto 0) ;
  Y : in std_logic_vector ( 3 downto 0) ;
  Cin : in std_logic;
  Sum  :  out std_logic_vector ( 3 downto 0) ;
  Carry : out std_logic 
   );
end component;

signal s1,s2,s3,s4,x_temp1,y_temp1,x_temp2,y_temp2,x_temp3,y_temp3,x_temp4,y_temp4: std_logic_vector(3 downto 0);
signal c51,c52,c53: std_logic;

begin

x_temp1 <= (X5(3)&X5(2)&X5(1)&X5(0));
y_temp1 <= (Y5(3)&Y5(2)&Y5(1)&Y5(0));
BCD_full_1: BCD_Adder port map(X => x_temp1, Y => y_temp1, Cin=>Cin5, Sum=>s1, Carry=>c51);
x_temp2 <= (X5(7)&X5(6)&X5(5)&X5(4));
y_temp2 <= (Y5(7)&Y5(6)&Y5(5)&Y5(4));
BCD_full_2: BCD_Adder port map(X => x_temp2, Y => y_temp2, Cin=>c51, Sum=>s2, Carry=>c52);
x_temp3 <= (X5(11)&X5(10)&X5(9)&X5(8));
y_temp3 <= (Y5(11)&Y5(10)&Y5(9)&Y5(8));
BCD_full_3: BCD_Adder port map(X => x_temp3, Y => y_temp3, Cin=>c52, Sum=>s3, Carry=>c53);
x_temp4 <= (X5(15)&X5(14)&X5(13)&X5(12));
y_temp4 <= (Y5(15)&Y5(14)&Y5(13)&Y5(12));
BCD_full_4: BCD_Adder port map(X => x_temp4, Y => y_temp4, Cin=>c53, Sum=>s4, Carry=>Carry5);
Sum5 <= s4&s3&s2&s1;

end architecture;
