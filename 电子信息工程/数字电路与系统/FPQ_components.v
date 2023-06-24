// `define BOOL_JUST_FOR_SIMU 1

/*
	MODULE: timetable
	MODULE: cur_value_translator
	MODULE: q_server 				// NOT BE USED IN FINAL VERSION
	MODULE: q_server_3_states
	MODULE: round_robin_FP
*/

///////////////////////////////////////////////////////////////////////////////

module timetable (
	cnt_clk,	// clock for the inner counter
	// NOTE: cnt_clk in this module ticks in bit
	rst_n, 		// reset input, negative
	ena_n, 		// enable input, negative
	cur_value,	// the residual value of the inner counter
	cur_state	// the current state
);
	input cnt_clk ;	// divided by M with period 0.01us ( 1 bit @ 100Mbps ) in practice
					//              with period 0.005s  ( 1 bit @ 200bps ) for demo
					// 16 BYTE -- 1.28us ( @ 100Mbps ) in practice
					// 16 BYTE -- 0.64s  ( @ 200bps ) for demo
	input rst_n, ena_n ;
	output [7:0] cur_value ;
	output [1:0] cur_state ;
	parameter [1:0] T_PCF = 2'b10 ;
	parameter [1:0] T_TT  = 2'b11 ;
	parameter [1:0] T_MAR = 2'b01 ;	// margin before a TT or a PCF
	parameter [1:0] T_DEF = 2'b00 ; // default, porosity
	// TYPE : 00 (default) -- porosity / 01 -- margin / 11 -- TT / 10 -- PCF

	wire [1:0] sche_type [7:0] ;
	wire [7:0] sche_len [7:0] ; 	// unit 1 for 16 B, the shortest frame 4
									// the longest frame 95 ( 1520, little 
									// grearter than 1518 MTU )
									// the sche_len 0 ~ 4K, but the margin
									// with be 95 constantly
	reg [2:0] index ;
	reg [11:0] cnt ;

`ifndef 	BOOL_JUST_FOR_SIMU
	assign sche_type [0] 	= T_PCF ;
	assign sche_len  [0]	   = 4 ;
	assign sche_type [1] 	= T_TT ;
	assign sche_len  [1] 	= 28 ; 	 // 462 Bytes
	assign sche_type [2] 	= T_DEF ;
	assign sche_len  [2] 	= 190 ;  // 3040 Bytes
	assign sche_type [3] 	= T_MAR ;
	assign sche_len  [3] 	= 95 ;	  // 1520 Bytes -- for the MTU 1518 B
	assign sche_type [4] 	= T_TT ;
	assign sche_len  [4] 	= 95 ; 	
	assign sche_type [5] 	= T_DEF ;
	assign sche_len  [5] 	= 232 ;  // 3712 Bytes -- defective config. -- no margin before TT
	assign sche_type [6] 	= T_TT ;
	assign sche_len  [6] 	= 190 ;  // 3712 Bytes
	assign sche_type [7] 	= T_MAR ;
	assign sche_len  [7] 	= 95 ;	  // 1520 Bytes;
	
`else // just for functional simulation
	assign sche_type [0] 	= T_PCF ;
	assign sche_len  [0]	   = 1 ;
	assign sche_type [1] 	= T_TT ;
	assign sche_len  [1] 	= 4 ; 	
	assign sche_type [2] 	= T_DEF ;
	assign sche_len  [2] 	= 16 ; 
	assign sche_type [3] 	= T_MAR ;
	assign sche_len  [3] 	= 8 ;	// MTU 128B just for simu 
	assign sche_type [4] 	= T_TT ;
	assign sche_len  [4] 	= 4 ; 	
	assign sche_type [5] 	= T_DEF ;
	assign sche_len  [5] 	= 16 ; // 3712 Bytes -- defective config. -- no margin before TT
	assign sche_type [6] 	= T_TT ;
	assign sche_len  [6] 	= 6 ; 
	assign sche_type [7] 	= T_MAR ;
	assign sche_len  [7] 	= 8 ;	
