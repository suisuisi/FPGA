-makelib ies_lib/xil_defaultlib -sv \
  "E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../../../../../../../Xilinx/Miz7035/My_ip_lib/HDMI_FPGA_ML_A7_0/src/DVITransmitter.vhd" \
  "../../../../../../../../../../Xilinx/Miz7035/My_ip_lib/HDMI_FPGA_ML_A7_0/src/SerializerN_1.vhd" \
  "../../../../../../../../../../Xilinx/Miz7035/My_ip_lib/HDMI_FPGA_ML_A7_0/src/TMDSEncoder.vhd" \
  "../../../../../../../../../../Xilinx/Miz7035/My_ip_lib/HDMI_FPGA_ML_A7_0/src/hdmi_tx.vhd" \
  "../../../../../../../../../../Xilinx/Miz7035/My_ip_lib/HDMI_FPGA_ML_A7_0/sim/HDMI_FPGA_ML_A7_0.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

