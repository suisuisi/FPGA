#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#��λ����
set_location_assignment	PIN_M1	-to RST_n

#ʱ������
set_location_assignment	PIN_R9	-to CLOCK


#按键对应的引脚
set_location_assignment	PIN_R8	-to Pin_In
set_location_assignment	PIN_E1	-to KEY_UP
set_location_assignment	PIN_T8  -to KEY_DOWN
set_location_assignment	PIN_M2	-to KEY_LEFT
set_location_assignment	PIN_T9	-to KEY_RIGHT


#LED对应的引脚
set_location_assignment	PIN_J1	-to Pin_Out


