library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
entity FifoGenerators is
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
    rows: in integer range 0 to 1023;
    columns: in integer range 0 to 1023 ;
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
end FifoGenerators;

architecture Behavioral of FifoGenerators is
constant width: integer:=1024;
COMPONENT fifo_generator_3
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    almost_full : OUT STD_LOGIC;
    wr_ack : OUT STD_LOGIC;
    overflow : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    almost_empty : OUT STD_LOGIC;
    valid : OUT STD_LOGIC;
    underflow : OUT STD_LOGIC
  );
END COMPONENT;
COMPONENT fifo_generator_2
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    almost_full : OUT STD_LOGIC;
    wr_ack : OUT STD_LOGIC;
    overflow : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    almost_empty : OUT STD_LOGIC;
    valid : OUT STD_LOGIC;
    underflow : OUT STD_LOGIC
  );
END COMPONENT;
COMPONENT fifo_generator_1
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    almost_full : OUT STD_LOGIC;
    wr_ack : OUT STD_LOGIC;
    overflow : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    almost_empty : OUT STD_LOGIC;
    valid : OUT STD_LOGIC;
    underflow : OUT STD_LOGIC
  );
END COMPONENT;
COMPONENT fifo_generator_0
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    almost_full : OUT STD_LOGIC;
    wr_ack : OUT STD_LOGIC;
    overflow : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    almost_empty : OUT STD_LOGIC;
    valid : OUT STD_LOGIC;
    underflow : OUT STD_LOGIC
  );
END COMPONENT;

component bit8Register is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (7 downto 0);
           en : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (7 downto 0));
end component;



 signal   d_0 :  STD_LOGIC_VECTOR (7 downto 0);
 signal   d_1 :  STD_LOGIC_VECTOR (7 downto 0);
 signal   d_2 :  STD_LOGIC_VECTOR (7 downto 0);
 signal   d_0_0:  std_logic_vector(7 downto 0);
 signal   d_0_1:  std_logic_vector(7 downto 0);
 signal   d_0_2:  std_logic_vector(7 downto 0);
 signal   d_1_0:  std_logic_vector(7 downto 0);
 signal   d_1_1:  std_logic_vector(7 downto 0);
 signal   d_1_2:  std_logic_vector(7 downto 0);
 signal   d_2_0:  std_logic_vector(7 downto 0);
 signal   d_2_1:  std_logic_vector(7 downto 0);
 signal   d_2_2:  std_logic_vector(7 downto 0);
begin
width16:if width=16 generate
FIFOGENERATOR0 : fifo_generator_1
  PORT MAP (
    clk => clk,
    srst => srst,
    din => din,
    wr_en => wr_en0,
    rd_en => rd_en0,
    dout => d_0,
    full => open,
    almost_full => open,
    wr_ack => open,
    overflow => open,
    empty => open,
    almost_empty => open,
    valid => open,
    underflow => open
  );
 
  FIFOGENERATOR1 : fifo_generator_1
  PORT MAP (
    clk => clk,
    srst => srst,
    din => d_0,
    wr_en => wr_en1,
    rd_en => rd_en1,
    dout => d_1,
    full => open,
    almost_full => open,
    wr_ack => open,
    overflow => open,
    empty => open,
    almost_empty => open,
    valid => open,
    underflow => open
  );
 
    FIFOGENERATOR2 : fifo_generator_1
  PORT MAP (
    clk => clk,
    srst => srst,
    din => d_1,
    wr_en => wr_en2,
    rd_en => rd_en2,
    dout => d_2,
    full => open,
    almost_full => open,
    wr_ack => open,
    overflow => open,
    empty => open,
    almost_empty => open,
    valid => open,
    underflow => open
  );
end generate;

width32:if width=1024 generate
FIFOGENERATOR0 : fifo_generator_0
  PORT MAP (
    clk => clk,
    srst => srst,
    din => din,
    wr_en => wr_en0,
    rd_en => rd_en0,
    dout => d_0,
    full => open,
    almost_full => open,
    wr_ack => open,
    overflow => open,
    empty => open,
    almost_empty => open,
    valid => open,
    underflow => open
  );
 
  FIFOGENERATOR1 : fifo_generator_0
  PORT MAP (
    clk => clk,
    srst => srst,
    din => d_0,
    wr_en => wr_en1,
    rd_en => rd_en1,
    dout => d_1,
    full => open,
    almost_full => open,
    wr_ack => open,
    overflow => open,
    empty => open,
    almost_empty => open,
    valid => open,
    underflow => open
  );
 
    FIFOGENERATOR2 : fifo_generator_0
  PORT MAP (
    clk => clk,
    srst => srst,
    din => d_1,
    wr_en => wr_en2,
    rd_en => rd_en2,
    dout => d_2,
    full => open,
    almost_full => open,
    wr_ack => open,
    overflow => open,
    empty => open,
    almost_empty => open,
    valid => open,
    underflow => open
  );
end generate;




D00:bit8Register port map(clk,srst,d_0,en,d_0_0);
D01:bit8Register port map(clk,srst,d_0_0,en,d_0_1);
D02:bit8Register port map(clk,srst,d_0_1,en,d_0_2);

D10:bit8Register port map(clk,srst,d_1,en,d_1_0);
D11:bit8Register port map(clk,srst,d_1_0,en,d_1_1);
D12:bit8Register port map(clk,srst,d_1_1,en,d_1_2);

D20:bit8Register port map(clk,srst,d_2,en,d_2_0);
D21:bit8Register port map(clk,srst,d_2_0,en,d_2_1);
D22:bit8Register port map(clk,srst,d_2_1,en,d_2_2);

dout_2_2<="00000000" when (rows=0 or columns=0) else
          d_2_2;
         
dout_2_1<="00000000" when rows=0 else
          d_2_1;
         
dout_2_0<="00000000" when(rows=0 or columns=width-1) else
           d_2_0;

dout_1_2<="00000000" when (columns=0) else
          d_1_2;
         
dout_1_1<=d_1_1;

dout_1_0<="00000000" when (columns=width-1) else
          d_1_0;

dout_0_2<="00000000" when (rows=width-1 or columns=0) else
          d_0_2;
         
dout_0_1<="00000000" when rows=width-1 else
          d_0_1;
         
dout_0_0<="00000000" when(rows=width-1 or columns=width-1) else
           d_0_0;        


central_color(1)<='0' when rows mod 2=0 else
                  '1';
                 
central_color(0)<='0' when columns mod 2=0 else
                  '1';        
end Behavioral;