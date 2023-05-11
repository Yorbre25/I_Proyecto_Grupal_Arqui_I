module testExec;
	parameter setValuesBuffer = 16;
	parameter RW = 24;
	parameter BufferW = setValuesBuffer + 2*RW;

	logic clk, rst, en;
	logic signed [RW-1:0] rd1, rd2, pc, imm, aluOut, result;
	logic signed [RW-1:0] rd3;
	logic [1:0] opType;
	logic [3:0] aluControl, opCode;
	logic [3:0] Rc;
	logic immSrc, branchFlag, memWrite, memToReg, regWrite;
	logic Fa, Fb;
	logic [BufferW-1:0] bufferOut;
	
	exec #(.N(RW), .BW(BufferW)) exec1(
	.clk(clk), .rst(rst), .en(en),
	.rd1(rd1), .rd2(rd2), .pc(pc), .imm(imm), .aluOut(aluOut), .result(result),
	.rd3(rd3),
	.aluControl(aluControl),
	.Rc(Rc),
	.immSrc(immSrc), .branchFlag(branchFlag), .memWrite(memWrite), .memToReg(memToReg), .regWrite(regWrite),
	.Fa(Fa), .Fb(Fb),
	.opType(opType), .opCode(opCode),
	.bufferOut(bufferOut)
	);
	
	
	// Clock generation
	always #10 clk = ~clk;

	// Initialize inputs
	initial begin
		clk = 1;
		rst = 0;
		en = 1;
		
		//Output Buffer 
		memWrite = 0; 
		memToReg = 0; 
		regWrite = 0;
		Rc = 3;
		rd3 = 0;
		opType = 0;
		opCode = 1;
		Fa = 0; 
		Fb = 0;
		
		//Inputs
		rd1 = 2; 
		rd2 = 2; 
		pc = 0; 
		imm = 0; 
		aluOut = 0; 
		result = 0;

		immSrc = 0;
		aluControl = 0;
		branchFlag = 0; 
		
//		// Apply reset
//		rst = 1;
//		#5;
//		rst = 0;
//		#5;

	
		// rd1 + rd2 
		rd1 = 2; rd2 = 2; pc = 2; imm = 2; aluOut = 0; result = 0;
		immSrc = 0; branchFlag = 0; aluControl = 1;
		#30;
		assert(bufferOut[23:0] === 0) else $error("rd value"); //rd3
		assert(bufferOut[27:24] === 3) else $error("Rc value"); //Rc
		assert(bufferOut[28] === 0) else $error("regWrite value"); //regWrite
		assert(bufferOut[29] === 0) else $error("memToReg value"); //memToReg
		assert(bufferOut[30] === 0) else $error("memWrite value"); //memWrite
		assert(bufferOut[31] === 0) else $error("branchFlag value"); //branchFlag
		assert(bufferOut[32] === 0) else $error("negFlag value"); //negFlag
		assert(bufferOut[33] === 0) else $error("zeroFlag value 1"); //zeroFlag
		assert(bufferOut[57:34] === 4) else $error("aluCurrentResult value"); //aluCurrentResult
		assert(bufferOut[61:58] == 1)  else $error("opCode value"); //opCode
		assert(bufferOut[63:62] == 0)  else $error("opType value"); //opType
		$display("Data: %b", bufferOut[57:34]);
		$display("Data: %b", bufferOut);
		
		
		rd1 = 2; rd2 = 2; pc = 0; imm = 2; aluOut = 0; result = 0;
		aluControl = 4;
		immSrc = 1; branchFlag = 0; 
		#30;
		assert(bufferOut[57:34] === 0) else $error("Test to compare rd1 and imm");//aluCurrentResult
		assert(bufferOut[33] === 1) else $error("zeroFlag value 2"); //zeroFlag
		$display("Data: %b", bufferOut[57:34]);
		
		
		rd1 = 2; rd2 = 2; pc = 1; imm = 1; aluOut = 0; result = 0;
		aluControl = 0;
		immSrc = 0; branchFlag = 1; 
		#30;
		assert($signed(bufferOut[25:22]) === -1) else $error("Test to sub pc and rd2");//aluCurrentResult
		assert(bufferOut[20] === 1) else $error("negFlag value 2"); //zeroFlag
		$display("Data: %b", bufferOut);
		
		
	end

	
endmodule
