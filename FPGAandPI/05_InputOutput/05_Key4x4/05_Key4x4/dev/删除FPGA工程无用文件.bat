@echo off

rd  /s/q incremental_db
rd  /s/q db
rd  /s/q .sopc_builder
rd  /s/q _sim
rd  /s/q greybox_tmp
rd  /s/q YJ_Nios_sim
del *.rpt
del *.done
del *.smsg
del *.summary
del *.jdi
del *.pin
del *.qar
del *.qarlog
del *.txt

rd /s/q software\PCP_SoftNIOS\obj
del "software\PCP_SoftNIOS\*.map"
del "software\PCP_SoftNIOS\*.objdump"
del "software\PCP_SoftNIOS_bsp\*.a"
rd  /s/q software\PCP_SoftNIOS_bsp\obj











