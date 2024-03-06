  
`timescale 1 ps/1 ps
module tb();

    parameter DATA_WIDTH = 32;
    parameter NUMBER_PE = 9;

    reg i_clk;
    reg i_rest_n;
//	 reg run;
	 reg weight_en;
//    reg [NUMBER_PE - 1 : 0]weight_en;
//	reg [NUMBER_PE - 1 : 0]i_left_en;
//	reg [NUMBER_PE - 1 : 0]i_right_en;
//	reg weight_en1, weight_en2, weight_en3,weight_en4, weight_en5, weight_en6, weight_en7, weight_en8, weight_en9;
	reg i_left_en1, i_left_en2,i_left_en3,i_left_en4,i_left_en5,i_left_en6,i_left_en7,i_left_en8,i_left_en9;
	reg i_right_en1,i_right_en2,i_right_en3,i_right_en4,i_right_en5,i_right_en6,i_right_en7, i_right_en8,i_right_en9;
//	reg i_right_en;
    reg [DATA_WIDTH-1:0] i_fmap_f_left_0, i_fmap_f_left_1, i_fmap_f_left_2, i_fmap_f_left_3, i_fmap_f_left_4, i_fmap_f_left_5, i_fmap_f_left_6, i_fmap_f_left_7, i_fmap_f_left_8;
    reg [DATA_WIDTH-1:0] weight_f_top_0, weight_f_top_1, weight_f_top_2, weight_f_top_3, weight_f_top_4, weight_f_top_5, weight_f_top_6, weight_f_top_7, weight_f_top_8; 
    reg [DATA_WIDTH-1:0] psum_f_top = 32'b0000000000000000000000;

    wire [DATA_WIDTH-1:0] psum_t_down;
    wire [DATA_WIDTH-1:0] i_fmap_t_right_0, i_fmap_t_right_1, i_fmap_t_right_2, i_fmap_t_right_3, i_fmap_t_right_4, i_fmap_t_right_5, i_fmap_t_right_6, i_fmap_t_right_7, i_fmap_t_right_8;


    MPE # (
        .DATA_WIDTH(DATA_WIDTH),
        .NUMBER_PE(NUMBER_PE)
    ) DUT (
        .i_clk(i_clk),
        .i_rest_n(i_rest_n),
//		  .run(run),
		  .weight_en(weight_en),
//		  .i_right_en(i_right_en),
//        .weight_en1(weight_en1), .weight_en2(weight_en2), .weight_en3(weight_en3), .weight_en4(weight_en4), .weight_en5(weight_en5), .weight_en6(weight_en6), .weight_en7(weight_en7), .weight_en8(weight_en8), .weight_en9(weight_en9),
		  .i_left_en1(i_left_en1), .i_left_en2(i_left_en2),.i_left_en3(i_left_en3),.i_left_en4(i_left_en4),.i_left_en5(i_left_en5),.i_left_en6(i_left_en6),.i_left_en7(i_left_en7),.i_left_en8(i_left_en8),.i_left_en9(i_left_en9),
		  .i_right_en1(i_right_en1),.i_right_en2(i_right_en2),.i_right_en3(i_right_en3),.i_right_en4(i_right_en4),.i_right_en5(i_right_en5),.i_right_en6(i_right_en6),.i_right_en7(i_right_en7), .i_right_en8(i_right_en8),.i_right_en9(i_right_en9),
        .i_fmap_f_left_0(i_fmap_f_left_0), .i_fmap_f_left_1(i_fmap_f_left_1), .i_fmap_f_left_2(i_fmap_f_left_2), .i_fmap_f_left_3(i_fmap_f_left_3), .i_fmap_f_left_4(i_fmap_f_left_4), .i_fmap_f_left_5(i_fmap_f_left_5), .i_fmap_f_left_6(i_fmap_f_left_6), .i_fmap_f_left_7(i_fmap_f_left_7), .i_fmap_f_left_8(i_fmap_f_left_8), 
        .weight_f_top_0(weight_f_top_0), .weight_f_top_1(weight_f_top_1), .weight_f_top_2(weight_f_top_2), .weight_f_top_3(weight_f_top_3), .weight_f_top_4(weight_f_top_4), .weight_f_top_5(weight_f_top_5), .weight_f_top_6(weight_f_top_6), .weight_f_top_7(weight_f_top_7), .weight_f_top_8(weight_f_top_8), 
        .psum_f_top(psum_f_top),
        .psum_t_down(psum_t_down),
        .i_fmap_t_right_0(i_fmap_t_right_0), .i_fmap_t_right_1(i_fmap_t_right_1), .i_fmap_t_right_2(i_fmap_t_right_2), .i_fmap_t_right_3(i_fmap_t_right_3), .i_fmap_t_right_4(i_fmap_t_right_4), .i_fmap_t_right_5(i_fmap_t_right_5), .i_fmap_t_right_6(i_fmap_t_right_6), .i_fmap_t_right_7(i_fmap_t_right_7), .i_fmap_t_right_8(i_fmap_t_right_8)
    );

	 initial begin
			i_clk = 0;
			forever #5 i_clk = !i_clk; 
	 end
	
	initial begin



		#10
		i_rest_n = 1'b0;
		weight_en = 1'b0;
//		i_right_en = 1'b0;
		i_right_en1= 1'b0;
		i_right_en2= 1'b0;
		i_right_en3= 1'b0;
		i_right_en4= 1'b0;
		i_right_en5= 1'b0;
		i_right_en6= 1'b0;
		i_right_en7= 1'b0;
		i_right_en8= 1'b0;
		i_right_en9= 1'b0;
		//==============
		i_left_en1= 1'b0;
		i_left_en2= 1'b0;
		i_left_en3= 1'b0;
		i_left_en4= 1'b0;
		i_left_en5= 1'b0;
		i_left_en6= 1'b0;
		i_left_en7= 1'b0;
		i_left_en8= 1'b0;
		i_left_en9= 1'b0;

		#10
		i_rest_n = 1'b1;
		weight_en = 1'b1;
		
		
	

		//input_W
		weight_f_top_0 = 32'b10111101101011001000100100010110;
		weight_f_top_1 = 32'b10111011100111111010011100110000;
		weight_f_top_2 = 32'b00111101110110011001101000011011;
		weight_f_top_3 = 32'b00111110000011010100111111111011;
		weight_f_top_4 = 32'b00111101111110100001110100001000;
		weight_f_top_5 = 32'b00111101101110010001011100101110;
		weight_f_top_6 = 32'b10111011100111111010011100110000; 
		weight_f_top_7 = 32'b10111101100011000000011000101001;
		weight_f_top_8 = 32'b10111101111011011000111011110001;
		
		#10
//		run = 1'b1;
		i_left_en1 = 1'b1;
		i_fmap_f_left_0 = 32'b10111101000000011101011000010100;
//		i_right_en = 1'b1;
		i_right_en1 = 1'b1;
		#10
		i_fmap_f_left_0 = 32'hBD5C1B3D;
		i_left_en2 = 1'b1;
		i_fmap_f_left_1 = 32'b00111100101110110111001100100100;
		i_right_en2 = 1'b1;
		#10
		i_fmap_f_left_1 = 32'hBCACC083;
		i_left_en3 = 1'b1;
		i_fmap_f_left_2 = 32'b00111101000010101011100111110000;
		i_right_en3 = 1'b1;
		#10
		i_fmap_f_left_2 = 32'h3B71B092;
		i_left_en4 = 1'b1;
		i_fmap_f_left_3 = 32'b00111101001101110101111011001011;
		i_right_en4 = 1'b1;
		#10
		i_fmap_f_left_3 = 32'h3D00D76D;
		i_left_en5 = 1'b1;
		i_fmap_f_left_4 = 32'b00111101110001110011101100010010;
		i_right_en5 = 1'b1;
		#10
		i_fmap_f_left_4 = 32'h3D82B281;
		i_left_en6 = 1'b1;
		i_fmap_f_left_5 = 32'b00111100110000000000010000010101; 
		i_right_en6 = 1'b1;
		#10
		i_fmap_f_left_5 = 32'h3B9F8F4D;
		i_left_en7 = 1'b1;
		i_fmap_f_left_6 = 32'b10111011000101110000010011110100; 
		i_right_en7 = 1'b1;
		#10
		i_fmap_f_left_6 = 32'h3C998A9E;
		i_left_en8 = 1'b1;
		i_fmap_f_left_7 = 32'b10111101011101010011010000110000; 
		i_right_en8 = 1'b1;
		#10
		i_fmap_f_left_7 = 32'hBD3C40F1;
		i_left_en9 = 1'b1;
		i_fmap_f_left_8 = 32'b10111101101011100010001100011101;
		i_right_en9 = 1'b1;
		#10
		i_fmap_f_left_8 = 32'hBD8056D9;
		#200 $finish;
		end
		
endmodule 

//====================================CODE_VERSION_2====================================
`timescale 1ps/1ps

