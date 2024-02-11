library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dvlsi2021_lab5_top is
  port (
        DDR_cas_n         : inout STD_LOGIC;
        DDR_cke           : inout STD_LOGIC;
        DDR_ck_n          : inout STD_LOGIC;
        DDR_ck_p          : inout STD_LOGIC;
        DDR_cs_n          : inout STD_LOGIC;
        DDR_reset_n       : inout STD_LOGIC;
        DDR_odt           : inout STD_LOGIC;
        DDR_ras_n         : inout STD_LOGIC;
        DDR_we_n          : inout STD_LOGIC;
        DDR_ba            : inout STD_LOGIC_VECTOR( 2 downto 0);
        DDR_addr          : inout STD_LOGIC_VECTOR(14 downto 0);
        DDR_dm            : inout STD_LOGIC_VECTOR( 3 downto 0);
        DDR_dq            : inout STD_LOGIC_VECTOR(31 downto 0);
        DDR_dqs_n         : inout STD_LOGIC_VECTOR( 3 downto 0);
        DDR_dqs_p         : inout STD_LOGIC_VECTOR( 3 downto 0);
        FIXED_IO_mio      : inout STD_LOGIC_VECTOR(53 downto 0);
        FIXED_IO_ddr_vrn  : inout STD_LOGIC;
        FIXED_IO_ddr_vrp  : inout STD_LOGIC;
        FIXED_IO_ps_srstb : inout STD_LOGIC;
        FIXED_IO_ps_clk   : inout STD_LOGIC;
        FIXED_IO_ps_porb  : inout STD_LOGIC
       );
end entity; -- dvlsi2021_lab5_top

architecture arch of dvlsi2021_lab5_top is

  component design_1_wrapper is
    port (
          DDR_cas_n         : inout STD_LOGIC;
          DDR_cke           : inout STD_LOGIC;
          DDR_ck_n          : inout STD_LOGIC;
          DDR_ck_p          : inout STD_LOGIC;
          DDR_cs_n          : inout STD_LOGIC;
          DDR_reset_n       : inout STD_LOGIC;
          DDR_odt           : inout STD_LOGIC;
          DDR_ras_n         : inout STD_LOGIC;
          DDR_we_n          : inout STD_LOGIC;
          DDR_ba            : inout STD_LOGIC_VECTOR( 2 downto 0);
          DDR_addr          : inout STD_LOGIC_VECTOR(14 downto 0);
          DDR_dm            : inout STD_LOGIC_VECTOR( 3 downto 0);
          DDR_dq            : inout STD_LOGIC_VECTOR(31 downto 0);
          DDR_dqs_n         : inout STD_LOGIC_VECTOR( 3 downto 0);
          DDR_dqs_p         : inout STD_LOGIC_VECTOR( 3 downto 0);
          FIXED_IO_mio      : inout STD_LOGIC_VECTOR(53 downto 0);
          FIXED_IO_ddr_vrn  : inout STD_LOGIC;
          FIXED_IO_ddr_vrp  : inout STD_LOGIC;
          FIXED_IO_ps_srstb : inout STD_LOGIC;
          FIXED_IO_ps_clk   : inout STD_LOGIC;
          FIXED_IO_ps_porb  : inout STD_LOGIC;
          --------------------------------------------------------------------------
          ----------------------------------------------- PL (FPGA) COMMON INTERFACE
          ACLK                                : out STD_LOGIC;
          ARESETN                             : out STD_LOGIC_VECTOR(0 to 0);
          ------------------------------------------------------------------------------------
          -- PS2PL-DMA AXI4-STREAM MASTER INTERFACE TO ACCELERATOR AXI4-STREAM SLAVE INTERFACE
          M_AXIS_TO_ACCELERATOR_tdata         : out STD_LOGIC_VECTOR(7 downto 0);
          M_AXIS_TO_ACCELERATOR_tkeep         : out STD_LOGIC_VECTOR( 0    to 0);
          M_AXIS_TO_ACCELERATOR_tlast         : out STD_LOGIC;
          M_AXIS_TO_ACCELERATOR_tready        : in  STD_LOGIC;
          M_AXIS_TO_ACCELERATOR_tvalid        : out STD_LOGIC;
          ------------------------------------------------------------------------------------
          -- ACCELERATOR AXI4-STREAM MASTER INTERFACE TO PL2P2-DMA AXI4-STREAM SLAVE INTERFACE
          S_AXIS_S2MM_FROM_ACCELERATOR_tdata  : in  STD_LOGIC_VECTOR(31 downto 0);
          S_AXIS_S2MM_FROM_ACCELERATOR_tkeep  : in  STD_LOGIC_VECTOR( 3 downto 0);
          S_AXIS_S2MM_FROM_ACCELERATOR_tlast  : in  STD_LOGIC;
          S_AXIS_S2MM_FROM_ACCELERATOR_tready : out STD_LOGIC;
          S_AXIS_S2MM_FROM_ACCELERATOR_tvalid : in  STD_LOGIC
         );
  end component design_1_wrapper;

