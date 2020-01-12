#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#复位引脚
set_location_assignment	PIN_M1	-to RST_n

#时钟引脚
set_location_assignment	PIN_R9	-to CLOCK

#液晶屏对应的引脚
set_location_assignment	PIN_J16	-to OLED_SDA
set_location_assignment	PIN_K16	-to OLED_SCL











