restart -nowave

add wave -position end -radix hex -color cyan sim:/alu/op1
add wave -position end -radix hex -color cyan sim:/alu/op2
add wave -position end -radix hex -color yellow sim:/alu/opCode
add wave -position end -radix hex -color orange sim:/alu/res
add wave -position end -radix hex -color white sim:/alu/cf
add wave -position end -radix hex -color white sim:/alu/nf
add wave -position end -radix hex -color white sim:/alu/zf





force -freeze sim:/alu/op1 x\"1234_5678\" 0
force -freeze sim:/alu/op2 x\"ABCD_EFAB\" 0
force -freeze sim:/alu/opCode x"1" 0 
run 
# NOP

force -freeze sim:/alu/op1 x\"1234_5678\" 0
force -freeze sim:/alu/op2 x\"ABCD_EFAB\" 0
force -freeze sim:/alu/opCode x"2" 0 
run 
# SETC

force -freeze sim:/alu/op1 x\"1234_5678\" 0
force -freeze sim:/alu/op2 x\"ABCD_EFAB\" 0
force -freeze sim:/alu/opCode x"3" 0 
run 
# CLRC

force -freeze sim:/alu/op1 x\"1234_5678\" 0
force -freeze sim:/alu/op2 x\"ABCD_EFAB\" 0
force -freeze sim:/alu/opCode x"4" 0 
run 
# NOT op1

force -freeze sim:/alu/op1 x\"1234_5678\" 0
force -freeze sim:/alu/op2 x\"ABCD_EFAB\" 0
force -freeze sim:/alu/opCode x"5" 0 
run 
# INC

force -freeze sim:/alu/op1 x\"FFFF_FFFF\" 0
force -freeze sim:/alu/op2 x\"ABCD_EFAB\" 0
force -freeze sim:/alu/opCode x"5" 0 
run 
# INC CARRY TEST

force -freeze sim:/alu/op1 x\"1234_5678\" 0
force -freeze sim:/alu/op2 x\"ABCD_EFAB\" 0
force -freeze sim:/alu/opCode x"6" 0 
run 
# DEC

force -freeze sim:/alu/op1 x\"0000_0000\" 0
force -freeze sim:/alu/op2 x\"ABCD_EFAB\" 0
force -freeze sim:/alu/opCode x"6" 0 
run 
# DEC BORROW TEST

force -freeze sim:/alu/op1 x\"1234_5678\" 0
force -freeze sim:/alu/op2 x\"ABCD_EFAB\" 0
force -freeze sim:/alu/opCode x"A" 0 
run 
# ADD

force -freeze sim:/alu/op1 x\"FFFF_FFFF\" 0
force -freeze sim:/alu/op2 x\"0000_0001\" 0
force -freeze sim:/alu/opCode x"A" 0 
run 
# ADD CARRY TEST

force -freeze sim:/alu/op1 x\"0000_000D\" 0
force -freeze sim:/alu/op2 x\"0000_0006\" 0
force -freeze sim:/alu/opCode x"C" 0 
run 
# SUB BORROW TEST

force -freeze sim:/alu/op1 x\"1234_5678\" 0
force -freeze sim:/alu/op2 x\"ABCD_EFAB\" 0
force -freeze sim:/alu/opCode x"D" 0 
run 
# AND

force -freeze sim:/alu/op1 x\"1234_5678\" 0
force -freeze sim:/alu/op2 x\"ABCD_EFAB\" 0
force -freeze sim:/alu/opCode x"E" 0 
run 
# OR