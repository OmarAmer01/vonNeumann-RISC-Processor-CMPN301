restart -nowave

add wave -position end  sim:/shreg/clk
force -freeze sim:/shreg/clk 1 0, 0 {50 ps} -r 100

add wave -position end -color white  sim:/shreg/rst

add wave -position end -color cyan   sim:/shreg/shfDir
add wave -position end -color blue -radix hex   sim:/shreg/shfAmt

add wave -position end -color yellow sim:/shreg/shBit

add wave -position end -color orange sim:/shreg/dataIN
add wave -position end -color pink   sim:/shreg/dataOut


force -freeze sim:/shreg/dataIN x\"ABCDABCD\" 0
force -freeze sim:/shreg/shfAmt 10#12 0
force -freeze sim:/shreg/shfDir 0 0


run 1000 ps
force -freeze sim:/shreg/shfDir 1 0
run 1000 ps