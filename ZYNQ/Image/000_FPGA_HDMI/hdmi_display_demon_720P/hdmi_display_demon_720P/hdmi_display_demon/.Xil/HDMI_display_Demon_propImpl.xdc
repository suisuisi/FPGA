set_property SRC_FILE_INFO {cfile:f:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc rfile:../hdmi_display_demon.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc id:1 order:EARLY scoped_inst:u_clk/inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
