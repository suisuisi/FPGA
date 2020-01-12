transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FILE/FPGA/FPGA_Interface/06_Display/01_LedDisplay/src/TestModule {F:/FILE/FPGA/FPGA_Interface/06_Display/01_LedDisplay/src/TestModule/clock_div.v}

vlog -vlog01compat -work work +incdir+F:/FILE/FPGA/FPGA_Interface/06_Display/01_LedDisplay/dev/../src/TestBench {F:/FILE/FPGA/FPGA_Interface/06_Display/01_LedDisplay/dev/../src/TestBench/clock_div_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  clock_div_tb

add wave *
view structure
view signals
run -all
