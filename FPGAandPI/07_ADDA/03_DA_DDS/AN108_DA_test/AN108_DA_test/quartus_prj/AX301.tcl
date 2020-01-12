#------------------GLOBAL--------------------#
set_global_assignment -name FAMILY "Cyclone IV E"
set_global_assignment -name DEVICE EP4CE6F17C8
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

set_global_assignment -name RESERVE_ALL_UNUSED_PINS_WEAK_PULLUP "AS INPUT TRI-STATED"
set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA0_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA1_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_FLASH_NCE_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DCLK_AFTER_CONFIGURATION "USE AS REGULAR IO"

#复位引脚
set_location_assignment	PIN_E15	-to rst_n

#时钟引脚 50M
set_location_assignment	PIN_E1	-to sclk


#key_pin

#set_location_assignment	PIN_E15	 -to KEY1
#set_location_assignment	PIN_E16	 -to KEY2
#set_location_assignment	PIN_M16  -to KEY3
#set_location_assignment	PIN_M15  -to KEY4
set_location_assignment PIN_E16  -to key_f
set_location_assignment	PIN_M16  -to key_p

#led
set_location_assignment	PIN_G15	-to led0

#sin_driver


set_location_assignment	PIN_E8	-to clk_DA    
set_location_assignment PIN_F7	-to o_wave[7]
set_location_assignment PIN_F9	-to o_wave[6]
set_location_assignment PIN_E9	-to o_wave[5]
set_location_assignment PIN_C9	-to o_wave[4]
set_location_assignment PIN_D9	-to o_wave[3]
set_location_assignment PIN_E10	-to o_wave[2]
set_location_assignment PIN_C11 -to o_wave[1]
set_location_assignment PIN_D11	-to o_wave[0]

  
 
                                    




