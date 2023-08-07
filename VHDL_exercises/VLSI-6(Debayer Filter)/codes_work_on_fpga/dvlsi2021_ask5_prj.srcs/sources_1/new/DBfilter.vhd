----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 06/06/2023 05:10:00 PM
-- Design Name:
-- Module Name: DBfilter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DBfilter is
    Port ( new_image : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst_n : in STD_LOGIC;
           valid_in : in STD_LOGIC;
           pixel : in STD_LOGIC_VECTOR (7 downto 0);
           valid_out : out STD_LOGIC;
           image_finished : out STD_LOGIC;
           R : out STD_LOGIC_VECTOR (7 downto 0);
           G : out STD_LOGIC_VECTOR (7 downto 0);
           B: out STD_LOGIC_VECTOR (7 downto 0) 
           );
           
end DBfilter;

architecture Behavioral of DBfilter is
component Debayering is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           valid_in : in STD_LOGIC;
           new_image : in STD_LOGIC;  
           pixel:in std_logic_vector(7 downto 0);
           valid_out : out STD_LOGIC;
           GREEN : out STD_LOGIC_VECTOR (7 downto 0);
           BLUE : out STD_LOGIC_VECTOR (7 downto 0);
           RED : out STD_LOGIC_VECTOR (7 downto 0);
           image_finished : out STD_LOGIC);
end component;
signal new_image_reg: STD_LOGIC;
signal valid_in_reg :  STD_LOGIC;
signal pixel_reg : STD_LOGIC_VECTOR (7 downto 0);
signal valid_out_reg :  STD_LOGIC;
signal image_finished_reg :  STD_LOGIC;
signal R_reg:  STD_LOGIC_VECTOR (7 downto 0):=(others=>'0');
signal B_reg:  STD_LOGIC_VECTOR (7 downto 0):=(others=>'0');
signal G_reg:  STD_LOGIC_VECTOR (7 downto 0):=(others=>'0');
begin
process(clk,rst_n)
begin
if rst_n='1' then
    new_image_reg<='0';
    valid_in_reg<='0';
    pixel_reg<=(others=>'0');
elsif rising_edge(clk) then
      new_image_reg<=new_image;
      valid_in_reg<=valid_in;
      pixel_reg<=pixel;  
     
end if;
end process;
DB: Debayering port map(clk,rst_n,valid_in_reg,new_image_reg,pixel_reg,valid_out_reg,G_reg(7 downto 0),B_reg(7 downto 0),R_reg(7 downto 0),image_finished_reg);
process(clk,rst_n)
begin
if rst_n='1' then
    image_finished<='0';
    valid_out<='0';
    R<=(others=>'0');
    B<=(others=>'0');
    G<=(others=>'0');
elsif rising_edge(clk) then
      R<=R_reg;
      B<=B_reg;
      G<=G_reg;
      valid_out<=valid_out_reg;
      image_finished<=image_finished_reg;  
     
end if;
end process;
end Behavioral;