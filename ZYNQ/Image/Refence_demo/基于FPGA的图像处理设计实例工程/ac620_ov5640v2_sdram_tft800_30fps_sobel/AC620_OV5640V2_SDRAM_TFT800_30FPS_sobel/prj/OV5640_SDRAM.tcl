# Copyright (C) 1991-2013 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.

# Quartus II 64-Bit Version 13.0.0 Build 156 04/24/2013 SJ Full Version
# File: C:\Users\Administrator\Desktop\AC620_OV5640V2_SDRAM_TFT800_sobel\prj\OV5640_SDRAM.tcl
# Generated on: Wed Oct 24 20:39:45 2018

package require ::quartus::project

set_location_assignment PIN_J12 -to TFT_BL
set_location_assignment PIN_E1 -to clk
set_location_assignment PIN_M2 -to cmos_pclk
set_location_assignment PIN_N3 -to cmos_href
set_location_assignment PIN_P3 -to cmos_data[7]
set_location_assignment PIN_L7 -to cmos_data[6]
set_location_assignment PIN_P6 -to cmos_data[5]
set_location_assignment PIN_N6 -to cmos_data[4]
set_location_assignment PIN_T6 -to cmos_data[3]
set_location_assignment PIN_M7 -to cmos_data[2]
set_location_assignment PIN_P8 -to cmos_data[1]
set_location_assignment PIN_K10 -to cmos_data[0]
set_location_assignment PIN_M6 -to cmos_vsync
set_location_assignment PIN_R7 -to cmos_sdat
set_location_assignment PIN_T2 -to cmos_sclk
set_location_assignment PIN_A3 -to pio_led[3]
set_location_assignment PIN_A4 -to pio_led[2]
set_location_assignment PIN_B3 -to pio_led[1]
set_location_assignment PIN_A2 -to pio_led[0]
set_location_assignment PIN_M16 -to pio_key[0]
set_location_assignment PIN_E16 -to reset_n
set_location_assignment PIN_B5 -to uart_0_txd
set_location_assignment PIN_A6 -to uart_0_rxd
set_location_assignment PIN_T9 -to sdram_we_n
set_location_assignment PIN_N9 -to sdram_ras_n
set_location_assignment PIN_R10 -to sdram_dqm[1]
set_location_assignment PIN_T8 -to sdram_dqm[0]
set_location_assignment PIN_P9 -to sdram_dq[15]
set_location_assignment PIN_N8 -to sdram_dq[14]
set_location_assignment PIN_M8 -to sdram_dq[13]
set_location_assignment PIN_L8 -to sdram_dq[12]
set_location_assignment PIN_K8 -to sdram_dq[11]
set_location_assignment PIN_L9 -to sdram_dq[10]
set_location_assignment PIN_K9 -to sdram_dq[9]
set_location_assignment PIN_R9 -to sdram_dq[8]
set_location_assignment PIN_R8 -to sdram_dq[7]
set_location_assignment PIN_R6 -to sdram_dq[6]
set_location_assignment PIN_T5 -to sdram_dq[5]
set_location_assignment PIN_R5 -to sdram_dq[4]
set_location_assignment PIN_T4 -to sdram_dq[3]
set_location_assignment PIN_R4 -to sdram_dq[2]
set_location_assignment PIN_T3 -to sdram_dq[1]
set_location_assignment PIN_R3 -to sdram_dq[0]
set_location_assignment PIN_R12 -to sdram_cs_n
set_location_assignment PIN_T10 -to sdram_clk
set_location_assignment PIN_T11 -to sdram_cke
set_location_assignment PIN_R11 -to sdram_cas_n
set_location_assignment PIN_M9 -to sdram_ba[1]
set_location_assignment PIN_T12 -to sdram_ba[0]
set_location_assignment PIN_N11 -to sdram_addr[12]
set_location_assignment PIN_R13 -to sdram_addr[11]
set_location_assignment PIN_M10 -to sdram_addr[10]
set_location_assignment PIN_T14 -to sdram_addr[9]
set_location_assignment PIN_R14 -to sdram_addr[8]
set_location_assignment PIN_T15 -to sdram_addr[7]
set_location_assignment PIN_L11 -to sdram_addr[6]
set_location_assignment PIN_M11 -to sdram_addr[5]
set_location_assignment PIN_N12 -to sdram_addr[4]
set_location_assignment PIN_T13 -to sdram_addr[3]
set_location_assignment PIN_P14 -to sdram_addr[2]
set_location_assignment PIN_L10 -to sdram_addr[1]
set_location_assignment PIN_P11 -to sdram_addr[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart_0_txd
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart_0_rxd
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_we_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_ras_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dqm[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dqm[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_cs_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_cke
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_cas_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_ba[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_ba[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_addr[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to reset_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to pio_led[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to pio_led[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to pio_led[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to pio_led[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to pio_key[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to pio_key[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_xclk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_vsync
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_sdat
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_sclk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_rst_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_pwdn
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_pclk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_href
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_data[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_data[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_data[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_data[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_data[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_data[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_data[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to cmos_data[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_BL
set_location_assignment PIN_P1 -to cmos_pwdn
set_location_assignment PIN_P16 -to TFT_RGB[15]
set_location_assignment PIN_N15 -to TFT_RGB[14]
set_location_assignment PIN_R16 -to TFT_RGB[13]
set_location_assignment PIN_P15 -to TFT_RGB[12]
set_location_assignment PIN_N13 -to TFT_RGB[11]
set_location_assignment PIN_L12 -to TFT_RGB[10]
set_location_assignment PIN_K12 -to TFT_RGB[9]
set_location_assignment PIN_L13 -to TFT_RGB[8]
set_location_assignment PIN_M12 -to TFT_RGB[7]
set_location_assignment PIN_L14 -to TFT_RGB[6]
set_location_assignment PIN_N16 -to TFT_RGB[5]
set_location_assignment PIN_J16 -to TFT_RGB[4]
set_location_assignment PIN_K15 -to TFT_RGB[3]
set_location_assignment PIN_K16 -to TFT_RGB[2]
set_location_assignment PIN_J13 -to TFT_RGB[1]
set_location_assignment PIN_L15 -to TFT_RGB[0]
set_location_assignment PIN_J14 -to TFT_VS
set_location_assignment PIN_K11 -to TFT_HS
set_location_assignment PIN_J11 -to TFT_DE
set_location_assignment PIN_J15 -to TFT_VCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_DE
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_HS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_RGB[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_VCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TFT_VS
set_location_assignment PIN_E15 -to pio_key[1]
set_location_assignment PIN_T7 -to cmos_rst_n
set_location_assignment PIN_N5 -to cmos_xclk
