----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 05/17/2023 12:50:53 PM
-- Design Name:
-- Module Name: Average - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



----------------------------------------------------
--|             |                   |               |
--|             |                   |               |
--|   D00       |       D01         |      D02      |
--|             |                   |               |
--|-------------|-------------------|---------------|
--|             |                   |               |
--|   D10       |       D11         |      D12      |
--|             |                   |               |                                  
--|-------------|-------------------|---------------|
--|             |                   |               |
--|    D20      |       D21         |      D22      |
--|             |                   |               |
----------------------------------------------------

--central_color: case as in the picture
-------------------------11-------------------------
--|             |                   |               |
--|             |                   |               |
--|   GREEN     |      BLUE         |    GREEN      |
--|             |                   |               |
--|-------------|-------------------|---------------|
--|             |                   |               |
--|   RED       |       GREEN       |      RED      |
--|             |                   |               |                                  
--|-------------|-------------------|---------------|
--|             |                   |               |
--|   GREEN     |      BLUE         |     GREEN     |
--|             |                   |               |
----------------------------------------------------
-------------------------00-------------------------
--|             |                   |               |
--|             |                   |               |
--|   GREEN     |      RED          |    GREEN      |
--|             |                   |               |
--|-------------|-------------------|---------------|
--|             |                   |               |
--|   BLUE      |       GREEN       |     BLUE      |
--|             |                   |               |                                  
--|-------------|-------------------|---------------|
--|             |                   |               |
--|   GREEN     |        RED        |     GREEN     |
--|             |                   |               |
----------------------------------------------------
-------------------------10-------------------------
--|             |                   |               |
--|             |                   |               |
--|   BLUE      |      GREEN        |    BLUE       |
--|             |                   |               |
--|-------------|-------------------|---------------|
--|             |                   |               |
--|   GREEN     |       RED         |     GREEN     |
--|             |                   |               |                                  
--|-------------|-------------------|---------------|
--|             |                   |               |
--|   BLUE      |       GREEN       |     BLUE      |
--|             |                   |               |
----------------------------------------------------
-------------------------01-------------------------
--|             |                   |               |
--|             |                   |               |
--|    RED      |      GREEN        |     RED       |
--|             |                   |               |
--|-------------|-------------------|---------------|
--|             |                   |               |
--|   GREEN     |      BLUE         |     GREEN     |
--|             |                   |               |                                  
--|-------------|-------------------|---------------|
--|             |                   |               |
--|   RED       |       GREEN       |     RED      |
--|             |                   |               |
----------------------------------------------------


entity Average is
    Port ( d_0_0reg : in STD_LOGIC_VECTOR (7 downto 0);
           d_0_1reg : in STD_LOGIC_VECTOR (7 downto 0);
           d_0_2reg : in STD_LOGIC_VECTOR (7 downto 0);
           d_1_0reg : in STD_LOGIC_VECTOR (7 downto 0);
           d_1_1reg : in STD_LOGIC_VECTOR (7 downto 0);
           d_1_2reg : in STD_LOGIC_VECTOR (7 downto 0);
           d_2_0reg : in STD_LOGIC_VECTOR (7 downto 0);
           d_2_1reg : in STD_LOGIC_VECTOR (7 downto 0);
           d_2_2reg : in STD_LOGIC_VECTOR (7 downto 0);
           central_color : in STD_LOGIC_VECTOR (1 downto 0);
           en : in STD_LOGIC;
           clk : in STD_LOGIC;
           GREEN : out STD_LOGIC_VECTOR (7 downto 0);
           BLUE : out STD_LOGIC_VECTOR (7 downto 0);
           RED : out STD_LOGIC_VECTOR (7 downto 0));
end Average;

architecture Behavioral of Average is
signal RED_sig:STD_LOGIC_VECTOR (9 downto 0);
signal GREEN_sig:STD_LOGIC_VECTOR (9 downto 0);
signal BLUE_sig:STD_LOGIC_VECTOR (9 downto 0);
signal d_0_0 :  STD_LOGIC_VECTOR (9 downto 0);
signal d_0_1 :  STD_LOGIC_VECTOR (9 downto 0);
signal d_0_2 :  STD_LOGIC_VECTOR (9 downto 0);
signal d_1_0 :  STD_LOGIC_VECTOR (9 downto 0);
signal d_1_1 :  STD_LOGIC_VECTOR (9 downto 0);
signal d_1_2 :  STD_LOGIC_VECTOR (9 downto 0);
signal d_2_0 :  STD_LOGIC_VECTOR (9 downto 0);
signal d_2_1 :  STD_LOGIC_VECTOR (9 downto 0);
signal d_2_2 :  STD_LOGIC_VECTOR (9 downto 0);
signal width:integer range 0 to 1:=0;
begin
d_0_0<="00"&d_0_0reg;
d_0_1<="00"&d_0_1reg;
d_0_2<="00"&d_0_2reg;
d_1_0<="00"&d_1_0reg;
d_1_1<="00"&d_1_1reg;
d_1_2<="00"&d_1_2reg;
d_2_0<="00"&d_2_0reg;
d_2_1<="00"&d_2_1reg;
d_2_2<="00"&d_2_2reg;

process(clk)
begin
if rising_edge(clk) then
    if en='1' then
        case central_color is
             when "11"=> GREEN_sig(8 downto 1)<= d_1_1(7 downto 0);
                         GREEN_sig(0)<='0';
                         GREEN_sig(9)<='0';                  
                         RED_sig<=d_1_0+d_1_2;
                         BLUE_sig<=d_0_1+d_2_1;
                         width<=0;
             when "00"=> GREEN_sig(8 downto 1)<= d_1_1(7 downto 0);
                         GREEN_sig(0)<='0';
                         GREEN_sig(9)<='0';  
                         RED_sig<=d_0_1+d_2_1;
                         BLUE_sig<=d_1_0+d_1_2;
                         width<=0;
             when "10"=> GREEN_sig<=d_1_0+d_0_1+d_1_2+d_2_1;
                         RED_sig(9 downto 2)<=d_1_1(7 downto 0);
                         RED_sig(0)<='0';
                         RED_sig(1)<='0';
                         BLUE_sig<=d_0_0+d_0_2+d_2_0+d_2_2;
                         width<=1;
             when "01"=> GREEN_sig<=d_1_0+d_0_1+d_1_2+d_2_1;
                         RED_sig<=d_0_0+d_0_2+d_2_0+d_2_2;
                         BLUE_sig(9 downto 2)<=d_1_1(7 downto 0);
                         BLUE_sig(0)<='0';
                         BLUE_sig(1)<='0';
                         width<=1;
             when others=> null;
        end case;
    end if;
end if;
end process;
RED<=RED_sig(8+width downto 1+width);
BLUE<=BLUE_sig(8+width downto 1+width);
GREEN<=GREEN_sig(8+width downto 1+width);

end Behavioral;