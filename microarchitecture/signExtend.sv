module signExtend #(parameter beforeExtend=18,parameter afterExtend=32)(input [beforeExtend-1:0] in,output logic [afterExtend-1:0] out);
	always @(*)begin
	 out={{afterExtend-beforeExtend{in[beforeExtend-1]}},in};
	end
endmodule 