--------------------------component to DB_FILTER
 component wrapper is
 generic( N: integer := 32 );
   Port (
   clk : IN STD_LOGIC;
   rst : IN STD_LOGIC;
   pixel : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
   valid_in: IN STD_LOGIC; 
   new_image : IN STD_LOGIC; 
   R : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
   G : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
   B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
   valid_out: OUT STD_LOGIC;
   outputs :out STD_LOGIC_VECTOR(31 DOWNTO 0):=  (others => '0');
   image_finished: OUT STD_LOGIC

   );
  end component;
-------------------------------------------
-- INTERNAL SIGNAL & COMPONENTS DECLARATION

  signal aclk    : std_logic;
  signal aresetn : std_logic_vector(0 to 0);

  signal tmp_tdata  : std_logic_vector(7 downto 0);
  signal tmp_tkeep  : std_logic_vector(0 downto 0);
  signal tmp_tlast  : std_logic;
  signal tmp_tready : std_logic;
  signal tmp_tvalid : std_logic;
  signal tmp_tdata2  : std_logic_vector(32 downto 0);

-- signals for my DB filter
  signal rst_ip : std_logic;
  signal valid_in_ip: std_logic;
  signal new_image_ip: std_logic;
  signal valid_out_ip: std_logic;
  signal finished_image_ip: std_logic;
  signal pixel_ip: std_logic_vector(7 downto 0);
  signal R_ip: std_logic_vector(7 downto 0) := "00000000";
  signal G_ip: std_logic_vector(7 downto 0) := "00000000";
  signal B_ip: std_logic_vector(7 downto 0):= "00000000";
  signal X,Y,Z: std_logic_vector(7 downto 0) ;
  
  -----signals for AXI stream Slave
  signal Slave_TDATA :std_logic_vector(7 downto 0); 
  signal Slave_TVALID: std_logic; 
  signal Slave_TLAST: std_logic;
  signal Slave_TREADY:std_logic:= '0';
  -----signals for AXI stream Master
  signal Master_TDATA :std_logic_vector(31 downto 0); 
  signal Master_TVALID: std_logic;
  signal Master_TLAST: std_logic;
  signal Master_TREADY:std_logic:= '0';
  ----------------------
  signal flag: std_logic:= '0';
  signal flag2: std_logic:= '0';
  signal prev_valid : std_logic:='0';
  signal counter :  std_logic_vector(integer(ceil(log2(real(32*32)))) downto 0) :=  (others => '0') ;
  ---
  signal pixel_temp  : std_logic_vector(7 downto 0);
