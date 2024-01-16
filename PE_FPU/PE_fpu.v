module PE_fpu #(
    parameter DATA_WIDTH = 32,
    parameter NUMBER_PE_COL = 8, //number PE in a row
	 parameter NUMBER_PE_ROW = 9 //number PE in a col 
)
(
    input i_clk,
    input i_rest_n, 
    input start,
	 
	 //************************************Input********************************
	 //*************************************************************************
	 
	 input [DATA_WIDTH - 1 : 0] i_fmap_f_left_0 [NUMBER_PE_ROW - 1 : 0],
	 input [DATA_WIDTH - 1 : 0] i_fmap_f_left_1 [NUMBER_PE_ROW - 1 : 0],
	 input [DATA_WIDTH - 1 : 0] i_fmap_f_left_2 [NUMBER_PE_ROW - 1 : 0],
	 input [DATA_WIDTH - 1 : 0] i_fmap_f_left_3 [NUMBER_PE_ROW - 1 : 0],
	 input [DATA_WIDTH - 1 : 0] i_fmap_f_left_4 [NUMBER_PE_ROW - 1 : 0],
	 input [DATA_WIDTH - 1 : 0] i_fmap_f_left_5 [NUMBER_PE_ROW - 1 : 0],
	 input [DATA_WIDTH - 1 : 0] i_fmap_f_left_6 [NUMBER_PE_ROW - 1 : 0],
	 input [DATA_WIDTH - 1 : 0] i_fmap_f_left_7 [NUMBER_PE_ROW - 1 : 0],
	 input [DATA_WIDTH - 1 : 0] i_fmap_f_left_8 [NUMBER_PE_ROW - 1 : 0],

	 
	 
    //*****************************Kernel_0*************************************
	//**************************************************************************
	 
	 input [DATA_WIDTH - 1 : 0] weight_f_top_0 [NUMBER_PE_COL - 1 : 0], //Kernel_n - Filter_0
	 input [DATA_WIDTH - 1 : 0] weight_f_top_1 [NUMBER_PE_COL - 1 : 0], //Kernel_n - Filter_1
	 input [DATA_WIDTH - 1 : 0] weight_f_top_2 [NUMBER_PE_COL - 1 : 0], //Kernel_n - Filter_2
	 input [DATA_WIDTH - 1 : 0] weight_f_top_3 [NUMBER_PE_COL - 1 : 0], //Kernel_n - Filter_3
	 input [DATA_WIDTH - 1 : 0] weight_f_top_4 [NUMBER_PE_COL - 1 : 0], //Kernel_n - Filter_4
	 input [DATA_WIDTH - 1 : 0] weight_f_top_5 [NUMBER_PE_COL - 1 : 0], //Kernel_n - Filter_5
	 input [DATA_WIDTH - 1 : 0] weight_f_top_6 [NUMBER_PE_COL - 1 : 0], //Kernel_n - Filter_6
	 input [DATA_WIDTH - 1 : 0] weight_f_top_7 [NUMBER_PE_COL - 1 : 0], //Kernel_n - Filter_7
	 input [DATA_WIDTH - 1 : 0] weight_f_top_8 [NUMBER_PE_COL - 1 : 0], //Kernel_n - Filter_8

	 
	 //=========================================================================
	 //============================Psum_f_top - row_0===========================
    // input  [DATA_WIDTH - 1 : 0] psum_f_top_00, psum_f_top_01, psum_f_top_02, psum_f_top_03, psum_f_top_04, psum_f_top_05, psum_f_top_06, psum_f_top_07, psum_f_top_08,
	input [DATA_WIDTH - 1 : 0] psum_f_top [NUMBER_PE_ROW - 1 : 0],
	output reg [DATA_WIDTH - 1 : 0] psum_t_down [NUMBER_PE_COL - 1 : 0]
);

	//*****************************state_definition*****************************

	reg [3:0] current_state, next_state;
	parameter [3:0] IDLE = 3'd0, LOAD = 3'd1, EXE = 3'd2, STORE = 3'd3, OUTPUT = 3'd4, DONE = 3'd5;

	//=============================wire connection of PE========================
	//=================================wire input_0=============================
	wire [DATA_WIDTH - 1 : 0] wire_row_0 [NUMBER_PE_COL - 2 : 0];    //input_0 -> the first row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_1 [NUMBER_PE_COL - 2 : 0];    //input_1 -> the first row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_2 [NUMBER_PE_COL - 2 : 0];    //input_2 -> the first row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_3 [NUMBER_PE_COL - 2 : 0];    //input_3 -> the first row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_4 [NUMBER_PE_COL - 2 : 0];    //input_4 -> the first row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_5 [NUMBER_PE_COL - 2 : 0];    //input_5 -> the first row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_6 [NUMBER_PE_COL - 2 : 0];    //input_6 -> the first row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_7 [NUMBER_PE_COL - 2 : 0];    //input_7 -> the first row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_8 [NUMBER_PE_COL - 2 : 0];    //input_8 -> the first row PE Array


	//=============================psum_each_row================================
    wire [DATA_WIDTH - 1 : 0] psum_0 [NUMBER_PE_ROW - 1 : 0]; 
	wire [DATA_WIDTH - 1 : 0] psum_1 [NUMBER_PE_ROW - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_2 [NUMBER_PE_ROW - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_3 [NUMBER_PE_ROW - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_4 [NUMBER_PE_ROW - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_5 [NUMBER_PE_ROW - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_6 [NUMBER_PE_ROW - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_7 [NUMBER_PE_ROW - 1 : 0];

	//*****************************control register*****************************
	//*****************************weight_enable********************************
	reg [0:0] weight_en_0 [NUMBER_PE_COL - 1 : 0];
	reg [0:0] weight_en_1 [NUMBER_PE_COL - 1 : 0];
	reg [0:0] weight_en_2 [NUMBER_PE_COL - 1 : 0];
	reg [0:0] weight_en_3 [NUMBER_PE_COL - 1 : 0];
	reg [0:0] weight_en_4 [NUMBER_PE_COL - 1 : 0];
	reg [0:0] weight_en_5 [NUMBER_PE_COL - 1 : 0];
	reg [0:0] weight_en_6 [NUMBER_PE_COL - 1 : 0];
	reg [0:0] weight_en_7 [NUMBER_PE_COL - 1 : 0];
	reg [0:0] weight_en_0 [NUMBER_PE_COL - 1 : 0];
	


	reg [0:0] i_left_en [NUMBER_PE_ROW - 1 : 0];
	reg out_buf_rest;






	 
//**********************************Row_0*****************************************
//           				The first row of PE Array                            *
//********************************************************************************
	MPE_0 process_element0(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en[0]),
			.i_left_en(i_left_en[0]),
			.i_fmap_f_left(i_fmap_f_left_0[0]),
			.weight_f_top(weight_f_top_0[0]),
			.psum_f_top(psum_f_top[0]),
			.psum_t_down(psum_0[0])
	);

	genvar i0;
	generate
	for (i0 = 1; i0 < NUMBER_PE_COL; i0 = i0 + 1)begin
		MPE_0 process_element00(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.i_fmap_left(wire_row_0[i0-1]),
			.weight_f_top(weight_f_top_0[i0]),
			.psum_f_top(psum_f_top[i0]),ss
			.psum_t_down(psum_0[i0])
		);
	end
	endgenerate

//**********************************Row_1******************************************
//           				The second row of PE Array                            *
//*********************************************************************************

	MPE_0 process_element1(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.i_fmap_f_left(i_fmap_f_left_1[0]),
			.weight_f_top(weight_f_top_1[0]),
			.psum_f_top(psum_0[0]),
			.psum_t_down(psum_1[0])
	);

	genvar i1;
	generate
	for(i1 = 1; i1 < NUMBER_PE_COL; i1 = i1 + 1)begin
		MPE_0 process_element10(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.i_fmap_f_left(wire_row_1[i1-1]),
			.weight_f_top(weight_f_top_1[i1]),
			.psum_f_top(psum_0[i1]),
			.psum_t_down(psum_1[i1])
		);
	end

	endgenerate



//**********************************Row_2******************************************
//           				The third row of PE Array                            *
//*********************************************************************************

	MPE_0 process_element2(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),

			.i_fmap_f_left(i_fmap_f_left_2[0]),
			.weight_f_top(weight_f_top_2[0]),
			.psum_f_top(psum_1[0]),
			.psum_t_down(psum_2[0])
	);

	genvar i2;
	generate
	for(i2 = 1; i2 < NUMBER_PE_COL; i2 = i2 + 1)begin
		MPE_0 process_element20(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),

			.i_fmap_f_left(wire_row_2[i2-1]),
			.weight_f_top(weight_f_top_2[i2]),
			.psum_f_top(psum_1[i2]),
			.psum_t_down(psum_2[i2])
		);
	end

	endgenerate

//**********************************Row_3******************************************
//           				The fourth row of PE Array                            *
//*********************************************************************************
	MPE_0 process_element3(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),

			.i_fmap_f_left(i_fmap_f_left_3[0]),
			.weight_f_top(weight_f_top_3[0]),
			.psum_f_top(psum_2[0]),
			.psum_t_down(psum_3[0])
	);

	genvar i3;
	generate
	for(i3 = 1; i3 < NUMBER_PE_COL; i3 = i3 + 1)begin
		MPE_0 process_element30(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.i_fmap_f_left(wire_row_3[i3-1]),
			.weight_f_top(weight_f_top_3[i3]),
			.psum_f_top(psum_2[i3]),
			.psum_t_down(psum_3[i3])
		);
	end

	endgenerate
	

//**********************************Row_4******************************************
//           				The fiveth row of PE Array                             *
//*********************************************************************************

	MPE_0 process_element4(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),

			.i_fmap_f_left(i_fmap_f_left_4[0]),
			.weight_f_top(weight_f_top_4[0]),
			.psum_f_top(psum_3[0]),
			.psum_t_down(psum_4[0])
	);

	genvar i4;
	generate
	for(i4 = 1; i4 < NUMBER_PE_COL; i4 = i4 + 1)begin
		MPE_0 process_element40(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),

			.i_fmap_f_left(wire_row_4[i4-1]),
			.weight_f_top(weight_f_top_4[i4]),
			.psum_f_top(psum_3[i4]),
			.psum_t_down(psum_4[i4])
		);
	end

	endgenerate

