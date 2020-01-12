onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L xpm -L xbip_utils_v3_0_8 -L c_reg_fd_v12_0_4 -L c_mux_bit_v12_0_4 -L c_shift_ram_v12_0_11 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.Line_Shift_RAM_8Bit xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {Line_Shift_RAM_8Bit.udo}

run -all

quit -force
