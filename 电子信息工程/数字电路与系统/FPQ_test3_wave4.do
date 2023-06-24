onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /FPQ_test3/clk
add wave -noupdate /FPQ_test3/rst_n
add wave -noupdate -radix hexadecimal /FPQ_test3/pkt_len
add wave -noupdate /FPQ_test3/bool_go
add wave -noupdate -label {cnt @ uut_q_Q16} -radix hexadecimal /FPQ_test3/uut_q_Q16/cnt
add wave -noupdate -radix hexadecimal /FPQ_test3/uut_q_Q16/index
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1712000 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 62
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
WaveRestoreZoom {0 ns} {10500 us}
