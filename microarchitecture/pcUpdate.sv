module pcUpdate(input clk,rst,en,branchFlag,input [31:0] branchAddr,output[31:0] pc);
	logic [31:0] pc4;
	logic [31:0] bufferInput,bufferOutput; 

	buffer #(.Buffer_size(32)) pcBuffer (.rst(rst),.clk(clk),.en(en),.bufferInput(bufferInput),.bufferOut(bufferOutput));
	adder #(.N(32)) adder (.a(bufferOutput),.b(4),.c(pc4));
	mux21 #(.N(32)) thePcMux(.a(pc4),.b(branchAddr),.c(bufferInput),.sel(branchFlag));
	
	assign pc=bufferOutput;
endmodule 