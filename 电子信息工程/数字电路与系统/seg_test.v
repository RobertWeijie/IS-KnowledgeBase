`timescale 1ns / 1ps 

module seg_test1
(
	//INPUT
	//seg_data_1		,
	//seg_data_2		,

	//OUTPUT
	output reg [7:0] seg_led_1,
	input wire clk,
	input wire rst_n,
	input wire key
);
	//*******************
	//DEFINE INPUT
	//*******************
	//input 	[3:0]	seg_data_1,seg_data_2;     

    //*******************
	//DEFINE OUTPUT
	//*******************

	
	//*********************
	//INNER SIGNAL DECLARATION
	//*********************
	//REGS
	reg   	[6:0]   seg	[15:0];  
	reg      [2:0]   count;
	
	/////////门级电路显示数码管-a
	wire [6:0] w_temp_seg ; // temporary wires for segs' output
	wire w_A, w_B, w_C, w_D, w_A_n, w_B_n, w_C_n, w_D_n ; 
	wire w_g_11, w_g_12, w_g_13, w_g_14, w_g_15, w_g_16 ; 
	wire w_y_a;
	assign {w_A, w_B, w_C, w_D} = count ;
	not g01( w_A_n, w_A ), g02( w_B_n, w_B ), g03( w_C_n, w_C ), g04( w_D_n, w_D );
	nand g11( w_g_11, w_A_n, w_B, w_D );
	nand g12( w_g_12, w_A_n, w_C );
	nand g13( w_g_13, w_A, w_B_n, w_C_n );
	nand g14( w_g_14, w_A, w_D_n );
	nand g15( w_g_15, w_B_n, w_D_n );
	nand g16( w_g_16, w_B, w_C );
	nand g17( w_y_a, w_g_11, w_g_12, w_g_13, w_g_14, w_g_15, w_g_16 );
	
	//WIRE
	//wire			dp1,dp2;
	
	initial 
	begin               /*******************8***请补全 8~F*********************************/
		seg[0] = 7'h3f;	   //  0
		seg[1] = 7'h06;	   //  1
		seg[2] = 7'h5b;	   //  2
		seg[3] = 7'h4f;	   //  3
		seg[4] = 7'h66;	   //  4
		seg[5] = 7'h6d;	   //  5
		seg[6] = 7'h7d;	   //  6
		seg[7] = 7'h07;	   //  7
				   //  8
				   //  9
			;	   //  A
				   //  b
				   //  C
				   //  d
				   //  E
		 		   //  F
		count = 4'b0000;
	end

reg  key_rst;	// 读取当前时刻的按键值
always @(posedge clk or negedge rst_n)
begin
 if(!rst_n)
  key_rst <= 1'b1;
 else
  key_rst <= key; 
end



reg  key_rst_r;   // 将上一时刻的按键值进行存储
always @(posedge clk or negedge rst_n)
begin
 if(!rst_n)
  key_rst_r <= 1'b1;
 else
  key_rst_r <= key_rst;  
end
	
wire key_an = key_rst_r & (~key_rst);  // 当键值从0到1时key_an改变
 
 
reg [15:0] cnt;  // 延时用计数器
always @(posedge clk or negedge rst_n)
begin
 if(!rst_n)
  cnt <= 16'd0;
 else if(key_an)
   cnt <= 16'd0;
  else
   cnt <= cnt + 16'd1;
end

reg  key_value;

always @(posedge clk or negedge rst_n)
begin
 if(!rst_n)
  key_value <= 1'b1;
 else if(cnt == 16'hffff) // 6ms
   key_value <= key; // 去抖6ms后读取当前时刻的按键值
end
	
	
reg  key_value_r;
 
always @(posedge clk or negedge rst_n)
begin
 if(!rst_n)
  key_value_r <= 1'b1;
 else
  key_value_r <= key_value; // 将去抖前一时刻的按键值进行存储
end


wire  key_ctrl = key_value_r & (~key_value); 

reg d1;
 
always @(posedge  clk or negedge rst_n)
begin
 if(!rst_n)
  count <= 0; 
 else
 begin
  if(key_ctrl) 
	begin
		seg_led_1 = {1'b0,seg[count]};
		count=count+1;
	end
 end
end

			
endmodule     