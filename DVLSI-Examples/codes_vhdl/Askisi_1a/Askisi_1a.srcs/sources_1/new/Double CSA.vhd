library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity double_CSA is Port ( 
  clk,rst:in std_logic;
  W,X,Y,Z : in std_logic_vector( 15 downto 0);
  S: out std_logic_vector(15 downto 0) ;
  C: out std_logic_vector(16 downto 1)
  );
end double_CSA;

architecture Behavioral of double_CSA is

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

signal S1,C1,temp_W :std_logic_vector(15 downto 0) ;
begin 
CAS1: CSA port map (clk=>clk,rst=>rst,X=>X,Y=>Y,Z=>Z,S=>S1,C=>C1);
dff_16_1: dff_16 port map(clk=>clk,rst=>rst,d=>W,q=>temp_W);
CAS2: CSA port map (clk=>clk,rst=>rst,X=>S1,Y=>C1,Z=>temp_W,S=>S,C=>C);
end Behavioral;

------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CSA_Tree_b is Port ( 
  clk,rst:in std_logic;
  A0,A1,A2,A3,A4,A5,A6,A7 : in std_logic_vector( 15 downto 0);
  S_final,C_final: out std_logic_vector(15 downto 0) 
  );
end CSA_Tree_b;


architecture Behavioral of CSA_Tree_b is

component double_CSA is Port ( 
  clk,rst:in std_logic;
  W,X,Y,Z : in std_logic_vector( 15 downto 0);
  S: out std_logic_vector(15 downto 0) ;
  C: out std_logic_vector(16 downto 1)
  );
end component;

signal S1,C1,S2,C2,S3,C3 :std_logic_vector(15 downto 0) ;
begin

dCAS1: double_CSA port map (clk=>clk,rst=>rst,X=>A0,Y=>A1,Z=>A2,W=>A3,S=>S1,C=>C1);
dCAS2: double_CSA port map (clk=>clk,rst=>rst,X=>A4,Y=>A5,Z=>A6,W=>A7,S=>S2,C=>C2);
dCAS3: double_CSA port map (clk=>clk,rst=>rst,X=>S1,Y=>C1,Z=>S2,W=>C2,S=>S3,C=>C3);

--S_final <= '0'&S2;
--C_final <= C3&'0';

S_final <= S2;
C_final <= C3;

end Behavioral;

---------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ask1_b is Port ( 
  clk,rst:in std_logic;
  A0,A1,A2,A3,A4,A5,A6,A7 : in std_logic_vector( 15 downto 0);
   S: out std_logic_vector(16-1 downto 0);
   C: out std_logic
  );
end ask1_b;

architecture Behavioral of ask1_b is

component CSA_Tree_b is Port ( 
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

CAS_tree: CSA_Tree_b port map (clk=>clk,rst=>rst,A0=>A0,A1=>A1,A2=>A2,A3=>A3,A4=>A4,A5=>A5,A6=>A6,A7=>A7,S_final=>S_final,C_final=>C_final);
Prefix_Adder_box: Prefix_Adder port map(X=>S_final,Y=>C_final,S=>S,C=>C);

end Behavioral;


