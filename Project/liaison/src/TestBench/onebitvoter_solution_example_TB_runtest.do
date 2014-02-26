SetActiveLib -work
comp -include "$dsn\src\onebitvoter.vhd" 
comp -include "$dsn\src\TestBench\onebitvoter_solution_example_TB.vhd" 
asim TESTBENCH_FOR_onebitvoter 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg a
wave -noreg b
wave -noreg c
wave -noreg d
wave -noreg y
wave -noreg status
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\onebitvoter_solution_example_TB_tim_cfg.vhd" 
# asim TIMING_FOR_onebitvoter 
