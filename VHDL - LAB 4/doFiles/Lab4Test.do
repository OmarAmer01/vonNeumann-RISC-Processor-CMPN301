# DO FILE TEST
# OMAR TAREK AHMED MOHAMED ALY AMER
# 1180004
# SUNDAY LAB


restart -nowave



add wave -position end -color white  -radix hex   sim:/regram/data   
#add wave -position end -color white  -radix hex   sim:/regram/dataBus   

add wave -position end -color blue                sim:/regram/rAddr  
add wave -position end -color blue                sim:/regram/wAddr
add wave -position end -color cyan                sim:/regram/rwSel
add wave -position end -color cyan                sim:/regram/rrSel  
add wave -position end                            sim:/regram/rst   

add wave -position end -color yellow              sim:/regram/wen
add wave -position end -color yellow              sim:/regram/ren


add wave -position end -color cyan                sim:/regram/clk     
 

add wave -position end -color orange -radix hex   sim:/regram/r0out   
add wave -position end -color orange -radix hex   sim:/regram/r1out   
add wave -position end -color orange -radix hex   sim:/regram/r2out   
add wave -position end -color orange -radix hex   sim:/regram/r3out
add wave -position end -color orange -radix hex   sim:/regram/ramAddr   

add wave -position end               -radix hex   sim:/regram/ramOut

  
 
force -freeze sim:/regram/clk 0 0, 1 {50 ns} -r 100 ns

force -freeze sim:/regram/rAddr "00" 0
force -freeze sim:/regram/wAddr "00" 0

force -freeze sim:/regram/wen 1 0
force -freeze sim:/regram/ren 0 0


mem load -filltype value -filldata 101 -fillradix hexadecimal /regram/ram32/ram(0)
mem load -filltype value -filldata 102 -fillradix hexadecimal /regram/ram32/ram(1)
mem load -filltype value -filldata 103 -fillradix hexadecimal /regram/ram32/ram(2)
mem load -filltype value -filldata 104 -fillradix hexadecimal /regram/ram32/ram(3)
mem load -filltype value -filldata 105 -fillradix hexadecimal /regram/ram32/ram(4)


# RESET

force -freeze sim:/regram/rst "1" 0
run 5 ns
force -freeze sim:/regram/rst "0" 0

#tm t3b2et el ram benaga7

run 100 ns

# load M[0] on r0

force -freeze sim:/regram/ren "0" 0
force -freeze sim:/regram/wen "1" 0
force -freeze sim:/regram/wAddr "00" 0
run 25 ns

# load M[1] on r1

force -freeze sim:/regram/ren "0" 0
force -freeze sim:/regram/wen "1" 0
force -freeze sim:/regram/wAddr "01" 0

run 25 ns

# load r0 on r3
force -freeze sim:/regram/wen "0" 0
force -freeze sim:/regram/ren "1" 0
force -freeze sim:/regram/rAddr "00" 0
force -freeze sim:/regram/wAddr "11" 0

run 25 ns

force -freeze sim:/regram/wen "1" 0
force -freeze sim:/regram/ren "1" 0

force -freeze sim:/regram/wAddr "11" 0
force -freeze sim:/regram/rAddr "00" 0

run 100 ns


# store from r1 to M[3]
force -freeze sim:/regram/ren "1" 0
force -freeze sim:/regram/rAddr "01" 0

run 25 ns
force -freeze sim:/regram/wen "0" 0

run 150 ns

