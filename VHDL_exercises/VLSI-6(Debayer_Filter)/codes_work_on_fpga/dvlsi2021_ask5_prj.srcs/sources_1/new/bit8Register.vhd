----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 05/22/2023 10:17:03 PM
-- Design Name:
-- Module Name: 8bit_Register - Behavioral
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

entity bit8Register is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (7 downto 0);
           en : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (7 downto 0));
end bit8Register;

architecture Behavioral of bit8Register is
begin
process(clk)
begin
if rising_edge(clk) then
if reset='1' then
    dout<=(others=>'0');

     elsif en='1' then
        dout<=din;
    end if;
end if;
end process;
end Behavioral;