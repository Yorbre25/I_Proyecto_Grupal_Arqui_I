module IOMemory(input rst,en,input [7:0] address,input [23:0] dataIn,input logic [3:0] switches, input logic [35:0] gpio1,output [35:0] gpio2,output [23:0] dataOut);

	logic [75:0] memory;
	logic [35:0] readMemory;
	
	
	assign memory[75:72]=switches;
	assign memory[71:36]=gpio1;
	assign memory[35:0]=readMemory;
	assign gpio2=memory[35:0];
	
	always_ff @(en or rst) begin
		if(rst)readMemory[35:0]=0;
		else begin
			if(address<=35 & en)readMemory[address]=dataIn[0];
		end
	end
	
	always_comb begin
		if(address>75)dataOut=0;
		else dataOut={{23{1'b0}},memory[address]};
	
	end
	
	
endmodule 