module writeBack #(parameter N=4)(input [N-1:0] a,b, input sel, output logic [N-1:0] o);

	always_comb begin
		case(sel)
			1'b0:o=a;
			1'b1:o=b;
			default:o=a;
		endcase
	end
	
endmodule 