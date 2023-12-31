library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm is
  Port ( 
      clk: in std_logic;
      inp: in STD_logic;
      rst: in std_logic;
      outp: out std_logic_vector(1 downto 0)
      );
end fsm;

architecture Behavioral of fsm is
type state_type is (ST0,ST1,ST2,ST3);
signal PS,NS: state_type;
begin
    sync_proc: process (clk,rst)
    begin
        if rst='1' then
            PS<=ST0;
        elsif rising_edge(clk) then
            PS<=NS;
        end if;
    end process;

    comb_proc: process(PS,inp)
    begin
        case PS is
            when ST0=>
                outp<="00";
                if inp='0' then NS<=ST0;
                else NS<=ST1;
                end if;
            when ST1=>
                outp<="01";
                if inp='0' then NS<=ST2;
                else NS<=ST3;
                end if;
            when ST2=>
                outp<="10";
                if inp='0' then NS<=ST2;
                else NS<=ST3;
                end if;
            when ST3=>
                outp<="11";
                if inp='0' then NS<=ST1;
                else NS<=ST0;
                end if;
            when others=>
                 NS<=ST0;
                 outp<="00";
        end case;
    end process;

end Behavioral;
