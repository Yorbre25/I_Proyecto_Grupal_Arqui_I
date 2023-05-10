module Operator #(parameter N = 4)(
	input logic signed [N-1:0] a,
	input logic signed [N-1:0] b,
	output logic signed [N-1:0] r_mov,
	output logic signed [N-1:0] r_comp,
	output logic signed [N-1:0] r_add,
	output logic signed [N-1:0] r_sub,
	output logic signed [N-1:0] r_mul,
	output logic signed [N-1:0] r_div,
	output logic signed [N-1:0] r_xor,
	output logic signed [N-1:0] r_and,
	output logic signed [N-1:0] r_not,
	output logic signed [N-1:0] r_shl,
	output logic signed [N-1:0] r_shr,
	output logic signed [N-1:0] r_mod
);
	

	assign r_mov = b;
	assign r_add = a + b;
	assign r_sub = a - b;
	assign r_comp = a - b;
	assign r_mul= a * b;
	assign r_div = a / b;
	assign r_xor = a ^ b;
	assign r_and = a & b;
	assign r_not = ~b;
	assign r_shl = a <<< b;
	assign r_shr = a >>> b;
	assign r_mod = a % b;
	


endmodule

	