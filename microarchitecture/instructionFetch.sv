module instructionFetch(input clk,rst,en,branchFlag,input [31:0] branchAddr,output logic [31:0] instruction,pc);


	pcUpdate mypc(.clk(clk),.rst(rst),.en(en),.branchFlag(branchFlag),.branchAddr(branchAddr),.pc(pc));
	instructionMemory #(.address_size(14),.data_width(8)) mymem (.addr(pc[13:0]),.data(instruction));
endmodule 