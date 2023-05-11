module chipSet(input [18:0] address,input memWrite,output en1,en2, output logic memSel);

	always_comb begin
		if(address<=75)memSel=0;
		else memSel=1;
	end
	
	assign en1= memWrite & !memSel;
	assign en2= memWrite & memSel;

endmodule 