module tb();
	parameter DATA_WIDTH = 32;
	parameter NUMBER_PE = 9;
	reg i_clk;
	reg i_rest_n;
	reg weight_en;
	reg [0:0] i_left_en[NUMBER_PE - 1 : 0];
	reg [0:0] i_right_en[NUMBER_PE - 1 : 0];
	reg [DATA_WIDTH - 1:0]psum_f_top = 32'h0; 
	reg [DATA_WIDTH - 1:0]i_fmap_f_left[NUMBER_PE-1:0];
	reg [DATA_WIDTH - 1:0]weight_f_top[NUMBER_PE-1:0];
	reg [DATA_WIDTH - 1:0]i_fmap_t_right[NUMBER_PE-1:0];
	reg [DATA_WIDTH - 1:0]psum_t_down;
	integer i;

	MPE #(
		.DATA_WIDTH(DATA_WIDTH),
		.NUMBER_PE(NUMBER_PE)
	) DUT (
		.i_clk(i_clk),
		.i_rest_n(i_rest_n),
		.weight_en(weight_en),
		.i_left_en(i_left_en),
		.i_right_en(i_right_en),
		.psum_f_top(psum_f_top),
		.i_fmap_f_left(i_fmap_f_left),
		.weight_f_top(weight_f_top),
		.i_fmap_t_right(i_fmap_t_right),
		.psum_t_down(psum_t_down)
	);

	initial begin
		i_clk = 0;
		forever #5 i_clk = !i_clk;
	end
	initial begin
		#10
		i_rest_n = 1'b0;
		weight_en = 1'b0;

		for(i = 0; i<NUMBER_PE; i = i + 1)begin
			i_left_en[i] = 1'b0;
			i_right_en[i] = 1'b0;
		end

		#10
		i_rest_n = 1'b1;
		weight_en = 1'b1;

		weight_f_top[0] = 32'b10111101101011001000100100010110;
 		weight_f_top[1] = 32'b10111011100111111010011100110000;
 		weight_f_top[2] = 32'b00111101110110011001101000011011;
 		weight_f_top[3] = 32'b00111110000011010100111111111011;
 		weight_f_top[4] = 32'b00111101111110100001110100001000;
 		weight_f_top[5] = 32'b00111101101110010001011100101110;
 		weight_f_top[6] = 32'b10111011100111111010011100110000; 
 		weight_f_top[7] = 32'b10111101100011000000011000101001;
 		weight_f_top[8] = 32'b10111101111011011000111011110001;

		#10