//**********************************Row_5******************************************
//           				The sixth row of PE Array                           *
//*********************************************************************************

	MPE_0 process_element5(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),

			.i_fmap_f_left(i_fmap_f_left_5[0]),
			.weight_f_top(weight_f_top_5[0]),
			.psum_f_top(psum_4[0]),
			.psum_t_down(psum_5[0])
	);

	genvar i5;
	generate
	for(i5 = 1; i5 < NUMBER_PE_COL; i5 = i5 + 1)begin
		MPE_0 process_element50(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),

			.i_fmap_f_left(wire_row_5[i5-1]),
			.weight_f_top(weight_f_top_5[i5]),
			.psum_f_top(psum_4[i5]),
			.psum_t_down(psum_5[i5])
		);
	end

	endgenerate


//**********************************Row_6******************************************
//           				The seventh row of PE Array                           *
//*********************************************************************************

	MPE_0 process_element6(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),

			.i_fmap_f_left(i_fmap_f_left_6[0]),
			.weight_f_top(weight_f_top_6[0]),
			.psum_f_top(psum_5[0]),
			.psum_t_down(psum_6[0])
	);

	genvar i6;
	generate
	for(i6 = 1; i6 < NUMBER_PE_COL; i6 = i6 + 1)begin
		MPE_0 process_element30(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),

			.i_fmap_f_left(wire_row_6[i6-1]),
			.weight_f_top(weight_f_top_6[i6]),
			.psum_f_top(psum_5[i6]),
			.psum_t_down(psum_6[i6])
		);
	end

	endgenerate


