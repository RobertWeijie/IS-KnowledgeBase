module FPQ_disp_value
(
	input [ 7:0 ] cur_value,
	output reg [ 7:0 ] cur_value_led
);
	always @ (cur_value)
	if(cur_value>=8'd128) cur_value_led = 8'b1111_1111 ;
	else if(cur_value>=8'd64) cur_value_led = 8'b0111_1111 ;
	else if(cur_value>=8'd32) cur_value_led = 8'b0011_1111 ;
	else if(cur_value>=8'd16) cur_value_led = 8'b0001_1111 ;
	else if(cur_value>=8'd8) cur_value_led = 8'b0000_1111 ;
	else if(cur_value>=8'd4) cur_value_led = 8'b0000_0111 ;
	else if(cur_value>=8'd2)  cur_value_led = 8'b0000_0011 ;
	else if(cur_value>=8'd1) cur_value_led = 8'b0000_0001 ;
	else cur_value_led = 8'b0000_0000 ;
endmodule