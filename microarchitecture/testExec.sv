module testExec;
	parameter WIDTH = 4;
	parameter BW = 32;

	logic clk, rst, en;
	logic signed [WIDTH-1:0] rd1, rd2, pc, imm, aluOut, result;
	logic signed [WIDTH-1:0] rd3;
	logic [1:0] opType;
	logic [3:0] aluControl, opCode;
	logic [3:0] Ra, Rb, Rc;
	logic immSrc, branchFlag, memWrite, memToReg, regWrite;
	logic Fa, Fb;
	logic [BW-1:0] bufferOut;
	
	exec #(.N(WIDTH), .BW(BW)) exec1(clk, rst, en, rd1, rd2, pc, imm, aluOut, result, rd3, aluControl, Ra, Rb, Rc, immSrc, branchFlag, memWrite, memToReg, regWrite, opType, opCode, Fa, Fb, bufferOut);
	
	
	
	// Clock generation
	always #5 clk = ~clk;

	// Initialize inputs
	initial begin
		clk = 0;
		rst = 0;
		en = 1;
		
		//Output Buffer 
		branchFlag = 0; 
		memWrite = 0; 
		memToReg = 0; 
		regWrite = 0;
		Ra = 1;
		Rb = 2;
		Rc = 3;
		rd3 = 0;
		opType = 0;
		opCode = 1;
		
		//Inputs
		rd1 = 2; 
		rd2 = 2; 
		pc = 0; 
		imm = 0; 
		aluOut = 0; 
		result = 0;
		Fa = 0; 
		Fb = 0;
		immSrc = 1;
		aluControl = 0;
		
		// Apply reset
		rst = 1;
		#10;
		rst = 0;
		#10;

	
		// rd1 + rd2 
		rd1 = 2; rd2 = 2; pc = 0; imm = 0; aluOut = 0; result = 0;
		immSrc = 0; branchFlag = 0; aluControl = 1;
		#15;
		assert(bufferOut[3:0] === 0) else $error("add rd1 and rd2"); //rd3
		assert(bufferOut[7:4] === 3) else $error("Rc value"); //Rc
		assert(bufferOut[11:8] === 2) else $error("Rb value"); //Rb
		assert(bufferOut[15:12] === 1) else $error("Ra value"); //Ra
		assert(bufferOut[16] === 0) else $error("regWrite value"); //regWrite
		assert(bufferOut[17] === 0) else $error("memToReg value"); //memToReg
		assert(bufferOut[18] === 0) else $error("memWrite value"); //memWrite
		assert(bufferOut[19] === 0) else $error("branchFlag value"); //branchFlag
		assert(bufferOut[20] === 0) else $error("negFlag value"); //negFlag
		assert(bufferOut[21] === 0) else $error("zeroFlag value 1"); //zeroFlag
		assert(bufferOut[25:22] === 4) else $error("aluCurrentResult value"); //aluCurrentResult
		assert(bufferOut[27:26] == 1)  else $error("opCode value"); //opCode
		assert(bufferOut[31:28] == 0)  else $error("opType value"); //opType
		$display("Data: %b", bufferOut);

		
		rd1 = 2; rd2 = 2; pc = 0; imm = 2; aluOut = 0; result = 0;
		aluControl = 4;
		immSrc = 1; branchFlag = 0; 
		#15;
		assert(bufferOut[25:22] === 0) else $error("Test to compare rd1 and imm");//aluCurrentResult
		assert(bufferOut[21] === 1) else $error("zeroFlag value 2"); //zeroFlag
		$display("Data: %b", bufferOut);
		
		
		rd1 = 2; rd2 = 2; pc = 1; imm = 1; aluOut = 0; result = 0;
		aluControl = 0;
		immSrc = 0; branchFlag = 1; 
		#15;
		assert($signed(bufferOut[25:22]) === -1) else $error("Test to sub pc and rd2");//aluCurrentResult
		assert(bufferOut[20] === 1) else $error("negFlag value 2"); //zeroFlag
		$display("Data: %b", bufferOut);
		
		
	end

	
endmodule
