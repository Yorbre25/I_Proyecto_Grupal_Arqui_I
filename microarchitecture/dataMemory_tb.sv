`timescale 1ns/1ns
module dataMemory_tb();
	
	logic clk,rst,memWrite;
	logic [18:0] address1,address2;
	logic [23:0] data1,data2,qa;
	logic [7:0] qb;
	logic [3:0] switches;
	logic [35:0] gpio1,gpio2;
	dataMemory myDataMemory(.clk(clk),.rst(rst),.memWrite(memWrite),.address1(address1),.address2(address2),.data1(data1),.data2(data2),.switches(switches),.gpio1(gpio1),.gpio2(gpio2),.qa(qa),.qb(qb));

	
	always begin
	
		#10;
		clk=!clk;
	end
	
	initial begin
		clk=0;
		rst=1;
		memWrite=0;
		address1=75;
		address2=1;;
		data1=255;
		data2=65535;
		switches=4'b1010;
		gpio1=4;
		
		#10; //posedge
		
		
		#10;//negedge
		rst=0;
		
		#10; //posedge
		
		#10; //negedge
		memWrite=1;
		address1=5000;
		assert(qa==1) $display("Lectura switches correcta");
		else $error("Lectura desde switches incorrecta");
		
		#10; //posedge
		
		#10;//negedge
		memWrite=0;
		data1=27;
		assert(qa==255) $display("Lectura de la posicion 50000 de memoria despues de la escritura fue correcta");
		else $error("Lectura de la posicion 50000 de memoria despues de la escritura fue correcta");
		
		#10;//posedge
		
		#10; //negedge
		memWrite=1;
		address1=30;
		data1=1;
		assert(qa==255) $display("Lectura de no escritura con memWrite bajo correcta");
		else $error("Lectura de no escritura con memWrite bajo incorrecta");
		
		
		assert(qb==2) $display("Lectura desde el puerto dos de la posicion escrita anteriormente correcta");
		else $error("Lectura desde el puerto dos de la posicion escrita anteriormente incorrecta");
		
		
		#10; //posedge
		
		
		#10; //negedge
		address1=38;
		memWrite=0;
		assert(qa==1) $display("Lectura correcta de los GPIO escritos");
		else $error("Lectura incorrecta de los GPIO escritos");
		
		#10; //posedge
		
		#10; //negedge
		
		assert(qa==1) $display("Lectura correcta de los GPIO como entradas");
		else $error("Lectura incorrecta de los GPIO como entradas");
		
		#10; //posedge
		
		
		
		
		
		
	
	end
	
endmodule 