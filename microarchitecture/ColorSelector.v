module ColorSelector(
	clk,
	pixel_x,
	pixel_y,
	color_array,
	address_color,
	color
);
input clk;
input [9:0] pixel_x;
input [9:0] pixel_y;
input [90000:0] color_array;
output reg [17:0] address_color;
output reg [7:0] color;

reg [9:0] counter_x;
reg [9:0] counter_y;


always @(posedge clk)
begin
	if( pixel_y > 34 && pixel_y < 334)
	begin
		//Codigo para asignar el color
		counter_x <= pixel_x - 141;
		counter_y <= pixel_y - 34;
		address_color <= (counter_x*300 + counter_y); // array[address_color]
		//color <= color_array[address_color];
		color <= 8'h74;
	end
	else begin
		counter_x <= 0;
		counter_y <= 0;
		address_color <= 0;
		color <= 8'h00;
	end
end

endmodule