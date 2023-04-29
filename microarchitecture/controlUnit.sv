module controlUnit(input [1:0] opType, input [3:0] opCode, output immSrc,branchFlag,memWrite,memToReg, output [3:0] aluControl);

 //immSrc : es inmediato en alu
 //brachFlag: es branch
 //aluControl: operacion en alu
 //memWrite: operacion escribe en memoria
 //memToReg: de memoria a registro
 
 
	immSrcControl myImmSrc(.opType(opType),.immSrc(immSrc));
	branchFlagControl myBranchFlag (.opType(opType),.branchFlag(branchFlag));
	aluControl myAluControl(.opType(opType),.opCode(opCode),.aluControl(aluControl));
	memWriteControl myMemWriteControl(.opType(opType),.opCode(opCode),.memWrite(memWrite));
	memToRegControl myMemToRegControl(.opType(opType),.opCode(opCode),.memToReg(memToReg));
endmodule 