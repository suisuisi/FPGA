#**************************************************************
# This .sdc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
create_clock -period 20 	[get_ports clk]
create_clock -period 41.666 [get_ports cmos_pclk]

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks

create_generated_clock -name CLK100MtoSDRAM -source [get_nets {u_system_ctrl_pll|u_sys_pll|altpll_component|auto_generated|wire_pll1_clk[1]}] [get_ports {sdram_clk}]
create_generated_clock -name CLK25toCLKVGA -source [get_nets {u_system_ctrl_pll|u_sys_pll|altpll_component|auto_generated|wire_pll1_clk[2]}] [get_ports {lcd_dclk}]
create_generated_clock -name CLK24toOV7725 -source [get_nets {u_system_ctrl_pll|u_sys_pll|altpll_component|auto_generated|wire_pll1_clk[3]}] [get_ports {cmos_xclk}]


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************
set_input_delay -clock { u_system_ctrl_pll|u_sys_pll|altpll_component|auto_generated|pll1|clk[0] } -min 2.09 [get_ports {sdram_data[0] sdram_data[1] sdram_data[2] sdram_data[3] sdram_data[4] sdram_data[5] sdram_data[6] sdram_data[7] sdram_data[8] sdram_data[9] sdram_data[10] sdram_data[11] sdram_data[12] sdram_data[13] sdram_data[14] sdram_data[15] sdram_data[16] sdram_data[17] sdram_data[18] sdram_data[19] sdram_data[20] sdram_data[21] sdram_data[22] sdram_data[23]}]
set_input_delay -clock { u_system_ctrl_pll|u_sys_pll|altpll_component|auto_generated|pll1|clk[0] } -max 2.22 [get_ports {sdram_data[0] sdram_data[1] sdram_data[2] sdram_data[3] sdram_data[4] sdram_data[5] sdram_data[6] sdram_data[7] sdram_data[8] sdram_data[9] sdram_data[10] sdram_data[11] sdram_data[12] sdram_data[13] sdram_data[14] sdram_data[15] sdram_data[16] sdram_data[17] sdram_data[18] sdram_data[19] sdram_data[20] sdram_data[21] sdram_data[22] sdram_data[23]}]

#**************************************************************
# Set Output Delay
#**************************************************************
set_output_delay -clock { u_system_ctrl_pll|u_sys_pll|altpll_component|auto_generated|pll1|clk[0] } -min -0.95 [get_ports {sdram_data[0] sdram_data[1] sdram_data[2] sdram_data[3] sdram_data[4] sdram_data[5] sdram_data[6] sdram_data[7] sdram_data[8] sdram_data[9] sdram_data[10] sdram_data[11] sdram_data[12] sdram_data[13] sdram_data[14] sdram_data[15] sdram_data[16] sdram_data[17] sdram_data[18] sdram_data[19] sdram_data[20] sdram_data[21] sdram_data[22] sdram_data[23]}]
set_output_delay -clock { u_system_ctrl_pll|u_sys_pll|altpll_component|auto_generated|pll1|clk[0] } -max 1.68 [get_ports {sdram_data[0] sdram_data[1] sdram_data[2] sdram_data[3] sdram_data[4] sdram_data[5] sdram_data[6] sdram_data[7] sdram_data[8] sdram_data[9] sdram_data[10] sdram_data[11] sdram_data[12] sdram_data[13] sdram_data[14] sdram_data[15] sdram_data[16] sdram_data[17] sdram_data[18] sdram_data[19] sdram_data[20] sdram_data[21] sdram_data[22] sdram_data[23]}]

#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************
set_false_path -from [get_clocks {cmos_pclk}] -to [get_clocks {u_system_ctrl_pll|u_sys_pll|altpll_component|auto_generated|pll1|clk[0]}]
set_false_path -from [get_clocks {u_system_ctrl_pll|u_sys_pll|altpll_component|auto_generated|pll1|clk[0]}] -to [get_clocks {cmos_pclk}]

#**************************************************************
# Set Multicycle Path
#**************************************************************
set_false_path -from rst_n -to *


#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************



