vlib work
vlog -timescale 1ns/1ns morse.v
vsim morse
log {/*}
add wave {/*}
force {KEY[0]} 1
force {SW[9]} 1
run 1ns
# test 1 S
force {CLOCK_50} 0 0, 1 2 -repeat 4
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[1]} 1 0, 0 3
force {KEY[0]} 0 0, 1 1
run 34ns

# test 2 Z
force {CLOCK_50} 0 0, 1 2 -repeat 4
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[1]} 1 0, 0 3
force {KEY[0]} 0 0, 1 1
run 34ns
