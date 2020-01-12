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
# File: F:\FILE\FPGA\FPGA_Interface\02_Protocol\prj\test_usb.tcl
# Generated on: Mon Aug 12 21:45:18 2019

package require ::quartus::project

set_location_assignment PIN_M2 -to CLCOK
#复位引脚
set_location_assignment	PIN_M1	-to rst_n

set_location_assignment PIN_J16 -to flag_a
set_location_assignment PIN_K16 -to flag_d
set_location_assignment PIN_L16 -to slwr
set_location_assignment PIN_N16 -to slrd
set_location_assignment PIN_P16 -to sloe
set_location_assignment PIN_R16 -to pktend
set_location_assignment PIN_L13 -to ifclk
set_location_assignment PIN_N14 -to fifo_addr[1]
set_location_assignment PIN_P14 -to fifo_addr[0]
set_location_assignment PIN_K15 -to usb_data[15]
set_location_assignment PIN_L15 -to usb_data[14]
set_location_assignment PIN_L14 -to usb_data[13]
set_location_assignment PIN_N15 -to usb_data[12]
set_location_assignment PIN_P15 -to usb_data[11]
set_location_assignment PIN_K12 -to usb_data[10]
set_location_assignment PIN_M11 -to usb_data[9]
set_location_assignment PIN_N12 -to usb_data[8]
set_location_assignment PIN_L9 -to usb_data[7]
set_location_assignment PIN_R14 -to usb_data[6]
set_location_assignment PIN_R13 -to usb_data[5]
set_location_assignment PIN_R12 -to usb_data[4]
set_location_assignment PIN_R11 -to usb_data[3]
set_location_assignment PIN_R10 -to usb_data[2]
set_location_assignment PIN_R7 -to usb_data[1]
set_location_assignment PIN_R6 -to usb_data[0]
