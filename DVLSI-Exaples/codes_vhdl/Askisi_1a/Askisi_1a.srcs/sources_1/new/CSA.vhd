

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity CSA is Port ( 
  clk,rst:in std_logic;
  X,Y,Z : in std_logic_vector( 15 downto 0);
  S: out std_logic_vector(15 downto 0) ;
  C: out std_logic_vector(16 downto 1)
  );
end CSA;

architecture Behavioral of CSA is

component  fa_clk is port(
    a,b,cin,rst,clk: in std_logic;
    sout,cout: out std_logic
);
end component;


begin

--for i in  0 to 15 loop
--fa_clk_i : fa_clk port map ( clk =>clk,rst=>rst,a=>X(i),b=>Y(i),cin=>Z(i),sout => temp_S(i),cout =>temp_C(i+1));
--end loop;
 
--C(0)<= '0';
--S(16) <= '0'; 
fa_clk0 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(0),b=>Y(0),cin=>Z(0),sout => S(0),cout =>C(1));
fa_clk1 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(1),b=>Y(1),cin=>Z(1),sout => S(1),cout =>C(2));
fa_clk2 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(2),b=>Y(2),cin=>Z(2),sout => S(2),cout =>C(3));
fa_clk3 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(3),b=>Y(3),cin=>Z(3),sout => S(3),cout =>C(4));
fa_clk4 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(4),b=>Y(4),cin=>Z(4),sout => S(4),cout =>C(5));
fa_clk5 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(5),b=>Y(5),cin=>Z(5),sout => S(5),cout =>C(6));
fa_clk6 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(6),b=>Y(6),cin=>Z(6),sout => S(6),cout =>C(7));
fa_clk7 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(7),b=>Y(7),cin=>Z(7),sout => S(7),cout =>C(8));
fa_clk8 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(8),b=>Y(8),cin=>Z(8),sout => S(8),cout =>C(9));
fa_clk9 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(9),b=>Y(9),cin=>Z(9),sout => S(9),cout =>C(10));
fa_clk10 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(10),b=>Y(10),cin=>Z(10),sout => S(10),cout =>C(11));
fa_clk11 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(11),b=>Y(11),cin=>Z(11),sout => S(11),cout =>C(12));
fa_clk12 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(12),b=>Y(12),cin=>Z(12),sout => S(12),cout =>C(13));
fa_clk13 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(13),b=>Y(13),cin=>Z(13),sout => S(13),cout =>C(14));
fa_clk14 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(14),b=>Y(14),cin=>Z(14),sout => S(14),cout =>C(15));
fa_clk15 : fa_clk port map ( clk =>clk,rst=>rst,a=>X(15),b=>Y(15),cin=>Z(15),sout => S(15),cout =>C(16));

end Behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CSA_Tree_a is Port ( 
  clk,rst:in std_logic;
  A0,A1,A2,A3,A4,A5,A6,A7 : in std_logic_vector( 15 downto 0);
  S_final,C_final: out std_logic_vector(15 downto 0) 
  );
end CSA_Tree_a;


architecture Behavioral of CSA_Tree_a is

component CSA is Port ( 
  clk,rst:in std_logic;
  X,Y,Z : in std_logic_vector( 15 downto 0);
   S: out std_logic_vector(15 downto 0) ;
   C: out std_logic_vector(16 downto 1)
  );
end component;

component dff_16 is
    Port ( d : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (15 downto 0));
end component;


signal S1,C1,S2,C2,S3,C3,S4,C4,S5,C5,S6,C6 :std_logic_vector(15 downto 0) ;
signal A6_t,A7_t : std_logic_vector( 15 downto 0);
signal S4_t : std_logic_vector( 15 downto 0);
begin

CAS1: CSA port map (clk=>clk,rst=>rst,X=>A0,Y=>A1,Z=>A2,S=>S1,C=>C1);
CAS2: CSA port map (clk=>clk,rst=>rst,X=>A3,Y=>A4,Z=>A5,S=>S2,C=>C2);
CAS3: CSA port map (clk=>clk,rst=>rst,X=>S1,Y=>C1,Z=>C2,S=>S3,C=>C3);
CAS4: CSA port map (clk=>clk,rst=>rst,X=>A6_t,Y=>A7_t,Z=>S2,S=>S4,C=>C4);
CAS5: CSA port map (clk=>clk,rst=>rst,X=>S3,Y=>C3,Z=>C4,S=>S5,C=>C5);
CAS6: CSA port map (clk=>clk,rst=>rst,X=>S5,Y=>C5,Z=>S4_t,S=>S6,C=>C6);

--S_final <= '0'&S6;
--C_final <= C6&'0';

S_final <= S6;
C_final <= C6;

dff_16_1: dff_16 port map(clk=>clk,rst=>rst,d=>A6,q=>A6_t);
dff_16_2: dff_16 port map(clk=>clk,rst=>rst,d=>A7,q=>A7_t);
dff_16_3: dff_16 port map(clk=>clk,rst=>rst,d=>S4,q=>S4_t);



end Behavioral;
--------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ask1_a is Port ( 
  clk,rst:in std_logic;
  A0,A1,A2,A3,A4,A5,A6,A7 : in std_logic_vector( 15 downto 0);
   S: out std_logic_vector(16-1 downto 0);
   C: out std_logic
  );
end ask1_a;

architecture Behavioral of ask1_a is

component CSA_Tree_a is Port ( 
  clk,rst:in std_logic;
  A0,A1,A2,A3,A4,A5,A6,A7 : in std_logic_vector( 15 downto 0);
  S_final,C_final: out std_logic_vector(15 downto 0) 
  );
end component;

component Prefix_Adder is
   generic(
    N:natural:=16
    );
  Port ( 
    X: in std_logic_vector(N-1 downto 0);
    Y: in std_logic_vector(N-1 downto 0);
    S: out std_logic_vector(N-1 downto 0);
    C: out std_logic
  );
end component;
signal   S_final,C_final: std_logic_vector(15 downto 0);
begin

CAS_tree: CSA_Tree_a port map (clk=>clk,rst=>rst,A0=>A0,A1=>A1,A2=>A2,A3=>A3,A4=>A4,A5=>A5,A6=>A6,A7=>A7,S_final=>S_final,C_final=>C_final);
Prefix_Adder_box: Prefix_Adder port map(X=>S_final,Y=>C_final,S=>S,C=>C);

end Behavioral;





