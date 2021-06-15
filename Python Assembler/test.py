# Registers = {"R0":"000" , "R1":"001" ,"R2":"010" ,"R3":"011" ,"R4":"100" ,"R5":"101" ,"R6":"110" ,"R7":"111"}
# InstructionsOP = {"NOP":"0000000000000000" ,"SETC":"0000100000000000","CLRC":"0001000000000000","NOT":"00011","INC":"00100","DEC":"00101","OUT":"00111","IN":"01000","MOV":"01001","ADD":"01010","IADD":"01011","SUB":"01100","AND":"01101","OR":"01110","SHL":"01111","SHR":"10000","PUSH":"10001","POP":"10010","LDM":"10011","LDD":"10100","STD":"10101","JZ":"10110","JN":"10111","JC":"11000","JMP":"11001","CALL":"11010","RET":"11011","RTI":"11100"}
# OneOperand ={"NOP","SETC","CLRC","NOT","INC","DEC","OUT","IN"}
# TwoOperand ={"MOV","ADD","IADD","SUB","AND","OR","SHL","SHR"}
# Memory ={"PUSH","POP","LDM","LDD","STD"}
# Branch ={"JZ","JN","JC","JMP","CALL","RET"}

a=16


def dTob(num ,l):
    binary=bin(num).split('b')[1]
    for i in range(l - len(binary)):
        binary = "0" + binary #add zeroes to the left of the number
    return binary

hexa = input("Enter Hex: ")

ih = int(hexa , 16)
ih+=1
print (ih)

#print(dTob(20,5))