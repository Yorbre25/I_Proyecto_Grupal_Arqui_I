module TestOperator;

	parameter WIDTH = 4;

	logic [WIDTH - 1:0] a;
	logic [WIDTH - 1:0] b;

	
	logic [WIDTH:0] r_mov;
	logic [WIDTH:0] r_add;
	logic [WIDTH:0] r_sub;
	logic [WIDTH:0] r_compare;
	logic [WIDTH:0] r_mul;
	logic [WIDTH:0] r_div;
	logic [WIDTH:0] r_xor;
	logic [WIDTH:0] r_and;
	logic [WIDTH:0] r_not;
	logic [WIDTH:0] r_shl;
	logic [WIDTH:0] r_shr;
	
	Operator #(.N(WIDTH)) operator1(a, b, r_mov, r_compare, r_add, r_sub, r_mul, r_div, r_xor, r_and, r_not, r_shl, r_shr);
	
	initial begin
		a = 4;
		b = 2;
		#10;
		a = 2;
		b = 4;
		#10;
		end
endmodule