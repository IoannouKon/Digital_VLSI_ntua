library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier_tb is
end entity;

architecture sim of multiplier_tb is

    -- Component Declaration
    component multiplier is
        port (
            A, B : in  std_logic_vector(3 downto 0);
            P    : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signal Declaration
    signal A_signal, B_signal : std_logic_vector(3 downto 0);
    signal P_signal : std_logic_vector(7 downto 0);

begin

    -- Component Instantiation
    multiplier_inst : multiplier port map (
        A => A_signal,
        B => B_signal,
        P => P_signal
    );

    -- Stimulus Process
    stim_proc : process
    begin

        for i in 0 to 15 loop
            for j in 0 to 15 loop

                A_signal <= std_logic_vector(to_unsigned(i, 4));
                B_signal <= std_logic_vector(to_unsigned(j, 4));

                wait for 10 ns;

                report "A = " & integer'image(i) & ", B = " & integer'image(j) &
                       ", P = " & integer'image(to_integer(unsigned(P_signal))) &
                       " expected " & integer'image(i * j);

            end loop;
        end loop;

        wait;
    end process;

end architecture;
