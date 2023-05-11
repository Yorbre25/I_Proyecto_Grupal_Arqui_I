module ALUMux#(parameter N=24)(
	input [N-1:0] rd1, rd2, pc, imm, aluOut, result, // Posible Alu entries
	input [3:0] aluControl,
	input immSrc, branchFlag,
	input Fa, Fb,
	output [1:0] flags,
	output [N-1:0] aluCurrentResult
);
	logic [N-1:0] op1,op2;
	
	operatorsALUMux #(.opSize(N)) aluMux(.RD1(rd1), .RD2(rd2), .Imm(imm), .pc(pc), .AluOut(aluOut), .Result(result), .immSrc(immSrc), .branchFlag(branchFlag), .Fa(Fa), .Fb(Fb), .op1(op1), .op2(op2));
	ALU #(.N(N)) alu(.a(op1), .b(op2), .select(aluControl), .result(aluCurrentResult), .flags(flags));

endmodule