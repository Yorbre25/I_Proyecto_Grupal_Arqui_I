module immSrcControl(input [1:0] opType,output logic immSrc);

	assign immSrc= opType[0]; //01 V 11
endmodule 