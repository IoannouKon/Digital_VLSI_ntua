--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

--entity dff is
--  port(
--       d : in  std_logic;
--       q : out  std_logic;
--       clk : in std_logic;
--       rst : in std_logic
--      );
--end entity;

--architecture behavioural of dff is  
--begin
--    process(clk, rst)
--    begin
--        if rst = '0' then
--            q <= '0';
--        elsif clk' event and clk = '1' then
--            q <= d;
--        end if;
--    end process;
--end behavioural;
-----------------------------------------------------------------------
--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;

--entity ha_clk is port(
--    a,b,rst,clk: in std_logic;
--    sout,cout: out std_logic
--);
--end ha_clk;

--architecture Behavioural of ha_clk is    

--signal out_temp : std_logic_vector(1 downto 0) := (others => '0');
--begin

--    process(clk, rst)
--    begin
--        if rst = '0' then
--            out_temp <= "00";
--        elsif rising_edge(clk) then
--            out_temp <= ('0' & a) + ('0' & b) ;
--        end if;
--    end process;
--    sout <= out_temp(0);
--    cout <= out_temp(1);
--end Behavioural;
-----------------------------------------------------------------------------------------------------
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use ieee.numeric_std.all;


--entity diesi is
--  Port (
--  rst,clk: in std_logic;
--  p1,p2,g1,g2: in std_logic ;
--  p1_2,g1_2: out std_logic 
--   );
--end diesi;

--architecture Behavioural of diesi is    

--signal temp : std_logic;
--begin

--process(clk, rst)
--    begin
--        if rst = '0' then
--           p1_2 <= '0';
--           g1_2 <= '0';
--        elsif rising_edge(clk) then
--         p1_2 <= p1 and p2 ;
--         temp <= p2 and g1;
--         g1_2 <= g2 OR temp;  
--        end if;
--    end process;
    
--end Behavioural;

--------------------------------------------------------------------------------------

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use ieee.numeric_std.all;


--entity Prefix_Adder is
--  Port (
--  rst,clk: in std_logic;
--  X,Y: in std_logic_vector(15 downto 0) ;
--  S: out std_logic_vector(15 downto 0) ;
--  C16: out std_logic 
--   );
--end Prefix_Adder;


--architecture Behavioral of Prefix_Adder is

--component ha_clk is port(
--    a,b,rst,clk: in std_logic;
--    sout,cout: out std_logic
--);
--end component;

--component diesi is
--  Port (
--  rst,clk: in std_logic;
--  p1,p2,g1,g2: in std_logic ;
--  p1_2,g1_2: out std_logic 
--   );
--end component;

--component dff is
--  port(
--       d : in  std_logic;
--       q : out  std_logic;
--       clk : in std_logic;
--       rst : in std_logic
--      );
      
--end component;

--signal p,g : std_logic_vector(15 downto 0) ;
--signal p_out,g_out : std_logic_vector(15 downto 0) ;
--signal temp_G : std_logic_vector(15 downto 0) ;
--signal p3_temp,g3_temp,p2_temp,g2_temp: std_logic;
--begin


--ha0 :ha_clk port map(clk =>clk,rst=>rst,a=>X(0),b=>Y(0),sout=>p(0),cout=>g(0));
--ha1 :ha_clk port map(clk =>clk,rst=>rst,a=>X(1),b=>Y(1),sout=>p(1),cout=>g(1));
--ha2 :ha_clk port map(clk =>clk,rst=>rst,a=>X(2),b=>Y(2),sout=>p(2),cout=>g(2));
--ha3 :ha_clk port map(clk =>clk,rst=>rst,a=>X(3),b=>Y(3),sout=>p(3),cout=>g(3));
--ha4 :ha_clk port map(clk =>clk,rst=>rst,a=>X(4),b=>Y(4),sout=>p(4),cout=>g(4));
--ha5 :ha_clk port map(clk =>clk,rst=>rst,a=>X(5),b=>Y(5),sout=>p(5),cout=>g(5));
--ha6 :ha_clk port map(clk =>clk,rst=>rst,a=>X(6),b=>Y(6),sout=>p(6),cout=>g(6));
--ha7 :ha_clk port map(clk =>clk,rst=>rst,a=>X(7),b=>Y(7),sout=>p(7),cout=>g(7));
--ha8 :ha_clk port map(clk =>clk,rst=>rst,a=>X(8),b=>Y(8),sout=>p(8),cout=>g(8));
--ha9 :ha_clk port map(clk =>clk,rst=>rst,a=>X(9),b=>Y(9),sout=>p(9),cout=>g(9));
--ha10 :ha_clk port map(clk =>clk,rst=>rst,a=>X(10),b=>Y(10),sout=>p(10),cout=>g(10));
--ha11 :ha_clk port map(clk =>clk,rst=>rst,a=>X(11),b=>Y(11),sout=>p(11),cout=>g(11));
--ha12 :ha_clk port map(clk =>clk,rst=>rst,a=>X(12),b=>Y(12),sout=>p(12),cout=>g(12));
--ha13 :ha_clk port map(clk =>clk,rst=>rst,a=>X(13),b=>Y(13),sout=>p(13),cout=>g(13));
--ha14 :ha_clk port map(clk =>clk,rst=>rst,a=>X(14),b=>Y(14),sout=>p(14),cout=>g(14));
--ha15 :ha_clk port map(clk =>clk,rst=>rst,a=>X(15),b=>Y(15),sout=>p(15),cout=>g(15));


