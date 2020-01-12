onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib XILSQRT_opt

do {wave.do}

view wave
view structure
view signals

do {XILSQRT.udo}

run -all

quit -force
