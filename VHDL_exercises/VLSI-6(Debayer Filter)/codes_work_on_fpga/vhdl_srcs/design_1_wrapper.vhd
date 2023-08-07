--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2.1 (lin64) Build 2288692 Thu Jul 26 18:23:50 MDT 2018
--Date        : Fri May 14 16:25:30 2021
--Host        : mlab running 64-bit Ubuntu 20.04.2 LTS
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    ACLK : out STD_LOGIC;
    ARESETN : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    M_AXIS_TO_ACCELERATOR_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXIS_TO_ACCELERATOR_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXIS_TO_ACCELERATOR_tlast : out STD_LOGIC;
    M_AXIS_TO_ACCELERATOR_tready : in STD_LOGIC;
    M_AXIS_TO_ACCELERATOR_tvalid : out STD_LOGIC;
    S_AXIS_S2MM_FROM_ACCELERATOR_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXIS_S2MM_FROM_ACCELERATOR_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXIS_S2MM_FROM_ACCELERATOR_tlast : in STD_LOGIC;
    S_AXIS_S2MM_FROM_ACCELERATOR_tready : out STD_LOGIC;
    S_AXIS_S2MM_FROM_ACCELERATOR_tvalid : in STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    M_AXIS_TO_ACCELERATOR_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXIS_TO_ACCELERATOR_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXIS_TO_ACCELERATOR_tlast : out STD_LOGIC;
    M_AXIS_TO_ACCELERATOR_tready : in STD_LOGIC;
    M_AXIS_TO_ACCELERATOR_tvalid : out STD_LOGIC;
    ACLK : out STD_LOGIC;
    ARESETN : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXIS_S2MM_FROM_ACCELERATOR_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXIS_S2MM_FROM_ACCELERATOR_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXIS_S2MM_FROM_ACCELERATOR_tlast : in STD_LOGIC;
    S_AXIS_S2MM_FROM_ACCELERATOR_tready : out STD_LOGIC;
    S_AXIS_S2MM_FROM_ACCELERATOR_tvalid : in STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      ACLK => ACLK,
      ARESETN(0) => ARESETN(0),
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      M_AXIS_TO_ACCELERATOR_tdata(7 downto 0) => M_AXIS_TO_ACCELERATOR_tdata(7 downto 0),
      M_AXIS_TO_ACCELERATOR_tkeep(0) => M_AXIS_TO_ACCELERATOR_tkeep(0),
      M_AXIS_TO_ACCELERATOR_tlast => M_AXIS_TO_ACCELERATOR_tlast,
      M_AXIS_TO_ACCELERATOR_tready => M_AXIS_TO_ACCELERATOR_tready,
      M_AXIS_TO_ACCELERATOR_tvalid => M_AXIS_TO_ACCELERATOR_tvalid,
      S_AXIS_S2MM_FROM_ACCELERATOR_tdata(31 downto 0) => S_AXIS_S2MM_FROM_ACCELERATOR_tdata(31 downto 0),
      S_AXIS_S2MM_FROM_ACCELERATOR_tkeep(3 downto 0) => S_AXIS_S2MM_FROM_ACCELERATOR_tkeep(3 downto 0),
      S_AXIS_S2MM_FROM_ACCELERATOR_tlast => S_AXIS_S2MM_FROM_ACCELERATOR_tlast,
      S_AXIS_S2MM_FROM_ACCELERATOR_tready => S_AXIS_S2MM_FROM_ACCELERATOR_tready,
      S_AXIS_S2MM_FROM_ACCELERATOR_tvalid => S_AXIS_S2MM_FROM_ACCELERATOR_tvalid
    );
end STRUCTURE;
