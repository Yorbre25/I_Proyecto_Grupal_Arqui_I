module buffer_tb();

	logic rst,clk,en;
	logic [11:0] bufferInput,bufferOut;
	buffer #(.Buffer_size(12)) mybuffer (.rst(rst),.clk(clk),.en(en),.bufferInput(bufferInput),.bufferOut(bufferOut));
	
	
	always begin
		#10;
		clk=!clk;
	end
	initial begin
		clk=1;
		rst=0;
		en=1;
		bufferInput=12'b101011101010;
		
		#10; //negedge
		
		#10; //posedge 
		bufferInput=12'b111111111111;
		
		
		#10; //negedge
		assert(bufferOut==12'b101011101010) $display("Test 1 Passed");
		else $error("Test 1 Failed");
		
		#10; //posedge
		bufferInput=12'b010101010101;
		
		
		#10; //negedge
		assert(bufferOut==12'b111111111111) $display("Test 2 Passed");
		else $error("Test 2 Failed");
		
		#10; //posedge
		bufferInput=12'b101010101010;
		
		
		#10; //negedge
		assert(bufferOut==12'b010101010101) $display("Test 3 Passed");
		else $error("Test 3 Failed");
		
		#10; //posedge
		
		
		#10; //negedge
		assert(bufferOut==12'b101010101010) $display("Test 4 Passed");
		else $error("Test 4 Failed");
		
	end

endmodule 