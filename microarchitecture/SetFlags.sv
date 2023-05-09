module SetFlags #(parameter N = 4)(
	input [3:0] select,
	input [N-1:0] result,
	output [1:0] flags
);


	logic flag0, flag1;
	

	
	always_comb begin
		//Zero flag flags[0]
		if(result == 0 && select == 4)
			flag0 = 1'b1;
			
		else
			flag0 = 1'b0;
		
		//Negative flag flags[1]
		if(select <= 5 || select == 9 || select == 10)
			flag1 = result[N-1];
		else
			flag1 = 0;
	end
					
	
	assign flags[0] = flag0;
	assign flags[1] = flag1;


endmodule

