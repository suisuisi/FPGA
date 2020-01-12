### This file is a general .xdc for the Nexys Video Rev. A
### To use it in a project:
### - uncomment the lines corresponding to used pins
### - rename the used ports (in each line, after get_ports) according to the top level signal names in the project


# Clock Signal

set_property IOSTANDARD LVCMOS15 [get_ports sys_clk]
set_property PACKAGE_PIN C8 [get_ports sys_clk]




set_property PACKAGE_PIN H7 [get_ports sys_rst_n]
set_property IOSTANDARD SSTL15 [get_ports sys_rst_n]




## HDMI in
#set_property -dict { PACKAGE_PIN AA5   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_cec }]; #IO_L10P_T1_34 Sch=hdmi_rx_cec
#set_property -dict { PACKAGE_PIN W4    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_clk_n }]; #IO_L12N_T1_MRCC_34 Sch=hdmi_rx_clk_n
#set_property -dict { PACKAGE_PIN V4    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_clk_p }]; #IO_L12P_T1_MRCC_34 Sch=hdmi_rx_clk_p
#set_property -dict { PACKAGE_PIN AB12  IOSTANDARD LVCMOS25 } [get_ports { hdmi_rx_hpa }]; #IO_L7N_T1_13 Sch=hdmi_rx_hpa
#set_property -dict { PACKAGE_PIN Y4    IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_scl }]; #IO_L11P_T1_SRCC_34 Sch=hdmi_rx_scl
#set_property -dict { PACKAGE_PIN AB5   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_sda }]; #IO_L10N_T1_34 Sch=hdmi_rx_sda
#set_property -dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_txen }]; #IO_L3P_T0_DQS_34 Sch=hdmi_rx_txen
#set_property -dict { PACKAGE_PIN AA3   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_n[0] }]; #IO_L9N_T1_DQS_34 Sch=hdmi_rx_n[0]
#set_property -dict { PACKAGE_PIN Y3    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_p[0] }]; #IO_L9P_T1_DQS_34 Sch=hdmi_rx_p[0]
#set_property -dict { PACKAGE_PIN Y2    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_n[1] }]; #IO_L4N_T0_34 Sch=hdmi_rx_n[1]
#set_property -dict { PACKAGE_PIN W2    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_p[1] }]; #IO_L4P_T0_34 Sch=hdmi_rx_p[1]
#set_property -dict { PACKAGE_PIN V2    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_n[2] }]; #IO_L2N_T0_34 Sch=hdmi_rx_n[2]
#set_property -dict { PACKAGE_PIN U2    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_p[2] }]; #IO_L2P_T0_34 Sch=hdmi_rx_p[2]


##HDMI out
#set_property -dict { PACKAGE_PIN AA4   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_cec }]; #IO_L11N_T1_SRCC_34 Sch=hdmi_tx_cec
#set_property -dict {PACKAGE_PIN D14 IOSTANDARD TMDS_33} [get_ports TMDS_Clk_n]
#set_property -dict {PACKAGE_PIN D15 IOSTANDARD TMDS_33} [get_ports TMDS_Clk_p]
#set_property -dict { PACKAGE_PIN AB13  IOSTANDARD LVCMOS25 } [get_ports { hdmi_hpd }]; #IO_L3N_T0_DQS_13 Sch=hdmi_tx_hpd
#set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_rscl }]; #IO_L6P_T0_34 Sch=hdmi_tx_rscl
#set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_rsda }]; #IO_L6N_T0_VREF_34 Sch=hdmi_tx_rsda
#set_property -dict {PACKAGE_PIN D16 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_n[0]}]
#set_property -dict {PACKAGE_PIN E16 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_p[0]}]
#set_property -dict {PACKAGE_PIN E15 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_n[1]}]
#set_property -dict {PACKAGE_PIN F15 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_p[1]}]
#set_property -dict {PACKAGE_PIN C16 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_n[2]}]
#set_property -dict {PACKAGE_PIN C17 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_p[2]}]

set_property IOSTANDARD LVDS [get_ports TMDS_Data_p[1]]
set_property PACKAGE_PIN D15 [get_ports TMDS_Clk_p]
set_property IOSTANDARD LVDS [get_ports TMDS_Clk_p]
set_property IOSTANDARD LVDS [get_ports TMDS_Clk_n]
set_property PACKAGE_PIN E16 [get_ports TMDS_Data_p[0]]
set_property IOSTANDARD LVDS [get_ports TMDS_Data_p[0]]
set_property IOSTANDARD LVDS [get_ports TMDS_Data_n[0]]

