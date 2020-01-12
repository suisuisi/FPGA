vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv -L xil_defaultlib "+incdir+E:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+E:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../../../../../../../Xilinx/Miz7035/My_ip_lib/HDMI_FPGA_ML_A7_0/src/DVITransmitter.vhd" \
"../../../../../../../../../../Xilinx/Miz7035/My_ip_lib/HDMI_FPGA_ML_A7_0/src/SerializerN_1.vhd" \
"../../../../../../../../../../Xilinx/Miz7035/My_ip_lib/HDMI_FPGA_ML_A7_0/src/TMDSEncoder.vhd" \
"../../../../../../../../../../Xilinx/Miz7035/My_ip_lib/HDMI_FPGA_ML_A7_0/src/hdmi_tx.vhd" \
"../../../../../../../../../../Xilinx/Miz7035/My_ip_lib/HDMI_FPGA_ML_A7_0/sim/HDMI_FPGA_ML_A7_0.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

