module PE_fpu #(
    parameter DATA_WIDTH = 32,
    parameter NUMBER_PE_COL = 8, //number PE in a row
	parameter NUMBER_PE_ROW = 9 //number PE in a col 
)
(
	 
    input i_clk,
    input i_rest_n, 
	input weight_en,
	input [NUMBER_PE_ROW - 1 : 0] i_left_en [NUMBER_PE_COL - 1 : 0], //[9]a[8]
	input [NUMBER_PE_ROW - 1 : 0] i_right_en [NUMBER_PE_COL - 1 : 0],
	
	input [DATA_WIDTH - 1 : 0] i_fmap_f_left [NUMBER_PE_ROW - 1 : 0],
	input [DATA_WIDTH*NUMBER_PE_ROW - 1 : 0] weight_f_top[NUMBER_PE_COL - 1 : 0],  //[32x9]

	input [DATA_WIDTH - 1 : 0] psum_f_top [NUMBER_PE_COL - 1 : 0],
	output reg [DATA_WIDTH - 1 : 0] psum_t_down [NUMBER_PE_COL - 1 : 0]
);
	 
	 
//    //*****************************Kernel_0*************************************
//	//**************************************************************************
//	//[32] weight[9]
//	reg [DATA_WIDTH*NUMBER_PE_ROW - 1 : 0] weight_f_top[NUMBER_PE_ROW - 1 : 0];


	//=============================wire connection of PE========================
	//=================================wire input_0=============================
	wire [DATA_WIDTH - 1 : 0] wire_row_0 [NUMBER_PE_COL - 1 : 0];    //input_0 -> the first row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_1 [NUMBER_PE_COL - 1 : 0];    //input_1 -> the second row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_2 [NUMBER_PE_COL - 1 : 0];    //input_2 -> the third row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_3 [NUMBER_PE_COL - 1 : 0];    //input_3 -> the fourth row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_4 [NUMBER_PE_COL - 1 : 0];    //input_4 -> the fiveth row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_5 [NUMBER_PE_COL - 1 : 0];    //input_5 -> the sixth row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_6 [NUMBER_PE_COL - 1 : 0];    //input_6 -> the seventh row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_7 [NUMBER_PE_COL - 1 : 0];    //input_7 -> the eighth row PE Array
	wire [DATA_WIDTH - 1 : 0] wire_row_8 [NUMBER_PE_COL - 1 : 0];    //input_8 -> the nineth row PE Array


	//=============================psum_each_row================================
   wire [DATA_WIDTH - 1 : 0] psum_0 [NUMBER_PE_ROW - 1 : 0]; 
	wire [DATA_WIDTH - 1 : 0] psum_1 [NUMBER_PE_ROW - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_2 [NUMBER_PE_ROW - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_3 [NUMBER_PE_ROW - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_4 [NUMBER_PE_ROW - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_5 [NUMBER_PE_ROW - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_6 [NUMBER_PE_ROW - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_7 [NUMBER_PE_ROW - 1 : 0];

//	//*****************************control register*****************************
//	
//	reg [NUMBER_PE_ROW - 1 : 0] i_left_en [NUMBER_PE_ROW - 1 : 0];
//	reg [NUMBER_PE_ROW - 1 : 0] i_right_en [NUMBER_PE_ROW - 1 : 0];

	 
//**********************************Row_0*****************************************
//           				The first row of PE Array                            *
//********************************************************************************
	MPE_0 process_element0(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[0][0]),
			.i_right_en(i_right_en[0][0]),
			.i_fmap_f_left(i_fmap_f_left[0]),
			.weight_f_top(weight_f_top[0][DATA_WIDTH - 1 : 0]),
			.psum_f_top(psum_f_top[0]),
			.i_fmap_t_right(wire_row_0[0]),
			.psum_t_down(psum_0[0])
	);


genvar i0;
generate
	for(i0 = 1; i0 < NUMBER_PE_COL; i0 = i0 + 1)begin
		MPE_0 process_element00(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[i0][0]),
			.i_right_en(i_right_en[i0][0]),
			.i_fmap_f_left(wire_row_0[i0-1]),
			.weight_f_top(weight_f_top[i0][DATA_WIDTH - 1 : 0]),
			.psum_f_top(psum_f_top[i0]),
			.i_fmap_t_right(wire_row_0[i0]),
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
			.weight_en(weight_en),
			.i_left_en(i_left_en[0][1]),
			.i_right_en(i_right_en[0][1]),
			.i_fmap_f_left(i_fmap_f_left[1]),
			.weight_f_top(weight_f_top[0][(DATA_WIDTH*2) - 1 : DATA_WIDTH]),
			.psum_f_top(psum_0[0]),
			.i_fmap_t_right(wire_row_1[0]),
			.psum_t_down(psum_1[0])
	);

	genvar i1;
	generate
	for(i1 = 1; i1 < NUMBER_PE_COL; i1 = i1 + 1)begin
		MPE_0 process_element10(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[i1][1]),
			.i_right_en(i_right_en[i1][1]),
			.i_fmap_f_left(wire_row_1[i1-1]),
			.weight_f_top(weight_f_top[i1][(DATA_WIDTH*2) - 1 : DATA_WIDTH]),
			.psum_f_top(psum_0[i1]),
			.i_fmap_t_right(wire_row_1[i1]),
			.psum_t_down(psum_1[i1])
		);
	end

	endgenerate



//**********************************Row_2******************************************
//           				The third row of PE Array                             *
//*********************************************************************************

	MPE_0 process_element2(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[0][2]),
			.i_right_en(i_left_en[0][2]),
			.i_fmap_f_left(i_fmap_f_left[2]),
			.weight_f_top(weight_f_top[0][(DATA_WIDTH*3) - 1 : DATA_WIDTH*2]),
			.psum_f_top(psum_1[0]),
			.i_fmap_t_right(wire_row_2[0]),
			.psum_t_down(psum_2[0])
	);

	genvar i2;
	generate
	for(i2 = 1; i2 < NUMBER_PE_COL; i2 = i2 + 1)begin
		MPE_0 process_element20(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[i2][2]),
			.i_right_en(i_right_en[i2][2]),
			.i_fmap_f_left(wire_row_2[i2-1]),
			.weight_f_top(weight_f_top[i2][(DATA_WIDTH*3) - 1 : DATA_WIDTH*2]),
			.psum_f_top(psum_1[i2]),
			.i_fmap_t_right(wire_row_2[i2]),
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
			.weight_en(weight_en),
			.i_left_en(i_left_en[0][3]),
			.i_right_en(i_right_en[0][3]),
			.i_fmap_f_left(i_fmap_f_left[3]),
			.weight_f_top(weight_f_top[0][(DATA_WIDTH*4) - 1 : DATA_WIDTH*3]),
			.psum_f_top(psum_2[0]),
			.i_fmap_t_right(wire_row_3[0]),
			.psum_t_down(psum_3[0])
	);

	genvar i3;
	generate
	for(i3 = 1; i3 < NUMBER_PE_COL; i3 = i3 + 1)begin
		MPE_0 process_element30(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[i3][3]),
			.i_right_en(i_right_en[i3][3]),
			.i_fmap_f_left(wire_row_3[i3-1]),
			.weight_f_top(weight_f_top[i3][(DATA_WIDTH*4) - 1 : DATA_WIDTH*3]),
			.psum_f_top(psum_2[i3]),
			.i_fmap_t_right(wire_row_3[i3]),
			.psum_t_down(psum_3[i3])
		);
	end

	endgenerate
	

