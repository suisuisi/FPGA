-- (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:user:HDMI_FPGA_ML:1.0
-- IP Revision: 2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY HDMI_FPGA_ML_0 IS
  PORT (
    PXLCLK_I : IN STD_LOGIC;
    PXLCLK_5X_I : IN STD_LOGIC;
    LOCKED_I : IN STD_LOGIC;
    RST_N : IN STD_LOGIC;
    VGA_HS : IN STD_LOGIC;
    VGA_VS : IN STD_LOGIC;
    VGA_DE : IN STD_LOGIC;
    VGA_RGB : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    HDMI_CLK_P : OUT STD_LOGIC;
    HDMI_CLK_N : OUT STD_LOGIC;
    HDMI_D2_P : OUT STD_LOGIC;
    HDMI_D2_N : OUT STD_LOGIC;
    HDMI_D1_P : OUT STD_LOGIC;
    HDMI_D1_N : OUT STD_LOGIC;
    HDMI_D0_P : OUT STD_LOGIC;
    HDMI_D0_N : OUT STD_LOGIC
  );
END HDMI_FPGA_ML_0;

ARCHITECTURE HDMI_FPGA_ML_0_arch OF HDMI_FPGA_ML_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : string;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF HDMI_FPGA_ML_0_arch: ARCHITECTURE IS "yes";

  COMPONENT HDMI_FPGA_ML IS
    PORT (
      PXLCLK_I : IN STD_LOGIC;
      PXLCLK_5X_I : IN STD_LOGIC;
      LOCKED_I : IN STD_LOGIC;
      RST_N : IN STD_LOGIC;
      VGA_HS : IN STD_LOGIC;
      VGA_VS : IN STD_LOGIC;
      VGA_DE : IN STD_LOGIC;
      VGA_RGB : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
      HDMI_CLK_P : OUT STD_LOGIC;
      HDMI_CLK_N : OUT STD_LOGIC;
      HDMI_D2_P : OUT STD_LOGIC;
      HDMI_D2_N : OUT STD_LOGIC;
      HDMI_D1_P : OUT STD_LOGIC;
      HDMI_D1_N : OUT STD_LOGIC;
      HDMI_D0_P : OUT STD_LOGIC;
      HDMI_D0_N : OUT STD_LOGIC
    );
  END COMPONENT HDMI_FPGA_ML;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF HDMI_FPGA_ML_0_arch: ARCHITECTURE IS "HDMI_FPGA_ML,Vivado 2015.4";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF HDMI_FPGA_ML_0_arch : ARCHITECTURE IS "HDMI_FPGA_ML_0,HDMI_FPGA_ML,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF HDMI_FPGA_ML_0_arch: ARCHITECTURE IS "HDMI_FPGA_ML_0,HDMI_FPGA_ML,{x_ipProduct=Vivado 2015.4,x_ipVendor=xilinx.com,x_ipLibrary=user,x_ipName=HDMI_FPGA_ML,x_ipVersion=1.0,x_ipCoreRevision=2,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}";
BEGIN
  U0 : HDMI_FPGA_ML
    PORT MAP (
      PXLCLK_I => PXLCLK_I,
      PXLCLK_5X_I => PXLCLK_5X_I,
      LOCKED_I => LOCKED_I,
      RST_N => RST_N,
      VGA_HS => VGA_HS,
      VGA_VS => VGA_VS,
      VGA_DE => VGA_DE,
      VGA_RGB => VGA_RGB,
      HDMI_CLK_P => HDMI_CLK_P,
      HDMI_CLK_N => HDMI_CLK_N,
      HDMI_D2_P => HDMI_D2_P,
      HDMI_D2_N => HDMI_D2_N,
      HDMI_D1_P => HDMI_D1_P,
      HDMI_D1_N => HDMI_D1_N,
      HDMI_D0_P => HDMI_D0_P,
      HDMI_D0_N => HDMI_D0_N
    );
END HDMI_FPGA_ML_0_arch;
