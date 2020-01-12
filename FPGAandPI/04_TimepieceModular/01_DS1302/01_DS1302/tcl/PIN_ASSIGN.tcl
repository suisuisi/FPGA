#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#复位引脚
set_location_assignment	PIN_M1	-to RST_n

#时钟引脚
set_location_assignment	PIN_R9	-to CLOCK



#DS1302(实时时钟)对应的引脚
set_location_assignment	PIN_K9	-to RTC_SCLK
set_location_assignment	PIN_F13	-to RTC_NRST
set_location_assignment	PIN_D14	-to RTC_DATA


#数码管对应的引脚
set_location_assignment	PIN_M8	-to SMG_Data[0]
set_location_assignment	PIN_L7	-to SMG_Data[1]
set_location_assignment	PIN_P9	-to SMG_Data[2]
set_location_assignment	PIN_N9	-to SMG_Data[3]
set_location_assignment	PIN_M9	-to SMG_Data[4]
set_location_assignment	PIN_M10	-to SMG_Data[5]
set_location_assignment	PIN_P11	-to SMG_Data[6]
set_location_assignment	PIN_N11	-to SMG_Data[7]
set_location_assignment	PIN_N6	-to Scan_Sig[0]
set_location_assignment	PIN_P6	-to Scan_Sig[1]
set_location_assignment	PIN_M6  -to Scan_Sig[2]
set_location_assignment	PIN_M7	-to Scan_Sig[3]
set_location_assignment	PIN_P8	-to Scan_Sig[4] 
set_location_assignment	PIN_N8	-to Scan_Sig[5]





