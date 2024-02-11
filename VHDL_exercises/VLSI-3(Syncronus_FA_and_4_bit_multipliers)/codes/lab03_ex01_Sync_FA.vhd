library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fa_clk is port(
    a: in std_logic;
    b: in std_logic;
    cin: in std_logic;
    sout: out std_logic;
    cout: out std_logic;
    rst : in std_logic;
    clk : in std_logic
);
end fa_clk;

architecture Behavioural of fa_clk is    

signal out_temp : std_logic_vector(1 downto 0) := (others => '0');
begin

    process(clk, rst)
    begin
        if rst = '0' then
            out_temp <= "00";
        elsif rising_edge(clk) then
            out_temp <= ('0' & a) + ('0' & b) + ('0' & cin);
        end if;
    end process;
    sout <= out_temp(0);
    cout <= out_temp(1);
end Behavioural;
