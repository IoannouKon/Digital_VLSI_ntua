----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 06/05/2023 10:11:01 PM
-- Design Name:
-- Module Name: Debayering - Behavioral
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

entity Debayering is
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
end Debayering;


architecture Behavioral of Debayering is
constant width: integer:=1024;
component ControlUnit2 is
--    generic(
--        width:integer:=32
--    );

    Port (
        clk:in std_logic;
        reset:in std_logic;
        valid_in:in std_logic;
        new_image:in std_logic;
        pixel:in std_logic_vector(7 downto 0);
        pixel_out : out STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr_en0 : out STD_LOGIC;  
        rd_en0 : out STD_LOGIC;
        wr_en1 : out STD_LOGIC;  
        rd_en1 : out STD_LOGIC;
        wr_en2 : out STD_LOGIC;  
        rd_en2 : out STD_LOGIC;  
        en : out STD_LOGIC;    
        srst : out STD_LOGIC;
        valid_out : out STD_LOGIC;
        image_finished : out STD_LOGIC;
        rows: out integer range 0 to width-1;
        columns: out integer range 0 to width-1
    );
end component;

component Average is
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
end component;

component FifoGenerators is
--generic(
--    width:integer:=32
--);
  Port (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en0 : IN STD_LOGIC;  
    rd_en0 : IN STD_LOGIC;
    wr_en1 : IN STD_LOGIC;  
    rd_en1 : IN STD_LOGIC;
    wr_en2 : IN STD_LOGIC;  
    rd_en2 : IN STD_LOGIC;
   

   
 
    en : IN STD_LOGIC;
       
   
   
    rows: in integer range 0 to width-1;
    columns: in integer range 0 to width-1;
    central_color: out std_logic_vector(1 downto 0);
    dout_0_0: out std_logic_vector(7 downto 0);
    dout_0_1: out std_logic_vector(7 downto 0);
    dout_0_2: out std_logic_vector(7 downto 0);
    dout_1_0: out std_logic_vector(7 downto 0);
    dout_1_1: out std_logic_vector(7 downto 0);
    dout_1_2: out std_logic_vector(7 downto 0);
    dout_2_0: out std_logic_vector(7 downto 0);
    dout_2_1: out std_logic_vector(7 downto 0);
    dout_2_2: out std_logic_vector(7 downto 0)
   
   
   );
end component;
signal pixel_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
signal wr_en0 :  STD_LOGIC;  
signal rd_en0 :  STD_LOGIC;
signal wr_en1 :  STD_LOGIC;  
signal rd_en1 :  STD_LOGIC;
signal wr_en2 :  STD_LOGIC;  
signal rd_en2 :  STD_LOGIC;
signal en :  STD_LOGIC;
signal srst :  STD_LOGIC;
signal rows:  integer range 0 to width-1;
signal columns:  integer range 0 to width-1;


signal central_color:std_logic_vector(1 downto 0);
signal dout_0_0:  std_logic_vector(7 downto 0);
signal dout_0_1:  std_logic_vector(7 downto 0);
signal dout_0_2:  std_logic_vector(7 downto 0);
signal dout_1_0:  std_logic_vector(7 downto 0);
signal dout_1_1:  std_logic_vector(7 downto 0);
signal dout_1_2:  std_logic_vector(7 downto 0);
signal dout_2_0:  std_logic_vector(7 downto 0);
signal dout_2_1:  std_logic_vector(7 downto 0);
signal dout_2_2:  std_logic_vector(7 downto 0);

signal valid_out_reg:std_logic;
signal image_finished_reg:std_logic;
begin
CU:ControlUnit2 port map(clk,reset,valid_in,new_image,pixel,pixel_out,wr_en0,rd_en0,wr_en1,rd_en1,wr_en2,rd_en2,en,srst,valid_out_reg,image_finished_reg,rows,columns);
process(clk,reset)
begin
if reset='1' then image_finished<='0'; valid_out<='0';
elsif rising_edge(clk) then image_finished<=image_finished_reg; valid_out<=valid_out_reg;
end if;
end process;
FG:FifoGenerators port map(clk,srst,pixel_out,wr_en0,rd_en0,wr_en1,rd_en1,wr_en2,rd_en2,en,rows,columns,central_color,dout_0_0,dout_0_1,dout_0_2,dout_1_0,dout_1_1,dout_1_2,dout_2_0,dout_2_1,dout_2_2);
Avg:Average port map(dout_0_0,dout_0_1,dout_0_2,dout_1_0,dout_1_1,dout_1_2,dout_2_0,dout_2_1,dout_2_2,central_color,'1',clk,GREEN,BLUE,RED);
end Behavioral;
