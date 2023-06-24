// `define BOOL_JUST_FOR_SIMU 1

/*
	MODULE: q_Q16_negedge  	// cycled queue to instead queue in demo
	MODULE: q_Q16    		// NOT BE USED IN FINAL VERSION
	MODULE: FPQ_disp_q_head  // user interface -- display
	MODULE: FPQ_disp_state	 // NOT BE USED IN FINAL VERSION 
	MODULE: FPQ_disp_state_by_meter  // user interface -- display by a log2 meter
	MODULE: FPQ_mux_1TT_2RC  // 	
*/

module q_Q16_negedge
#( parameter [3:0] offset = 0 )
(
	input cnt_clk , // NOTE: cnt_clk in this module ticks in bit
	input rst_n ,
	input go ,
	output reg [7:0] pkt_len,  // unit 1 for 16 B, the shortest frame 4
							   // the longest frame 95 ( 1520, little 
							   // grearter than 1518 MTU )
							   // Note : should ceil the value of cnt by 16
	output reg bool_new_pkt
);
	reg [ 11:0 ] cnt ;
	reg [ 3:0 ] index ;
	wire [ 7:0 ] q_pkt_len [ 15:0 ] ;
	reg reg_go ; // the history of 'go'

// NOTE: q_pkt_len shall not be set as 8'b1111_1111 ( its max value is 126 )
`ifndef 	BOOL_JUST_FOR_SIMU	
	assign q_pkt_len  [0]	= 4 ;
	assign q_pkt_len  [1]	= 8 ;
	assign q_pkt_len  [2]	= 16 ;
	assign q_pkt_len  [3]	= 32 ;
	assign q_pkt_len  [4]	= 64 ;
	assign q_pkt_len  [5]	= 95 ;
	assign q_pkt_len  [6]	= 0 ;
	assign q_pkt_len  [7]	= 0 ;
	assign q_pkt_len  [8]	= 0 ;
	assign q_pkt_len  [9]	= 0 ;
	assign q_pkt_len  [10]	= 64 ;
	assign q_pkt_len  [11]	= 32 ;
	assign q_pkt_len  [12]	= 16 ;
	assign q_pkt_len  [13]	= 8 ;
	assign q_pkt_len  [14]	= 4 ;
	assign q_pkt_len  [15]	= 0 ;
`else
	assign q_pkt_len  [0]	= 1 ;  // MTU 128B just for simu ( max pkt_len is 8 )
	assign q_pkt_len  [1]	= 2 ;
	assign q_pkt_len  [2]	= 3 ;
	assign q_pkt_len  [3]	= 4 ;
	assign q_pkt_len  [4]	= 6 ;
	assign q_pkt_len  [5]	= 8 ;
	assign q_pkt_len  [6]	= 0 ;
	assign q_pkt_len  [7]	= 0 ;
	assign q_pkt_len  [8]	= 0 ;
	assign q_pkt_len  [9]	= 0 ;
	assign q_pkt_len  [10]	= 6 ;
	assign q_pkt_len  [11]	= 5 ;
	assign q_pkt_len  [12]	= 4 ;
	assign q_pkt_len  [13]	= 3 ;
	assign q_pkt_len  [14]	= 2 ;
	assign q_pkt_len  [15]	= 0 ;