set_property PACKAGE_PIN F15 [get_ports TMDS_Data_p[1]]
set_property PACKAGE_PIN C17 [get_ports TMDS_Data_p[2]]
set_property IOSTANDARD LVDS [get_ports TMDS_Data_p[2]]








## Pmod header JA
#set_property -dict { PACKAGE_PIN AB22  IOSTANDARD LVCMOS33 } [get_ports { cam_sda }]; #IO_L10N_T1_D15_14 Sch=ja[1]
#set_property -dict { PACKAGE_PIN AB21  IOSTANDARD LVCMOS33 } [get_ports { cam_scl }]; #IO_L10P_T1_D14_14 Sch=ja[2]
#set_property -dict { PACKAGE_PIN AB20  IOSTANDARD LVCMOS33 } [get_ports { cam_href }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=ja[3]
#set_property -dict { PACKAGE_PIN AB18  IOSTANDARD LVCMOS33 } [get_ports { cam_vsync }]; #IO_L17N_T2_A13_D29_14 Sch=ja[4]
#set_property -dict { PACKAGE_PIN Y21   IOSTANDARD LVCMOS33 } [get_ports { cam_pwdn }]; #IO_L9P_T1_DQS_14 Sch=ja[7]
#set_property -dict { PACKAGE_PIN AA21  IOSTANDARD LVCMOS33 } [get_ports { cam_pclk }]; #IO_L8N_T1_D12_14 Sch=ja[8]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets cam_pclk_IBUF]
##set_property -dict { PACKAGE_PIN AA20  IOSTANDARD LVCMOS33 } [get_ports { ja[6] }]; #IO_L8P_T1_D11_14 Sch=ja[9]
#set_property -dict { PACKAGE_PIN AA18  IOSTANDARD LVCMOS33 } [get_ports { cam_rst_n }]; #IO_L17P_T2_A14_D30_14 Sch=ja[10]


# Pmod header JB
set_property -dict {PACKAGE_PIN AB12 IOSTANDARD LVCMOS33} [get_ports {cam_data[0]}]
set_property -dict {PACKAGE_PIN AA15 IOSTANDARD LVCMOS33} [get_ports {cam_data[1]}]
set_property -dict {PACKAGE_PIN AD15 IOSTANDARD LVCMOS33} [get_ports {cam_data[2]}]
set_property -dict {PACKAGE_PIN Y15  IOSTANDARD LVCMOS33} [get_ports {cam_data[3]}]
set_property -dict {PACKAGE_PIN AD16 IOSTANDARD LVCMOS33} [get_ports {cam_data[4]}]
set_property -dict {PACKAGE_PIN Y16  IOSTANDARD LVCMOS33} [get_ports {cam_data[5]}]
set_property -dict {PACKAGE_PIN AC16 IOSTANDARD LVCMOS33} [get_ports {cam_data[6]}]
set_property -dict {PACKAGE_PIN AA17 IOSTANDARD LVCMOS33} [get_ports {cam_data[7]}]






# Pmod header JC
set_property -dict {PACKAGE_PIN AC17 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports cam_xclk]

set_property -dict {PACKAGE_PIN AB17 IOSTANDARD LVCMOS33} [get_ports cam_sda]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports cam_scl]
set_property -dict {PACKAGE_PIN AB16 IOSTANDARD LVCMOS33} [get_ports cam_href]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports cam_vsync]
#set_property -dict {PACKAGE_PIN R6 IOSTANDARD LVCMOS33} [get_ports cam_pwdn]
set_property -dict {PACKAGE_PIN Y17 IOSTANDARD LVCMOS33} [get_ports cam_pclk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets cam_pclk_IBUF]
#set_property -dict { PACKAGE_PIN AB7   IOSTANDARD LVCMOS33 } [get_ports { jc[6] }]; #IO_L20P_T3_34 Sch=jc_p[4]
#set_property -dict {PACKAGE_PIN AB6 IOSTANDARD LVCMOS33} [get_ports cam_rst_n]



set_property PULLUP true [get_ports cam_sda]
set_property PULLUP true [get_ports cam_scl]
#------------------------------------------------------------------------------------------------
#set_property -dict {PACKAGE_PIN AC17 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports cmos_xclk_o]

#------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------









## HID port
#set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33   PULLUP true } [get_ports { ps2_clk }]; #IO_L16N_T2_A15_D31_14 Sch=ps2_clk
#set_property -dict { PACKAGE_PIN N13   IOSTANDARD LVCMOS33   PULLUP true } [get_ports { ps2_data }]; #IO_L23P_T3_A03_D19_14 Sch=ps2_data




## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]


