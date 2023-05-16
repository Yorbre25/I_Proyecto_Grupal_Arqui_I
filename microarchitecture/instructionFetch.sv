module instructionFetch(input clk,rst1,rst2,en1,en2,branchFlag,input [23:0] branchAddr,output [55:0] bufferOut );

	logic [31:0] instruction;
	logic [23:0] pc;
	logic [55:0] bufferInput;

	pcUpdate mypc(.clk(clk),.rst(rst1),.en(en1),.branchFlag(branchFlag),.branchAddr(branchAddr),.pc(pc));
	instructionMemory #(.address_size(14),.data_width(8)) mymem (.addr(pc[13:0]),.data(instruction));
	buffer #(.Buffer_size(56)) myBuffer(.rst(rst2),.clk(clk),.en(en2),.bufferInput(bufferInput),.bufferOut(bufferOut));
	
	
	assign bufferInput={instruction,pc};
endmodule 