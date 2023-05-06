module instructionMemory_tb();


	logic [31:0] data;
	logic [13:0] addr;
	instructionMemory #(.address_size(14),.data_width(8)) mymem (.addr(addr),.data(data));
	
	initial begin
	
	addr=0;
	#5;
	addr=4;
	#5;
	addr=8;
	#50;
	
	end

endmodule 