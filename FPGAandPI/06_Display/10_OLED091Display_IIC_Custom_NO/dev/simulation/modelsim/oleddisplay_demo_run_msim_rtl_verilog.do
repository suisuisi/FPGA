transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FILE/FPGA/FPGA_Interface/06_Display/10_OLED091Display_IIC_Custom/src/OLED_Display {F:/FILE/FPGA/FPGA_Interface/06_Display/10_OLED091Display_IIC_Custom/src/OLED_Display/write_data_module.v}
vlog -vlog01compat -work work +incdir+F:/FILE/FPGA/FPGA_Interface/06_Display/10_OLED091Display_IIC_Custom/src/OLED_Display {F:/FILE/FPGA/FPGA_Interface/06_Display/10_OLED091Display_IIC_Custom/src/OLED_Display/write_data.v}
vlog -vlog01compat -work work +incdir+F:/FILE/FPGA/FPGA_Interface/06_Display/10_OLED091Display_IIC_Custom/src/iic {F:/FILE/FPGA/FPGA_Interface/06_Display/10_OLED091Display_IIC_Custom/src/iic/iic.v}
vcom -93 -work work {F:/FILE/FPGA/FPGA_Interface/06_Display/10_OLED091Display_IIC_Custom/src/OLED_Display/ROM.vhd}

vlog -vlog01compat -work work +incdir+F:/FILE/FPGA/FPGA_Interface/06_Display/10_OLED091Display_IIC_Custom/dev/../src/TestBench {F:/FILE/FPGA/FPGA_Interface/06_Display/10_OLED091Display_IIC_Custom/dev/../src/TestBench/write_data_module_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  write_data_module_tb

add wave *
view structure
view signals
run -all
