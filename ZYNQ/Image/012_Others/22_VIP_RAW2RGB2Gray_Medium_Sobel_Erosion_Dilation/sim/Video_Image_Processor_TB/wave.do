onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Video_Image_Processor_TB/clk_cmos
add wave -noupdate /Video_Image_Processor_TB/sys_rst_n
add wave -noupdate /Video_Image_Processor_TB/u_Video_Image_Simulate_CMOS/cmos_pclk
add wave -noupdate /Video_Image_Processor_TB/u_Video_Image_Processor/per_frame_vsync
add wave -noupdate /Video_Image_Processor_TB/u_Video_Image_Processor/per_frame_href
add wave -noupdate -radix unsigned /Video_Image_Processor_TB/u_Video_Image_Processor/per_img_RAW
add wave -noupdate -radix unsigned /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/u_VIP_Matrix_Generate_3X3_8Bit/row1_data
add wave -noupdate -radix unsigned /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/u_VIP_Matrix_Generate_3X3_8Bit/row2_data
add wave -noupdate -radix unsigned /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/u_VIP_Matrix_Generate_3X3_8Bit/row3_data
add wave -noupdate -radix unsigned /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/u_VIP_Matrix_Generate_3X3_8Bit/pixel_cnt
add wave -noupdate -radix hexadecimal /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/u_VIP_Matrix_Generate_3X3_8Bit/matrix_row1
add wave -noupdate -radix hexadecimal /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/u_VIP_Matrix_Generate_3X3_8Bit/matrix_row2
add wave -noupdate -radix hexadecimal /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/u_VIP_Matrix_Generate_3X3_8Bit/matrix_row3
add wave -noupdate /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/u_VIP_Matrix_Generate_3X3_8Bit/matrix_frame_vsync
add wave -noupdate /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/u_VIP_Matrix_Generate_3X3_8Bit/matrix_frame_href
add wave -noupdate -radix unsigned /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/line_cnt
add wave -noupdate -radix unsigned /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/pixel_cnt
add wave -noupdate -radix unsigned /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/post_img_red
add wave -noupdate -radix unsigned /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/post_img_green
add wave -noupdate -radix unsigned /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/post_img_blue
add wave -noupdate /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/post_frame_vsync
add wave -noupdate /Video_Image_Processor_TB/u_Video_Image_Processor/u_VIP_RAW8_RGB888/post_frame_href
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {93380194 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 212
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {90025 ns} {100525 ns}
