
--DFF 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dff is
 port(
      d : in  std_logic;
      q : out  std_logic;
      clk : in std_logic;
      rst : in std_logic
     );
end entity;


--DFFinput
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity dff_big is
    Port ( d : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (7 downto 0));
end dff_big;

architecture Behavioral of dff_big is

begin
    process(clk, rst) begin
        if rst='1' then
            Q<="00000000";
        elsif rising_edge(clk) then
            Q<=D;
        end if;
    end process;
end Behavioral;


--DFF2
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dff2 is
    port(
        d : in  std_logic;
        q : out  std_logic;
        clk : in std_logic;
        rst : in std_logic
       );
end dff2;

architecture structural of dff2 is
    component dff is
        port(
          d : in  std_logic;
          q : out  std_logic;
          clk : in std_logic;
          rst : in std_logic
         );
end component;

signal buffer_bit : std_logic;
  begin
    delay3 : dff
    port map (
        d => d,
        q => buffer_bit,
        clk => clk,
        rst => rst
    );
    delay4 : dff 
    port map (
        d => buffer_bit,
        q => q,
        clk => clk,
        rst => rst
    );
end architecture;
--------------------------------------------------------------


architecture behavioural of dff is  
begin
   process(clk, rst)
   begin
       if rst = '1' then
           q <= '0';
       elsif clk' event and clk = '1' then
           q <= d;
       end if;
   end process;
end behavioural;


-- ROM
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity mlab_rom is
	 generic (
		coeff_width : integer :=8  				--- width of coefficients (bits)
	 );
    Port ( clk : in  STD_LOGIC;
		   en : in  STD_LOGIC;				--- operation enable
           addr : in  STD_LOGIC_VECTOR (2 downto 0);			-- memory address
           rom_out : out  STD_LOGIC_VECTOR (coeff_width-1 downto 0));	-- output data
    end mlab_rom;

architecture Behavioral of mlab_rom is
    type rom_type is array (7 downto 0) of std_logic_vector (coeff_width-1 downto 0);                  
                             signal rom : rom_type:= ("00001000", "00000111", "00000110", "00000101", "00000100", "00000011", "00000010",
                                                          "00000001");                  

    signal rdata : std_logic_vector(coeff_width-1 downto 0) := (others => '0');
