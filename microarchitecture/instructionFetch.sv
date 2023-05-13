module instructionFetch(input clk,rst,en,branchFlag,input [31:0] branchAddr,output [55:0] bufferOut );

	logic [31:0] instruction;
	logic [23:0] pc;
	logic [55:0] bufferInput;

	pcUpdate mypc(.clk(clk),.rst(rst),.en(en),.branchFlag(branchFlag),.branchAddr(branchAddr),.pc(pc));
	instructionMemory #(.address_size(14),.data_width(8)) mymem (.addr(pc[13:0]),.data(instruction));
	buffer #(.Buffer_size(56)) myBuffer(.rst(rst),.clk(clk),.en(en),.bufferInput(bufferInput),.bufferOut(bufferOut));
	
	
	assign bufferInput={instruction,pc};
endmodule 