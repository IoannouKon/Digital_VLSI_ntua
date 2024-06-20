----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 06/03/2023 02:06:58 PM
-- Design Name:
-- Module Name: ControlUnit - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlUnit2 is
--    generic(
--        width:integer:=32
--    );

    Port (
        clk:in std_logic;
        reset:in std_logic;
        valid_in:in std_logic;
        new_image:in std_logic;
        pixel:in std_logic_vector(7 downto 0);
        pixel_out : out STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr_en0 : out STD_LOGIC;  
        rd_en0 : out STD_LOGIC;
        wr_en1 : out STD_LOGIC;  
        rd_en1 : out STD_LOGIC;
        wr_en2 : out STD_LOGIC;  
        rd_en2 : out STD_LOGIC;  
        en : out STD_LOGIC;    
        srst : out STD_LOGIC;
        valid_out : out STD_LOGIC;
        image_finished : out STD_LOGIC;
        rows: out integer range 0 to 1023;
        columns: out integer range 0 to 1023
    );
end ControlUnit2;
architecture Behavioral of ControlUnit2 is
constant width: integer:=1024;
signal counter: integer range 0 to width*width+2*width+1;
signal rows_sig:  integer range 0 to width-1:=0;
signal columns_sig:  integer range 0 to width-1:=0;
begin
rows<=rows_sig;
columns<=columns_sig;
process(clk,reset)
begin
if reset='1' then
    counter<=0;
    srst<='1';
    wr_en0<='0';
    rd_en0<='0';
    wr_en1<='0';
    rd_en1<='0';
    wr_en2<='0';
    rd_en2<='0';
    pixel_out<=(others=>'0');
    en<='0';
    rows_sig<=0;
    columns_sig<=0;
    valid_out<='0';
    image_finished<='0';
elsif rising_edge(clk) then
    if counter=0 then
        if(new_image='0' or valid_in='0') then
            counter<=0;
            srst<='1';
            wr_en0<='0';
            rd_en0<='0';
            wr_en1<='0';
            rd_en1<='0';
            wr_en2<='0';
            rd_en2<='0';
            pixel_out<=(others=>'0');
            en<='0';
            rows_sig<=0;
            columns_sig<=0;
            valid_out<='0';
            image_finished<='0';
         else
            counter<=counter+1;
            srst<='0';
            wr_en0<='1';
            rd_en0<='0';
            wr_en1<='0';
            rd_en1<='0';
            wr_en2<='0';
            rd_en2<='0';
            pixel_out<=pixel;
            en<='0';
            rows_sig<=0;
            columns_sig<=0;  
            valid_out<='0';
            image_finished<='0';                
        end if;
    elsif (valid_in='0' and counter<width*width) then
            counter<=counter;
            srst<='0';
            wr_en0<='0';
            rd_en0<='0';
            wr_en1<='0';
            rd_en1<='0';
            wr_en2<='0';
            rd_en2<='0';
            pixel_out<=pixel;
            en<='0';
            rows_sig<=rows_sig;
            columns_sig<=columns_sig;
            valid_out<='0';
            image_finished<='0';
    else    
            pixel_out<=pixel;    
            if(counter > 2*width+2) then
                if (columns_sig=width-1) then
                    columns_sig<=0;
                    if(rows_sig=width-1) then rows_sig<=0; else
                    rows_sig<=rows_sig+1; end if;
                 else columns_sig<=columns_sig+1;
                 end if;
            end if;
            if counter<width-1 then
                counter<= counter+1;
                wr_en0<='1';
            elsif counter < width then
                rd_en0<='1';
                counter<=counter+1;
                wr_en0<='1';
            elsif counter<2*width-1 then
                counter<=counter+1;
                rd_en0<='1';
                wr_en1<='1';
                wr_en0<='1';
            elsif counter<2*width then
                counter<=counter+1;
                rd_en0<='1';
                wr_en1<='1';
                rd_en1<='1';
                wr_en0<='1';
            elsif counter<2*width+2 then
                counter<=counter+1;
                rd_en0<='1';
                wr_en1<='1';
                rd_en1<='1';
                wr_en0<='1';
                en<='1';
                wr_en2<='1';
            elsif counter<3*width-1 then
                counter<=counter+1;
                rd_en0<='1';
                wr_en1<='1';
                rd_en1<='1';
                wr_en0<='1';
                en<='1';
                wr_en2<='1';
                valid_out<='1';
            elsif counter<width*width then
                counter<=counter+1;
                rd_en0<='1';
                wr_en1<='1';
                rd_en1<='1';
                wr_en0<='1';
                en<='1';
                wr_en2<='1';
                valid_out<='1';
                rd_en2<='1';
            elsif counter<width*width+width-1 then
                counter<=counter+1;
                rd_en0<='1';
                wr_en1<='1';
                rd_en1<='1';
                wr_en0<='0';
                en<='1';
                wr_en2<='1';
                valid_out<='1';
                rd_en2<='1';
            elsif counter<width*width+width then
                counter<=counter+1;
                rd_en0<='0';
                wr_en1<='1';
                rd_en1<='1';
                wr_en0<='0';
                en<='1';
                wr_en2<='1';
                valid_out<='1';
                rd_en2<='1';
            elsif counter<width*width+2*width-1 then
                counter<=counter+1;
                rd_en0<='0';
                wr_en1<='0';
                rd_en1<='1';
                wr_en0<='0';
                en<='1';
                wr_en2<='1';
                valid_out<='1';
                rd_en2<='1';
            elsif counter<width*width+2*width+1 then
                counter<=counter+1;
                rd_en0<='0';
                wr_en1<='0';
                rd_en1<='0';
                wr_en0<='0';
                en<='1';
                wr_en2<='1';
                valid_out<='1';
                rd_en2<='1';
            elsif counter=width*width+2*width+1 then
                counter<=0;
                rd_en0<='0';
                wr_en1<='0';
                rd_en1<='0';
                wr_en0<='0';
                en<='1';
                wr_en2<='1';
                valid_out<='1';
                rd_en2<='1';
                image_finished<='1';
                end if;
    end if;
end if;
end process;

end Behavioral;