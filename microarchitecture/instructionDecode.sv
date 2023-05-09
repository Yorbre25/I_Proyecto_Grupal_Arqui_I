module instructionDecode(input clk,input rst,en, input [31:0] inst,input WE,input [3:0] Rd,input [31:0] WD,output [148:0] bufferOut);
	

	//sub modules output
	logic [3:0] Ra,Rb,Rc;
	logic [17:0] imm;
	logic [31:0] extendImm;
	logic [31:0] RD1,RD2,RD3;
	logic [31:0] op1,op2;
	
	
	//control signal
	
	logic immSrc,branchFlag,memWrite,memToReg,regWrite;
	logic [1:0] opType;
	logic [3:0] opCode;
	logic [3:0] aluControl;
	
	
	//buffer concatenation
	logic [148:0] bufferInput;
	
	
	
	//sign extend of the immediate
	signExtend #(.beforeExtend(18),.afterExtend(32)) myExtend(.in(imm),.out(extendImm));
	
	// Register bank access
	registerBank #(.Index_size(4),.width(32)) myRegisterBank (.clk(clk),.rst(rst),.Ra(Ra), .Rb(Rb) ,.Rc(Rc),.Rd(Rd),.WE(WE),.WD(WD),.RD1(RD1),.RD2(RD2),.RD3(RD3));
	
	
	//buffer setup
	buffer #(.Buffer_size(149)) ID_EX (.rst(rst),.clk(clk),.en(en),.bufferInput(bufferInput),.bufferOut(bufferOut));
	
	//control unit to the control flags
	controlUnit myControlUnit(.opType(opType),.opCode(opCode),.Rd(Rc),.immSrc(immSrc),.branchFlag(branchFlag),.memWrite(memWrite),.memToReg(memToReg),.regWrite(regWrite), .aluControl(aluControl));
	
	
	//divide instruction 
	assign opType=inst[31:30];
	assign opCode=inst[29:26];
	assign Rc= inst[25:22];
	assign Ra=inst[21:18];
	assign Rb=inst[17:14];
	assign imm=inst[17:0];
	assign bufferInput={immSrc,branchFlag,memWrite,memToReg,regWrite,aluControl,Ra,RD1,Rb,RD2,Rc,RD3,extendImm};

endmodule 