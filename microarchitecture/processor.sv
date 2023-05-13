parameter RW = 24;
parameter IF_BW = 57;
parameter ID_BW = 147;
parameter EX_BW = 64;
parameter MEM_BW = 60;
module processor(input);

	logic branchTakenFlag;
	logic rst_if, rst2_id, rst3_ex, rst4_mem
	logic flush1, flush2, flush3, flush4;
	logic Fa, Fb
	
	branchTaken myBranchTakenFlag(
		.opType(opType), //
		.opCode(opCode), //
		.flags(flags),  //
		.branchTakenFlag(branchTakenFlag) 
	);
	
	resetModule(
		.rst(rst), //
		.flush1(flush1), 
		.flush2(flush2), 
		.flush3(flush3), 
		.flush4(flush4), 
		.rst1.(rst_if), 
		.rst2(rst_id), 
		.rst3(rst_ex), 
		.rst4(rst_mem)
);

	hazardUnit myhazardUnit(
		.Ra(Ra), //
		.Rb(Rb), //
		.Rd_EXMEM(Rd_EXMEM), //
		.Rd_MEMWB(Rd_MEMWB), //
		.opTypeMem(opTypeMem), //
		.opTypeWB(opTypeWB), //
		.opCodeMem(opCodeMem), //
		.opCodeWB(opCodeWB), //
		.aluResult(aluResult), //
		.Result(Result),  //
		.branchTakenFlag(branchTakenFlag), //
		.Fa(Fa),.Fb(Fb),
		.stall(stall), //
		.flush1(flush1),.flush2(flush2), 
		.flush3(flush3),.flush4(flush4), 
		.flush5(flush5), //
		.Forward1(Forward1), //
		.Forward2(Forward2) //
	);
	
	
	logic [31:0] inst;
	logic [RW-1:0] pc;
	logic [IF_BW-1:0] bufferOut_if;
	
	instructionFetch myInstructionFetch(
		.clk(clk),               //
		.rst(rst),					 //
		.en(en),						 //
		.branchFlag(branchFlag), //
		.branchAddr(branchAddr), //
		.bufferOut(bufferOut_if)
	);
	
	logic [ID_BW-1:0] bufferOut_id;
	logic [31:0] inst_if_id;
	logic [RW:0] pc_if_id;
	
	// Get ID buffer values
	assign inst_if_id = bufferOut_if[31:0];
	assign pc_if_id = bufferOut_if[56:32];
	
	instructionDecode myInstructionDecode(
		.clk(clk),
		.rst(rst),
		.en(en),
		.inst(inst_if_id),
		.WE(WE),      //
		.Rd(Rd),      //
		.WD(WD),      //
		.pc(pc_if_id),
		.bufferOut(bufferOut_id)
	);

	
	logic [1:0] opType_id_ex;
	logic [3:0] opCode_id_ex;
	logic immSrc_id_ex, branchFlag_id_ex, memWrite_id_ex, memToReg_id_ex, regWrite_id_ex;
	logic signed [3:0] aluControl_id_ex, Rc_id_ex;
	logic signed [RW-1:0] rd1_id_ex, rd2_id_ex, rd3_id_ex;
	logic signed [RW-1:0] extendImm_id_ex;
	
	// Get ID buffer values
	assign pc_id_exec = bufferOut_id[146:123]
	assign opType_id_ex = bufferOut_id[122:121];
	assign opCode_id_ex = bufferOut_id[120:117];
	assign immSrc_id_ex = bufferOut_id[116];
	assign branchFlag_id_ex = bufferOut_id[115];
	assign memWrite_id_ex = bufferOut_id[114];
	assign memToReg_id_ex = bufferOut_id[113];
	assign regWrite_id_ex = bufferOut_id[112];
	assign aluControl_id_ex = bufferOut_id[111:108];
	assign rd1_id_ex = bufferOut_id[103:80];
	assign rd2_id_ex = bufferOut_id[75:52];
	assign Rc_id_ex = bufferOut_id[51:48];
	assign rd3_id_ex = bufferOut_id[47:24];
	assign extendImm_id_ex = bufferOut_id[23:0];  //
	
	logic [Ex_MEM-1:0]bufferOut_ex;
	
	
	exec #(.N(RW), .BW(BufferW)) myExec(
	.clk(clk), 
	.rst(rst), 
	.en(en),
	.rd1(rd1_id_ex), 
	.rd2(rd2_id_ex), 
	.pc(pc_id_ex), 
	.imm(imm), 				//
	.aluOut(aluOut), 		//
	.result(result),		//
	.rd3(rd3_id_ex),
	.aluControl(aluControl_id_ex),
	.Rc(Rc_id_ex),
	.immSrc(immSrc_id_ex), 
	.branchFlag(branchFlag_id_ex), 
	.memWrite(memWrite_id_ex),
	.memToReg(memToReg_id_ex), 
	.regWrite(regWrite_id_ex),
	.Fa(Fa), 				
	.Fb(Fb),					
	.opType(opType_id_ex), 
	.opCode(opCode_id_ex),
	.bufferOut(bufferOut_ex)
	);
	
	
	logic memWrite_ex_mem,memToReg_ex_mem,regWrite_ex_mem;
	logic [1:0] opType_ex_mem;
	logic [3:0] opCode_ex_mem;
	logic [23:0] address1_ex_mem,address2_ex_mem;
	logic [3:0] Rc_ex_mem,switches_ex_mem;
	logic [23:0] writeData_ex_mem,q_ex_mem;
	logic [35:0] gpio1_ex_mem,gpio2_ex_mem;
	
	logic [59:0] bufferOut;
	
	
	
	
	
	// Get exec buffer values
	bufferOut_ex[23:0]   //rd3
	assign rc_ex_mem = bufferOut_ex[27:24] 
	assign regWrite_ex_mem = bufferOut_ex[28]
	assign memToReg_ex_mem = bufferOut_ex[29] 
	assign memWrite_ex_mem = bufferOut_ex[30]
	bufferOut_ex[31] //branchFlag
	bufferOut_ex[32] //negFlag
	bufferOut_ex[33] //zeroFlag
	bufferOut_ex[57:34]//aluCurrentResult
	assign opType_ex_mem = bufferOut_ex[61:58] //opCode
	assign opCode_ex_mem = bufferOut_ex[63:62] //opType
	
	logic [MEM_BW-1:0]bufferOut_mem;
	
	memoryStage myMemoryStage(
		.clk(clk),
		.rst(rst),
		.en(en),
		.opType(opType_ex_mem),
		.opCode(opCode_ex_mem),
		.address1(),
		.address2(),
		.memWrite(memWrite_ex_mem),
		.memToReg(memToReg_ex_mem),
		.regWrite(regWrite_ex_mem),
		.Rc(rc_ex_mem),
		.writeData(),
		.switches(),
		.gpio1(),
		.gpio2(),
		.q(q),
		.bufferOut(bufferOut_mem)
	);
	
	
	logic memToReg_mem_wb;
	
	//Get MEM buffer values
	bufferOut_mem[23:0] // address1
	bufferOut_mem[47:24] // qa
	bufferOut_mem[51:48] // Rc
	bufferOut_mem[52] // regWrite
	assign memToReg_mem_wb = bufferOut_mem[53] // memToReg
	bufferOut_mem[58:54] // opCode
	bufferOut_mem[60:59] // opType
	
	
	writeBack #(.N(RW))(
		.readDataW(readDataW), //
		.aluOutW(aluOutW),     //
		.memToReg(memToReg_mem_wb),
		.resultW(resultW)     //
	);
	



endmodule;