----first row
--S(0)<= p(0) xor '0';
----++4dffs 

----secon row
--diesi_0: diesi port map(clk=>clk,rst=>rst,p1=>p(0),g1=>g(0),p2=>p(1),g2=>g(1),p1_2=>p_out(1),g1_2=>g_out(1));
--S(1)<= p_out(1) xor g(0);
----++3dffs

----thrid row
--dff_1: dff port map (clk=>clk,rst=>rst,d=>p(2),q=>p2_temp);
--dff_2: dff port map (clk=>clk,rst=>rst,d=>g(2),q=>g2_temp);
--diesi_1: diesi port map(clk=>clk,rst=>rst,p1=>p_out(1),g1=>g_out(1),p2=>p2_temp,g2=>g2_temp,p1_2=>p_out(2),g1_2=>g_out(2));
--S(2)<= p_out(2) xor g_out(1);
----++2dffs

----four row
--diesi_2: diesi port map(clk=>clk,rst=>rst,p1=>p(2),g1=>g(2),p2=>p(3),g2=>g(3),p1_2=>p3_temp,g1_2=>p3_temp);
--diesi_3: diesi port map(clk=>clk,rst=>rst,p1=>p(2),g1=>g(2),p2=>p3_temp,g2=>g3_temp,p1_2=>p_out(3),g1_2=>g_out(3));
--end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity HalfAdder is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           p : out STD_LOGIC;
           g : out STD_LOGIC);
end HalfAdder;

architecture Behavioral of HalfAdder is

begin
p<=x xor y;
g<=x and y;

end Behavioral;

---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Hashtag is
    Port ( g1 : in STD_LOGIC;
           p1 :  in STD_LOGIC;
           g2 : in STD_LOGIC;
           p2 : in STD_LOGIC;
           g12 : out STD_LOGIC;
           p12 : out STD_LOGIC);
end Hashtag;

architecture Behavioral of Hashtag is

begin
p12<=p1 and p2;
g12<=g2 or (g1 and p2);
end Behavioral;

----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;


entity Prefix_Adder is
   generic(
    N:natural:=16
    );
  Port ( 
    X: in std_logic_vector(N-1 downto 0);
    Y: in std_logic_vector(N-1 downto 0);
    S: out std_logic_vector(N-1 downto 0);
    C: out std_logic
  );
end Prefix_Adder;

architecture Behavioral of Prefix_Adder is
component HalfAdder is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           p : out STD_LOGIC;
           g : out STD_LOGIC);
end component;
component Hashtag is
    Port ( g1 : in STD_LOGIC;
           p1 :  in STD_LOGIC;
           g2 : in STD_LOGIC;
           p2 : in STD_LOGIC;
           g12 : out STD_LOGIC;
           p12 : out STD_LOGIC);
end component;
signal P:std_logic_vector(N-1 downto 0);
signal G:std_logic_vector(N-1 downto 0);
signal propagation:std_logic_vector(N-1 downto 0);
signal generated:std_logic_vector(N-1 downto 0);
begin
Half_Adders: for i in 0 to N-1 generate
HA:             HalfAdder port map(X(i),Y(i),propagation(i),generated(i));
             end generate;
P(0)<=propagation(0);
G(0)<=generated(0);
P_G_gen: for j in 1 to N-1 generate
HS:            Hashtag port map(G(j-1),P(j-1),generated(j),propagation(j),G(j),P(j));
         end generate;

C<=G(N-1);
S(0)<=propagation(0);
SumCalculations: for k in 1 to N-1 generate
                    S(k)<=propagation(k) xor G(k-1);
                 end generate;
end Behavioral;

--------------------------------------------


