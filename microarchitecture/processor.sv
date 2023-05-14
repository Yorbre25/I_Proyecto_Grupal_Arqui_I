parameter RW = 24;
parameter IF_BW = 56;
parameter ID_BW = 147;
parameter EX_BW = 64;
parameter MEM_BW = 60;
module processor(input rst,input clk, input [35:0] gpio1,input [23:0] parallelAddress,input [3:0] switches,output [35:0] gpio2,output [23:0] q);





	
	logic branchTakenFlag;
	logic rst_pc,rst_if, rst_id, rst_ex, rst_mem;
	logic flush1, flush2, flush3, flush4,flush5;
	logic Fa, Fb;
	
	


	branchTaken myBranchTakenFlag(
		.opType(opType_ex_mem), 
		.opCode(opCode_ex_mem), 
		.flags(flags_ex),  
		.branchTakenFlag(branchTakenFlag) 
	);
	
	resetModule(
		.rst(rst), 
		.flush1(flush1), 
		.flush2(flush2), 
		.flush3(flush3), 
		.flush4(flush4), 
		.flush5(flush5),
		.rst1(rst_pc),
		.rst2(rst_if), 
		.rst3(rst_id), 
		.rst4(rst_ex), 
		.rst5(rst_mem),
		.stall(stall)
);


	logic stall,en;
	logic [23:0] Forward1,Forward2;
	hazardUnit myhazardUnit(
		.Ra(ra_id_ex), 
		.Rb(rb_id_ex), 
		.Rd_EXMEM(rc_ex_mem), 
		.Rd_MEMWB(rc_mem_wb), 
		.opTypeMem(opType_ex_mem), 
		.opTypeWB(optype_mem_wb), 
		.opCodeMem(opCode_ex_mem), 
		.opCodeWB(opcode_mem_wb), 
		.aluResult(aluResult), 
		.Result(resultW), 
		.branchTakenFlag(branchTakenFlag), 
		.Fa(Fa),.Fb(Fb),
		.stall(stall), 
		.flush1(flush1),.flush2(flush2), 
		.flush3(flush3),.flush4(flush4),.flush5(flush5),
		.Forward1(Forward1), 
		.Forward2(Forward2) 
	);
	
	
	assign en=!stall;
	
	logic [31:0] inst;
	logic [RW-1:0] pc;
	logic [IF_BW-1:0] bufferOut_if;
	
	instructionFetch myInstructionFetch(
		.clk(clk),               
		.rst1(rst_pc),
		.rst2(rst_if),
		.en1(en),
		.en2(en),						 
		.branchFlag(branchTakenFlag), 
		.branchAddr(aluResult), 
		.bufferOut(bufferOut_if)
	);
	
	logic [ID_BW-1:0] bufferOut_id;
	logic [31:0] inst_if_id;
	logic [RW:0] pc_if_id;
	
	// Get ID buffer values
	assign inst_if_id = bufferOut_if[55:24];
	assign pc_if_id = bufferOut_if[23:0];
	
	instructionDecode myInstructionDecode(
		.clk(clk),
		.rst(rst_id),
		.en(en),
		.inst(inst_if_id),
		.WE(regWriteWB),      
		.Rd(rc_mem_wb),      
		.WD(resultW),      
		.pc(pc_if_id),
		.bufferOut(bufferOut_id)
	);

	
	logic [1:0] opType_id_ex;
	logic [3:0] opCode_id_ex;
	logic immSrc_id_ex, branchFlag_id_ex, memWrite_id_ex, memToReg_id_ex, regWrite_id_ex;
	logic [23:0] pc_id_ex;
	logic signed [3:0] aluControl_id_ex, Rc_id_ex;
	logic signed [RW-1:0] rd1_id_ex, rd2_id_ex, rd3_id_ex;
	logic signed [RW-1:0] extendImm_id_ex;
	logic [3:0] ra_id_ex,rb_id_ex;
	// Get ID buffer values
	assign pc_id_ex = bufferOut_id[146:123];
	assign opType_id_ex = bufferOut_id[122:121];
	assign opCode_id_ex = bufferOut_id[120:117];
	assign immSrc_id_ex = bufferOut_id[116];
	assign branchFlag_id_ex = bufferOut_id[115];
	assign memWrite_id_ex = bufferOut_id[114];
	assign memToReg_id_ex = bufferOut_id[113];
	assign regWrite_id_ex = bufferOut_id[112];
	assign aluControl_id_ex = bufferOut_id[111:108];
	assign ra_id_ex=bufferOut_id[107:104];
	assign rd1_id_ex = bufferOut_id[103:80];
	assign rb_id_ex=bufferOut_id[79:76];
	assign rd2_id_ex = bufferOut_id[75:52];
	assign Rc_id_ex = bufferOut_id[51:48];
	assign rd3_id_ex = bufferOut_id[47:24];
	assign extendImm_id_ex = bufferOut_id[23:0];  
	
	logic [EX_BW-1:0]bufferOut_ex;
	
	exec #(.N(RW), .BW(EX_BW)) myExec(
	.clk(clk), 
	.rst(rst_ex), 
	.en(en),
	.rd1(rd1_id_ex), 
	.rd2(rd2_id_ex), 
	.pc(pc_id_ex), 
	.imm(extendImm_id_ex), 				
	.aluOut(Forward1), 		
	.result(Forward2),
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
	logic [3:0] rc_ex_mem,switches_ex_mem;
	logic [23:0] writeData_ex_mem,q_ex_mem;
	logic [35:0] gpio1_ex_mem,gpio2_ex_mem;
	logic [59:0] bufferOut;
	
	
	
	
	logic [1:0] flags_ex;
	logic branchFlag_ex;
	logic [23:0] aluResult;
	logic [23:0] writeData;
	
	// Get exec buffer values
	assign writeData=bufferOut_ex[23:0];  //rd3
	assign rc_ex_mem = bufferOut_ex[27:24] ;
	assign regWrite_ex_mem = bufferOut_ex[28];
	assign memToReg_ex_mem = bufferOut_ex[29] ;
	assign memWrite_ex_mem = bufferOut_ex[30];
	assign branchFlag_ex=bufferOut_ex[31] ;
	assign flags_ex ={bufferOut_ex[32],bufferOut_ex[33]} ; // neg ,zero
	assign aluResult=bufferOut_ex[57:34];//aluCurrentResult
	assign opCode_ex_mem = bufferOut_ex[61:58]; //opCode
	assign opType_ex_mem= bufferOut_ex[63:62]; //opType
	
	logic [MEM_BW-1:0]bufferOut_mem;
	
	memoryStage myMemoryStage(
		.clk(clk),
		.rst(rst_mem),
		.en(1'b1),
		.opType(opType_ex_mem),
		.opCode(opCode_ex_mem),
		.address1(aluResult),
		.address2(parallelAddress), //entrada
		.memWrite(memWrite_ex_mem),
		.memToReg(memToReg_ex_mem),
		.regWrite(regWrite_ex_mem),
		.Rc(rc_ex_mem),
		.writeData(writeData),
		.switches(switches), //entrada
		.gpio1(gpio1), //entrada
		.gpio2(gpio2),  //salida
		.q(q), //salida
		.bufferOut(bufferOut_mem)
	);
	
	
	logic memToReg_mem_wb;
	logic [3:0] rc_mem_wb;
	logic [1:0] optype_mem_wb;
	logic [3:0] opcode_mem_wb;
	logic regWriteWB;
	logic [23:0] addressWB,readMemoryWB;
	
	//Get MEM buffer values
	assign addressWB=bufferOut_mem[23:0]; // address1
	assign readMemoryWB=bufferOut_mem[47:24]; // qa
	assign rc_mem_wb=bufferOut_mem[51:48];// Rc
	assign regWriteWB=bufferOut_mem[52]; // regWrite
	assign memToReg_mem_wb = bufferOut_mem[53]; // memToReg
	assign opcode_mem_wb=bufferOut_mem[57:54]; // opCode
	assign optype_mem_wb=bufferOut_mem[59:58]; // opType
	

	
	logic [23:0] resultW;
	
	writeBack #(.N(RW))(
		.readDataW(readMemoryWB), 
		.aluOutW(addressWB),     
		.memToReg(memToReg_mem_wb),
		.resultW(resultW)     
	);
	



endmodule 