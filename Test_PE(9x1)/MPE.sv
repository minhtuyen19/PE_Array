    
module MPE #(
    parameter DATA_WIDTH = 32,
    parameter NUMBER_PE = 9
)
(
    input i_clk,
    input i_rest_n, 
//	 input run,
//    input [NUMBER_PE - 1 : 0]weight_en,
//    input [NUMBER_PE - 1 : 0]i_left_en,
//    input [NUMBER_PE - 1 : 0]i_right_en,
//	input [0 : 0] weight_en [NUMBER_PE - 1 : 0],
//	input [0 : 0]i_left_en[NUMBER_PE - 1 : 0],
//	input [0 : 0]i_right_en[NUMBER_PE - 1 : 0],
//	input weight_en1, weight_en2, weight_en3, weight_en4, weight_en5, weight_en6, weight_en7, weight_en8, weight_en9,
	input weight_en,
	input i_left_en1, i_left_en2,i_left_en3,i_left_en4,i_left_en5,i_left_en6,i_left_en7,i_left_en8,i_left_en9,
	input i_right_en1,i_right_en2,i_right_en3,i_right_en4,i_right_en5,i_right_en6,i_right_en7, i_right_en8,i_right_en9,

//	 input i_right_en,
    input [DATA_WIDTH - 1 : 0] i_fmap_f_left_0, i_fmap_f_left_1, i_fmap_f_left_2, i_fmap_f_left_3, i_fmap_f_left_4, i_fmap_f_left_5, i_fmap_f_left_6, i_fmap_f_left_7, i_fmap_f_left_8, 
    input [DATA_WIDTH - 1 : 0] weight_f_top_0, weight_f_top_1, weight_f_top_2, weight_f_top_3, weight_f_top_4, weight_f_top_5, weight_f_top_6, weight_f_top_7, weight_f_top_8, 
    input [DATA_WIDTH - 1 : 0] psum_f_top,
    output [DATA_WIDTH - 1 : 0] i_fmap_t_right_0, i_fmap_t_right_1, i_fmap_t_right_2, i_fmap_t_right_3, i_fmap_t_right_4, i_fmap_t_right_5, i_fmap_t_right_6, i_fmap_t_right_7, i_fmap_t_right_8,
    output [DATA_WIDTH - 1 : 0] psum_t_down

);
    wire [DATA_WIDTH - 1 : 0] psum [NUMBER_PE - 1 : 0];

    PE_fpu #(
                    .DATA_WIDTH(DATA_WIDTH)
                ) process_element_0 (
                    .i_clk(i_clk),
                    .i_rest_n(i_rest_n),
                    .weight_en(weight_en),
//						  .run(run),
                    .i_left_en(i_left_en1),
                    .i_right_en(i_right_en1),
                    .weight_f_top(weight_f_top_0),
                    .psum_f_top(psum_f_top),
                    .i_fmap_f_left(i_fmap_f_left_0),
                    .i_fmap_t_right(i_fmap_t_right_0),
                    .psum_t_down(psum[0])
                );
            
		
PE_fpu #(
                    .DATA_WIDTH(DATA_WIDTH)
                ) process_element_1 (
                    .i_clk(i_clk),
                    .i_rest_n(i_rest_n),
//						  .run(run),
                    .weight_en(weight_en),
                    .i_left_en(i_left_en2),
                    .i_right_en(i_right_en2),
                    .weight_f_top(weight_f_top_1),
                    .psum_f_top(psum[0]),
                    .i_fmap_f_left(i_fmap_f_left_1),
                    .i_fmap_t_right(i_fmap_t_right_1),
                    .psum_t_down(psum[1])
                );
            	
			
PE_fpu #(
                    .DATA_WIDTH(DATA_WIDTH)
                ) process_element_2 (
                    .i_clk(i_clk),
                    .i_rest_n(i_rest_n),
//						  .run(run),
                    .weight_en(weight_en),
                    .i_left_en(i_left_en3),
                    .i_right_en(i_right_en3),
                    .weight_f_top(weight_f_top_2),
                    .psum_f_top(psum[1]),
                    .i_fmap_f_left(i_fmap_f_left_2),
                    .i_fmap_t_right(i_fmap_t_right_2),
                    .psum_t_down(psum[2])
                );
            
			
