module writeBack #(parameter N=24)(input [N-1:0] readDataW, aluOutW, input memToReg, output logic [N-1:0] ResultW);
	
	mux21 #(.N(N)) mux1(
	.a(readDataW), 
	.b(aluOutW), 
	.c(resultW), 
	.sel(memToReg));

	
endmodule 