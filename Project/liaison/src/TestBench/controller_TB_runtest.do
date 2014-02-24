SetActiveLib -work
comp -include "$dsn\src\controller.vhd" 
comp -include "$dsn\src\TestBench\controller_TB.vhd" 
asim TESTBENCH_FOR_controller 
wave 
wave -noreg di_ready
wave -noreg clk
wave -noreg reset
wave -noreg do_ready
wave -noreg control_signals
wave -noreg voted_data_selector
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\controller_TB_tim_cfg.vhd" 
# asim TIMING_FOR_controller 
