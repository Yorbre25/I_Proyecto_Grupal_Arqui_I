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

`include "vpg.h"

module vpg(
	clk_50,
	reset_n,
	mode,
	mode_change,
	offset,
	color,
	vpg_pclk,
	vpg_de,
	vpg_hs,
	vpg_vs,
	vpg_r,
	vpg_g,
	vpg_b,
	parallelAddress
);

input					clk_50;
input					reset_n;
input		[3:0]		mode;
input					mode_change;
input 	[17:0]	offset;
input		[7:0]		color;
output				vpg_pclk;
output				vpg_de;
output				vpg_hs;
output				vpg_vs;
output	[7:0]		vpg_r;
output	[7:0]		vpg_g;
output	[7:0]		vpg_b;
output	[23:0]	parallelAddress;

//=======================================================
//  Signal declarations
//=======================================================
//=============== PLL reconfigure
wire [63:0] reconfig_to_pll, reconfig_from_pll;
wire        gen_clk_locked;
wire [31:0] mgmt_readdata, mgmt_writedata;
wire        mgmt_read, mgmt_write;
wire [5:0]  mgmt_address;
//============= assign timing constant  
reg  [11:0] h_total, h_sync, h_start, h_end; 
reg  [11:0] v_total, v_sync, v_start, v_end; 
reg  [11:0] v_active_14, v_active_24, v_active_34; 


//=======================================================
//  Sub-module
//=======================================================
//=============== PLL reconfigure
pll_reconfig u_pll_reconfig (
	.mgmt_clk(clk_50),
	.mgmt_reset(!reset_n),
	.mgmt_readdata(mgmt_readdata),
	.mgmt_waitrequest(),
	.mgmt_read(mgmt_read),
	.mgmt_write(mgmt_write),
	.mgmt_address(mgmt_address),
	.mgmt_writedata(mgmt_writedata),
	.reconfig_to_pll(reconfig_to_pll),
	.reconfig_from_pll(reconfig_from_pll) );

pll u_pll (
	.refclk(clk_50),           
	.rst(!reset_n),              
	.outclk_0(vpg_pclk), 
	.locked(gen_clk_locked),           
	.reconfig_to_pll(reconfig_to_pll),  
	.reconfig_from_pll(reconfig_from_pll) );

pll_controller u_pll_controller (
	.clk(clk_50),
	.reset_n(reset_n),
	.mode(mode),
	.mode_change(mode_change),
	.mgmt_readdata(mgmt_readdata),
	.mgmt_read(mgmt_read),
	.mgmt_write(mgmt_write),
	.mgmt_address(mgmt_address),
	.mgmt_writedata(mgmt_writedata) );

//=============== pattern generator according to vga timing
vga_generator u_vga_generator (                                    
	.clk(vpg_pclk),                
	.reset_n(gen_clk_locked),                                                
	.h_total(h_total),           
	.h_sync(h_sync),           
	.h_start(h_start),             
	.h_end(h_end),                                                    
	.v_total(v_total),           
	.v_sync(v_sync),            
	.v_start(v_start),           
	.v_end(v_end), 
	.v_active_14(v_active_14), 
	.v_active_24(v_active_24), 
	.v_active_34(v_active_34), 
	.offset(offset),
   .color(color),
	.vga_hs(vpg_hs),
	.vga_vs(vpg_vs),           
	.vga_de(vpg_de),
	.vga_r(vpg_r),
	.vga_g(vpg_g),
	.vga_b(vpg_b),
	.counter_x(pixel_x),
	.counter_y(pixel_y),
	.parallelAddress(parallelAddress)
	);
	


//=======================================================
//  Structural coding
//=======================================================
//============= assign timing constant  
//h_total : total - 1
//h_sync : sync - 1
//h_start : sync + back porch - 1 - 2(delay)
//h_end : h_start + active
//v_total : total - 1
//v_sync : sync - 1
//v_start : sync + back porch - 1
//v_end : v_start + active
//v_active_14 : v_start + 1/4 active
//v_active_24 : v_start + 2/4 active
//v_active_34 : v_start + 3/4 active
always @(mode)
begin
	{h_total, h_sync, h_start, h_end} <= {12'd799, 12'd95, 12'd141, 12'd781}; 
	{v_total, v_sync, v_start, v_end} <= {12'd524, 12'd1, 12'd34, 12'd514}; 
	{v_active_14, v_active_24, v_active_34} <= {12'd154, 12'd274, 12'd394};
	//{h_total, h_sync, h_start, h_end} <= {12'd299, 12'd100, 12'd141, 12'd781}; //Cambie aqui el 95 x 195
	//{v_total, v_sync, v_start, v_end} <= {12'd524, 12'd1, 12'd34, 12'd514};
	//{v_active_14, v_active_24, v_active_34} <= {12'd100, 12'd200, 12'd300};
end

endmodule