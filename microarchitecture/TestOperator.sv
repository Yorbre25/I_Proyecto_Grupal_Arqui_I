module TestOperator;

	parameter WIDTH = 4;

	logic signed [WIDTH - 1:0] a;
	logic signed [WIDTH - 1:0] b;

	
	logic signed [WIDTH-1:0] r_mov;
	logic signed [WIDTH-1:0] r_add;
	logic signed [WIDTH-1:0] r_sub;
	logic signed [WIDTH-1:0] r_compare;
	logic signed [WIDTH-1:0] r_mul;
	logic signed [WIDTH-1:0] r_div;
	logic signed [WIDTH-1:0] r_xor;
	logic signed [WIDTH-1:0] r_and;
	logic signed [WIDTH-1:0] r_not;
	logic signed [WIDTH-1:0] r_shl;
	logic signed [WIDTH-1:0] r_shr;
	
	Operator #(.N(WIDTH)) operator1(a, b, r_mov, r_compare, r_add, r_sub, r_mul, r_div, r_xor, r_and, r_not, r_shl, r_shr);
	
	initial begin
		a = 2; 
		b = 3; 
		#10;
		a = 3; 
		b = 2; 
		#10;
		end
endmodule