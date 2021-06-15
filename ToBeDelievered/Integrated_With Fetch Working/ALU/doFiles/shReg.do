restart -nowave

add wave -position end  sim:/shreg/clk
force -freeze sim:/shreg/clk 1 0, 0 {50 ps} -r 100

add wave -position end -color white  sim:/shreg/rst

add wave -position end -color cyan   sim:/shreg/shDir
add wave -position end -color blue -radix hex   sim:/shreg/shAmt

add wave -position end -color yellow sim:/shreg/shBit

add wave -position end -color orange -radix hex  sim:/shreg/dataIN
add wave -position end -color pink   -radix hex sim:/shreg/dataOut


force -freeze sim:/shreg/dataIN x\"AB\" 0
force -freeze sim:/shreg/shAmt "00001" 0
force -freeze sim:/shreg/shDir 0 0


run 1000 ps
force -freeze sim:/shreg/shDir 1 0
run 1000 ps