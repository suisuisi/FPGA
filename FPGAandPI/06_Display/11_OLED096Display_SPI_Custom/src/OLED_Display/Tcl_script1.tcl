set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_location_assignment PIN_R9  -to CLK_50M 
set_location_assignment PIN_T13  -to res_oled
#SDA(D1)
set_location_assignment PIN_T14  -to spi_out[0]
#SCL(D0)
set_location_assignment PIN_T15  -to spi_out[1]
#DC
set_location_assignment PIN_T12  -to spi_out[2] 
#CS
set_location_assignment PIN_T11  -to spi_out[3] 

