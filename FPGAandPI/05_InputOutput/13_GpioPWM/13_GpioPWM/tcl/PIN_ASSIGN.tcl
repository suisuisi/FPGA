#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#��λ����
set_location_assignment	PIN_M1	-to RST_n

#ʱ������
set_location_assignment	PIN_R9	-to CLOCK


#按键对应的引脚
set_location_assignment	PIN_R8	-to Key_In[0]
set_location_assignment	PIN_M2	-to Key_In[1]
set_location_assignment	PIN_T9	-to Key_In[2]


#LED对应的引脚
set_location_assignment	PIN_J1	-to LED