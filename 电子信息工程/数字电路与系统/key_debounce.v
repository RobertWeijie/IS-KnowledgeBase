module key_debounce(
  clk,rst_n,
  key1_n,key2_n,key3_n,
  led1_n,led2_n,led3_n
  );
 
input clk;
input rst_n;
input key1_n,key2_n,key3_n;
output led1_n,led2_n,led3_n;
 
reg [2:0] key_rst;
 
always @(posedge clk or negedge rst_n)
begin
 if(!rst_n)
  key_rst <= 3'b111;
 else
  key_rst <= {key3_n,key2_n,key1_n}; // 读取当前时刻的按键值
end
 
reg [2:0] key_rst_r;
 
always @(posedge clk or negedge rst_n)
begin
 if(!rst_n)
  key_rst_r <= 3'b111;
 else
  key_rst_r <= key_rst;  // 将上一时刻的按键值进行存储
end
 
wire [2:0]key_an = key_rst_r & (~key_rst); // 当键值从0到1时key_an改变
//wire [2:0]key_an = key_rst_r ^ key_rst;  // 注：也可以这样写
 
reg [19:0] cnt;  // 延时用计数器
 
always @(posedge clk or negedge rst_n)
begin
 if(!rst_n)
  cnt <= 20'd0;
 else if(key_an)
   cnt <= 20'd0;
  else
   cnt <= cnt + 20'd1;
end
 
reg [2:0] key_value;
 
always @(posedge clk or negedge rst_n)
begin
 if(!rst_n)
  key_value <= 3'b111;
 else if(cnt == 20'hfffff) // 2^20*1/(50MHZ)=20ms
   key_value <= {key3_n,key2_n,key1_n}; // 去抖20ms后读取当前时刻的按键值
end
 
reg [2:0] key_value_r;
 
always @(posedge clk or negedge rst_n)
begin
 if(!rst_n)
  key_value_r <= 3'b111;
 else
  key_value_r <= key_value; // 将去抖前一时刻的按键值进行存储
end
 
wire [2:0] key_ctrl = key_value_r & (~key_value); // 当键值从0到1时key_ctrl改变
 
reg d1;
reg d2;
reg d3;
 
always @(posedge  clk or negedge rst_n)
begin
 if(!rst_n)
 begin  // 一个if内有多条语句时不要忘了begin end
  d1 <= 0; 
  d2 <= 0;
  d3 <= 0;
 end
 else
 begin
  if(key_ctrl[0]) d1 <= ~d1;
  if(key_ctrl[1]) d2 <= ~d2;
  if(key_ctrl[2]) d3 <= ~d3;
 end
end
 
assign led1_n = d1? 1'b1:1'b0; // 此处只是为了将LED输出进行翻转，RTL级与下面注释代码无差别
assign led2_n = d2? 1'b1:1'b0;
assign led3_n = d3? 1'b1:1'b0;
 
endmodule