module chipSet(input [18:0] address,input memWrite,output en1,en2, output logic [1:0] memSel);

	always_comb begin
		if(address<=75)memSel=0;
		else if(address>=76 & address<262220) memSel=1;
		else memSel=2;
	end
	
	assign en1= memWrite & !memSel;
	assign en2= memWrite & memSel;

endmodule 