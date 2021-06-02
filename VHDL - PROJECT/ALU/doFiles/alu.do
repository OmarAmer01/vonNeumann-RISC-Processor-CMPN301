restart -nowave

add wave -position end -radix hex -color cyan sim:/au/op1
add wave -position end -radix hex -color cyan sim:/au/op2
add wave -position end -radix hex -color yellow sim:/au/opCode
add wave -position end -radix hex -color orange sim:/au/res
add wave -position end -radix hex -color white sim:/au/cf
add wave -position end -radix hex -color white sim:/au/nf
add wave -position end -radix hex -color white sim:/au/zf

force -freeze sim:/au/op1 x\"FFFF_FFFF\" 0
force -freeze sim:/au/opCode x"5" 0

run
force -freeze sim:/au/op1 x\"0000_0000\" 0
force -freeze sim:/au/opCode x"6" 0
run
run