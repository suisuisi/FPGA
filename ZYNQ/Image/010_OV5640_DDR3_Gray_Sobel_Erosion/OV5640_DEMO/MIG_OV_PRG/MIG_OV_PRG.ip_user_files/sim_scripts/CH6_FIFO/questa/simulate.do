onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib CH6_FIFO_opt

do {wave.do}

view wave
view structure
view signals

do {CH6_FIFO.udo}

run -all

quit -force
