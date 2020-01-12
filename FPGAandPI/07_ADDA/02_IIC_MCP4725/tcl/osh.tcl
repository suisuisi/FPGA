#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#复位引脚
set_location_assignment	PIN_M1	-to RESET

#时钟引脚
set_location_assignment	PIN_R9	-to CLOCK








#24LC04（EEPROM）对应的引脚
set_location_assignment	PIN_R6	-to SDA
set_location_assignment	PIN_R7	-to SCL



#数码管对应的引脚
set_location_assignment	PIN_M8	-to DIG[0]
set_location_assignment	PIN_L7	-to DIG[1]
set_location_assignment	PIN_P9	-to DIG[2]
set_location_assignment	PIN_N9	-to DIG[3]
set_location_assignment	PIN_M9	-to DIG[4]
set_location_assignment	PIN_M10	-to DIG[5]
set_location_assignment	PIN_P11	-to DIG[6]
set_location_assignment	PIN_N11	-to DIG[7]
set_location_assignment	PIN_N6	-to SEL[5]
set_location_assignment	PIN_P6	-to SEL[4]
set_location_assignment	PIN_M6  -to SEL[3]
set_location_assignment	PIN_M7	-to SEL[2]
set_location_assignment	PIN_P8	-to SEL[1] 
set_location_assignment	PIN_N8	-to SEL[0]





