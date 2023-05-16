`timescale 1ns/1ns
module processor_tb();
		
		logic rst,clk;
		logic [35:0] gpio1,gpio2;
		logic [23:0] parallelAdress,q;
		logic [3:0] switches;
		processor myprocesor(.rst(rst),.clk(clk),.gpio1(gpio1),.parallelAddress(parallelAdress),.switches(switches),.gpio2(gpio2),.q(q));
		
		always begin
			#10;
			clk=!clk;
		end
		
		initial begin
		
			clk=0;
			rst=1;
			gpio1=0;
			parallelAdress=179;
			switches=4'b0000;
			
			#10; //posedge
			
			#10; //negedge (rst)
			
			#10; //posedge
			rst=0;
			
			
			#100; 
			switches=4'b0100;
			
			
			#500;
			
			
		end
endmodule 