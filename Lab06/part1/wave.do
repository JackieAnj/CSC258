vlib work
vlog -timescale 1ns/1ns sequence_detector.v
vsim sequence_detector
log {/*}
add wave {/*}
force {SW[0]} 0 0, 1 2
run 4ns
#case 1
force {SW[1]} 1
force {KEY[0]} 1 0, 0 2
run 4ns
#case 2
force {SW[1]} 1
force {KEY[0]} 1 0, 0 2
run 4ns
#case 3
force {SW[1]} 0
force {KEY[0]} 1 0, 0 2
run 4ns
#case 4
force {SW[1]} 1
force {KEY[0]} 0 0, 1 2
run 4ns
#case 5
force {SW[1]} 1
force {KEY[0]} 0 0, 1 2
run 4ns
#case 6
force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 0 0, 1 2
run 4ns
#case 7
force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 1 0, 0 2
run 4ns
#case 8
force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 1 0, 0 2
run 4ns
#case 9
force {SW[1]} 1
force {KEY[0]} 1 0, 0 2
run 4ns
#case 10
force {SW[1]} 0
force {KEY[0]} 1 0, 0 2
run 4ns
#case 11
force {SW[1]} 0
force {KEY[0]} 1 0, 0 2
run 4ns
#case 12
force {SW[1]} 1
force {KEY[0]} 1 0, 0 2
run 4ns
#case 13
force {KEY[0]} 1 0, 0 2
run 4ns
#case 14
force {SW[1]} 0
force {KEY[0]} 1 0, 0 2
run 4ns
