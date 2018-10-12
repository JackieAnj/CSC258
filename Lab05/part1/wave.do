vlib work
vlog -timescale 1ns/1ns timer.v
vsim count
log {/*}
add wave {/*}
force {SW[0]} 0
run 5ns
#test 1
force {SW[0]} 1
force {SW[1]} 1 0, 0 10 -repeat 20
force {KEY[0]} 0 0, 1 1 -repeat 2
run 60ns



