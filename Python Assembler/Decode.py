from os import write
import re

Registers = {"R0":"000" , "R1":"001" ,"R2":"010" ,"R3":"011" ,"R4":"100" ,"R5":"101" ,"R6":"110" ,"R7":"111"}
InstructionsOP = {"NOP":"00000" ,"SETC":"00001","CLRC":"00010","NOT":"00011","INC":"00100","DEC":"00101","OUT":"00111","IN":"01000","MOV":"01001","ADD":"01010","IADD":"01011","SUB":"01100","AND":"01101","OR":"01110","SHL":"01111","SHR":"10000","PUSH":"10001","POP":"10010","LDM":"10011","LDD":"10100","STD":"10101","JZ":"10110","JN":"10111","JC":"11000","JMP":"11001","CALL":"11010","RET":"11011","RTI":"11100"}

OneOperand ={"NOP","SETC","CLRC","NOT","INC","DEC","OUT","IN"}
TwoOperand ={"MOV","ADD","IADD","SUB","AND","OR","SHL","SHR"}
Memory ={"PUSH","POP","LDM","LDD","STD"}
Branch ={"JZ","JN","JC","JMP","CALL","RET","RTI"}

Immediate = {"IADD","LDM","LDD","STD"}
Shift = {"SHL","SHR"}

def dTob(num ,l):
    binary=bin(int(num , 16)).split('b')[1]
    for i in range(l - len(binary)):
        binary = "0" + binary #add zeroes to the left of the number
    return binary

def FillHex(num):
    for i in range(4 - len(num)):
        num = "0" + num #add zeroes to the left of the number
    return num

with open('D:\some code\Arch proj\case1.txt' , 'r') as file: # original code
    with open('D:\some code\Arch proj\Opcode.txt' , 'r+') as Opcode: # file to write in binary
        Opcode.truncate(0) # clear file if exists
        for Line in file:
            Instruction = Line.split('#')
            Instruction = Instruction[0].split() #these 2 lines to get rid of comments next to instrucions

            if Instruction and Instruction[0].upper() in InstructionsOP.keys():  #check if instruction isnt empty and then check if the instruction exist
                Opcode.write(InstructionsOP[Instruction[0].upper()])
                #print(Instruction)
                if Instruction[0].upper() in OneOperand: #One operand
                    if len(Instruction) > 1 and Instruction[1].upper() in Registers.keys(): # add register opcode and fill rest with zeroes
                        Opcode.write(Registers[Instruction[1].upper()] + "00000000")
                    else:
                        Opcode.write("00000000000")

                elif Instruction[0].upper() in TwoOperand: #Two Operand
                    r=Instruction[1].split(',')
                    if r[0].upper() in Registers.keys():
                        Opcode.write(Registers[r[0].upper()])                    
                    if r[1].upper() in Registers.keys(): #Instruction[2] is "," so 2nd register is in Instruction[3]
                        Opcode.write(Registers[r[1].upper()] + "00000")
                    elif Instruction[0].upper() in Shift:
                        Opcode.write("000" + dTob(r[1],5))
                    elif Instruction[0].upper() in Immediate:
                        Opcode.write("000" + dTob(r[1],16) +"00000")

                elif Instruction[0].upper() in Branch:  # branch operation
                    
                    if len(Instruction) > 1 and Instruction[1].upper() in Registers.keys(): # add register opcode and fill rest with zeroes
                        #print (Instruction , len(Instruction))
                        Opcode.write(Registers[Instruction[1].upper()] + "00000000")
                    else: # just for RET pretty much
                        Opcode.write("00000000000")

                elif Instruction[0].upper() in Memory:
                    r=Instruction[1].split(',')
                    if r[0].upper() in Registers.keys():
                        Opcode.write(Registers[r[0].upper()])
                    if len(r) > 1:
                        r2= re.split( pattern=r"[()]",string =r[1])
                        if len(r2) > 1:
                            if r2[1].upper() in Registers.keys():
                                Opcode.write(Registers[r2[1].upper()])                                
                        else:
                            Opcode.write("000")
                        Opcode.write(dTob(r2[0],16) + "00000")
                    else:
                        Opcode.write("00000000")
                Opcode.write("\n")
            elif Instruction and Instruction[0].upper() == ".ORG":
                Opcode.write(Instruction[0] + " " + Instruction[1] + "\n")

with open('D:\some code\Arch proj\Opcode.txt' , 'r') as oc: #file to write in binary
    with open('D:\some code\Arch proj\Test.txt' , 'w') as test: #final toput in VHDL
        test.truncate(0)
        test.write("// memory data file (do not edit the following line - required for mem load use)\n// instance=/processor/InstructMem/ram\n// format=bin addressradix=h dataradix=b version=1.0 wordsperline=4\n")
        #test.write("type ramType is array(0 to 1024) of std_logic_vector(15 downto 0) ;\nsignal ram : ramType;\n")
        iteration = 0
        Location = 0
        for line in oc:
            a = line.split()
            if(a and a[0].upper() == ".ORG"):
                #print(a[1])
                if iteration != 0:
                    for i in range (4 - Location % 4):
                        test.write("0000000000000000 ")
                        if i == 3 - Location % 4:
                            test.write("\n")
                if iteration != 0: 
                    tempLoc = Location
                else:
                    tempLoc=-10
                Location = int(a[1] , 16)
                z = Location - (Location % 4)
                print(z)
                if Location - tempLoc > 4:
                    test.write("@" + str(hex(z).split('x')[1]) +" ")
                    for i in range (Location % 4):
                        test.write("0000000000000000 ")    

            elif len(line) > 20:
                chunks = [line[i:i+16] for i in range(0, len(line), 16)]
                test.write(chunks[0] + " ")
                Location +=1
                if Location % 4 == 0:
                    test.write("\n@" + str(hex(Location).split('x')[1]) +" ")
                
                test.write(chunks[1] + " ")
                Location +=1
                if Location % 4 == 0:
                    test.write("\n@" + str(hex(Location).split('x')[1]) +" ")
            else:
                test.write(line[:-1] + " ")
                Location +=1
                if Location % 4 == 0:
                    test.write("\n@" + str(hex(Location).split('x')[1]) +" ")
            iteration +=1
        for i in range (Location % 4):
            test.write("0000000000000000 ")
        #test.close()
