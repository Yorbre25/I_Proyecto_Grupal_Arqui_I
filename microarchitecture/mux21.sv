module mux21 #(parameter N=4)(input [N-1:0] a,b, output logic [N-1:0] c, input sel);


	always_comb begin
		if(!sel) c=a;
		else c=b;
	end
	
endmodule 