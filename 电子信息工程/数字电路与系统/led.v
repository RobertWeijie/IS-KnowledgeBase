module seg_test1(
	input wire clk,
	input wire reset,
	output reg[2:0] led
);

always@(posedge clk,negedge reset )begin
	if(!reset)
		led<=3'b001;
	else
		led<={led[0],led[2:1]};
end

endmodule