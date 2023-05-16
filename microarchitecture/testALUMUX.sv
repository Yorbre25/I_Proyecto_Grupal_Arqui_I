module testALUMUX;
	parameter setValuesBuffer = 16;
	parameter RW = 24;
	parameter BufferW = setValuesBuffer + 2*RW;


	logic signed [RW-1:0] rd1, rd2, pc, imm, aluOut, result;
	logic [3:0] aluControl;
	logic immSrc, branchFlag;
	logic [1:0] flags;
	logic Fa, Fb;
	logic [RW-1:0] aluCurrentResult;
	
	ALUMux #(.N(RW)) AluMux1(.rd1(rd1), .rd2(rd2), .pc(pc), .imm(imm), .aluOut(aluOut), .result(result), .aluControl(aluControl), .immSrc(immSrc), .branchFlag(branchFlag), .Fa(Fa), .Fb(Fb), .flags(flags), .aluCurrentResult(aluCurrentResult));
	
	initial begin
		
		Fa = 0; 
		Fb = 0;
		
		//MUX inputs a
		rd1 = 2; 
		rd2 = 2; 
		pc = 0; 
		imm = 0; 
		aluOut = 0; 
		result = 0;
		
		//select
		immSrc = 0;
		branchFlag = 0;
		
		//operation
		aluControl = 1;
		#10;
	end


endmodule