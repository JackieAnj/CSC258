vlib work
vlog -timescale 1ns/1ns poly_function.v
vsim fpga_top
log {/*}
add wave {/*}
force {CLOCK_50} 0 0, 1 2 -repeat 4
force {KEY[0]} 0 0, 1 4
run 8ns
# case 1
force {SW[0]} 1 0, 0 20
force {SW[1]} 1 0, 0 20
force {SW[2]} 0 0, 1 20
force {SW[3]} 1 0, 0 20
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[1]} 0 0, 1 5 -repeat 10
force {CLOCK_50} 0 0, 1 2 -repeat 4
run 150ns
force {CLOCK_50} 0 0, 1 2 -repeat 4
force {KEY[0]} 0 0, 1 4
run 8ns
# case 2
force {SW[0]} 0 0, 1 20
force {SW[1]} 0 0, 1 20
force {SW[2]} 0 0, 1 20
force {SW[3]} 1 0, 0 20
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[1]} 0 0, 1 5 -repeat 10
force {CLOCK_50} 0 0, 1 2 -repeat 4
run 150ns

