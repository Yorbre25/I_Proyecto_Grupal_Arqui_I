parameter setValuesBuffer = 16;
module exec #(parameter N= 24, parameter BW=setValuesBuffer + 2*N)(
	input clk, rst, en, //clock, flush, stall
	input [N-1:0] rd1, rd2, pc, imm, Forward1, Forward2,Forward3, // Posible Alu entries
	input [N-1:0] rd3,
	input [3:0] aluControl,
	input [3:0] Rc, // Register number
	input immSrc, branchFlag, memWrite, memToReg, regWrite,
	input Fa, Fb,Fc,
	input [1:0] opType,
	input [3:0] opCode,
	output [BW-1:0] bufferOut
);
	
	//sub modules output
	logic [1:0] flags;
	logic [N-1:0] aluCurrentResult,RD3Out;
	logic [N-1:0] op1,op2;
	logic [BW-1:0] bufferInput;
	logic zeroFlag, negFlag;
	
	//Alu entry selector
	ALUMux #(.N(N)) AluMux1(
		.rd1(rd1), 
		.rd2(rd2), 
		.rd3(rd3),
		.pc(pc), 
		.imm(imm), 
		.Forward1(Forward1), 
		.Forward2(Forward2), 
		.Forward3(Forward3),
		.aluControl(aluControl), 
		.immSrc(immSrc), 
		.branchFlag(branchFlag), 
		.Fa(Fa), 
		.Fb(Fb), 
		.Fc(Fc),
		.flags(flags), 
		.aluCurrentResult(aluCurrentResult),
		.RD3Out(RD3Out)
	);
	
	
	//buffer setup
	buffer #(.Buffer_size(BW)) EX_MEM (.rst(rst), .clk(clk), .en(en), .bufferInput(bufferInput), .bufferOut(bufferOut));
	
	
	assign zeroFlag = flags[0];
	assign negFlag = flags[1];
	
	
	
	
//divide instruction:
//	   | opType | opCode | aluCurrentResult | zeroFlag | negFlag | branchFlag | memWrite | memToReg | regWrite | Rc | rd3  |
//Size:
//	   |   [2] 	|   [4]  |       [N]	       |  [1]     |   [1]   |    [1]     |   [1]    |    [1]   |   [1]    |[4] | [N]  | 
//	----------------------------------------------------------------------------------------------------------------
//    |63		|61		|57				    |33		   |32	    |31			  |30			 |29			|28		  | 27 |23   0|

  	assign bufferInput={opType,opCode,aluCurrentResult,zeroFlag,negFlag,branchFlag,memWrite,memToReg,regWrite, Rc, RD3Out};
	
endmodule