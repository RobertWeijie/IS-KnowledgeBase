`timescale 1us/100ns
module FPQ_test5 ;
  reg clk ;
	reg rst_n ;
	//
	wire bool_ready_H ;
	wire bool_go_H ;
	wire [ 1 : 0 ] bool_ready_L ;
	wire [ 1 : 0 ] bool_go_L ;
	//
	wire ena_n_H ;
	wire [ 1 : 0 ] ena_n_L ;
	//
	reg trig_TT ;
	reg [ 1 : 0 ] trig_RC ;
	reg ctrl_keep_TT ;
	reg [ 1 : 0 ] ctrl_keep_RC ;
	reg [ 1 : 0 ] ctrl_op_RC ;
	reg [ 1 : 0 ] ctrl_rdy_remain_RC ;
	//
	wire [1:0] active ; // 00 - none, 01 - H, 10 - L
	wire [3:0] channel ;
	//
	round_robin_FP #(2) uut_rr_FP ( .clk( clk ), .rst_n( rst_n ),
	                   .bool_ready_H ( bool_ready_H ),
	                   .bool_go_H ( bool_go_H ),
	                   .bool_ready_L ( bool_ready_L ),
	                   .bool_go_L ( bool_go_L ),
	                   .ena_n_H ( ena_n_H ),
	                   .ena_n_L ( ena_n_L ),
	                   .active ( active ),
	                   .channel ( channel ) );

  initial  begin // clock generator
    clk = 0;
    forever #5 clk = !clk;
  end
  
  initial	begin
   rst_n = 1;
   #10 rst_n = 0;
	 #20 trig_TT = 0 ; trig_RC = 2'b00 ;
   #10 rst_n = 1;
	 #20 ;
	 ctrl_keep_TT = 1'b1 ;
	 ctrl_keep_RC = 2'b11 ;
	 ctrl_op_RC = 2'b11 ;
	 ctrl_rdy_remain_RC = 2'b11 ;
   #40 ;
    // test case by setting bool_ready_H/_L
	 trig_TT = ! trig_TT ;
	 #300 ;
	 ctrl_keep_TT = 1'b0 ;
	 #10 ;
	 trig_RC[ 0 ] = ! trig_RC [ 0 ];
	 #90 ;
	 #900 ;
	 trig_RC[ 1 ] = ! trig_RC [ 1 ] ;
	 #400 ;
	 trig_TT = ! trig_TT ;
	 #200 ;
	 ctrl_keep_RC = 2'b10 ;  	
    // TO BE CONTINUE       
  end

/*  INTERFACE OF MODULE ready_go_emulator
( input clk , rst_n ,
	input trigger ,
	input type_keep ,
	input type_op , 
	input type_rdy_remain ,
	output reg bool_ready ,
	input ena_n ,
	output reg bool_go );
 */  
  ready_go_emulator #( 12'h010 ) emu_TT ( .clk( clk ), 
                    .rst_n ( rst_n ), .trigger ( trig_TT ) ,
                    .type_keep( ctrl_keep_TT ), 
                    .type_op ( 1'b1 ), 
                    .type_rdy_remain ( 1'b1 ),
                    .bool_ready( bool_ready_H ),
                    .ena_n ( ena_n_H ),
                    .bool_go ( bool_go_H ) );
                    
  ready_go_emulator #( 12'h018 ) emu_RC0 ( .clk( clk ), 
                    .rst_n ( rst_n ), .trigger ( trig_RC [ 0 ] ) ,
                    .type_keep  ( ctrl_keep_RC [ 0 ] ), 
                    .type_op    ( ctrl_op_RC [ 0 ] ), 
                    .type_rdy_remain ( ctrl_rdy_remain_RC [ 0 ] ),
                    .bool_ready( bool_ready_L [ 0 ] ),
                    .ena_n ( ena_n_L [ 0 ] ),
                    .bool_go ( bool_go_L [ 0 ] ) );
                    
  ready_go_emulator #( 12'h00c ) emu_RC1 ( .clk( clk ), 
                    .rst_n ( rst_n ), .trigger ( trig_RC [ 1 ] ) ,
                    .type_keep  ( ctrl_keep_RC [ 1 ] ), 
                    .type_op    ( ctrl_op_RC [ 1 ] ), 
                    .type_rdy_remain ( ctrl_rdy_remain_RC [ 1 ] ),
                    .bool_ready( bool_ready_L [ 1 ] ),
                    .ena_n ( ena_n_L [ 1 ] ),
                    .bool_go ( bool_go_L [ 1 ] ) ); 
endmodule

module shifter2_n
  (
    input clk, rst_n ,
    input in ,
    output reg out_n
  );
  reg d_ff1, d_ff2 ;
  always @ ( negedge rst_n or posedge clk )
    if( ! rst_n ) begin 
      d_ff1 <= 0 ;
      d_ff2 <= 0 ;
    end
    else begin
      d_ff1 <= in ;
      d_ff2 <= d_ff1 ;
      if( d_ff2 ) out_n <= 1'b0 ;
      else  out_n <= 1'b1 ;
    end
endmodule

module ready_go_emulator
#( parameter [11:0] VAL_DELAY = 12'h010 )
(
	input clk , rst_n ,
	input trigger ,
	input type_keep ,
	input type_op , 
	input type_rdy_remain ,
	output reg bool_ready ,
	input ena_n ,
	output reg bool_go
);
	localparam TYPE_KEEP_FALSE = 0;
	localparam TYPE_KEEP_TRUE = 1 ;
	localparam TYPE_OP_NORMAL = 1 ;
	localparam TYPE_OP_TIMEOUT = 0 ;
	localparam TYPE_READY_REMAIN = 1 ;
	localparam TYPE_READY_CHANGE_EARLY = 0 ;
	
	localparam [1:0] S_WAIT =  2'b00 ;
	localparam [1:0] S_READY = 2'b01 ;
	localparam [1:0] S_GO =    2'b11 ;
	localparam [1:0] S_OVER =  2'b10;
	
	localparam [11:0] VAL_GO_DOWN = 12'h002 ;
	localparam [11:0] VAL_READY_CHANGE = 12'h008 ;
	
	reg [1:0] state ;
	reg [11:0] cnt ;
	
	reg reg1_trigger ;
	reg reg2_trigger ;
	wire pulse ; 
	
	always @ ( negedge clk ) begin 
	   reg1_trigger <= trigger ;
	   reg2_trigger <= reg1_trigger ;
	end
		
	assign pulse = reg2_trigger ^ trigger;
	
	always @( posedge clk or negedge rst_n )
		if( !rst_n ) begin
			state <= S_WAIT ;
			bool_ready <= 1'b0 ;
			bool_go <= 1'b0 ;
		end
		else
			case( state )
				S_WAIT: begin
					if( pulse ) begin
						bool_ready <= 1'b1 ;
						state <= S_READY ;						
					end
				end
				S_READY: begin
					if( ! ena_n )
						if ( type_op == TYPE_OP_NORMAL ) begin
							cnt <= VAL_DELAY ;
							bool_go <= 1'b1 ;
							state <= S_GO ;
						end
						else // type_op == TYPE_OP_TIMEOUT
							state <= S_WAIT ;
				end
				S_GO: begin 
					if ( cnt == 0 ) begin
						cnt <= VAL_GO_DOWN ;
						bool_go <= 1'b0 ;
						state <= S_OVER ;						
					end
					else if ( type_rdy_remain == TYPE_READY_CHANGE_EARLY && 
							  cnt == VAL_READY_CHANGE ) begin
						bool_ready <= 1'b0 ;
						cnt <= cnt -1 ;
					end
					else cnt <= cnt - 1 ;
				end
				S_OVER: begin
					if( cnt == 0 ) begin
						if( type_keep == TYPE_KEEP_TRUE ) begin
							bool_ready <= 1'b1 ;
							state <= S_READY ; 
						end
						else begin  // type_keep == TYPE_KEEP_FALSE
							bool_ready <= 1'b0 ;
							state <= S_WAIT ;
						end
					end
					else cnt <= cnt - 1 ;
				end
			endcase		
	
endmodule