#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

#复位引脚
set_location_assignment	PIN_M1	-to RESET

#时钟引脚
set_location_assignment	PIN_R9	-to CLOCK
set_location_assignment	PIN_A9	-to CLOCK_40M




#SRAM的引脚
set_location_assignment	PIN_L9	-to SRAM_A[0]
set_location_assignment	PIN_P14	-to SRAM_A[1]
set_location_assignment	PIN_N12	-to SRAM_A[2]
set_location_assignment	PIN_N14	-to SRAM_A[3]
set_location_assignment	PIN_M11	-to SRAM_A[4]
set_location_assignment	PIN_L15	-to SRAM_A[5]
set_location_assignment	PIN_K16	-to SRAM_A[6]
set_location_assignment	PIN_K15	-to SRAM_A[7]
set_location_assignment	PIN_J16	-to SRAM_A[8]
set_location_assignment	PIN_J15	-to SRAM_A[9]
set_location_assignment	PIN_T6	-to SRAM_A[10]
set_location_assignment	PIN_R5	-to SRAM_A[11]
set_location_assignment	PIN_T5	-to SRAM_A[12]
set_location_assignment	PIN_R4	-to SRAM_A[13]
set_location_assignment	PIN_T4	-to SRAM_A[14]
set_location_assignment	PIN_T14	-to SRAM_A[15]
set_location_assignment	PIN_R14	-to SRAM_A[16]
set_location_assignment	PIN_T15	-to SRAM_A[17]

set_location_assignment	PIN_L13	-to SRAM_DB[0]
set_location_assignment	PIN_K12	-to SRAM_DB[1]
set_location_assignment	PIN_R16	-to SRAM_DB[2]
set_location_assignment	PIN_P15	-to SRAM_DB[3]
set_location_assignment	PIN_P16	-to SRAM_DB[4]
set_location_assignment	PIN_N15	-to SRAM_DB[5]
set_location_assignment	PIN_N16	-to SRAM_DB[6]
set_location_assignment	PIN_L14	-to SRAM_DB[7]
set_location_assignment	PIN_R6	-to SRAM_DB[8]
set_location_assignment	PIN_T7	-to SRAM_DB[9]
set_location_assignment	PIN_R7	-to SRAM_DB[10]
set_location_assignment	PIN_T10	-to SRAM_DB[11]
set_location_assignment	PIN_R10	-to SRAM_DB[12]
set_location_assignment	PIN_T11	-to SRAM_DB[13]
set_location_assignment	PIN_R11	-to SRAM_DB[14]
set_location_assignment	PIN_T12	-to SRAM_DB[15]

set_location_assignment	PIN_R12	-to SRAM_LB_N
set_location_assignment	PIN_T13	-to SRAM_UB_N
set_location_assignment	PIN_R13	-to SRAM_OE_N
set_location_assignment	PIN_L16	-to SRAM_WE_N
set_location_assignment	PIN_L11	-to SRAM_CE_N





#LED对应的引脚
set_location_assignment	PIN_J1	-to LED[0]
set_location_assignment	PIN_J2	-to LED[1]
set_location_assignment	PIN_K1	-to LED[2]
set_location_assignment	PIN_K2	-to LED[3]







