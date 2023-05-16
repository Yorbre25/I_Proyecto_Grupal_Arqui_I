`timescale 1ns/1ns
module mainMemory_tb();

	
	logic	[17:0]  address_a,address_b;
	logic clk,wren_a,wren_b;
	logic [23:0]  data_a,data_b,q_a,q_b;
	
	
	mainMemory myMainMemory (
	.address_a(address_a),
	.address_b(address_b),
	.clock(!clk),
	.data_a(data_a),
	.data_b(data_b),
	.wren_a(wren_a),
	.wren_b(wren_b),
	.q_a(q_a),
	.q_b(q_b));
	
	always begin
		#10;
		clk=!clk;
	
	end
	initial begin
		clk=1;
		address_a=0;
		address_b=10;
		data_a=255;
		data_b=65535;
		wren_a=0;
		wren_b=0;
		
		#10; //negedge
		
		#10; //posedge
		wren_a=1;
		assert(q_a==24'hffffff) $display("Lectura correcta de estado inicial");
		else $error("Lectura incorrecta de estado inicial");
		#10; //negedge
		
		#10; //posedge
		wren_a=0;
		data_a=300;
		assert(q_a==255) $display("Escritura realizada correctamente con wren_a en alto");
		else $error("Escritura no realizada correctamente con wren_a en alto");
		
		#10; //negedge
		
		#10; //posedge
		wren_b=1;
		assert(q_a==255) $display("Escritura no realizada con wren_a en bajo");
		else $error("Escritura realizada con wren_a en bajo");
		
		#10; //negedge
		
		
		#10; //posedge
		address_a=200000;
		wren_a=1;
		data_a=3444;
		assert(q_b==65535) $display("Escritura realizada con wren_b en alto");
		else $error("Escritura no realizada con wren_b en alto");
		
		#10; //negedge
		
		#10; //posedge
		wren_b=0;
		data_b=90;
		assert(q_a==3444) $display("Escritura realizada con wren_a en alto");
		else $error("Escritura no realizada con wren_a en alto");
		
		
		#10; //negedge
		address_a=0;
		wren_a=0;
		
		#10; //posedge
		
		assert(q_b==65535) $display("Escritura no realizada con wren_b en bajo");
		else $error("Escritura realizada con wren_b en bajo");
		
		
		
		#10;
	
	end
	
	
endmodule 