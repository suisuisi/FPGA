onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib CH0_FIFO_opt

do {wave.do}

view wave
view structure
view signals

do {CH0_FIFO.udo}

run -all

quit -force
