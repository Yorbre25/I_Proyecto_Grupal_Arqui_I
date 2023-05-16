module ALUMux#(parameter N=24)(
	input [N-1:0] rd1, rd2,rd3, pc, imm, Forward1, Forward2,Forward3, // Posible Alu entries
	input [3:0] aluControl,
	input immSrc, branchFlag,
	input Fa, Fb,Fc,
	output [1:0] flags,
	output [N-1:0] aluCurrentResult,RD3Out
);
	logic [N-1:0] op1,op2;
	
	operatorsALUMux #(.opSize(N)) aluMux(.RD1(rd1), .RD2(rd2),.RD3(rd3), .Imm(imm), .pc(pc), .Forward1(Forward1), .Forward2(Forward2),.Forward3(Forward3), .immSrc(immSrc), .branchFlag(branchFlag), .Fa(Fa), .Fb(Fb),.Fc(Fc), .op1(op1), .op2(op2),.op3(RD3Out));
	ALU #(.N(N)) alu(.a(op1), .b(op2), .select(aluControl), .result(aluCurrentResult), .flags(flags));

endmodule