// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------

module vga_generator(                                    
  input						clk,                
  input						reset_n,                                                
  input			[11:0]	h_total,           
  input			[11:0]	h_sync,           
  input			[11:0]	h_start,             
  input			[11:0]	h_end,                                                    
  input			[11:0]	v_total,           
  input			[11:0]	v_sync,            
  input			[11:0]	v_start,           
  input			[11:0]	v_end, 
  input			[11:0]	v_active_14, 
  input			[11:0]	v_active_24, 
  input			[11:0]	v_active_34, 
  input 			[17:0]	offset,
  input			[7:0]		color,
  output	reg				vga_hs,             
  output	reg				vga_vs,           
  output	reg				vga_de,
  output	reg	[7:0]		vga_r,
  output	reg	[7:0]		vga_g,
  output	reg	[7:0]		vga_b,
  output reg [9:0] counter_x, // horizontal counter
  output reg [9:0] counter_y, // vertical counter
  output reg [23:0] parallelAddress
);

//=======================================================
//  Signal declarations
//=======================================================
reg	[11:0]	h_count;
reg	[7:0]		pixel_x;
reg	[11:0]	v_count;
reg				h_act; 
reg				h_act_d;
reg				v_act; 
reg				v_act_d; 
reg				pre_vga_de;
wire				h_max, hs_end, hr_start, hr_end;
wire				v_max, vs_end, vr_start, vr_end;
wire				v_act_14, v_act_24, v_act_34;
reg            InBoxX, InBoxY;
reg				boarder;
reg	[3:0]		color_mode;
reg	[1:0]		columna;
reg	[1:0]		fila;
reg [23:0] pos_x; // horizontal counter
reg [23:0] pos_y;
reg [17:0] address_color;
reg [7:0] screen_color;



//=======================================================
//  Structural coding
//=======================================================
assign h_max = h_count == h_total;
assign hs_end = h_count >= h_sync;
assign hr_start = h_count == h_start; 
assign hr_end = h_count == h_end;
assign v_max = v_count == v_total;
assign vs_end = v_count >= v_sync;
assign vr_start = v_count == v_start; 
assign vr_end = v_count == v_end;
assign v_act_14 = v_count == v_active_14; 
assign v_act_24 = v_count == v_active_24; 
assign v_act_34 = v_count == v_active_34;


//horizontal control signals
always @ (posedge clk or negedge reset_n)
	if (!reset_n)
	begin
		h_act_d	<=	1'b0;
		h_count	<=	12'b0;
		pixel_x	<=	8'b0;
		vga_hs	<=	1'b1;
		h_act		<=	1'b0;
		columna <= 2'b00;
		counter_x <= 0;
		pos_x <= 0;
	end
	else
	begin
		h_act_d	<=	h_act;
		
		// Cuando se ha llegado al final de la fila
		if (h_max)
		begin
			h_count	<=	12'b0;
			counter_x <= 0;
			pos_x <= 0;
		end
		
		else
		begin
			h_count	<=	h_count + 12'b1;
			counter_x <= counter_x + 1;
		end

		if (h_act_d)
			pixel_x	<=	pixel_x + 1;
		else
			pixel_x	<=	8'b0;

		if (hs_end && !h_max)
			vga_hs	<=	1'b1;
		else
			vga_hs	<=	1'b0;

		if (hr_start)
			h_act		<=	1'b1;
		else if (hr_end)
			h_act		<=	1'b0;
			
		if(counter_x >= 141 && counter_x < 441)
			begin
				InBoxX <= 1'b1;
				pos_x <= pos_x + 1;
			end
		else
			begin
				InBoxX <= 1'b0;
				pos_x <= 0;
			end
			
	end

//vertical control signals
always@(posedge clk or negedge reset_n)
	if(!reset_n)
	begin
		v_act_d		<=	1'b0;
		v_count		<=	12'b0;
		vga_vs		<=	1'b1;
		v_act			<=	1'b0;
		fila <= 2'b00;
		counter_y <= 0;
		pos_y <= 0;
	end
	else 
	begin		
		if (h_max)
		begin		  
			v_act_d	  <=	v_act;
		  
			if (v_max)
			begin
				v_count	<=	12'b0;
				counter_y <= 0;
				pos_y <= 0;
			end
			else
			begin
				v_count	<=	v_count + 12'b1;
				counter_y <= counter_y + 1;
			end

			if (vs_end && !v_max)
				vga_vs	<=	1'b1;
			else
				vga_vs	<=	1'b0;

			if (vr_start)
				v_act <=	1'b1;
			else if (vr_end)
				v_act <=	1'b0;
			if( counter_y >= 34 && counter_y < 334)
				begin
					InBoxY <= 1'b1;
					pos_y <= pos_y + 1;
				end
			else
				begin
					InBoxY <= 1'b0;
					pos_y <= 0;
				end
		end
	end

// Assign of colors by column and row
always@(negedge clk or negedge reset_n)
	if(!reset_n)
		begin
			//pos_x <= 0;
			//pos_y <= 0;
			parallelAddress <= 24'd304;
			screen_color <= 8'h00;
		end
	else begin
		if((InBoxX == 1'b1) && (InBoxY == 1'b1))
		begin
			parallelAddress <= 24'd300 + (pos_x * 24'd300 + pos_y);
			//Codigo para asignar el color
			//pos_x <= pos_x + 24'd1;
			//pos_y <= pos_y + 24'd1;
			
			//parallelAddress <=  (pos_x + pos_y);
			//parallelAddress <= 304; 
			//color <= color_array[address_color];
			//color <= 8'hFF;
			screen_color <= color;
		end
		else begin
			//pos_x <= 0;
			//pos_y <= 0;
			parallelAddress <= 24'd304;
			screen_color <= 8'h00;
			
		end
	end
	
	
//pattern generator and display enable
always @(*)
begin
		vga_de		<=	pre_vga_de;
		pre_vga_de	<=	v_act && h_act;
    
		if ((!h_act_d&&h_act) || hr_end || (!v_act_d&&v_act) || vr_end)
			boarder	<=	1'b1;
		else
			boarder	<=	1'b0;   		
		
		if (boarder)
			{vga_r, vga_g, vga_b} <= {8'hFF,8'h88,8'h88};
		else
			begin
				if((InBoxX == 1'b1) && (InBoxY == 1'b1))
					begin
						{vga_r, vga_g, vga_b}	<=	{color,color,color};
					end
				else
					{vga_r, vga_g, vga_b}	<=	{8'h00,8'h00,8'h00};
			end
end	

endmodule