begin

  PROCESSING_SYSTEM_INSTANCE : design_1_wrapper
    port map (
              DDR_cas_n         => DDR_cas_n,
              DDR_cke           => DDR_cke,
              DDR_ck_n          => DDR_ck_n,
              DDR_ck_p          => DDR_ck_p,
              DDR_cs_n          => DDR_cs_n,
              DDR_reset_n       => DDR_reset_n,
              DDR_odt           => DDR_odt,
              DDR_ras_n         => DDR_ras_n,
              DDR_we_n          => DDR_we_n,
              DDR_ba            => DDR_ba,
              DDR_addr          => DDR_addr,
              DDR_dm            => DDR_dm,
              DDR_dq            => DDR_dq,
              DDR_dqs_n         => DDR_dqs_n,
              DDR_dqs_p         => DDR_dqs_p,
              FIXED_IO_mio      => FIXED_IO_mio,
              FIXED_IO_ddr_vrn  => FIXED_IO_ddr_vrn,
              FIXED_IO_ddr_vrp  => FIXED_IO_ddr_vrp,
              FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
              FIXED_IO_ps_clk   => FIXED_IO_ps_clk,
              FIXED_IO_ps_porb  => FIXED_IO_ps_porb,
              --------------------------------------------------------------------------
              ----------------------------------------------- PL (FPGA) COMMON INTERFACE
                            ACLK                                => aclk,    -- clock to accelerator
                            ARESETN                             => aresetn, -- reset to accelerator, active low
                            ------------------------------------------------------------------------------------
                            -- PS2PL-DMA AXI4-STREAM MASTER INTERFACE TO ACCELERATOR AXI4-STREAM SLAVE INTERFACE
                            M_AXIS_TO_ACCELERATOR_tdata         =>  pixel_ip,
                            M_AXIS_TO_ACCELERATOR_tkeep         => tmp_tkeep,
                            M_AXIS_TO_ACCELERATOR_tlast         => Slave_TLAST,
                            M_AXIS_TO_ACCELERATOR_tready        => '1',
                            M_AXIS_TO_ACCELERATOR_tvalid        =>  valid_in_ip,
                            ------------------------------------------------------------------------------------
                            -- ACCELERATOR AXI4-STREAM MASTER INTERFACE TO PL2P2-DMA AXI4-STREAM SLAVE INTERFACE
                            S_AXIS_S2MM_FROM_ACCELERATOR_tdata  => Master_TDATA,
                            S_AXIS_S2MM_FROM_ACCELERATOR_tkeep  => "1111",
                            S_AXIS_S2MM_FROM_ACCELERATOR_tlast  => finished_image_ip,
                            S_AXIS_S2MM_FROM_ACCELERATOR_tready => Master_TREADY,
                            S_AXIS_S2MM_FROM_ACCELERATOR_tvalid => valid_out_ip
             );
             
             -------------------------------Port map DB FILTER
                          Master_TDATA <= "00000000"&R_ip&G_ip&B_ip;       
                          rst_ip <= not aresetn(0);
                          
                          DB_Filter:  wrapper 
                         port map(
                            clk => aclk,
                            rst =>  rst_ip,
                            pixel => pixel_ip,
                            valid_in=>valid_in_ip,
                            new_image=>  new_image_ip, 
                            R=>R_ip,
                            G=>G_ip,
                            B=>B_ip,
                          -- outputs =>Master_TDATA,
                           valid_out=>valid_out_ip,
                           image_finished=>finished_image_ip  
                        );            
            

              
              

                        
----------------------------------------------my_process for SLAVE AXI
--                                   --receive inputs from software(ARM) and send output to FPGA(debayer filter)
--                                   --IN TDATA,TVALID,TLAST
--                                   --OUT TREADY
                                       process(aclk) 
                                       begin 
                                    
                                          if (rising_edge (aclk)) then
                                          if( valid_in_ip ='1' AND  flag2 = '0') then 
                                                new_image_ip <='1';
                                                 flag2 <='1';
                                          else 
                                                new_image_ip <= '0';
                                          end if;                                            
                                            if(Slave_TLAST = '1' ) then 
                                             flag2 <='0';
                                            end if;   
                                      end if;
                                    end process ;

         
                                     
                        
                       
end architecture; -- arch
