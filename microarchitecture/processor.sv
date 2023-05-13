parameter RW = 24;
parameter ID_BW = 147;
module processor;

	
	hazardUnit myhazardUnit(
		.Ra(Ra),
		.Rb(Rb),
		.Rd_EXMEM(Rd_EXMEM),
		.Rd_MEMWB(Rd_MEMWB),
		.opTypeMem(opTypeMem),
		.opTypeWB(opTypeWB),
		.opCodeMem(opCodeMem),
		.opCodeWB(opCodeWB),
		.aluResult(aluResult),
		.Result(Result), 
		.branchTakenFlag(branchTakenFlag),
		.Fa(Fa),.Fb(Fb),.stall(stall),
		.flush1(flush1),.flush2(flush2),
		.flush3(flush3),.flush4(flush4),
		.flush5(flush5), 
		.Forward1(Forward1),
		.Forward2(Forward2)
	);
	
	logic [31:0] inst;
	logic [RW-1:0] pc;
	
	instructionFetch myInstructionFetch(
		.clk(clk),               //
		.rst(rst),					 //
		.en(en),						 //
		.branchFlag(branchFlag), //
		.branchAddr(branchAddr), //
		//output
		.instruction(inst),
		.pc(pc)
	);
	
	logic [ID_BW-1:0] bufferOut_id
	
	instructionDecode myInstructionDecode(
		.clk(clk),
		.rst(rst),
		.en(en),
		.inst(inst),
		.WE(WE),
		.Rd(Rd),
		.WD(WD),
		.pc(pc),
		.bufferOut(bufferOut_id)
	);

	
	logic [1:0] opType;
	logic [3:0] opCode;
	logic immSrc, branchFlag, memWrite, memToReg, regWrite;
	logic signed [3:0] aluControl, Ra, Rb, Rc;
	logic signed [RW-1:0] rd1, rd2, rd3;
	logic signed [RW-1:0] extendImm;
	
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
	assign extendImm_id_ex = bufferOut_id[23:0];
	
	
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
	.Fa(Fa), 				//
	.Fb(Fb),					//
	.opType(opType_id_ex), 
	.opCode(opCode_id_ex),
	.bufferOut(bufferOut)
	);


endmodule;