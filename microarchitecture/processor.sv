parameter RW = 24;
parameter IF_BW = 57;
parameter ID_BW = 147;
parameter EX_MEM = 64;
module processor;
	
vc

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
	.Fa(Fa), 				//
	.Fb(Fb),					//
	.opType(opType_id_ex), 
	.opCode(opCode_id_ex),
	.bufferOut(bufferOut_ex)
	);
	
	
	logic [31:0] data_ex_mem;
	logic [13:0] addr_ex_mem;
	
	
	// Get ID buffer values
	
	instructionMemory #(.address_size(14),.data_width(8)) mymem (
		.addr(addr_ex_mem), //
		.data(data_ex_mem) //
	);
	
	writeBack #(.N(RW))(
		.readDataW(readDataW), //
		.aluOutW(aluOutW),     //
		.memToReg(memToReg),   //
		.resultW(resultW)     //
	);
	



endmodule;