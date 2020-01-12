onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L xpm -L fifo_generator_v13_2_1 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.MSG_FIFO xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {MSG_FIFO.udo}

run -all

quit -force
