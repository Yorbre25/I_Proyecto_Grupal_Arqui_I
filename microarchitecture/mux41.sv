module mux41 #(parameter N=4)(input [N-1:0] a,b,c,d, output logic [N-1:0] e, input[1:0] sel);


	always_comb begin
		case(sel)
			2'b00:e=a;
			2'b01:e=b;
			2'b10:e=c;
			2'b11:e=d;
			default:e=a;
		
		endcase
	end
	
endmodule 