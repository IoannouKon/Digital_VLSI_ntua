library IEEE;
use IEEE.std_logic_1164.all;

entity lab01_ex02 is
port (
clk,rst,si,en,pl,flag: in std_logic;
din: in std_logic_vector(3 downto 0);
so: out std_logic;
dffout: out std_logic_vector(3 downto 0));
end lab01_ex02;

architecture rtl of lab01_ex02 is
signal dff: std_logic_vector(3 downto 0);
--signal temp: std_logic;


begin
edge: process (clk,rst)

begin


if rst='0' then
dff<=(others=>'0');

elsif clk'event and clk='1' then
if pl='1' then
dff<=din;

elsif en='1' then
  if flag = '0' then
  dff<=si&dff(3 downto 1) ;

  
  elsif flag ='1' then 
  dff<=dff(2 downto 0)&si;

  
end if;
end if;
end if;

end process;

dffout <= dff;
so <= dff(0) WHEN flag = '0' ELSE dff(3) WHEN flag = '1';
---end process;
end rtl;