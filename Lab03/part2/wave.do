vlib work
vlog -timescale 1ns/1ns fulladder.v
vsim add
log {/*}
add wave {/*}

# Test 1
# Number: 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
# Number: 0
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
# Output: 3 (0011)
# Outside carry
force {SW[8]} 0
run 5ns

# Test 2
# Number: 5
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
# Number: 2
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 0
# Output: 7 (0111)
# Outside carry
force {SW[8]} 0
run 5ns

# Test 3
# Number: 7
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
# Number: 1
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 1
# Output: 3 (1000)
# Outside carry
force {SW[8]} 0
run 5ns

# Test 4
# Number: 8
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
# Number: 7
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
# Output: 15 (1111)
# Outside carry
force {SW[8]} 0
run 5ns

# Test 5
# Number: 15
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
# Number: 1
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 1
# Output: 0 (0000)
# Outside carry
force {SW[8]} 0
run 5ns

# Test 6
# Number: 15
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
# Number: 1
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
# Output: 14 (1110)
# Outside carry
force {SW[8]} 0
run 5ns