`endif
	
	always @( negedge cnt_clk or negedge rst_n )
		if( !rst_n ) begin
			index <= offset ;
			cnt[ 11:4 ] <= q_pkt_len [ offset ] ; // because unit 1 for 16B
			cnt[ 3:0 ] <= 4'b0000 ;	
			reg_go <= 0 ;
			bool_new_pkt <= 1'b1 ;
		end
		else if ( cnt != 12'd0 && go ) begin 
			cnt <= cnt - 12'd1 ;
			reg_go <= go ;
			bool_new_pkt <= 1'b0 ;
		end
		else if ( cnt == 12'd0 && reg_go == 1'b1 && go == 1'b0 ) begin
			index <= index + 4'd1 ;
			cnt[ 11:4 ] <= q_pkt_len [ index + 4'b0001 ] ;
			cnt[ 3:0 ] <= 4'b0000 ;
			reg_go <= go ;
			bool_new_pkt <= 1'b1 ;
		end
		else begin
		  reg_go <= go ;
		  bool_new_pkt <= 1'b0 ;
		end
				
	always @( cnt )
		if ( cnt[ 3:0 ] == 4'd0 ) pkt_len = cnt[ 11:4 ] ;
		else pkt_len = cnt[ 11:4 ] + 8'd1 ; // ceiling
	
endmodule

///////////////////////////////////////////////////////////////////////////////

module q_Q16
#( parameter [3:0] offset = 0 )
(
	input cnt_clk ,
	input rst_n ,
	input go ,
	output reg [7:0] pkt_len  // unit 1 for 16 B, the shortest frame 4
							   // the longest frame 95 ( 1520, little 
							   // grearter than 1518 MTU )
							   // Note : should ceil the value of cnt by 16
);
	reg [ 11:0 ] cnt ;
	reg [ 3:0 ] index ;
	wire [ 7:0 ] q_pkt_len [ 15:0 ] ;
	reg reg_go ; // the history of 'go'

`ifndef 	BOOL_JUST_FOR_SIMU	
	assign q_pkt_len  [0]	= 4 ;
	assign q_pkt_len  [1]	= 8 ;
	assign q_pkt_len  [2]	= 16 ;
	assign q_pkt_len  [3]	= 32 ;
	assign q_pkt_len  [4]	= 64 ;
	assign q_pkt_len  [5]	= 95 ;
	assign q_pkt_len  [6]	= 0 ;
	assign q_pkt_len  [7]	= 0 ;
	assign q_pkt_len  [8]	= 0 ;
	assign q_pkt_len  [9]	= 0 ;
	assign q_pkt_len  [10]	= 64 ;
	assign q_pkt_len  [11]	= 32 ;
	assign q_pkt_len  [12]	= 16 ;
	assign q_pkt_len  [13]	= 8 ;
	assign q_pkt_len  [14]	= 4 ;
	assign q_pkt_len  [15]	= 0 ;