`endif
		
	always @( posedge cnt_clk or negedge rst_n )
		if( !rst_n ) begin
			index <= 3'b000 ;
			cnt[ 11:4 ] <= sche_len [ 0 ]; // because unit 1 for 16B
			cnt[ 3:0 ] <= 4'b0000 ;			
		end
		else if ( !ena_n )
			if ( cnt == 0 ) begin	// switch to the next record
				cnt[ 11:4 ] <= sche_len [ index + 3'b001 ] ;
				// NOTE: very critical, "3'b001" denotes the length explictly,
				//       otherwise type cast will make index exceeds its length.
				index <= index + 3'd1 ;		
			end
			else cnt <= cnt - 12'd1 ;
		
	assign cur_state = sche_type [ index ] ;
	assign cur_value = cnt [ 11:4 ] ;
	
endmodule

///////////////////////////////////////////////////////////////////////////////

module cur_value_translator
(
	input [7:0] cur_value ,
	input [1:0] cur_state ,
	output reg [7:0] cnt_for_TT ,
	output reg [7:0] cnt_for_RC 
);
	parameter [1:0] T_PCF = 2'b10 ;
	parameter [1:0] T_TT  = 2'b11 ;
	parameter [1:0] T_MAR = 2'b01 ;	// margin before a TT or a PCF
	parameter [1:0] T_DEF = 2'b00 ; // default, porosity
	parameter [7:0] MTU_VAL = 7'd95 ; // 1520 Bytes -- for the MTU 1518 B
	
	// for TT
	always @ ( cur_state or cur_value )
		case( cur_state )
			T_TT : cnt_for_TT = cur_value ;
			default: cnt_for_TT = 0 ;
		endcase

	// for RC
	always @ ( cur_state or cur_value )	
		case( cur_state )
			T_MAR : cnt_for_RC = cur_value ;
			T_DEF : cnt_for_RC = MTU_VAL ;
			default : cnt_for_RC = 0 ;
		endcase
		
endmodule

///////////////////////////////////////////////////////////////////////////////

module q_server
#( parameter [1:0] PRIORITY = 2'b11  ) 
// 2'b00 -- PCF , 2'b01 -- TT, 2'b11 -- RC, 2'b10 -- BE 
(
   input [7:0] cur_value , 
   input [7:0] pkt_len ,
   input clk ,
   input ena_n ,
   input rst_n ,
   output reg bool_ready ,
   output reg bool_go 
);
	localparam  S_STOP = 1'b0, 
				S_GO = 1'b1 ;
	
	// Internal state variables
	reg state;
	reg next_state;
	
	always @( cur_value or pkt_len )
		if ( cur_value >= pkt_len ) bool_ready = 1'b1 ;
		else bool_ready = 1'b0 ;
	
	// State changes only at pos edge of clock
	always @( posedge clk or negedge rst_n )
		if ( !rst_n ) state <= S_STOP ;
		else state <= next_state;
	
	//State machine using case statements
	always @( state or ena_n or pkt_len )
		case ( state )
			S_STOP :
				if ( !ena_n ) next_state = S_GO ;
				else next_state = S_STOP ;
			S_GO :
				if ( ena_n ) next_state = S_STOP ;
				else if ( pkt_len == 0 ) next_state = S_STOP ;
				else next_state = S_GO ;
		endcase
		
	//Compute values
	always @( state )
		case ( state )
			S_STOP : bool_go = 1'b0 ;
			S_GO : bool_go = 1'b1 ;
		endcase	

endmodule

///////////////////////////////////////////////////////////////////////////////
module q_server_3_states
#( parameter [1:0] PRIORITY = 2'b11  ) 
// 2'b00 -- PCF , 2'b01 -- TT, 2'b11 -- RC, 2'b10 -- BE 
(
   input [7:0] cur_value , 
   input [7:0] pkt_len ,
   input clk ,
   input ena_n ,
   input rst_n ,
   output reg bool_ready ,
   output reg bool_go 
);
	localparam [1:0]  S_STOP  = 2'b00 ; 
	localparam [1:0]  S_GO    = 2'b11 ;
	localparam [1:0]  S_PAUSE = 2'b01 ;
	
	//以下为待补全
		reg state;
      reg next_state;
        
        always @( cur_value or pkt_len )
            if ( cur_value >= pkt_len ) bool_ready = 1'b1 ;
            else bool_ready = 1'b0 ;
        
        // State changes only at pos edge of clock
        always @( posedge clk or negedge rst_n )
            if ( !rst_n ) state <= S_STOP ;
            else state <= next_state;
        
        //State machine using case statements
        always @( state or ena_n or pkt_len )
            case ( state )
                S_STOP:
                    if(!ena_n) next_state = S_PAUSE;
                    else next_state = S_STOP;
                S_PAUSE :
                    if ( !ena_n ) next_state = S_GO ;
                    else next_state = S_STOP ;
                S_GO :
                    if ( ena_n ) next_state = S_STOP ;
                    else if ( pkt_len == 0 ) next_state = S_STOP ;
                    else next_state = S_GO ;
            endcase
            
        //Compute values
        always @( state )
            case ( state )
                S_STOP : bool_go = 1'b0 ;
                S_PAUSE : bool_go=1'b0;
                S_GO : bool_go = 1'b1 ;
            endcase    
    
endmodule

///////////////////////////////////////////////////////////////////////////////
module round_robin_FP
# ( parameter N = 2 )
(
	input clk ,
	input rst_n ,
	//
	input bool_ready_H ,
	input bool_go_H ,
	input [ N-1 : 0 ] bool_ready_L ,
	input [ N-1 : 0 ] bool_go_L ,
	//
	output reg ena_n_H ,
	output reg [ N-1 : 0 ] ena_n_L ,
	//
	output reg [1:0] active , // 00 - none, 01 - H, 10 - L
	output reg [3:0] channel 
);
	localparam [3:0] S_ACTIVE_H = 4'b0011 ;
	localparam [3:0] S_ACTIVE_L = 4'b1100 ;
	localparam [3:0] S_NONE = 4'b0000 ;
	localparam [3:0] S_WAIT_H = 4'b0001 ;
	localparam [3:0] S_WAIT_L = 4'b1000 ;

	localparam [1:0] A_H = 2'b01 ;
	localparam [1:0] A_L = 2'b10 ;
	localparam [1:0] A_NONE = 2'b00 ;

	reg [7:0] cnt_timeout ; // count down

`ifndef 	BOOL_JUST_FOR_SIMU
	localparam [7:0] VAL_TIMEOUT = 8'h80 ;  
