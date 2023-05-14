module writeBack #(parameter N=24)(input [N-1:0] readDataW, aluOutW, input memToReg, output logic [N-1:0] resultW);
	
	mux21 #(.N(N)) mux1(
	.a(aluOutW), 
	.b(readDataW), 
	.c(resultW), 
	.sel(memToReg));

	
endmodule 