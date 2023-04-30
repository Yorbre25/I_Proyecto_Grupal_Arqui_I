module UnitTestALU;
	parameter WIDTH = 4;

	logic signed [WIDTH-1:0] a,b,result;
	logic [3:0] alu_select;
	logic [1:0] flags;
	
	
	ALU #(.N(WIDTH)) alu1(a,b,alu_select,result,flags);
	
	initial begin
		a = 2;
		b = 3;
		alu_select = 0;
		#5;
		assert(result === -1) else $error("Test failed for 2-3");
		assert(flags[0] === 0) else $error("Test failed zero flag sub");
		assert(flags[1] === 1) else $error("Test failed negative flag sub");
		
		alu_select = 1;
		#5;
		assert(result === 5) else $error("Test failed for 2+3");
		assert(flags[0] === 0) else $error("Test failed zero flag add");
		assert(flags[1] === 0) else $error("Test failed negative flag add");

		alu_select = 2;
		#5;
		assert(result === 6) else $error("Test failed for 2*3");
		assert(flags[0] === 0) else $error("Test failed zero flag mul");
		assert(flags[1] === 0) else $error("Test failed negative flag mul");
		
		alu_select = 3;
		#5;
		assert(result === 2) else $error("Test failed for a");
		assert(flags[0] === 0) else $error("Test failed zero flag mov");
		assert(flags[1] === 0) else $error("Test failed negative flag mov");
		
		alu_select = 4;
		#5;
		assert(result === -1) else $error("Test failed for compare 1");
		assert(flags[0] === 0) else $error("Test failed zero flag compare 1");
		assert(flags[1] === 1) else $error("Test failed negative flag compare 1");
		
		alu_select = 5;
		#5;
		assert(result === 0) else $error("Test failed for 2/3");
		assert(flags[0] === 0) else $error("Test failed zero flag div");
		assert(flags[1] === 0) else $error("Test failed negative flag div");
		
		alu_select = 6;
		#5;
		assert(result === 1) else $error("Test failed for 2 ^ 3");
		assert(flags[0] === 0) else $error("Test failed zero flag xor");
		assert(flags[1] === 0) else $error("Test failed negative flag xor");
		
		alu_select = 7;
		#5;
		assert(result === 2) else $error("Test failed for 2 & 3");
		assert(flags[0] === 0) else $error("Test failed zero flag and");
		assert(flags[1] === 0) else $error("Test failed negative flag and");		
		
		alu_select = 8;
		#5;
		assert(result === -3) else $error("Test failed for ~a");
		assert(flags[0] === 0) else $error("Test failed zero flag not");
		assert(flags[1] === 0) else $error("Test failed negative flag not");
		
		alu_select = 9;
		#5;
		assert(result === 0) else $error("Test failed for 2<<3");
		assert(flags[0] === 0) else $error("Test failed zero flag shiftL");
		assert(flags[1] === 0) else $error("Test failed negative flag shiftL");

		alu_select = 10;
		#5;
		assert(result === 0) else $error("Test failed for 2>>3");
		assert(flags[0] === 0) else $error("Test failed zero flag shiftR");
		assert(flags[1] === 0) else $error("Test failed negative flag shiftR");		
		
		a = 2;
		b = 2;
		alu_select = 4;
		#5;
		assert(result === 0) else $error("Test failed for compare 2");
		assert(flags[0] === 1) else $error("Test failed zero flag compare 2");
		assert(flags[1] === 0) else $error("Test failed negative flag compare 2");
	end
		
		
		
endmodule