//**********************************Row_4******************************************
//           				The fiveth row of PE Array                            *
//*********************************************************************************

	MPE_0 process_element4(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[0][4]),
			.i_right_en(i_right_en[0][4]),
			.i_fmap_f_left(i_fmap_f_left[4]),
			.weight_f_top(weight_f_top[0][(DATA_WIDTH*5) - 1 : DATA_WIDTH*4]),
			.psum_f_top(psum_3[0]),
			.i_fmap_t_right(wire_row_4[0]),
			.psum_t_down(psum_4[0])
	);

	genvar i4;
	generate
	for(i4 = 1; i4 < NUMBER_PE_COL; i4 = i4 + 1)begin
		MPE_0 process_element40(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[i4][4]),
			.i_right_en(i_right_en[i4][4]),
			.i_fmap_f_left(wire_row_4[i4-1]),
			.weight_f_top(weight_f_top[i4][(DATA_WIDTH*5) - 1 : DATA_WIDTH*4]),
			.psum_f_top(psum_3[i4]),
			.i_fmap_t_right(wire_row_4[i4]),
			.psum_t_down(psum_4[i4])
		);
	end

	endgenerate

//**********************************Row_5******************************************
//           				The sixth row of PE Array                             *
//*********************************************************************************

	MPE_0 process_element5(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[0][5]),
			.i_right_en(i_right_en[0][5]),
			.i_fmap_f_left(i_fmap_f_left[5]),
			.weight_f_top(weight_f_top[0][(DATA_WIDTH*6) - 1 : DATA_WIDTH*5]),
			.psum_f_top(psum_4[0]),
			.i_fmap_t_right(wire_row_5[0]),
			.psum_t_down(psum_5[0])
	);

	genvar i5;
	generate
	for(i5 = 1; i5 < NUMBER_PE_COL; i5 = i5 + 1)begin
		MPE_0 process_element50(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[i5][5]),
			.i_right_en(i_right_en[i5][5]),
			.i_fmap_f_left(wire_row_5[i5-1]),
			.weight_f_top(weight_f_top[i5][(DATA_WIDTH*6) - 1 : DATA_WIDTH*5]),
			.psum_f_top(psum_4[i5]),
			.i_fmap_t_right(wire_row_5[i5]),
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
			.weight_en(weight_en),
			.i_left_en(i_left_en[0][6]),
			.i_right_en(i_right_en[0][6]),
			.i_fmap_f_left(i_fmap_f_left[6]),
			.weight_f_top(weight_f_top[0][(DATA_WIDTH*7) - 1 : DATA_WIDTH*6]),
			.psum_f_top(psum_5[0]),
			.i_fmap_t_right(wire_row_6[0]),
			.psum_t_down(psum_6[0])
	);

	genvar i6;
	generate
	for(i6 = 1; i6 < NUMBER_PE_COL; i6 = i6 + 1)begin
		MPE_0 process_element60(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[i6][6]),
			.i_right_en(i_right_en[i6][6]),
			.i_fmap_f_left(wire_row_6[i6-1]),
			.weight_f_top(weight_f_top[i6][(DATA_WIDTH*7) - 1 : DATA_WIDTH*6]),
			.psum_f_top(psum_5[i6]),
			.i_fmap_t_right(wire_row_6[i6]),
			.psum_t_down(psum_6[i6])
		);
	end

	endgenerate


