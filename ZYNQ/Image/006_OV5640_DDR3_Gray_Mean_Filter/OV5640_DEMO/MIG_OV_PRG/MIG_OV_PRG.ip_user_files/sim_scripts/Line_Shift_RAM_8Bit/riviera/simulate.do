onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+Line_Shift_RAM_8Bit -L xil_defaultlib -L xpm -L xbip_utils_v3_0_8 -L c_reg_fd_v12_0_4 -L c_mux_bit_v12_0_4 -L c_shift_ram_v12_0_11 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.Line_Shift_RAM_8Bit xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {Line_Shift_RAM_8Bit.udo}

run -all

endsim

quit -force
