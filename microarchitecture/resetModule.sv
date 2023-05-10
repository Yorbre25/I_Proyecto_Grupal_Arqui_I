module resetModule(input rst,flush1,flush2,flush3,flush4,output rst1,rst2,rst3,rst4);

	assign rst1=rst | flush1;
	assign rst2=rst | flush2;
	assign rst3=rst | flush3;
	assign rst4=rst | flush4;

endmodule 