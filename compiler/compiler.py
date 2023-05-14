Instructions = {
    "sub":{"opType":"art", "opcode":0},
    "add":{"opType":"art", "opcode":1},
    "mult":{"opType":"art", "opcode":2},
    "mov":{"opType":"art", "opcode":3},
    "cmp":{"opType":"art", "opcode":4},
    "div":{"opType":"art", "opcode":5},
    "xor":{"opType":"art", "opcode":6},
    "and":{"opType":"art", "opcode":7},
    "not":{"opType":"art", "opcode":8},
    "sl":{"opType":"art", "opcode":9},
    "sr":{"opType":"art", "opcode":10},
    "mod":{"opType":"art", "opcode":11},
    "ld":{"opType":"mem", "opcode":0},
    "str":{"opType":"mem", "opcode":1},
    "bi":{"opType":"cont", "opcode":0},
    "beq":{"opType":"cont", "opcode":1},
    "bneq":{"opType":"cont", "opcode":2},
    "bleq":{"opType":"cont", "opcode":3},
    "bg":{"opType":"cont", "opcode":4},
    }

functions = {}
branchLine = 0
actualInstruction = 0
instructionResult = []

def openFile():
    f = open("input.s", "r")
    counter = 0
    for line in f:
        if not line.isspace():
            try:
                AnalyzeLine(line.lower(), counter)
            except:
                print("Exception in line ", counter)
            counter += 1
  
    SetBranches()
    f.close()

    CreateFile()

def AnalyzeLine(line, counter):
    global branchLine
    global actualInstruction
    line = line.strip()
    if ":" in line:
        name = line.replace(":","")
        functions[name] = branchLine
        
    elif(line != ""):
        lineElements = line.split(" ",1)
        registers = GetRegistersInList(lineElements[1])
        GetFunction(lineElements[0], registers)
        actualInstruction += 1
        branchLine += 1

def GetFunction(functionText, registersList):
    result = Instructions.get(functionText)
    code = ""
    #If operation es aritmethic
    if(result.get("opType") == "art"):
        flag =  IsInmediate(registersList[len(registersList)-1])
        code += "01" if flag else "00"
        opcode = format(result.get("opcode"), 'b')
        while (len(opcode) < 4): opcode = "0"+opcode
        code += opcode
        if(functionText == "cmp" or functionText == "mov" or functionText == "not"): #It's an op of 2 operands
            if(functionText == "cmp"):
                code += GetAllRegistersOpcode("r0", registersList[0] ,registersList[1]) 
            else:   
                code += GetAllRegistersOpcode(registersList[0], "r0" ,registersList[1])
        else:
            code += GetAllRegistersOpcode(registersList[0], registersList[1], registersList[2])
    #If operation is Memory
    elif(result.get("opType") == "mem"):
        code += "10000"
        #If operation is load add 0, else is a store operation and add 1
        code += "0" if functionText == "ld" else "1"
        
        if(len(registersList) == 2):
            code += GetAllRegistersOpcode(registersList[0],registersList[1], "r0")
        else: 
            code += GetAllRegistersOpcode(registersList[0], registersList[1], registersList[2])
    elif(result.get("opType") == "cont"):
        code += "110"
        opcode = format(result.get("opcode"), 'b')
        while (len(opcode) < 3): opcode = "0"+opcode
        code += opcode
        code += "0" * 8
        code += "=" + registersList[0]
    instructionResult.append(code)
    print(code)

# Returns registers in a list
def GetRegistersInList(registersString):
    registersString = registersString.replace(" ","")
    registers = registersString.split(",")
    return registers

def IsInmediate(register3):
    
    flag = False
    if("#" in register3):
        flag = True
    return flag

def GetAllRegistersOpcode(register1, register2, register3): 
    flag = IsInmediate(register3)
    reg1 = GetRegisterOpcode(register1)
    reg2 = GetRegisterOpcode(register2)
    reg3 = ""
    if(flag):
        registerNumber = register3.replace("#","")
        registerNumber = int(registerNumber)
        reg3Aux = format(registerNumber, 'b')
        reg3 = reg3Aux.replace("-","")
        counter = len(reg3)
        print("Int is: ", registerNumber)
        print("reg3Aux is: ", reg3Aux)
        print("reg3 is: ", reg3)
        while(counter < 18):
            if("-" in reg3Aux and counter == 17):
                reg3 = "1" + reg3
            else:
                reg3 = "0" + reg3
            counter += 1
    else:
        reg3 = GetRegisterOpcode(register3)
        reg3 += "0" * 14
    result = reg1 + reg2 + reg3
    return result

def GetRegisterOpcode(register):
    registerNumber = register.replace("r","")
    registerNumber = int(registerNumber)
    binary = format(registerNumber, 'b')
    counter = len(binary)
    while(counter < 4):
        binary = "0" + binary
        counter += 1
    return binary

def SetBranches():
    branchLine = 0
    for branch in instructionResult:
        
        if( "=" in branch):
            pcRelative = 0
              
            newInstruction = branch[:branch.find("=")]
            branchLabel = branch[branch.find("=") + 1 :]
            print("Instruccion ",newInstruction)

            jump = functions.get(branchLabel)
            actualInstructionAux = branchLine
            print("Pc Relative ", jump)
            print("Actual Line ", branchLine)
            if(jump > branchLine):
                while(jump > actualInstructionAux):
                    pcRelative += 4
                    actualInstructionAux += 1
            elif(jump < actualInstructionAux):
                while(jump < actualInstructionAux):
                    pcRelative -= 4
                    actualInstructionAux -= 1

            resultAux = format(pcRelative, 'b')
            result = resultAux.replace("-","")
            counter = len(result)
            while(counter < 18):
                if("-" in resultAux and counter == 17):
                    result = "1" + result
                else:
                    result = "0" + result
                counter += 1
            instructionResult[branchLine] = newInstruction + result
        branchLine += 1
    return ""

def CreateFile():
    with open('output.mem', 'w') as f:
        counter = 0
        for line in instructionResult:
            hexadecimal = ConvertToHex(line)
            if(counter == len(instructionResult) - 1):
                f.writelines(hexadecimal[6:8]+"\n"+hexadecimal[4:6]+"\n"+hexadecimal[2:4]+"\n"+hexadecimal[0:2])
            else:
                f.writelines(hexadecimal[6:8]+"\n"+hexadecimal[4:6]+"\n"+hexadecimal[2:4]+"\n"+hexadecimal[0:2]+"\n")
            counter += 1
    f.close()

def ConvertToHex(binaryNumber):
    hexNumber = hex(int(binaryNumber,2))
    hexNumberSplit = hexNumber.split("x")
    hexNumber = hexNumberSplit[1]
    counter = len(hexNumber)
    while (counter < 8):
        hexNumber = "0" +hexNumber
        counter += 1
    return hexNumber
CreateFile()

openFile()