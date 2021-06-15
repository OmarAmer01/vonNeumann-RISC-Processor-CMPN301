restart -nowave

add wave -position end  sim:/processor/clk
add wave -position end -radix hex -color cyan sim:/processor/aluOp1
add wave -position end -radix hex -color cyan sim:/processor/aluOp2
add wave -position end -radix hex -color orange sim:/processor/aluRes
add wave -position end -radix hex -color yellow sim:/processor/status
add wave -position end -radix hex  sim:/processor/ctrlALUop
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100

force -freeze sim:/processor/aluOp1 x\"1234_5678\" 0
force -freeze sim:/processor/aluOp2 x\"ABCD_EFAB\" 0

##### BEGIN TESTING #####

force -freeze sim:/processor/ctrlALUop 00000 0
run


force -freeze sim:/processor/ctrlALUop 00001 0
run


force -freeze sim:/processor/ctrlALUop 00010 0
run


force -freeze sim:/processor/ctrlALUop 00011 0
run


force -freeze sim:/processor/ctrlALUop 00100 0
run


force -freeze sim:/processor/ctrlALUop 00101 0
run


force -freeze sim:/processor/ctrlALUop 00110 0
run


force -freeze sim:/processor/ctrlALUop 00111 0
run

force -freeze sim:/processor/ctrlALUop 01000 0
run

force -freeze sim:/processor/ctrlALUop 01001 0
run

force -freeze sim:/processor/ctrlALUop 01010 0
run

force -freeze sim:/processor/ctrlALUop 01011 0
run

force -freeze sim:/processor/ctrlALUop 01100 0
run

force -freeze sim:/processor/ctrlALUop 01101 0
run

force -freeze sim:/processor/ctrlALUop 01110 0
run

force -freeze sim:/processor/ctrlALUop 01111 0
run

force -freeze sim:/processor/ctrlALUop 10000 0
run

force -freeze sim:/processor/ctrlALUop 10001 0
run

force -freeze sim:/processor/ctrlALUop 10010 0
run

force -freeze sim:/processor/ctrlALUop 10011 0
run

force -freeze sim:/processor/ctrlALUop 10100 0
run
