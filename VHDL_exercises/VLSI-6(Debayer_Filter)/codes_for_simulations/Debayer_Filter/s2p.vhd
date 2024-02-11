library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

entity ser_2_par is
 --gneric( N: integer := 32 );
    port (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        pixel : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        valid_in,new_image : IN STD_LOGIC; --signals when it is valid to start the multiplication process
        s00 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s01 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s02 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s10 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s11 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s12 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s20 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s21 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s22 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        col,row : OUT std_logic_vector(integer(ceil(log2(real(32))))-1 downto 0)  :=  (others => '0') ;
        valid_out: OUT STD_LOGIC;
        counter_out: out  std_logic_vector(integer(ceil(log2(real(32*32)))) downto 0) :=  (others => '0') ;
        image_finished: OUT STD_LOGIC := '0' 
    );
end ser_2_par;
architecture Behavioral of ser_2_par is
--add all components


  
  COMPONENT fifo_generator_1024
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
   -- wr_ack : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
   -- valid : OUT STD_LOGIC
  );
END COMPONENT;

component dff is
    port(
      d : in  std_logic_vector(7 downto 0);
      q : out  std_logic_vector(7 downto 0);
      clk : in std_logic;
      rst : in std_logic
     );
end component;


signal fout2, fout1, fout0 : std_logic_vector(7 downto 0) :=  (others => '0') ;
signal  rd_en0: std_logic := '0';
signal  rd_en1: std_logic := '0';
signal  rd_en2: std_logic := '0';
signal  wr_en0: std_logic := '1';
signal  wr_en1: std_logic := '1';
signal  wr_en2: std_logic := '1';
signal full0, full1, full2, empty0, empty1, empty2, valid0, valid1, valid2: std_logic;
signal wr_ack0,wr_ack1,wr_ack2: std_logic;
-- new signals 
signal FLAG :std_logic  := '0';
signal t1,t2,t3,t4,t5,t6,t7,t8,t9,t1_extra : STD_LOGIC_VECTOR(7 DOWNTO 0)  :=  (others => '0');
signal ACTIVATE : std_logic := '0';
signal  flag1,flag2,flag3 : std_logic := '0';
signal counter_begin :  std_logic_vector(integer(ceil(log2(real(32*32)))) downto 0) :=  (others => '0') ;
signal counter_image : std_logic_vector(integer(ceil(log2(real(32))))-1 downto 0) :=  (others => '0');
signal col_temp,row_temp :  std_logic_vector(integer(ceil(log2(real(32))))-1 downto 0) :=  (others => '0');
signal  col_signal : std_logic_vector(integer(ceil(log2(real(32))))-1 downto 0)  :=  (others => '0') ;
signal counter_stall : std_logic_vector(integer(ceil(log2(real(32))))-1 downto 0) :=  (others => '0');
 
begin
RAM_FIFO_0 : fifo_generator_1024
    PORT MAP (
        clk => clk,
        srst => rst,
        din => pixel,
        wr_en => wr_en0,
        rd_en => rd_en0,
        dout => fout0,
        full => full0,
      --  wr_ack => wr_ack0,
        empty => empty0
     --   valid => valid0
    );

RAM_FIFO_1 : fifo_generator_1024
PORT MAP (
    clk => clk,
    srst => rst,
    din => fout0,
    wr_en => wr_en1,
    rd_en => rd_en1,
    dout => fout1,
    full => full1,
   -- wr_ack => wr_ack1,
    empty => empty1
  --  valid => valid1
);

RAM_FIFO_2 : fifo_generator_1024
PORT MAP (
    clk => clk,
    srst => rst,
    din => fout1,
    wr_en => wr_en2,
    rd_en => rd_en2,
    dout => fout2,
    full => full2,
    --wr_ack => wr_ack2,
    empty => empty2
    --valid => valid2
);

-- 3*3 array with DFF
--dff00_extra : dff port map(d=>fout0, clk=>clk, rst=>rst, q=>t1_extra);
 
dff00 : dff port map(d=>fout0, clk=>clk, rst=>rst, q=>t1);
 s00 <=t1;
dff01 : dff port map(d=>t1, clk=>clk, rst=>rst, q=>t2);
 s01 <=t2;
dff02 : dff port map(d=>t2, clk=>clk, rst=>rst, q=>t3);
 s02 <=t3;
