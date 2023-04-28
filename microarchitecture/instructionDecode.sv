module instructionDecode(input clk,input rst, input [31:0] inst,input WE,input [31:0] WD,input [31:0] pc4,input immSrc,branchFlag,output [1:0] opType,output [3:0] opCode,output [31:0] bufferOut);
	

	logic [3:0] Ra,Rb,Rd;
	logic [17:0] imm;
	logic [31:0] extendImm;
	logic [31:0] RD1,RD2;
	logic [31:0] op1,op2;
	logic [31:0] pc8;
	
	
	
	signExtend #(.beforeExtend(18),.afterExtend(32)) myExtend(.in(imm),.out(extendImm));
	
	
	mux21 #(.N(32)) branchMux(.a(RD1),.b(pc8),.c(op1), .sel(branchFlag));
	mux21 #(.N(32)) inmmediateMux(.a(RD2),.b(extendImm),.c(op2),.sel(immSrc));
	
	registerBank #(.Index_size(4),.width(32)) myRegisterBank (.clk(clk),.rst(rst),.Ra(Ra), .Rb(Rb) ,.Rd(Rd),.WE(WE),.WD(WD),.RD1(RD1),.RD2(RD2));
	buffer #(.Buffer_size(64)) ID_EX (.rst(rst),.clk(clk),.en(1'b1),.bufferInput({op1,op2}),.bufferOut(bufferOut));
	
	
	assign pc8=pc4+4;
	assign opType=inst[31:30];
	assign opCode=inst[29:26];
	assign Rd= inst[25:22];
	assign Ra=inst[21:18];
	assign Rb=inst[17:14];
	assign imm=inst[17:0];

endmodule 