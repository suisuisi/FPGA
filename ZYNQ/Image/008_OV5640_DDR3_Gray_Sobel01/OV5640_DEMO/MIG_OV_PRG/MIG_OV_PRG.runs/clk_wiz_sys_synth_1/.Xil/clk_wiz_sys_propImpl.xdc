set_property SRC_FILE_INFO {cfile:f:/FILE/FPGA/ZYNQ/zynq_7035/TEST/CH04_OV5640_DEMO/OV5640_TS_DATA/MIG_OV_PRG/MIG_OV_PRG.srcs/sources_1/ip/clk_wiz_sys/clk_wiz_sys.xdc rfile:../../../MIG_OV_PRG.srcs/sources_1/ip/clk_wiz_sys/clk_wiz_sys.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