//**********************************Row_7******************************************
//           				The eighth row of PE Array                            *
//*********************************************************************************

	MPE_0 process_element7(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[0][7]),
			.i_right_en(i_right_en[0][7]),
			.i_fmap_f_left(i_fmap_f_left[7]),
			.weight_f_top(weight_f_top[0][(DATA_WIDTH*8) - 1 : DATA_WIDTH*7]),
			.psum_f_top(psum_6[0]),
			.i_fmap_t_right(wire_row_7[0]),
			.psum_t_down(psum_7[0])
	);

	genvar i7;
	generate
	for(i7 = 1; i7 < NUMBER_PE_COL; i7 = i7 + 1)begin
		MPE_0 process_element70(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[i7][7]),
			.i_right_en(i_right_en[i7][7]),
			.i_fmap_f_left(wire_row_7[i7-1]),
			.weight_f_top(weight_f_top[i7][(DATA_WIDTH*8) - 1 : DATA_WIDTH*7]),
			.psum_f_top(psum_6[i7]),
			.i_fmap_t_right(wire_row_7[i7]),
			.psum_t_down(psum_7[i7])
		);
	end

	endgenerate

//**********************************Row_8******************************************
//           				The nineth row of PE Array                            *
//*********************************************************************************

	MPE_0 process_element8(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[0][8]),
			.i_right_en(i_right_en[0][8]),
			.i_fmap_f_left(i_fmap_f_left[8]),
			.weight_f_top(weight_f_top[0][(DATA_WIDTH*9) - 1 : DATA_WIDTH*8]),
			.psum_f_top(psum_7[0]),
			.i_fmap_t_right(wire_row_8[0]),
			.psum_t_down(psum_t_down[0])
	);

	genvar i8;
	generate
	for(i8 = 1; i8 < NUMBER_PE_COL; i8 = i8 + 1)begin
		MPE_0 process_element80(
			.i_clk(i_clk),
			.i_rest_n(i_rest_n),
			.weight_en(weight_en),
			.i_left_en(i_left_en[i8][8]),
			.i_right_en(i_right_en[i8][8]),
			.i_fmap_f_left(wire_row_8[i8-1]),
			.weight_f_top(weight_f_top[0][(DATA_WIDTH*9) - 1 : DATA_WIDTH*8]),
			.psum_f_top(psum_7[i8]),
			.i_fmap_t_right(wire_row_8[i8]),
			.psum_t_down(psum_t_down[i8])
		);
	end

	endgenerate

endmodule