PE_fpu #(
                    .DATA_WIDTH(DATA_WIDTH)
                ) process_element_3 (
                    .i_clk(i_clk),
                    .i_rest_n(i_rest_n),
//						  .run(run),
                    .weight_en(weight_en),
                    .i_left_en(i_left_en4),
                    .i_right_en(i_right_en4),
                    .weight_f_top(weight_f_top_3),
                    .psum_f_top(psum[2]),
                    .i_fmap_f_left(i_fmap_f_left_3),
                    .i_fmap_t_right(i_fmap_t_right_3),
                    .psum_t_down(psum[3])
                );
            
			
PE_fpu #(
                    .DATA_WIDTH(DATA_WIDTH)
                ) process_element_4 (
                    .i_clk(i_clk),
                    .i_rest_n(i_rest_n),
//						  .run(run),
                    .weight_en(weight_en),
                    .i_left_en(i_left_en5),
                    .i_right_en(i_right_en5),
                    .weight_f_top(weight_f_top_4),
                    .psum_f_top(psum[3]),
                    .i_fmap_f_left(i_fmap_f_left_4),
                    .i_fmap_t_right(i_fmap_t_right_4),
                    .psum_t_down(psum[4])
                );
            
			
PE_fpu #(
                    .DATA_WIDTH(DATA_WIDTH)
                ) process_element_5 (
                    .i_clk(i_clk),
                    .i_rest_n(i_rest_n),
//						  .run(run),
                    .weight_en(weight_en),
                    .i_left_en(i_left_en6),
                    .i_right_en(i_right_en6),
                    .weight_f_top(weight_f_top_5),
                    .psum_f_top(psum[4]),
                    .i_fmap_f_left(i_fmap_f_left_5),
                    .i_fmap_t_right(i_fmap_t_right_5),
                    .psum_t_down(psum[5])
                );
            
			
PE_fpu #(
                    .DATA_WIDTH(DATA_WIDTH)
                ) process_element_6 (
                    .i_clk(i_clk),
                    .i_rest_n(i_rest_n),
//						  .run(run),
                    .weight_en(weight_en),
                    .i_left_en(i_left_en7),
                    .i_right_en(i_right_en7),
                    .weight_f_top(weight_f_top_6),
                    .psum_f_top(psum[5]),
                    .i_fmap_f_left(i_fmap_f_left_6),
                    .i_fmap_t_right(i_fmap_t_right_6),
                    .psum_t_down(psum[6])
                );
            
			
PE_fpu #(
                    .DATA_WIDTH(DATA_WIDTH)
                ) process_element_7 (
                    .i_clk(i_clk),
                    .i_rest_n(i_rest_n),
//						  .run(run),
                    .weight_en(weight_en),
                    .i_left_en(i_left_en8),
                    .i_right_en(i_right_en8),
                    .weight_f_top(weight_f_top_7),
                    .psum_f_top(psum[6]),
                    .i_fmap_f_left(i_fmap_f_left_7),
                    .i_fmap_t_right(i_fmap_t_right_7),
                    .psum_t_down(psum[7])
                );
            
			
PE_fpu #(
                    .DATA_WIDTH(DATA_WIDTH)
                ) process_element_8 (
                    .i_clk(i_clk),
                    .i_rest_n(i_rest_n),
//						  .run(run),
                    .weight_en(weight_en),
                    .i_left_en(i_left_en9),
                    .i_right_en(i_right_en9),
                    .weight_f_top(weight_f_top_8),
                    .psum_f_top(psum[7]),
                    .i_fmap_f_left(i_fmap_f_left_8),
                    .i_fmap_t_right(i_fmap_t_right_8),
                    .psum_t_down(psum_t_down)
                );		
endmodule
