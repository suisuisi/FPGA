onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib MSG_FIFO_opt

do {wave.do}

view wave
view structure
view signals

do {MSG_FIFO.udo}

run -all

quit -force
