module operatorsALUMux #(parameter opSize=24)(input [opSize-1:0] RD1,RD2,Imm,pc,AluOut,Result,input immSrc,branchFlag,Fa,Fb,output [opSize-1:0] op1,op2);


	logic [1:0] controlOp1,controlOp2;
	
	assign controlOp1 ={Fa,branchFlag};
	assign controlOp2={Fb,immSrc};
	
	
	mux41 #(.N(opSize)) controlOp1Mux(.a(RD1),.b(pc),.c(AluOut),.d(Result),.e(op1), .sel(controlOp1));
	mux41 #(.N(opSize)) controlOp2Mux(.a(RD2),.b(Imm),.c(Result),.d(AluOut),.e(op2),.sel(controlOp2));
endmodule 