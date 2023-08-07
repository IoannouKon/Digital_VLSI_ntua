entity up_down_counter is
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           updn: in STD_LOGIC;
           load: in std_logic;
           data_in: in STD_LOGIC_VECTOR(31 downto 0);
           data_out : out std_logic_vector(31 downto 0)
           );
end up_down_counter;

architecture Behavioral of up_down_counter is
signal count: std_logic_vector(3 downto 0);
begin
    process(clk, reset)
    begin
        if reset='1' then
            count <= (others=>'0'); -- Code for reset
        elsif rising_edge(clk) then --clock rising edge
            if enable='1' then
                    if updn='0' then
                        if count/="0000" then
                            count<=count-1;
                        else count<="1001";
                        end if;
                    else 
                        if count/="1001" then
                             count<=count+1;
                        else count<="0000";
                        end if;
                    end if;
                else 
            end if;
        end if;
    end process;
    data_out <= count; -- Output signal
end Behavioral;