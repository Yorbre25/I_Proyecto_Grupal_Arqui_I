module testEx;

	parameter WIDTH = 4;

	logic clk, rst, en, //clock, flush, stall
	logic [N-1:0] rd1, rd2, pc, imm, aluOut, result, // Posible Alu entries
	logic [N-1:0] rd3,
	logic [3:0] aluControl,
	logic [3:0] Ra, Rb, Rc, // Register number
	logic immSrc, branchFlag, memWrite, memToReg, regWrite,
	logic Fa, Fb, //Hazard Unit Flags
	logic [81:0] bufferOut

	
	exec #(.N(WIDTH)) ejecutar(clk, rst, en, rd1, rd2, pc, imm, aluOut, result, rd3, aluControl, Ra, Rb, Rc, immSrc, branchFlag, memWrite, memToReg, redWrite, Fa, Fb, bufferOut);
	
	initial begin
		
	end
	
	
endmodule