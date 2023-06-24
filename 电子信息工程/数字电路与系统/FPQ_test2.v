`timescale 1us/100ns
module FPQ_test2 ;
  localparam CONST_LEN = 8'd4 ;
  reg clk ;
  reg [7:0] cur_value ;
  wire [7:0] pkt_len ;
  reg ena_n ;
  wire bool_go ;
  
  initial  begin // clock generator
    clk = 0;
    forever #5 clk = !clk;
  end
  
  reg rst_n ;
  initial	begin
    rst_n = 1;
    #10 rst_n = 0;
    #10 rst_n = 1;
    #100
    cur_value = 4 ;
    #200
    cur_value = 16 ;
    #200
    cur_value = 4 ;
    #200
    cur_value = 2 ;
    #200
    cur_value = 0 ;
  end
  
q_server #(2'b11) uut_q_s ( .cur_value( cur_value ), .pkt_len( pkt_len ), 
                            .clk( clk ), .rst_n( rst_n ),
                            .ena_n( ena_n ), 
                            .bool_ready( bool_ready ),
                            .bool_go( bool_go ) );
                            
reg shifter1, shifter2 ;
                            
always @( negedge rst_n or posedge clk )
  if( ! rst_n ) begin
    cur_value <= CONST_LEN ;
    shifter1 <= 0 ;
    shifter2 <= 0 ;
  end
  else begin
    shifter1 <= bool_ready ;
    shifter2 <= shifter1 ;
    if( shifter2 ) ena_n <= 1'b0 ;
    else ena_n <= 1'b1 ;
  end

reg [7:0] cnt ;

assign pkt_len = cnt ; 

always @( negedge rst_n or posedge clk )
  if( ! rst_n ) cnt <= CONST_LEN ;
  else if ( bool_go && cnt > 0 ) cnt <= cnt - 1 ;
  else if ( ! bool_go && cnt == 0 ) cnt <= CONST_LEN ; 

endmodule