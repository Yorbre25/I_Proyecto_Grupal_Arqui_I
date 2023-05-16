module testBuffer;
	parameter BW=4;
	
	
	logic clk, rst, en;
	logic [BW-1:0] bufferInput;
	logic [BW-1:0] bufferOut;
	
	buffer #(.Buffer_size(BW)) buff(rst,clk,en,bufferInput,bufferOut);
	
	
	always #5 clk = ~clk;

	// Initialize inputs
	initial begin
		clk = 0;
		rst = 0;

		// Apply reset
		rst = 1;
		#10;
		rst = 0;
		en = 1;
		#10;
		
		bufferInput = 3;
		#10;
		
		en = 0;
		bufferInput = 4;
		#10;
		
		en = 1;
		#10;
	end

endmodule