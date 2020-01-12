@echo off
set xv_path=D:\\Xilinx\\Vivado\\2016.4\\bin
echo "xvlog -m64 --relax -prj sim_tb_top_vlog.prj"
call %xv_path%/xvlog  -m64 --relax -prj sim_tb_top_vlog.prj -log xvlog.log
call type xvlog.log > compile.log
echo "xvhdl -m64 --relax -prj sim_tb_top_vhdl.prj"
call %xv_path%/xvhdl  -m64 --relax -prj sim_tb_top_vhdl.prj -log xvhdl.log
call type xvhdl.log >> compile.log
if "%errorlevel%"=="1" goto END
if "%errorlevel%"=="0" goto SUCCESS
:END
exit 1
:SUCCESS
exit 0
