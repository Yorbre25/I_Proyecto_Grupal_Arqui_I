//altdpram CBX_SINGLE_OUTPUT_FILE="ON" INDATA_ACLR="OFF" INDATA_REG="INCLOCK" INTENDED_DEVICE_FAMILY=""MAX V"" LPM_TYPE="altdpram" OUTDATA_ACLR="OFF" OUTDATA_REG="UNREGISTERED" RDADDRESS_ACLR="OFF" RDADDRESS_REG="UNREGISTERED" RDCONTROL_ACLR="OFF" RDCONTROL_REG="UNREGISTERED" USE_EAB="OFF" WIDTH=24 WIDTH_BYTEENA=1 WIDTHAD=18 WRADDRESS_ACLR="OFF" WRADDRESS_REG="INCLOCK" WRCONTROL_ACLR="OFF" WRCONTROL_REG="INCLOCK" data inclock q rdaddress wraddress wren
//VERSION_BEGIN 20.1 cbx_mgl 2020:06:05:12:11:10:SJ cbx_stratixii 2020:06:05:12:04:51:SJ cbx_util_mgl 2020:06:05:12:04:51:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2020  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and any partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel FPGA IP License Agreement, or other applicable license
//  agreement, including, without limitation, that your use is for
//  the sole purpose of programming logic devices manufactured by
//  Intel and sold by Intel or its authorized distributors.  Please
//  refer to the applicable agreement for further details, at
//  https://fpgasoftware.intel.com/eula.



//synthesis_resources = altdpram 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mg0p91
	( 
	data,
	inclock,
	q,
	rdaddress,
	wraddress,
	wren) /* synthesis synthesis_clearbox=1 */;
	input   [23:0]  data;
	input   inclock;
	output   [23:0]  q;
	input   [17:0]  rdaddress;
	input   [17:0]  wraddress;
	input   wren;

	wire  [23:0]   wire_mgl_prim1_q;

	altdpram   mgl_prim1
	( 
	.data(data),
	.inclock(inclock),
	.q(wire_mgl_prim1_q),
	.rdaddress(rdaddress),
	.wraddress(wraddress),
	.wren(wren));
	defparam
		mgl_prim1.indata_aclr = "OFF",
		mgl_prim1.indata_reg = "INCLOCK",
		mgl_prim1.intended_device_family = ""MAX V"",
		mgl_prim1.lpm_type = "altdpram",
		mgl_prim1.outdata_aclr = "OFF",
		mgl_prim1.outdata_reg = "UNREGISTERED",
		mgl_prim1.rdaddress_aclr = "OFF",
		mgl_prim1.rdaddress_reg = "UNREGISTERED",
		mgl_prim1.rdcontrol_aclr = "OFF",
		mgl_prim1.rdcontrol_reg = "UNREGISTERED",
		mgl_prim1.use_eab = "OFF",
		mgl_prim1.width = 24,
		mgl_prim1.width_byteena = 1,
		mgl_prim1.widthad = 18,
		mgl_prim1.wraddress_aclr = "OFF",
		mgl_prim1.wraddress_reg = "INCLOCK",
		mgl_prim1.wrcontrol_aclr = "OFF",
		mgl_prim1.wrcontrol_reg = "INCLOCK";
	assign
		q = wire_mgl_prim1_q;
endmodule //mg0p91
//VALID FILE