`else
	localparam [7:0] VAL_TIMEOUT = 8'd8 ;
`endif
		
	reg [3:0] state ;
	reg [3:0] index_L ;
	
	integer i ;
	always @( posedge clk or negedge rst_n )
		if ( ! rst_n ) begin
			state <= S_NONE ;
			index_L <= 0 ;
			ena_n_H <= 1'b1 ;
			for ( i=0; i<N ; i=i+1 ) ena_n_L[i] <= 1'b1 ;
		end
		else begin
			case ( state )
			
            S_NONE: 
					if( bool_ready_H ) begin
						ena_n_H <= 1'b0 ;
						state <= S_WAIT_H ;
						cnt_timeout <= VAL_TIMEOUT ;
					end
					else if( bool_ready_L != 0 ) 
						if( bool_ready_L [ index_L ] ) begin
							ena_n_L [ index_L ] <= 1'b0 ;
							state <= S_WAIT_L ;
							cnt_timeout <= VAL_TIMEOUT ;
						end
						else begin
						  if( index_L == N-1 ) index_L <= 4'd0 ;
						  else index_L <= index_L + 4'd1 ;
						end 
					else state <= S_NONE;

            S_WAIT_H:if(bool_go_H) state <= S_ACTIVE_H;
                     else if(cnt_timeout == 0) 
								begin 
								ena_n_H <= 1'b1;
								state <= S_NONE;
								end
                     else
								begin
								cnt_timeout <= cnt_timeout -1;
								state <= S_WAIT_H;
								end
								
            S_ACTIVE_H:if(!bool_go_H)
								begin
								ena_n_H <= 1'b1;
								state<=S_NONE;
								end
								
            S_WAIT_L:if(bool_go_L[index_L]) state <= S_ACTIVE_H;
                     else if(cnt_timeout == 0)
							begin
								ena_n_L[index_L] <= 1'b1;
								if( index_L == N-1 ) index_L <= 4'd0 ;
								else index_L <= index_L + 4'd1 ;
								state<=S_NONE;
							end
                     else cnt_timeout <= cnt_timeout -1;
            S_ACTIVE_L:if(!bool_go_L[index_L])
								begin
									ena_n_L[index_L]  <= 1'b1;
									if( index_L == N-1 ) index_L <= 4'd0 ;
									else index_L <= index_L + 4'd1 ;
									state<=S_NONE;
								end
									
			endcase
		end
		
		always @( state )
			case ( state )
				S_ACTIVE_H: active <= A_H ;
				S_WAIT_H: 	active <= A_H ;
				S_ACTIVE_L:	active <= A_L ;
				S_WAIT_L:	active <= A_L ;
				S_NONE: 	active <= A_NONE ;
				default: active <= A_NONE ;
			endcase			
		
		always @( active or index_L )
			if ( active == A_H ) channel = 0 ;
			else if ( active == A_L ) channel = index_L ;
			else channel = 0 ;
endmodule
