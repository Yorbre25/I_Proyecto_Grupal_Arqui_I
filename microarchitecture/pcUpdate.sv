module pcUpdate(input clk,rst,en,branchFlag,input [23:0] branchAddr,output[23:0] pc);
	logic [23:0] pc4;
	logic [23:0] bufferInput,bufferOutput; 

	buffer #(.Buffer_size(24)) pcBuffer (.rst(rst),.clk(clk),.en(en),.bufferInput(bufferInput),.bufferOut(bufferOutput));
	adder #(.N(24)) adder (.a(bufferOutput),.b(4),.c(pc4));
	mux21 #(.N(24)) thePcMux(.a(pc4),.b(branchAddr),.c(bufferInput),.sel(branchFlag));
	
	assign pc=bufferOutput;
endmodule 