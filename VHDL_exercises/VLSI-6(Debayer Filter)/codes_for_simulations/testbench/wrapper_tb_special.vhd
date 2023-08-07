library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;
use STD.TEXTIO.ALL;


entity wrapper_tb_special is
end wrapper_tb_special;

architecture test_bench of wrapper_tb_special is
 constant N_tb : integer := 32 ; 
 
 component wrapper 
--  generic( N: integer := 32); 
 Port (
  clk : IN STD_LOGIC;
  rst : IN STD_LOGIC;
  pixel : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
 valid_in,new_image : IN STD_LOGIC; --signals when it is valid to start the multiplication process
  R : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
  G : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
  B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
--  outputs :out STD_LOGIC_VECTOR(31 DOWNTO 0);
  valid_out: OUT STD_LOGIC;
  image_finished: OUT STD_LOGIC
  );
  end component;

 --Input Signals
    signal clk : std_logic := '0';
    signal rst: std_logic := '0';
    signal valid_in : std_logic := '1';
    signal new_image: std_logic:='0';
    signal pixel : STD_LOGIC_VECTOR(7 DOWNTO 0);
 --Output Signals
  signal R :  STD_LOGIC_VECTOR(7 DOWNTO 0);
  signal G :  STD_LOGIC_VECTOR(7 DOWNTO 0);
  signal B :  STD_LOGIC_VECTOR(7 DOWNTO 0);
  signal image_finished: STD_LOGIC;
  signal valid_out : std_logic := '0';
 signal outputs:std_logic_vector(31 downto 0);

 --Clock
 constant CLK_PERIOD : time := 10ns;
  -- Name of the text file
 -- constant FILENAME : string := "pixel_values.txt"; 

begin 
   wrapper_instance: wrapper
 --  generic map( N => N_tb ) 
  port map(   
        clk => clk,
        rst => rst,
        pixel => pixel,
        valid_in => valid_in,
        new_image => new_image,
       R => R,
       B => B,
       G => G,
  --     outputs => outputs ,
        image_finished => image_finished,
        valid_out => valid_out
        );

 clk_proc: process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;
    
    
    clk_proc_2: process
        begin
         --   rst <= '1';
          -- wait for 10*CLK_PERIOD;
            rst <= '0';
            valid_in <= '1';
            new_image <= '1';
            wait for clk_period;
        --    new_image <= '0';
          wait for 100000*CLK_PERIOD ;
        end process;
    test_debayer_from_file: process(clk,rst)
       file input_file      : text open read_mode is "C:\Users\User\Desktop\image_test.txt";
       variable row_read         : line;
       variable pixel_read  : integer;
       variable pixel_row_counter : integer := 0;
       
       file output_file    : text open write_mode is "C:\Users\User\Desktop\image_vhdl_out_official_TEST_NEW.txt";
       variable row_write  : line;
       
       
    begin
    if (rst='1') then
        pixel_row_counter     := 0;
        pixel_read            := -1;
    elsif (rising_edge(clk)) then
     valid_in <= '1';
    --    counter <= counter +1;
        
        
    
      
   
--      rst <= '0';
      -- read from input file in "row" variable
      if(not endfile(input_file) and rst='0') then
--          if (pixel_row_counter = 0) then
--              new_image <= '1';
--          else
              if (pixel_row_counter = N_tb*N_tb -1) then
                  pixel_row_counter := -1;
              end if;
--              new_image <= '0';
--          end if;                  
          pixel_row_counter := pixel_row_counter + 1;
          readline(input_file,row_read);
      end if;
      -- read integer number from "row" variable in integer array
      read(row_read,pixel_read);
      --valid_in <= '1';
      pixel <= std_logic_vector(to_unsigned(pixel_read,8));
      if (valid_out = '1') then
          write(row_write, to_integer(unsigned(R)), left, 4);
          write(row_write, to_integer(unsigned(G)), left, 4);
          write(row_write, to_integer(unsigned(B)), left, 4);
          writeline(output_file,row_write);
      end if;
      if  (image_finished = '1' and valid_out = '1') then
          write(row_write,string'("IMAGE FINISHED!"));
          writeline(output_file,row_write);
      end if;
    end if;
    end process;
    end test_bench;



     
