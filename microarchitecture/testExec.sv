module testExec;
	parameter WIDTH = 4;

	logic clk, rst, en;
	logic signed [WIDTH-1:0] rd1, rd2, pc, imm, aluOut, result;
	logic signed [WIDTH-1:0] rd3;
	logic [3:0] aluControl;
	logic [3:0] Ra, Rb, Rc;
	logic immSrc, branchFlag, memWrite, memToReg, regWrite;
	logic Fa, Fb;
	logic [81:0] bufferOut;
	
	exec #(.N(WIDTH)) exec1(clk, rst, en, rd1, rd2, pc, imm, aluOut, result, rd3, aluControl, Ra, Rb, Rc, immSrc, branchFlag, memWrite, memToReg, regWrite, Fa, Fb, bufferOut);
	
	initial begin
		clk = 0; rst = 0; en = 1;
		rd1 = 2; rd2 = 2; pc = 0; imm = 0; aluOut = 0; result = 0;
		rd3 = 0;
		aluControl = 0;
		Ra = 1;
		Rb = 2;
		Rc = 3;
		immSrc = 0; branchFlag = 0; memWrite = 0; memToReg = 0; regWrite = 0;
		Fa = 0; Fb = 0;
		#10;
	end

	
endmodule
