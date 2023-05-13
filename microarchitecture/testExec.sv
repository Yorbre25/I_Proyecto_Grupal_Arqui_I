module testExec;
	parameter setValuesBuffer = 16;
	parameter RW = 24;
	parameter BufferW = setValuesBuffer + 2*RW;


	logic clk, rst, en;
	
	// DECODE BUFFER INPUTS
	logic [1:0] opType;
	logic [3:0] opCode;
	logic immSrc, branchFlag, memWrite, memToReg, regWrite;
	logic signed [3:0] aluControl, Ra, Rb, Rc;
	logic signed [RW-1:0] rd1, rd2, rd3;
	logic signed [RW-1:0] extendImm;
	
	//DECODE BUFFER
	logic [123:0]bufferInput_decode;
	logic [123:0]bufferOutput_decode;

	//Exec inputs
	logic [1:0] opType_e;
	logic [3:0] opCode_e;
	logic immSrc_e, branchFlag_e, memWrite_e, memToReg_e, regWrite_e;
	logic signed [3:0] aluControl_e, Rc_e;
	logic signed [RW-1:0] rd1_e, rd2_e, rd3_e;
	// outside decode buffer
	logic Fa_e, Fb_e;
	logic [RW-1:0] aluOut_e, result_e, imm_e, pc_e;

	
	logic [BufferW-1:0] bufferOut;
	
	
	buffer #(.Buffer_size(123)) ID_EX(
		.rst(rst),
		.clk(clk),
		.en(en),
		.bufferInput(bufferInput_decode),
		.bufferOut(bufferOutput_decode)
	);
		
	
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
	
	
	assign bufferInput_decode={opType,opCode,immSrc,branchFlag,memWrite,memToReg,regWrite,aluControl,Ra,rd1,Rb,rd2,Rc,rd3,extendImm};
	
	//Exec Inputs
	assign opType_e = bufferOutput_decode[122:121];
	assign opCode_e = bufferOutput_decode[120:117];
	assign immSrc_e = bufferOutput_decode[116];
	assign branchFlag_e = bufferOutput_decode[115];
	assign memWrite_e = bufferOutput_decode[114];
	assign memToReg_e = bufferOutput_decode[113];
	assign regWrite_e = bufferOutput_decode[112];
	assign aluControl_e = bufferOutput_decode[111:108];
	assign rd1_e = bufferOutput_decode[103:80];
	assign rd2_e = bufferOutput_decode[75:52];
	assign Rc_e = bufferOutput_decode[51:48];
	assign rd3_e = bufferOutput_decode[47:24];
	
	

	
	// Clock generation
	always #10 clk = ~clk;

	
	// Initialize inputs
	initial begin
		clk = 1;
		rst = 0;
		en = 1;
		//Exec Inputs
		aluOut_e = 0; 
		result_e = 0;
		imm_e = 0;
		pc_e = 0;
		Fa_e = 0;
		Fb_e = 0;
		
		//Decode Buffer (rd1 + rd2)
		opType = 0; opCode = 1; immSrc = 0; branchFlag = 0; memWrite = 0; memToReg = 0; regWrite = 0; aluControl = 1; Ra = 0; rd1 = 2; Rb = 0; rd2 = 2; Rc = 3; rd3 = 0; extendImm = 0;

		
		#10; //negedge
		
		#10; //posedge
		//Decode Buffer (rd1 == rd2)
		opType = 0; opCode = 1; immSrc = 0; branchFlag = 0; memWrite = 0; memToReg = 0; regWrite = 0; aluControl = 4; Ra = 0; rd1 = 3; Rb = 0; rd2 = 3; Rc = 3; rd3 = 0; extendImm = 0;
		
		
		#10; //negedge
//		Assert rd1 + rd2
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
		
		#10; //posedge
		//Decode Buffer (rd1 - rd2)
		opType = 0; opCode = 1; immSrc = 0; branchFlag = 0; memWrite = 0; memToReg = 0; regWrite = 0; aluControl = 0; Ra = 0; rd1 = 2; Rb = 0; rd2 = 3; Rc = 3; rd3 = 0; extendImm = 0;
		
		#10; //negedge
		
		assert(bufferOut[57:34] === 0) else $error("Test to compare rd1 and rd2");//aluCurrentResult
		assert(bufferOut[33] === 1) else $error("zeroFlag value 2"); //zeroFlag
		$display("Data: %b", bufferOut[57:34]);
			
		#10; //posedge
		

		#10; //negedge
		assert($signed(bufferOut[57:34]) === -1) else $error("Test to sub rd1 and rd2");//aluCurrentResult
		assert(bufferOut[34] === 1) else $error("negFlag value 2"); //zeroFlag
		$display("Data: %b", bufferOut[57:34]);

//	
//		// rd1 + rd2 
//		rd1 = 2; rd2 = 2; pc = 2; imm = 2; aluOut = 0; result = 0;
//		immSrc = 0; branchFlag = 0; aluControl = 1;
//		#10; //negedge
//		
//		
//		#10; //posedge     
//		//rd1 == imm
//		rd1 = 2; rd2 = 2; pc = 0; imm = 2; aluOut = 0; result = 0;
//		aluControl = 4;
//		immSrc = 1; branchFlag = 0; 
//		
//		#10;// negedge
//		assert(bufferOut[23:0] === 0) else $error("rd value"); //rd3
//		assert(bufferOut[27:24] === 3) else $error("Rc value"); //Rc
//		assert(bufferOut[28] === 0) else $error("regWrite value"); //regWrite
//		assert(bufferOut[29] === 0) else $error("memToReg value"); //memToReg
//		assert(bufferOut[30] === 0) else $error("memWrite value"); //memWrite
//		assert(bufferOut[31] === 0) else $error("branchFlag value"); //branchFlag
//		assert(bufferOut[32] === 0) else $error("negFlag value"); //negFlag
//		assert(bufferOut[33] === 0) else $error("zeroFlag value 1"); //zeroFlag
//		assert(bufferOut[57:34] === 4) else $error("aluCurrentResult value"); //aluCurrentResult
//		assert(bufferOut[61:58] == 1)  else $error("opCode value"); //opCode
//		assert(bufferOut[63:62] == 0)  else $error("opType value"); //opType
//		$display("Data: %b", bufferOut[57:34]);
//		
//		#10; //posedge
//		// pc - rd2
//		rd1 = 2; rd2 = 2; pc = 1; imm = 1; aluOut = 0; result = 0;
//		aluControl = 0;
//		immSrc = 0; branchFlag = 1; 
//		
//		#10; //negedge
//		
//		assert(bufferOut[57:34] === 0) else $error("Test to compare rd1 and imm");//aluCurrentResult
//		assert(bufferOut[33] === 1) else $error("zeroFlag value 2"); //zeroFlag
//		$display("Data: %b", bufferOut[57:34]);
//			
//		#10; //posedge
//		
//
//		#10; //negedge
//		assert($signed(bufferOut[57:34]) === -1) else $error("Test to sub pc and rd2");//aluCurrentResult
//		assert(bufferOut[34] === 1) else $error("negFlag value 2"); //zeroFlag
//		$display("Data: %b", bufferOut[57:34]);
//		
		
	end

	
endmodule