//		run = 1'b1;
		i_left_en[0] = 1'b1;
		i_fmap_f_left[0] = 32'b10111101000000011101011000010100;
//		i_right_en = 1'b1;
		i_right_en[0] = 1'b1;
		#10
		i_fmap_f_left[0] = 32'hBD5C1B3D;
		i_left_en[1] = 1'b1;
		i_fmap_f_left[1] = 32'b00111100101110110111001100100100;
		i_right_en[1] = 1'b1;
		#10
		i_fmap_f_left[1] = 32'hBCACC083;
		i_left_en[2] = 1'b1;
		i_fmap_f_left[2] = 32'b00111101000010101011100111110000;
		i_right_en[2] = 1'b1;
		#10
		i_fmap_f_left[2] = 32'h3B71B092;
		i_left_en[3] = 1'b1;
		i_fmap_f_left[3] = 32'b00111101001101110101111011001011;
		i_right_en[3] = 1'b1;
		#10
		i_fmap_f_left[3] = 32'h3D00D76D;
		i_left_en[4] = 1'b1;
		i_fmap_f_left[4] = 32'b00111101110001110011101100010010;
		i_right_en[4] = 1'b1;
		#10
		i_fmap_f_left[4] = 32'h3D82B281;
		i_left_en[5] = 1'b1;
		i_fmap_f_left[5] = 32'b00111100110000000000010000010101; 
		i_right_en[5] = 1'b1;
		#10
		i_fmap_f_left[5] = 32'h3B9F8F4D;
		i_left_en[6] = 1'b1;
		i_fmap_f_left[6] = 32'b10111011000101110000010011110100; 
		i_right_en[6] = 1'b1;
		#10
		i_fmap_f_left[6] = 32'h3C998A9E;
		i_left_en[7] = 1'b1;
		i_fmap_f_left[7] = 32'b10111101011101010011010000110000; 
		i_right_en[7] = 1'b1;
		#10
		i_fmap_f_left[7] = 32'hBD3C40F1;
		i_left_en[8] = 1'b1;
		i_fmap_f_left[8] = 32'b10111101101011100010001100011101;
		i_right_en[8] = 1'b1;
		#10
		i_fmap_f_left[8] = 32'hBD8056D9;
		#1000 $finish;
	end
endmodule