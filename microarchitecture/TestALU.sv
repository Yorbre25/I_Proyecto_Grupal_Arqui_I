module TestALU;
	parameter WIDTH = 4;

	logic [WIDTH-1:0] a,b, result;
	logic [3:0] alu_select;
	logic [1:0] flags;
	integer i;
	
	
	ALU #(.N(WIDTH)) alu(a,b,alu_select,result,flags);
	
	initial begin
		a = 3;
		b = 2;
		alu_select = 0;
		#10;
		for (i=0; i <= 11; i=i+1)
			begin
				alu_select = alu_select + 1;
				#10;
			end
		end
endmodule