# Copyright (C) 2017  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel MegaCore Function License Agreement, or other 
# applicable license agreement, including, without limitation, 
# that your use is for the sole purpose of programming logic 
# devices manufactured by Intel and sold by Intel or its 
# authorized distributors.  Please refer to the applicable 
# agreement for further details.

# Quartus Prime Version 17.0.0 Build 595 04/25/2017 SJ Standard Edition
# File: F:\FILE\FPGA\FPGA_Interface\07_ADDA\01_AD7606\tcl\PIN_ASSIGN.tcl
# Generated on: Wed Sep 04 22:41:31 2019

#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#复位引脚
set_location_assignment	PIN_M1	-to rst_n

#时钟引脚
set_location_assignment	PIN_R9	-to clk


#AD
set_location_assignment	PIN_J16	-to ad_os[0]
set_location_assignment	PIN_K15	-to ad_os[1]
set_location_assignment	PIN_K16	-to ad_os[2]
set_location_assignment	PIN_L15	-to ad_convstab
set_location_assignment	PIN_L14	-to ad_rd
set_location_assignment	PIN_N15	-to ad_busy
set_location_assignment	PIN_L16	-to ad_reset
set_location_assignment	PIN_N16	-to ad_cs
set_location_assignment	PIN_P16	-to first_data
set_location_assignment	PIN_M11	-to ad_data[0]
set_location_assignment	PIN_L13	-to ad_data[1]
set_location_assignment	PIN_N12	-to ad_data[2]
set_location_assignment	PIN_N14	-to ad_data[3]
set_location_assignment	PIN_L9	-to ad_data[4]
set_location_assignment	PIN_P14	-to ad_data[5]
set_location_assignment	PIN_R14	-to ad_data[6]
set_location_assignment	PIN_T15	-to ad_data[7]
set_location_assignment	PIN_R13	-to ad_data[8]
set_location_assignment	PIN_T14	-to ad_data[9]
set_location_assignment	PIN_R12	-to ad_data[10]
set_location_assignment	PIN_T13	-to ad_data[11]
set_location_assignment	PIN_R11	-to ad_data[12]
set_location_assignment	PIN_T12	-to ad_data[13]
set_location_assignment	PIN_R10	-to ad_data[14]
set_location_assignment	PIN_T11	-to ad_data[15]


#串口对应的引脚
set_location_assignment	PIN_A8	-to rx
set_location_assignment	PIN_G5	-to tx