dff10 : dff port map(d=>fout1, clk=>clk, rst=>rst, q=>t4);
 s10 <=t4;
dff11 : dff port map(d=>t4, clk=>clk, rst=>rst, q=>t5);
 s11 <=t5;
dff12 : dff port map(d=>t5, clk=>clk, rst=>rst, q=>t6);
 s12 <=t6;
dff20 : dff port map(d=>fout2, clk=>clk, rst=>rst, q=>t7);
 s20 <=t7;
dff21 : dff port map(d=>t7,clk=>clk, rst=>rst, q=>t8);
 s21 <=t8;
dff22 : dff port map(d=>t8, clk=>clk, rst=>rst, q=>t9);
 s22 <=t9;
 


 process(clk,rst) 
 constant N : integer := 32;
 begin 
   if(rst = '1') then 
        
       -- add code here
                  wr_en0 <= '0';
                  rd_en0 <= '0';
                  wr_en1 <= '0';
                  rd_en1 <= '0';
                  wr_en2 <= '0';
                  rd_en2 <= '0';
                  valid_out <='0';
                 image_finished <= '0'; 
 
     --RESET  
    elsif rising_edge(clk) then
       if(ACTIVATE = '0') then
           valid_out <='0'; 
           image_finished <='0';
       end if;
       if ( ACTIVATE = '0' AND valid_in = '1'  AND new_image ='1' ) then 
            counter_begin <= (others => '0'); 
            row_temp<= (others => '0') ; --new code
            col_temp <= (others => '0') ; --new code
            ACTIVATE <= '1'; 
            image_finished <='0';
       
       else if ((ACTIVATE = '1' AND valid_in = '0' ) and FLAG = '0') then 
          --stall 
           wr_en0 <= '0';
           rd_en0 <= '0';
           wr_en1 <= '0';
           rd_en1 <= '0';
           wr_en2 <= '0';
           rd_en2 <= '0';
           counter_begin <= (others => '0');
          -- valid_out <='0';
           counter_stall <= counter_stall +1;
           
      else if( (ACTIVATE = '1' AND valid_in = '1')or FLAG = '1') then 
        -- do things
         wr_en0 <= '1';
---------------------------------------
          if(counter_begin > N*N) then 
                  FLAG <= '1';
                  end if;
                  
          if(FLAG ='1') then 
            valid_out <= '1';
          end if;
---------------------------------------------
           
         counter_begin <= counter_begin + 1 ;
         counter_out <=counter_begin;
         
       

   
         if (to_integer(unsigned(counter_begin)) >= N-3) then  
                   rd_en0 <= '1';
                   wr_en1 <='1';
           
                      rd_en1 <='1';
                      wr_en2 <='1';
           
                      rd_en2 <='1';
         end if;
           
           
             if (to_integer(unsigned(counter_begin)) >= N-3) then       
                  rd_en1 <='1';
                  wr_en2 <='1';
                  rd_en2 <='1';
                end if;



         
        if( counter_begin > 2*N+1 and  counter_stall =  0 ) then
          valid_out <='1';
           counter_stall <= (others=>'0');
        end if;
        
        
        if(  counter_stall >  0 ) then 
                 valid_out <='0';                  
                 counter_stall <= counter_stall-1;
        end if;
                          
             
         if( counter_begin > 2*N ) then --2*N+3 before 


              
             if(flag1 ='1')then 
                   flag1 <='0';
                   row <= row_temp;
                   col_temp <= (others => '0') ;
                 end if;
              
            
                  
             col_signal <=col_temp;
             col <=  col_temp;
             col_temp <= col_temp+1;
           
              
             if (to_integer(unsigned(col_signal)) = N-2) then   
                   row_temp <= row_temp + 1 ;
                    col_temp <= (others => '0') ;
                   flag1<='1';
             end if;
                                    
          if (to_integer(unsigned(row_temp))= N-1 and to_integer(unsigned(col_signal)) = N-1) then 
                    flag2 <= '1';
                    end if;
           
          if(flag2 = '1' and col_signal = N-1 ) then 
                   image_finished <= '1';
                   activate <= '0';
                   flag2 <='0';
                   FLAG <='0';
           --   else 
             --      image_finished <= '0';
              end if;
              
          end if;
          end if;
          end if;
         end if;
         end if;
  end process;
end architecture;