begin
    rdata <= rom(conv_integer(addr));
    process (clk)
    begin
        if (clk'event and clk = '1') then
            if (en = '1') then
                rom_out <= rdata;
            end if;
        end if;
    end process;			
end Behavioral;

--RAM
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mlab_ram is
	 generic (
		data_width : integer :=8  				--- width of data (bits)
	 );
    port (clk  : in std_logic;
          rst  : in std_logic;
          we   : in std_logic;						--- memory write enable
		  en   : in std_logic;				--- operation enable
          addr : in std_logic_vector(2 downto 0);			-- memory address
          di   : in std_logic_vector(data_width-1 downto 0);		-- input data
          do   : out std_logic_vector(data_width-1 downto 0));		-- output data
end mlab_ram;

architecture Behavioral of mlab_ram is
    type ram_type is array (7 downto 0) of std_logic_vector (data_width-1 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
begin
    process (clk)
    begin
        if rst='1' then
             ram <= (others=>(others=>'0'));
        elsif clk'event and clk = '1' then
            if en = '1' then
                if we = '1' then				-- write operation
                   for i in 0 to 6 loop
                        RAM(7-i) <= RAM(6-i);
                   end loop;                
                    RAM(0) <= di; 
                    do <= di;
                else						-- read operation
                   do <= RAM( conv_integer(addr));                
                end if;
            end if;
        end if;
    end process;
end Behavioral;

---- Control Unit previous
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Control_Unit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           valid_in : in STD_logic;
           mac_init: out STD_LOGIC;
           ram_addr : out STD_LOGIC_VECTOR (2 downto 0);
           rom_addr : out STD_LOGIC_VECTOR (2 downto 0);
           counter: out STD_LOGIC_VECTOR (2 downto 0);
           we: out STD_LOGIC;  --to we twn RAM/ROM
           valid_out: out STD_LOGIC
           );
end entity Control_Unit;

architecture Behavioral of Control_Unit is
    signal count_reg : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');  
    signal  waitt : std_logic ;  
    signal calculate : std_logic := '0';
    signal flag : std_logic;
    signal valid_out_temp:  STD_LOGIC; 
    signal s1,s2,s3,s4,s5,s6 :std_logic ;
    
    
   --comp7
       component dff2 is
           port(
               d : in  std_logic;
               q : out  std_logic;
               clk : in std_logic;
               rst : in std_logic
              );
       end component;
       
 
begin

    process (clk)
    begin
    
       if rst = '1' then
          count_reg <= (others => '0');
         valid_out_temp<='0';
          mac_init<='1'; 
       elsif rising_edge(clk) then
       if (valid_in = '1') and (calculate = '0') then 
           flag<='1';
           --count_reg <= count_reg + 1;
           end if;
         if count_reg = "000" then 
          mac_init<='1'; 
--          flag <= '0';
            if calculate = '1' then 
               valid_out_temp <= '1';
            else   valid_out_temp <= '0';
             end if;   
             
            if(valid_in = '0') then 
             we<= '0';
            calculate <= '0';
          --  count_reg <= "000";
            
            else 
              we<= '1';
              calculate <= '1';
            end if;  
         else -- counter = mid
         we <='0';
         valid_out_temp<='0';
         mac_init<='0'; 
         end if;
         
         if count_reg = "111" then  
            flag <= '0' ;
            end if;
            
       if flag='1' then
           count_reg <= count_reg+1;
       else 
            count_reg <= "000";
       end if;
    ram_addr <= count_reg;
    rom_addr <= count_reg;
    counter <= count_reg;
    
   -- valid_out_dff: dff_big port map(d=>valid_out_temp, clk=>clk, rst=>rst, q=>valid_out);
    
  end if;
  end process; 
  
 -- valid_out <= valid_out_temp;
    valid_out_deff1 : dff2 port map(d=>valid_out_temp, clk=>clk, rst=>rst, q=>s1);
    valid_out_deff2 : dff2 port map(d=>s1, clk=>clk, rst=>rst, q=>s2);
    valid_out_deff3 : dff2 port map(d=>s2, clk=>clk, rst=>rst, q=>s3);
    valid_out_deff4 : dff2 port map(d=>s3, clk=>clk, rst=>rst, q=>valid_out);
 
end architecture;


--MAC
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MAC is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;  
           rom_out : in STD_LOGIC_VECTOR (7 downto 0);
           ram_out : in STD_LOGIC_VECTOR (7 downto 0);
           mac_init : in STD_LOGIC;
--           valid_out: in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (18 downto 0));
end entity MAC;

architecture Behavioral of MAC is
    signal  sum : STD_LOGIC_VECTOR (18 downto 0) := (others => '0');   

begin
    process (clk)
    begin
     if(rst = '1') then 
      sum <= (others => '0');
       elsif rising_edge(clk) then
            if mac_init = '1' then  
               sum <= (others => '0'); --Asing all '0's to my vector 
               sum(15 downto 0) <= rom_out*ram_out;
            else
               sum <=sum + rom_out*ram_out; -- Perform multiplication and addition;
         end if;
         y <= sum;
--         if valid_out = '1' then
--            y <= sum;  -- L = (2*N+1) bits 
--         else 
--            y <= (others => '0');
--        end if;
        end if; 
    end process;
end architecture;


--FIR_simple
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity FIR is
  Port ( clk : in std_logic;
         rst : in std_logic;
         valid_in : in std_logic;
         en_ram_rom: in std_logic;
         x : in std_logic_vector(7 downto 0);
         valid_out : out std_logic;
         y_final : out std_logic_vector (18 downto 0);
         rom_out,ram_out:out STD_LOGIC_VECTOR (7 downto 0);
         rom_add,ram_add,counter_control:out STD_LOGIC_VECTOR (2 downto 0);
         mac_init : out std_logic;
         we_out:out std_logic 
         ); 
end FIR;

