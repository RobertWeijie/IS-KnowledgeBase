onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk /FPQ_test6b/clk
add wave -noupdate -label rst_n /FPQ_test6b/rst_n
add wave -noupdate -label cur_value_TT -radix hexadecimal /FPQ_test6b/cur_value_TT
add wave -noupdate -label bool_ready_H /FPQ_test6b/bool_ready_H
add wave -noupdate -label ena_n_H /FPQ_test6b/ena_n_H
add wave -noupdate -label bool_go_H /FPQ_test6b/bool_go_H
add wave -noupdate -label pkt_len_TT -radix hexadecimal /FPQ_test6b/uut_q_s_TT/pkt_len
add wave -noupdate -label {state @ q_s_TT} /FPQ_test6b/uut_q_s_TT/state
add wave -noupdate -label {next_state @ q_s_TT} /FPQ_test6b/uut_q_s_TT/next_state
add wave -noupdate -label cur_value_RC2 -radix hexadecimal /FPQ_test6b/cur_value_RC2
add wave -noupdate -label bool_ready_RC2 -radix hexadecimal /FPQ_test6b/bool_ready_RC2
add wave -noupdate -label ena_n_RC2 /FPQ_test6b/ena_n_RC2
add wave -noupdate -label bool_go_RC2 /FPQ_test6b/bool_go_RC2
add wave -noupdate -label pkt_len_RC2 -radix hexadecimal /FPQ_test6b/pkt_len_RC2
add wave -noupdate -label trig_RC /FPQ_test6b/trig_RC
add wave -noupdate -label index_L -radix hexadecimal /FPQ_test6b/uut_rr_FP/index_L
add wave -noupdate -label bool_ready_L /FPQ_test6b/bool_ready_L
add wave -noupdate -label ena_n_L /FPQ_test6b/ena_n_L
add wave -noupdate -label bool_go_L /FPQ_test6b/bool_go_L
add wave -noupdate -label {state @ rr_FP} /FPQ_test6b/uut_rr_FP/state
add wave -noupdate -label bool_no_confilict /FPQ_test6b/bool_no_confilict
add wave -noupdate -label active /FPQ_test6b/active
add wave -noupdate -label channel -radix hexadecimal /FPQ_test6b/channel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {13100000 ns} 0}
configure wave -namecolwidth 139
configure wave -valuecolwidth 51
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {9453100 ns} {14703100 ns}
