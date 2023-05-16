module testEx;
	parameter RW = 24;
	parameter BW = 64;


	logic clk, rst, en;
	logic [RW-1:0] rd1, rd2, pc, imm, Forward1, Forward2,Forward3;
	logic [RW-1:0] rd3;
	logic [3:0] aluControl;
	logic [3:0] Rc;
	logic immSrc, branchFlag, memWrite, memToReg, regWrite;
	logic Fa, Fb,Fc;
	logic [1:0] opType;
	logic [3:0] opCode;
	
	logic [BW-1:0] bufferOut;


	
	exec #(.N(RW), .BW(BW)) exec1(
	.clk(clk), .rst(rst), .en(en),
	.rd1(rd1), .rd2(rd2), .pc(pc), .imm(imm),
	.Forward1(forward1), .Forward2(forward2), .Forward3(forward3),
	.rd3(rd3),
	.aluControl(aluControl),
	.Rc(Rc),
	.immSrc(immSrc), .branchFlag(branchFlag), .memWrite(memWrite), .memToReg(memToReg), .regWrite(regWrite),
	.Fa(Fa), .Fb(Fb), .Fc(Fc),
	.opType(opType), .opCode(opCode),
	.bufferOut(bufferOut)
	);
	
	
	
	

	
	// Clock generation
	always #10 clk = ~clk;

	
	// Initialize inputs
	initial begin
		clk = 1;
		rst = 1;
		#10;
		#10;
		rst = 0;
		en = 1;
		//Exec Inputs
		rd3 = 0;
		Rc = 0; 
		memWrite = 0;
		memToReg = 0;
		regWrite = 0;
		Fa = 0;
		Fb = 0;
		Fc = 0;
		opType = 0;
		opCode = 0;
		
		
		
//    Decode Buffer (rd1 + rd2)
		aluControl = 1; rd1 = 2; rd2 = 2; pc = 0; imm = 0; immSrc = 0; branchFlag = 0; 

		
		#10; //negedge
		
		#10; //posedge
//    (rd1 == rd2)
		aluControl = 4; rd1 = 3; rd2 = 2; pc = 0; imm = 0; immSrc = 0; branchFlag = 0; 
		
		#10; //negedge
//		Assert rd1 + rd2
		assert(bufferOut[23:0] === 0) else $error("rd value"); //rd3
		assert(bufferOut[27:24] === 0) else $error("Rc value"); //Rc
		assert(bufferOut[28] === 0) else $error("regWrite value"); //regWrite
		assert(bufferOut[29] === 0) else $error("memToReg value"); //memToReg
		assert(bufferOut[30] === 0) else $error("memWrite value"); //memWrite
		assert(bufferOut[31] === 0) else $error("branchFlag value"); //branchFlag
		assert(bufferOut[32] === 0) else $error("negFlag value"); //negFlag
		assert(bufferOut[33] === 0) else $error("zeroFlag value 1"); //zeroFlag
		assert(bufferOut[57:34] === 4) else $error("aluCurrentResult value"); //aluCurrentResult
		assert(bufferOut[61:58] == 0)  else $error("opCode value"); //opCode
		assert(bufferOut[63:62] == 0)  else $error("opType value"); //opType
		$display("Data: %b", bufferOut[57:34]);	
		
		#10; //posedge
//		(rd1 - rd2)
		aluControl = 0; rd1 = 2; rd2 = 3; pc = 0; imm = 0; immSrc = 0; branchFlag = 0; 
		
		#10; //negedge
//		
		assert(bufferOut[57:34] === 1) else $error("Test to compare rd1 and rd2");//aluCurrentResult
		assert(bufferOut[33] === 0) else $error("zeroFlag value 2"); //zeroFlag
		$display("Data: %b", bufferOut[57:34]);
			
		#10; //posedge
		

		#10; //negedge
		assert($signed(bufferOut[57:34]) === -1) else $error("Test to sub rd1 and rd2");//aluCurrentResult
		assert(bufferOut[34] === 1) else $error("negFlag value 2"); //zeroFlag
		$display("Data: %b", bufferOut[57:34]);
	end


	
endmodule