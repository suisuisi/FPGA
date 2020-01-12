#--------------------------------------------------------#

set_property PACKAGE_PIN W16 [get_ports cmos_sclk_o]
set_property IOSTANDARD LVCMOS33 [get_ports cmos_sclk_o]

set_property PACKAGE_PIN AB17 [get_ports cmos_sdat_io]
set_property IOSTANDARD LVCMOS33 [get_ports cmos_sdat_io]

set_property PULLUP true [get_ports cmos_sdat_io]
set_property PULLUP true [get_ports cmos_sclk_o]
#------------------------------------------------------------------------------------------------
set_property -dict {PACKAGE_PIN AC17 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports cmos_xclk_o]
set_property -dict {PACKAGE_PIN Y17 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports cmos_pclk_i]
#------------------------------------------------------------------------------------------------
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets cmos_pclk_i_IBUF]
#--------------------------------------------------------------------------------------------------
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports cmos_vsync_i]
set_property -dict {PACKAGE_PIN AB16 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports cmos_href_i]
#------------------------------------------------------------------------------------------------
set_property -dict {PACKAGE_PIN AB12 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cmos_data_i[0]}]
set_property -dict {PACKAGE_PIN AA15 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cmos_data_i[1]}]
set_property -dict {PACKAGE_PIN AD15 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cmos_data_i[2]}]
set_property -dict {PACKAGE_PIN Y15  IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cmos_data_i[3]}]
set_property -dict {PACKAGE_PIN AD16 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cmos_data_i[4]}]
set_property -dict {PACKAGE_PIN Y16  IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cmos_data_i[5]}]
set_property -dict {PACKAGE_PIN AC16 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cmos_data_i[6]}]
set_property -dict {PACKAGE_PIN AA17 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cmos_data_i[7]}]
#-------------------------------------------------------------------------------------------------
#---------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports HDMI1_D1_P]
set_property PACKAGE_PIN D15 [get_ports HDMI1_CLK_P]
set_property IOSTANDARD LVDS [get_ports HDMI1_CLK_P]
set_property IOSTANDARD LVDS [get_ports HDMI1_CLK_N]
set_property PACKAGE_PIN E16 [get_ports HDMI1_D0_P]
set_property IOSTANDARD LVDS [get_ports HDMI1_D0_P]
set_property IOSTANDARD LVDS [get_ports HDMI1_D0_N]
set_property PACKAGE_PIN F15 [get_ports HDMI1_D1_P]
set_property PACKAGE_PIN C17 [get_ports HDMI1_D2_P]
set_property IOSTANDARD LVDS [get_ports HDMI1_D2_P]
#---------------------------------------------------------


set_property IOSTANDARD LVCMOS15 [get_ports clk50m_i]
set_property PACKAGE_PIN C8 [get_ports clk50m_i]

set_property PACKAGE_PIN H7 [get_ports rst_key]
set_property IOSTANDARD SSTL15 [get_ports rst_key]

set_property PACKAGE_PIN A8 [get_ports key_data[0]]
set_property IOSTANDARD SSTL15 [get_ports key_data[0]]
set_property PACKAGE_PIN A10 [get_ports key_data[1]]
set_property IOSTANDARD SSTL15 [get_ports key_data[1]]


set_property PACKAGE_PIN K10 [get_ports init_calib_complete]
set_property IOSTANDARD SSTL15 [get_ports init_calib_complete]

set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets CLK_WIZ_DDR/inst/clk_in1_clk_wiz_sys] 