architecture Behavioral of FIR is
    --comp1
    component mlab_rom is
	 generic (
		coeff_width : integer :=8  				--- width of coefficients (bits)
	 );
    Port ( clk : in  STD_LOGIC;
		   en : in  STD_LOGIC;				--- operation enable
           addr : in  STD_LOGIC_VECTOR (2 downto 0);			-- memory address
           rom_out : out  STD_LOGIC_VECTOR (coeff_width-1 downto 0));	-- output data
    end component;
    
    --comp2
    component mlab_ram is
         generic (
            data_width : integer :=8                  --- width of data (bits)
         );
        port (clk  : in std_logic;
              rst  : in std_logic;
              we   : in std_logic;                        --- memory write enable
              en   : in std_logic;                --- operation enable
              addr : in std_logic_vector(2 downto 0);            -- memory address
              di   : in std_logic_vector(data_width-1 downto 0);        -- input data
              do   : out std_logic_vector(data_width-1 downto 0));        -- output data
    end component;
    
    --comp3
    component Control_Unit is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               valid_in : in STD_logic;
               mac_init: out STD_LOGIC;
               ram_addr : out STD_LOGIC_VECTOR (2 downto 0);
               rom_addr : out STD_LOGIC_VECTOR (2 downto 0);
               we: out STD_LOGIC; --to we twn RAM/ROM
               counter: out STD_LOGIC_VECTOR (2 downto 0);
               valid_out: out STD_LOGIC
               );
    end component;
    
    --comp4
    component MAC is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;  
               rom_out : in STD_LOGIC_VECTOR (7 downto 0);
               ram_out : in STD_LOGIC_VECTOR (7 downto 0);
               mac_init : in STD_LOGIC;
--               valid_out: in STD_LOGIC;
               y : out STD_LOGIC_VECTOR (18 downto 0));
    end component;   
     
    --comp5
    component dff is
     port(
          d : in  std_logic;
          q : out  std_logic;
          clk : in std_logic;
          rst : in std_logic
         );
    end component;
    
    --comp6
    component dff_big is
        Port ( d : in STD_LOGIC_VECTOR (7 downto 0);
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               q : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    --comp7
    component dff2 is
        port(
            d : in  std_logic;
            q : out  std_logic;
            clk : in std_logic;
            rst : in std_logic
           );
    end component;
    
    signal x_dff,ram_out_temp,rom_out_temp : std_logic_vector(7 downto 0);
    signal ram_addr_temp, rom_addr_temp,counter_temp: std_logic_vector(2 downto 0);
    signal mac_init_temp, we_temp,valid_out_temp,mac_init_dff,valid_out_dff: std_logic;
    begin
    x_reg: dff_big port map(d=>x, clk=>clk, rst=>rst, q=>x_dff);
    control: Control_Unit port map(clk=>clk, rst=>rst, valid_in=>valid_in, mac_init=>mac_init_temp, ram_addr=>ram_addr_temp, rom_addr=>rom_addr_temp,we=>we_temp,valid_out=>valid_out_temp,counter=>counter_temp);
--    control: Control_Unit port map(clk=>clk, rst=>rst,  mac_init=>mac_init_temp, ram_addr=>ram_addr_temp, rom_addr=>rom_addr_temp,we=>we_temp);
    mac_init_reg : dff port map(d=>mac_init_temp, clk=>clk, rst=>rst, q=>mac_init_dff);
    valid_out_reg : dff2 port map(d=>valid_out_temp, clk=>clk, rst=>rst, q=>valid_out_dff);
    rom: mlab_rom port map(clk=>clk,en=>en_ram_rom, addr=>rom_addr_temp,rom_out=>rom_out_temp);
    ram: mlab_ram port map(clk=>clk, rst=>rst, en=>en_ram_rom, we=>we_temp ,addr=>ram_addr_temp,di=>x_dff, do=>ram_out_temp);
    macc: MAC port map(rst=>rst,clk=>clk, rom_out=>rom_out_temp, ram_out=>ram_out_temp, mac_init=>mac_init_dff, y=>y_final); 
   
    --just for simulation 
   --RAM_IN <= x_dff;
   mac_init <=mac_init_dff;
   we_out <= we_temp;
   ram_out <=ram_out_temp;
   rom_out <=rom_out_temp;  
   rom_add <=rom_addr_temp;
   ram_add <=ram_addr_temp;
   counter_control <= counter_temp;
   valid_out <=valid_out_dff;
   end Behavioral;
