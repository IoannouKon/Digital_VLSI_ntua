library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

entity wrapper is
--generic( N: integer :=32 );
  Port (
  clk : IN STD_LOGIC;
  rst : IN STD_LOGIC;
  pixel : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  valid_in,new_image : IN STD_LOGIC; --signals when it is valid to start the multiplication process
  R : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
  G : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
  B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
  --outputs :out STD_LOGIC_VECTOR(31 DOWNTO 0):=  (others => '0');
  valid_out: OUT STD_LOGIC;
  image_finished: OUT STD_LOGIC
  );
end wrapper;

architecture Behavioral of wrapper is

component ser_2_par is
   -- generic( N: integer  );  
    port (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        pixel : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        valid_in,new_image : IN STD_LOGIC; --signals when it is valid to start the multiplication process
        s00 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        s01 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        s02 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        s10 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        s11 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        s12 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        s20 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        s21 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        s22 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        col,row :  OUT std_logic_vector(integer(ceil(log2(real(32))))-1 downto 0)  :=  (others => '0') ;
        valid_out: OUT STD_LOGIC;
        counter_out: out  std_logic_vector(integer(ceil(log2(real(32*32)))) downto 0) :=  (others => '0') ;
        image_finished: OUT STD_LOGIC
    );
end component;

component debayer is
 -- generic( N: integer );
  Port (
  clk : IN STD_LOGIC;
  rst: IN STD_LOGIC;
  s2p_00 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_01 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_02 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_10 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_11 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_12 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_20 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_21 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_22 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  line_img : IN std_logic_vector(integer(ceil(log2(real(32))))-1 downto 0);
  column_img : IN std_logic_vector(integer(ceil(log2(real(32))))-1 downto 0);
  R : out std_logic_vector(7 downto 0);
  G : out std_logic_vector(7 downto 0);
  B : out std_logic_vector(7 downto 0) 
  );
end component;

constant N : integer := 32;
signal clk_signal, rst_signal: STD_LOGIC;
signal s00_signal, s01_signal, s02_signal, s10_signal, s11_signal, s12_signal: std_logic_vector(7 downto 0) :=  (others => '0');
signal s20_signal, s21_signal, s22_signal: std_logic_vector(7 downto 0) :=  (others => '0');
signal col_signal, row_signal: std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
signal counter_out:   std_logic_vector(integer(ceil(log2(real(N*N)))) downto 0) :=  (others => '0') ;
--signal Rsig :  STD_LOGIC_VECTOR(7 DOWNTO 0) :=  (others => '0'); 
--signal Gsig :  STD_LOGIC_VECTOR(7 DOWNTO 0) :=  (others => '0');
--signal Bsig :  STD_LOGIC_VECTOR(7 DOWNTO 0) :=  (others => '0');

begin 

 S2P : ser_2_par
--    generic map ( N => N )
    port map(
    clk => clk,
    rst => rst,
    pixel => pixel,
    valid_in => valid_in,
    new_image => new_image,
    s00 => s00_signal,
    s01 => s01_signal,
    s02 => s02_signal,
    s10 => s10_signal,
    s11 => s11_signal,
    s12 => s12_signal,
    s20 => s20_signal,
    s21 => s21_signal,
    s22 => s22_signal,
    valid_out => valid_out,
   image_finished =>  image_finished,
   counter_out => counter_out,
    row => row_signal,
    col => col_signal
    );

 --outputs <= "00000000"&Rsig&Gsig&Bsig;
--  R<=Rsig;
--  G<=Gsig;
--  B<=Bsig;
  
 debayer_box : debayer
--    generic map ( N => N )
    port map(
        clk => clk,
        rst => rst,
        s2p_00 => s00_signal,
        s2p_01 => s01_signal,
        s2p_02 => s02_signal,
        s2p_10 => s10_signal,
        s2p_11 => s11_signal,
        s2p_12 => s12_signal,
        s2p_20 => s20_signal,
        s2p_21 => s21_signal,
        s2p_22 => s22_signal,
        line_img => row_signal,
        column_img => col_signal,
        R => R,
        G => G,
        B => B); 
        
        
end ;

