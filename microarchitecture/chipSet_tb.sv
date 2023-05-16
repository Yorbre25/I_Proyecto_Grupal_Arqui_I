module chipSet_tb();

	logic [18:0] address;
	logic memWrite,en1,en2,memSel;
	chipSet myChipSet(.address(address),.memWrite(memWrite),.en1(en1),.en2(en2), .memSel(memSel));
	
	
	
	initial begin 
	
		#10;
		address=50;
		memWrite=1;
		
		#10;
		assert(en1==1) $display("Enable 1 activado correctamente");
		else $error("Enable 1 no activado con address 50 y memWrite 1");
		
		assert(en2==0) $display("Enable 2 desactivado correctamente");
		else $error("Enable 2 activado incorrectamente con address 50 y memWrite 1");
		
		#10;
		memWrite=0;
		
		#10;
		assert(en1==0) $display("Enable 1 desactivado correctamente");
		else $error("Enable 1  activado con address 50 y memWrite 0");
		
		assert(en2==0) $display("Enable 2 desactivado correctamente");
		else $error("Enable 2 activado incorrectamente con address 50 y memWrite 0");
		
		
		#10;
		address=77;
		memWrite=0;
		
		#10;
		
		assert(en1==0) $display("Enable 1 desactivado correctamente");
		else $error("Enable 1  activado con address 77 y memWrite 0");
		
		assert(en2==0) $display("Enable 2 desactivado correctamente");
		else $error("Enable 2 activado incorrectamente con address 77 y memWrite 0");
		
		#10;
		
		memWrite=1;
		
		#10;
		
		assert(en1==0) $display("Enable 1 desactivado correctamente");
		else $error("Enable 1  activado con address 77 y memWrite 0");
		
		assert(en2==1) $display("Enable 2 activado correctamente");
		else $error("Enable 2 desactivado incorrectamente con address 77 y memWrite 0");
		#10;
		
	end
endmodule 