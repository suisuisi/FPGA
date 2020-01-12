onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+rgb2dvi_1 -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.rgb2dvi_1 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {rgb2dvi_1.udo}

run -all

endsim

quit -force