`else
	assign q_pkt_len  [0]	= 1 ; // MTU 128B just for simu ( max pkt_len is 8 )
	assign q_pkt_len  [1]	= 2 ;
	assign q_pkt_len  [2]	= 3 ;
	assign q_pkt_len  [3]	= 4 ;
	assign q_pkt_len  [4]	= 6 ;
	assign q_pkt_len  [5]	= 8 ;
	assign q_pkt_len  [6]	= 0 ;
	assign q_pkt_len  [7]	= 0 ;
	assign q_pkt_len  [8]	= 0 ;
	assign q_pkt_len  [9]	= 0 ;
	assign q_pkt_len  [10]	= 6 ;
	assign q_pkt_len  [11]	= 5 ;
	assign q_pkt_len  [12]	= 4 ;
	assign q_pkt_len  [13]	= 3 ;
	assign q_pkt_len  [14]	= 2 ;
	assign q_pkt_len  [15]	= 0 ;
`endif
	
	always @( posedge cnt_clk or negedge rst_n )
		if( !rst_n ) begin
			index <= offset ;
			cnt[ 11:4 ] <= q_pkt_len [ offset ] ; // because unit 1 for 16B
			cnt[ 3:0 ] <= 4'b0000 ;	
			reg_go <= 0 ;
		end
		else if ( cnt != 0 && go ) begin 
			cnt <= cnt - 1 ;
			reg_go <= go ;
		end
		else if ( cnt == 12'd0 && reg_go == 1'b1 && go == 1'b0 ) begin
			index <= index + 1 ;
			cnt[ 11:4 ] <= q_pkt_len [ index + 4'b0001 ] ;
			cnt[ 3:0 ] <= 4'b0000 ;
			reg_go <= go ;
		end
		else reg_go <= go ;
				
	always @( cnt )
		if ( cnt[ 3:0 ] == 0 ) pkt_len = cnt[ 11:4 ] ;
		else pkt_len = cnt[ 11:4 ] + 1 ; // ceiling
	
endmodule

///////////////////////////////////////////////////////////////////////////////

module FPQ_disp_state
(
	input [ 1:0 ] active , // 00 - none, 01 - H, 10 - L
	input channel ,  
	input [  7:0 ] pkt_len_TT ,
	input [ 15:0 ] pkt_len_RC ,
	output reg forbid_LED_n ,
	output reg TT_LED_n ,
	output reg [ 0:1 ] RC_LED_n ,
	output reg [ 7:0 ] chain_LED_n
);

	always @ ( active or channel or pkt_len_TT or pkt_len_RC ) begin
		if ( active == 2'b00 ) begin
			forbid_LED_n = 1'b0 ;
			TT_LED_n = 1'b1 ;
			RC_LED_n = 2'b11 ;
			chain_LED_n = 8'b1111_1111 ;
		end
		else if ( active == 2'b01 ) begin
			forbid_LED_n = 1'b1 ;
			TT_LED_n = 1'b0 ;
			RC_LED_n = 2'b11 ;
			chain_LED_n = ~( pkt_len_TT ) ;
		end
		else if ( active == 2'b10 ) begin
			forbid_LED_n = 1'b1 ;
			TT_LED_n = 1'b1 ;
			if ( channel ) begin 
				RC_LED_n [ 1 ] = 1'b0 ;
				RC_LED_n [ 0 ] = 1'b1 ;
				chain_LED_n = ~( pkt_len_RC[ 15:8 ] ) ;
			end
			else begin
				RC_LED_n [ 1 ] = 1'b1 ;
				RC_LED_n [ 0 ] = 1'b0 ;	
				chain_LED_n = ~( pkt_len_RC[ 7:0 ] ) ;				
			end
		end
		else begin
			forbid_LED_n = 1'b1 ;
			TT_LED_n = 1'b1 ;
			RC_LED_n = 2'b11 ;
		end
	end
	
endmodule

///////////////////////////////////////////////////////////////////////////////

module FPQ_disp_q_head
`ifndef 	BOOL_JUST_FOR_SIMU
#( parameter [ 7:0 ] TH_PKT_LEN = 8'd32 ) // threshold, if in default
                                          // HEAD 32 32 31 TAIL at MTU 1518B
`else
#( parameter [ 7:0 ] TH_PKT_LEN = 8'd3 ) // threshold, if in default
                                          // HEAD 3 3 2 TAIL at MTU 8
`endif								  
(
	input rst_n ,
	input flash_clk ,
	input bool_new_pkt ,
	input [ 7:0 ] pkt_len ,
	output [ 0:1 ] bar_LED  // NOTE : bit-0 presents max significant codes (old data)
);
	reg [ 5:0 ] light_cnt ;
	
	reg [ 0:1 ] bool_light ;
	reg [ 0:1 ] reg_bar_LED ;

	always @ ( posedge flash_clk or negedge bool_new_pkt or negedge rst_n ) begin
		if ( ! rst_n ) begin
			bool_light <= 2'b00 ;
			reg_bar_LED <= 2'b00 ;
			light_cnt <= 5'd0 ;
		end
		else if ( ! bool_new_pkt ) begin 
			bool_light <= 2'b11 ;
			light_cnt <= 5'd0 ;
			if ( pkt_len >=  TH_PKT_LEN ) reg_bar_LED <= 2'b11 ;
			else if ( pkt_len > 0 ) reg_bar_LED <= 2'b10 ;
			else reg_bar_LED <= 2'b00 ;  // pkt_len == 0				
		end
		else begin
			light_cnt <= light_cnt + 3'd1 ;
			if ( pkt_len >= TH_PKT_LEN + TH_PKT_LEN ) begin
				reg_bar_LED <= 2'b11 ;
				bool_light [ 0 ] <= 1'b1 ; // HEAD  -o- -o- TAIL
				bool_light [ 1 ] <= 1'b1 ;
			end
			else if ( pkt_len >= TH_PKT_LEN ) begin
				reg_bar_LED <= 2'b11 ;
				bool_light [ 0 ] <= 1'b1 ; // HEAD  -o- -*- TAIL
				if( light_cnt == 5'b10000 ) 	bool_light [ 1 ] <= 1'b1 ;
				else bool_light [ 1 ] <= 1'b0 ; 
			end
			else if (pkt_len > 0 ) begin 
				reg_bar_LED <= 2'b10 ;
				if( light_cnt == 5'b10000 ) bool_light [ 0 ] <= 1'b1 ;
				else bool_light [ 0 ] <= 1'b0 ; 
				bool_light [ 1 ] <= 1'b0 ; // HEAD  -*- - - TAIL
			end
       end		
	end
	
	assign bar_LED [ 1 ] =  reg_bar_LED [ 1 ] & bool_light [ 1 ]  ;
	assign bar_LED [ 0 ] =  reg_bar_LED [ 0 ] & bool_light [ 0 ]  ;	
	
endmodule

///////////////////////////////////////////////////////////////////////////////

module FPQ_mux_1TT_2RC 
(
	input clk_10MHz ,
	input rst_n ,
	input [ 7:0 ] pkt_len_TT , 
	input [ 15:0 ] pkt_len_RC ,
	output bool_go_TT ,
	output [ 1:0 ] bool_go_RC ,
	output [ 1:0 ] active , // 00 - none, 01 - H, 10 - L
	output [ 3:0 ] channel ,  
	output bit_clk ,
	output [ 1:0 ] cur_state ,
	output [ 7:0 ] cur_value
);
	wire clk ;
	wire clk_pulse ;
	
	wire [ 7:0 ] cur_value_TT, cur_value_RC ;
	
	wire bool_ready_H ;
	wire bool_go_H ;
	wire ena_n_H ;
	wire [ 1:0 ] bool_ready_L ;
	wire [ 1:0 ] bool_go_L ;	
	wire [ 1:0 ] ena_n_L ;
	
	assign bit_clk = clk ;
	assign bool_go_TT = bool_go_H ; // NOTE: The assgin direction is Very Important !
	                                // The bool_go_H is an active signal outputed by srv
	                                // The bool_go_TT is passive unless being driven by active signal
	assign bool_go_RC = bool_go_L ; // NOTE: The assgin direction is Very Important !
	                                // The bool_go_L is an active signal outputed by srv
	                                // The bool_go_RC is passive unless being driven by active signal

`ifndef 	BOOL_JUST_FOR_SIM0
	divider #( 16'd25000 ) uut_clk_T_2500us ( .clk( clk_10MHz ),
		.rst_n( rst_n ), .cp( clk_pulse ) ) ;
	// #( parameter [15:0] CNT_NUM = 16'd60000 ) 	// 5ms @ 12MHz
	// #( parameter [15:0] CNT_NUM = 16'd60000 ) 	// 2.5ms @ 12MHz
	div_half uut_clk_T_5ms ( .clk( clk_pulse ),
	 .rst_n( rst_n ), .cp( clk ) ) ;
`else
  assign clk = clk_12MHz ;	
`endif	

	timetable uut_timetable ( .cnt_clk( clk ), .rst_n( rst_n ),
		.ena_n( 1'b0 ), 	.cur_value( cur_value ) ,
		.cur_state( cur_state ) );

	cur_value_translator uut_trans ( .cur_value( cur_value ) , 
	   .cur_state( cur_state ) , .cnt_for_TT( cur_value_TT ) ,
	   .cnt_for_RC( cur_value_RC ) );
	   
	localparam [1:0] P_PCF = 2'b00 ;
	localparam [1:0] P_TT  = 2'b01 ;
	localparam [1:0] P_RC  = 2'b11 ;
	localparam [1:0] P_BE  = 2'b10 ;   
	   
	q_server_3_states #( P_TT ) uut_q_s_TT ( .clk( clk ), .rst_n( rst_n ),
		    .cur_value( cur_value_TT ), 
		    .pkt_len( pkt_len_TT ),         
        .ena_n( ena_n_H ), 
        .bool_ready( bool_ready_H ),
        .bool_go( bool_go_H ) );  // NOTE: shall be wire bool_go_H other than output port bool_go_TT

	q_server_3_states #( P_RC ) uut_q_s_RC0 ( .clk( clk ), .rst_n( rst_n ),
		    .cur_value( cur_value_RC ), 
		    .pkt_len( pkt_len_RC [ 7:0 ] ), 
        .ena_n( ena_n_L [ 0 ] ), 
        .bool_ready( bool_ready_L [ 0 ] ),
        .bool_go( bool_go_L [ 0 ] ) );	 // ditto ( as the bool_go_H )

	q_server_3_states #( P_RC ) uut_q_s_RC1 ( .clk( clk ), .rst_n( rst_n ),
		    .cur_value( cur_value_RC ), 
		    .pkt_len( pkt_len_RC [ 15:8 ] ), 
        .ena_n( ena_n_L [ 1 ] ), 
        .bool_ready( bool_ready_L [ 1 ] ),
        .bool_go( bool_go_L [ 1 ] ) );		// ditto ( as the bool_go_H )	
		
	round_robin_FP #( 2 ) uut_rr_FP ( .clk( clk ), .rst_n( rst_n ),
	    .bool_ready_H ( bool_ready_H ),
	    .bool_go_H ( bool_go_H ),
	    .bool_ready_L ( bool_ready_L ),
	    .bool_go_L    ( bool_go_L  ),
	    .ena_n_H      ( ena_n_H ),
	    .ena_n_L      ( ena_n_L ),
	    .active ( active ),
	    .channel ( channel ) );

endmodule 

///////////////////////////////////////////////////////////////////////////////

module FPQ_disp_state_by_meter
(
	input [ 1:0 ] active , // 00 - none, 01 - H, 10 - L
	input channel ,  
	input [  7:0 ] pkt_len_TT ,
	input [ 15:0 ] pkt_len_RC ,
	
	output reg TT_LED_n ,
	output reg [ 0:1 ] RC_LED_n ,
	output wire [ 7:0 ] packet_length 
);

	reg [ 1:0 ] addr ;
	
	
	mux4 uut_mux4( .addr( addr ),
				   .in0( pkt_len_RC [ 7:0 ] ),
	            .in1( pkt_len_RC [ 15:8 ] ),
				   .in2( 8'd0 ),
				   .in3( pkt_len_TT [ 7:0 ] ),
				   .out( packet_length ) );

   

	always @ ( active or channel or pkt_len_TT or pkt_len_RC ) begin
		if ( active == 2'b00 ) begin
			
			TT_LED_n = 1'b1 ;
			RC_LED_n = 2'b11 ;
			addr = 2'b10 ; // chain_LED_n = 8'b1111_1111
		end
		else if ( active == 2'b01 ) begin
			
			TT_LED_n = 1'b0 ;
			RC_LED_n = 2'b11 ;
			addr = 2'b11 ; //  pkt_len_TT 
		end
		else if ( active == 2'b10 ) begin
			
			TT_LED_n = 1'b1 ;
			if ( channel ) begin 
				RC_LED_n [ 1 ] = 1'b0 ;
				RC_LED_n [ 0 ] = 1'b1 ;
				addr = 2'b01 ; //  pkt_len_RC[ 15:8 ] 
			end
			else begin
				RC_LED_n [ 1 ] = 1'b1 ;
				RC_LED_n [ 0 ] = 1'b0 ;	
				addr = 2'b00 ; // pkt_len_RC[ 7:0 ] 			
			end
		end
		else begin
			
			TT_LED_n = 1'b1 ;
			RC_LED_n = 2'b11 ;
			addr = 2'b10 ; // chain_LED_n = 8'b1111_1111 ;
		end
	end
	
endmodule




