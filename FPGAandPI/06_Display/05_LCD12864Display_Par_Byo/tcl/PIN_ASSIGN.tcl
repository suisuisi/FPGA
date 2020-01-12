#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#复位引脚
set_location_assignment	PIN_M1	-to RST_n

#时钟引脚
set_location_assignment	PIN_R9	-to CLOCK

#液晶屏对应的引脚
set_location_assignment	PIN_J16	-to LCD_RS
set_location_assignment	PIN_K16	-to LCD_RW
set_location_assignment	PIN_L16	-to LCD_EN


#液晶屏对应的引脚
set_location_assignment	PIN_N16	-to LCD_D[0]
set_location_assignment	PIN_P16	-to LCD_D[1]
set_location_assignment	PIN_R16	-to LCD_D[2]
set_location_assignment	PIN_L13	-to LCD_D[3]
set_location_assignment	PIN_N14	-to LCD_D[4]
set_location_assignment	PIN_T7	-to LCD_D[5]
set_location_assignment	PIN_T10	-to LCD_D[6]
set_location_assignment	PIN_T11	-to LCD_D[7]








