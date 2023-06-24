onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk /FPQ_test4/clk
add wave -noupdate -label rst_n /FPQ_test4/rst_n
add wave -noupdate -label cur_value -radix hexadecimal /FPQ_test4/cur_value
add wave -noupdate -label pkt_len -radix hexadecimal /FPQ_test4/pkt_len
add wave -noupdate -label bool_ready /FPQ_test4/bool_ready
add wave -noupdate /FPQ_test4/shifter1
add wave -noupdate /FPQ_test4/shifter2
add wave -noupdate -label bool_go /FPQ_test4/bool_go
add wave -noupdate -label {index @ uut_q_Q16} -radix hexadecimal /FPQ_test4/uut_q_Q16/index
add wave -noupdate -label {cnt @ uut_q_Q16} -radix hexadecimal /FPQ_test4/uut_q_Q16/cnt
add wave -noupdate -label {reg_go @ uut_q_Q16} /FPQ_test4/uut_q_Q16/reg_go
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4475000 ns} 0}
configure wave -namecolwidth 166
configure wave -valuecolwidth 79
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
WaveRestoreZoom {0 ns} {1312600 ns}
