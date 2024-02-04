library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
  Port (
    clk : in std_logic;
    CE : in std_logic;
    rw : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    addr : in std_logic_vector(11 downto 0);
    data_out : out std_logic_vector(7 downto 0)
   );
end RAM;


architecture Behavioral of RAM is
    type ram_type is array (4096 downto 0) of std_logic_vector (7 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
    signal address : std_logic_vector(11 downto 0);
    
begin
    process(clk, CE)
    begin
        if CE = '1' then
            if rising_edge(clk) then
                address <= addr;
            elsif falling_edge(clk) then
                if rw = '1' then 
                    RAM(conv_integer(address)) <= data_in;
                else 
                    data_out <= RAM(conv_integer(address));
                end if; 
            end if; 
        end if;
    end process;
end Behavioral;
