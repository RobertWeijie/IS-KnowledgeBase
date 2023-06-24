module LED_Nixietube(Sys_CLK,Data_Bin,EN,COM,SEG);

input Sys_CLK;
input EN;
input [7:0]Data_Bin;
output [3:0]COM;
output [7:0]SEG;

wire [7:0]Num_Display;
reg [3:0]a;
reg [7:0]SEG;
reg [1:0]COM_Cnt;
reg [3:0]COM_R;

reg Div_CLK;
reg [12:0]Div_Cnt;

assign Num_Display = Data_Bin;
assign COM=COM_R;

parameter Display_0 = 8'b11111100;
parameter Display_1 = 8'b01100000;
parameter Display_2 = 8'b11011010;
parameter Display_3 = 8'b11110010;
parameter Display_4 = 8'b01100110;
parameter Display_5 = 8'b10110110;
parameter Display_6 = 8'b10111110;
parameter Display_7 = 8'b11100000;
parameter Display_8 = 8'b11111110;
parameter Display_9 = 8'b11110110;




initial
begin
	SEG <= 8'b0;
	COM_Cnt <= 2'b00;
	Div_CLK <= 1'b0;
	Div_Cnt <= 13'b0;
end

always@(posedge Sys_CLK)
begin
	if(Div_Cnt < 13'd5000)
		Div_Cnt = Div_Cnt + 1'b1;
	else
	begin
		Div_CLK = ~Div_CLK;
		Div_Cnt = 13'b0;
	end
end

always @(posedge Div_CLK)
begin
	COM_Cnt<=COM_Cnt+1;
end


always@(COM_Cnt)
begin
	case(COM_Cnt)
	2'b00:begin COM_R<=4'b1110;a=Data_Bin%10;end
	2'b01:begin COM_R<=4'b1101;a=(Data_Bin/10)%10;end
	2'b10:begin COM_R<=4'b1011;a=(Data_Bin/100)%100;end
	2'b11:begin COM_R<=4'b0111;a=(Data_Bin/1000)%1000;end
	default:begin COM_R=COM_R;a=a;end
	endcase
end

always@(a)
begin
	case(a)
	4'd0:SEG <= Display_0;
	4'd1:SEG <= Display_1;
	4'd2:SEG <= Display_2;
	4'd3:SEG <= Display_3;
	4'd4:SEG <= Display_4;
	4'd5:SEG <= Display_5;
	4'd6:SEG <= Display_6;
	4'd7:SEG <= Display_7;
	4'd8:SEG <= Display_8;
	4'd9:SEG <= Display_9;
	
	default:SEG <= 1'b0;
	endcase
end

endmodule