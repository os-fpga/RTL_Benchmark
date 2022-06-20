quit -sim

vcom -work work -2002 -explicit -check_synthesis -novitalcheck -novital -source -O0 -debug -stats=none F:/Filtro_FIR/src/FIR_low_area.vhd
vcom -work work -2002 -explicit -check_synthesis -novitalcheck -novital -source -O0 -stats=none F:/Filtro_FIR/testbench/FIR_low_area_tb.vhd

vsim -gui work.fir_low_area_tb

add wave -position insertpoint  \
/fir_low_area_tb/data_length \
/fir_low_area_tb/bits_resol \
/fir_low_area_tb/taps \
/fir_low_area_tb/hn\
/fir_low_area_tb/areset \
/fir_low_area_tb/clock_fs \
/fir_low_area_tb/freq_xn

add wave -noupdate -format Analog-Interpolated -height 74 -max 2047.0 -min -2048.0 -radix decimal /fir_low_area_tb/duv_fir_signed/xn
add wave -noupdate -format Analog-Interpolated -height 74 -max 2047.0 -min -2048.0 -radix decimal /fir_low_area_tb/duv_fir_signed/yn

add wave -noupdate -format Analog-Interpolated -height 74 -max 4095.0 -min 0 -radix unsigned /fir_low_area_tb/duv_fir_unsigned/xn
add wave -noupdate -format Analog-Interpolated -height 74 -max 4095.0 -min 0 -radix unsigned /fir_low_area_tb/duv_fir_unsigned/yn



run -all