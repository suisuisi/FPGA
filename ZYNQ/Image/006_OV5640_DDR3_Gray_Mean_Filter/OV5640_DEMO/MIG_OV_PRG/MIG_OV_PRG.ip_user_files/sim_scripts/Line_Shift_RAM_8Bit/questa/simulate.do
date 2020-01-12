onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Line_Shift_RAM_8Bit_opt

do {wave.do}

view wave
view structure
view signals

do {Line_Shift_RAM_8Bit.udo}

run -all

quit -force
