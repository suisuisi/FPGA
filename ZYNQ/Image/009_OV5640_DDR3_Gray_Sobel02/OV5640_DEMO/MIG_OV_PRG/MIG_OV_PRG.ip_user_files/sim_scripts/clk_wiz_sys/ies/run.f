-makelib ies_lib/xil_defaultlib -sv \
  "E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../MIG_OV_PRG.srcs/sources_1/ip/clk_wiz_sys/clk_wiz_sys_clk_wiz.v" \
  "../../../../MIG_OV_PRG.srcs/sources_1/ip/clk_wiz_sys/clk_wiz_sys.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