//**********************************Row_7******************************************
//           				The eighth row of PE Array                           *
//*********************************************************************************

	MPE_0 process_element7(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),

			.i_fmap_f_left(i_fmap_f_left_7[0]),
			.weight_f_top(weight_f_top_7[0]),
			.psum_f_top(psum_6[0]),
			.psum_t_down(psum_7[0])
	);

	genvar i7;
	generate
	for(i7 = 1; i7 < NUMBER_PE_COL; i7 = i7 + 1)begin
		MPE_0 process_element70(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),

			.i_fmap_f_left(wire_row_7[i7-1]),
			.weight_f_top(weight_f_top_7[i7]),
			.psum_f_top(psum_6[i7]),
			.psum_t_down(psum_7[i7])
		);
	end

	endgenerate

//**********************************Row_8******************************************
//           				The nineth row of PE Array                           *
//*********************************************************************************

	MPE_0 process_element8(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
	
			.i_fmap_f_left(i_fmap_f_left_8[0]),
			.weight_f_top(weight_f_top_8[0]),
			.psum_f_top(psum_7[0]),
			.psum_t_down(psum_t_down[0])
	);

	genvar i8;
	generate
	for(i8 = 1; i8 < NUMBER_PE_COL; i8 = i8 + 1)begin
		MPE_0 process_element80(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),

			.i_fmap_f_left(wire_row_8[i8-1]),
			.weight_f_top(weight_f_top_8[i8]),
			.psum_f_top(psum_7[i8]),
			.psum_t_down(psum_t_down[i8])
		);
	end

	endgenerate

endmodule
