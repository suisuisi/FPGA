##############################################
#      	URL:    http://www.oshcn.org
#      	REV:    1.0
#	 AUTHOR:    AVIC
#	   DATE:    2010.6.19
#############################################

#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

set_location_assignment	PIN_M1	-to	RESET
set_location_assignment	PIN_A9	-to	CLOCK

#--------------------DA----------------------#
set_location_assignment	PIN_K12	-to	DA_DB[0]
set_location_assignment	PIN_P16	-to 	DA_DB[1]
set_location_assignment	PIN_P15	-to	DA_DB[2]
set_location_assignment	PIN_N16	-to	DA_DB[3]
set_location_assignment	PIN_N15	-to	DA_DB[4]
set_location_assignment	PIN_L16	-to	DA_DB[5]
set_location_assignment	PIN_L14	-to 	DA_DB[6]
set_location_assignment	PIN_K16	-to 	DA_DB[7]
set_location_assignment	PIN_L15	-to 	DA_CLK
#--------------------AD----------------------#
set_location_assignment	PIN_R14	-to	AD_DB[0]
set_location_assignment	PIN_T15	-to 	AD_DB[1]
set_location_assignment	PIN_R13	-to	AD_DB[2]
set_location_assignment	PIN_T14	-to	AD_DB[3]
set_location_assignment	PIN_R12	-to	AD_DB[4]
set_location_assignment	PIN_T13	-to	AD_DB[5]
set_location_assignment	PIN_R11	-to 	AD_DB[6]
set_location_assignment	PIN_T12	-to 	AD_DB[7]
set_location_assignment	PIN_R10	-to 	AD_CLK

set_location_assignment	PIN_J13	-to 	F_NCE
set_location_assignment	PIN_L11	-to 	SRAM_CS
#------------------END-----------------------#







