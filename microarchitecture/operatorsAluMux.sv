module operatorsALUMux #(parameter opSize=24)(input [opSize-1:0] RD1,RD2,RD3,Imm,pc,Forward1,Forward2,Forward3,input immSrc,branchFlag,Fa,Fb,Fc,output [opSize-1:0] op1,op2,op3);


	logic [1:0] controlOp1,controlOp2;
	
	assign controlOp1 ={Fa,branchFlag};
	assign controlOp2={Fb,immSrc};
	
	
	mux41 #(.N(opSize)) controlOp1Mux(.a(RD1),.b(pc),.c(Forward1),.d(0),.e(op1), .sel(controlOp1));
	mux41 #(.N(opSize)) controlOp2Mux(.a(RD2),.b(Imm),.c(Forward2),.d(0),.e(op2),.sel(controlOp2));
	mux21 #(.N(opSize)) controlOp3Mux(.a(RD3),.b(Forward3),.c(op3),.sel(Fc));
endmodule 