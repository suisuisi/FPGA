#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#��λ����
set_location_assignment	PIN_M1	-to RST_n

#ʱ������
set_location_assignment	PIN_R9	-to CLOCK


#按键对应的引脚
set_location_assignment	PIN_T7	-to key_in_y[0]
set_location_assignment	PIN_T10	-to key_in_y[1]
set_location_assignment	PIN_T11	-to key_in_y[2]
set_location_assignment	PIN_T12	-to key_in_y[3]

set_location_assignment	PIN_T14	-to key_out_x[0]
set_location_assignment	PIN_T15	-to key_out_x[1]
set_location_assignment	PIN_P14	-to key_out_x[2]
set_location_assignment	PIN_N14	-to key_out_x[3]


#LED对应的引脚
set_location_assignment	PIN_J1	-to LED[0]
set_location_assignment	PIN_J2	-to LED[1]
set_location_assignment	PIN_K1	-to LED[2]
set_location_assignment	PIN_K2	-to LED[3]

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

