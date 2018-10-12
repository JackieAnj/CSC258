vlib work
vlog -timescale 1ns/1ns reg_alu.v
vsim reg_alu
log {/*}
add wave {/*}

# Case 1
force {SW[9]} 1
force {KEY[0]} 0 0, 1 5 -repeat 10
force {SW[7:5]} 000
force {SW[3:0]} 0001
run 20 ns

# Case 2
force {SW[9]} 1
force {KEY[0]} 0 0, 1 5 
force {SW[7:5]} 001
force {SW[3:0]} 0010
run 10 ns

# Case 3
force {SW[9]} 1
force {KEY[0]} 0 0, 1 5 
force {SW[7:5]} 010
force {SW[3:0]} 0010
run 10 ns

# Case 4
force {SW[9]} 1
force {KEY[0]} 0 0, 1 5 
force {SW[7:5]} 011
force {SW[3:0]} 0010
run 10 ns

# Case 5
force {SW[9]} 1
force {KEY[0]} 0 0, 1 5 
force {SW[7:5]} 100
force {SW[3:0]} 0010
run 10 ns

# Case 6
force {SW[9]} 1
force {KEY[0]} 0 0, 1 5 
force {SW[7:5]} 101
force {SW[3:0]} 0010
run 10 ns

# Case 7
force {SW[9]} 1
force {KEY[0]} 0 0, 1 5 
force {SW[7:5]} 110
force {SW[3:0]} 0010
run 10 ns

# Case 8
force {SW[9]} 1 0, 0 10 
force {KEY[0]} 0 0, 1 5 
force {SW[7:5]} 111
force {SW[3:0]} 0010
run 20 ns





