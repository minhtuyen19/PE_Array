module controller # (
    parameter DATA_WIDTH = 32,
    parameter KERNEL_SIZE = 9,
    parameter NUM_KERNEL = 64

) (
    input clk,
    input rst_n,
    input [DATA_WIDTH*KERNEL_SIZE - 1 : 0] i_image, //32*9  
    output reg [DATA_WIDTH-1:0] o_image [0:NUM_KERNEL] // 65 number 32bits

);
    reg     [NUM_KERNEL-1 : 0] buffer_en;
    reg     [NUM_KERNEL-1 : 0] nxt_buffer_en;
    reg     [DATA_WIDTH*KERNEL_SIZE - 1 : 0] i_fmap [0:NUM_KERNEL] ; //65 number (32*9)
    reg     [DATA_WIDTH*KERNEL_SIZE - 1 : 0] nxt_i_fmap [0:NUM_KERNEL] ; //65 number (32*9)
    wire    [DATA_WIDTH-1:0] i_fmap_f_left[0:NUM_KERNEL-1];

    enum int unsigned {
        RESET,
        INIT,
        LOAD_BUFFER_0,
        LOAD_BUFFER_1,
        LOAD_BUFFER_2,
        LOAD_BUFFER_3,
        LOAD_BUFFER_4,
        LOAD_BUFFER_5,
        LOAD_BUFFER_6,
        LOAD_BUFFER_7,
        LOAD_BUFFER_8
    }state,nxt_state;

    always_ff @(posedge clk, negedge rst_n)
    begin
        if (~rst_n) begin
            state                   <=  RESET;                              
        end else begin
            state                   <=  nxt_state;
            buffer_en               <=  nxt_buffer_en;
            
        end
    end

    always_comb
    begin
            nxt_buffer_en   =   buffer_en;
            nxt_i_fmap      =   i_fmap;

        case(state)
            RESET:
            begin
                nxt_buffer_en   =  '0;
                nxt_state   =  INIT;
            end

            INIT: 
            begin
                nxt_buffer_en   =  '1;              // enable all buffer
                nxt_state   =  LOAD_BUFFER_0;
            end

            LOAD_BUFFER_0: 
            begin
                nxt_i_fmap[0]   =  i_image;
                nxt_state   =  LOAD_BUFFER_1;
            end

            LOAD_BUFFER_1: 
            begin
                nxt_i_fmap[1]   =  i_image;
                nxt_state   =  LOAD_BUFFER_2;
            end

            LOAD_BUFFER_2: 
            begin
                nxt_i_fmap[2]   =  i_image;
                nxt_state   =  LOAD_BUFFER_3;
            end

            LOAD_BUFFER_3: 
            begin
                nxt_i_fmap[3]   =  i_image;
                nxt_state   =  LOAD_BUFFER_4;
            end
            
            LOAD_BUFFER_4: 
            begin
                nxt_i_fmap[4]   =  i_image;
                nxt_state   =  LOAD_BUFFER_5;
            end

            LOAD_BUFFER_5: 
            begin
                nxt_i_fmap[5]   =  i_image;
                nxt_state   =  LOAD_BUFFER_6;
            end

            LOAD_BUFFER_6: 
            begin
                nxt_i_fmap[6]   =  i_image;
                nxt_state   =  LOAD_BUFFER_7;
            end

            LOAD_BUFFER_7: 
            begin
                nxt_i_fmap[7]   =  i_image;
                nxt_state   =  LOAD_BUFFER_8;
            end

            LOAD_BUFFER_8: 
            begin
                nxt_i_fmap[8]   =  i_image;
                nxt_state   =  LOAD_BUFFER_0;
            end
            

        endcase
    end


    genvar i;

    generate
        for ( i = 0 ; i < NUM_KERNEL ; i = i + 1) begin
            buffer buffer_inst(
                .clk(clk),
                .rst_n(rst_n),
                .i_data(i_fmap[i]),
                .enable(buffer_en[i]),
                .o_data(i_fmap_f_left[i])
            );
        end
    endgenerate

endmodule


module buffer #(
    parameter DATA_WIDTH = 32,
    parameter KERNEL_SIZE = 9
) (
    input                                               clk,
    input                                               rst_n,
    input           [DATA_WIDTH*KERNEL_SIZE - 1 : 0]    i_data,
    input                                               enable,
    output  reg     [DATA_WIDTH-1 : 0]                  o_data
);
    reg [DATA_WIDTH*KERNEL_SIZE - 1 : 0] buffer;
    always_ff @(posedge clk, negedge rst_n)
    begin
        if (~rst_n) begin
            o_data                  <=  '0;   
            buffer                  <=  '0;       
        end else begin
            o_data                  <=  buffer[DATA_WIDTH-1:0];
            buffer                  <=  {{(DATA_WIDTH){1'b0}},i_data[DATA_WIDTH*KERNEL_SIZE-1:DATA_WIDTH]};
        end
    end

endmodule






