#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#复位引脚
set_location_assignment	PIN_M1	-to RSTn

#时钟引脚
set_location_assignment	PIN_R9	-to CLK

#液晶屏对应的引脚
#LCD_CS
set_location_assignment	PIN_L1	-to SPI_Out[3]	
#LCD_A0
set_location_assignment	PIN_N1	-to SPI_Out[2]	
#LCD_SCL
set_location_assignment	PIN_L2	-to SPI_Out[1]
#LCD_SI
set_location_assignment	PIN_P1	-to SPI_Out[0]




