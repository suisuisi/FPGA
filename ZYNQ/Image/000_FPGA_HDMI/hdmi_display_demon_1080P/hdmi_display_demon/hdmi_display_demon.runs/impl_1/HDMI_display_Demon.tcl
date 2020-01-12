proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir F:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.cache/wt [current_project]
  set_property parent.project_path F:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.xpr [current_project]
  set_property ip_repo_paths F:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/Miz_ip_lib [current_project]
  set_property ip_cache_permissions disable [current_project]
  set_property XPM_LIBRARIES XPM_CDC [current_project]
  add_files -quiet F:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.runs/synth_1/HDMI_display_Demon.dcp
  add_files -quiet F:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp
  set_property netlist_only true [get_files F:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp]
  add_files -quiet f:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.srcs/sources_1/ip/hdmi_display_0_1/hdmi_display_0.dcp
  set_property netlist_only true [get_files f:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.srcs/sources_1/ip/hdmi_display_0_1/hdmi_display_0.dcp]
  read_xdc -mode out_of_context -ref clk_wiz_0 -cells inst f:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc
  set_property processing_order EARLY [get_files f:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]
  read_xdc -prop_thru_buffers -ref clk_wiz_0 -cells inst f:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc
  set_property processing_order EARLY [get_files f:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
  read_xdc -ref clk_wiz_0 -cells inst f:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc
  set_property processing_order EARLY [get_files f:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
  read_xdc F:/MIZ7035_Demon/s1/S01_CH11_hdmi_display_demon_1080P/hdmi_display_demon/hdmi_display_demon.srcs/constrs_1/new/zynq_pin.xdc
  link_design -top HDMI_display_Demon -part xc7z035ffg676-2
  write_hwdef -file HDMI_display_Demon.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force HDMI_display_Demon_opt.dcp
  catch { report_drc -file HDMI_display_Demon_drc_opted.rpt }
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force HDMI_display_Demon_placed.dcp
  catch { report_io -file HDMI_display_Demon_io_placed.rpt }
  catch { report_utilization -file HDMI_display_Demon_utilization_placed.rpt -pb HDMI_display_Demon_utilization_placed.pb }
  catch { report_control_sets -verbose -file HDMI_display_Demon_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force HDMI_display_Demon_routed.dcp
  catch { report_drc -file HDMI_display_Demon_drc_routed.rpt -pb HDMI_display_Demon_drc_routed.pb -rpx HDMI_display_Demon_drc_routed.rpx }
  catch { report_methodology -file HDMI_display_Demon_methodology_drc_routed.rpt -rpx HDMI_display_Demon_methodology_drc_routed.rpx }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file HDMI_display_Demon_timing_summary_routed.rpt -rpx HDMI_display_Demon_timing_summary_routed.rpx }
  catch { report_power -file HDMI_display_Demon_power_routed.rpt -pb HDMI_display_Demon_power_summary_routed.pb -rpx HDMI_display_Demon_power_routed.rpx }
  catch { report_route_status -file HDMI_display_Demon_route_status.rpt -pb HDMI_display_Demon_route_status.pb }
  catch { report_clock_utilization -file HDMI_display_Demon_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force HDMI_display_Demon_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  set_property XPM_LIBRARIES XPM_CDC [current_project]
  catch { write_mem_info -force HDMI_display_Demon.mmi }
  write_bitstream -force -no_partial_bitfile HDMI_display_Demon.bit 
  catch { write_sysdef -hwdef HDMI_display_Demon.hwdef -bitfile HDMI_display_Demon.bit -meminfo HDMI_display_Demon.mmi -file HDMI_display_Demon.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

