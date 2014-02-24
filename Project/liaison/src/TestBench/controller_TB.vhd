library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity controller_tb is
end controller_tb;

architecture TB_ARCHITECTURE of controller_tb is
	-- Component declaration of the tested unit
	component controller
	port(
		di_ready : in STD_LOGIC;
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		do_ready : out STD_LOGIC;
		control_signals : out STD_LOGIC_VECTOR(9 downto 0);
		voted_data_selector : out STD_LOGIC_VECTOR(4 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal di_ready : STD_LOGIC := '0';
	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal do_ready : STD_LOGIC;
	signal control_signals : STD_LOGIC_VECTOR(9 downto 0);
	signal voted_data_selector : STD_LOGIC_VECTOR(4 downto 0);

	constant clock_period : time := 10 ns;
	-- Full output period is 19 cycles, but 1 must be used to set di_ready on and off,
	-- therefore 18 cycles are set.
	constant output_period : time := clock_period*18; 
	
	
	
	
	
begin

	-- Unit Under Test port map
	UUT : controller
		port map (
			di_ready => di_ready,
			clk => clk,
			reset => reset,
			do_ready => do_ready,
			control_signals => control_signals,
			voted_data_selector => voted_data_selector
		);

	-- Add your stimulus here ...
	CLOCK_SYNTHESIS : process
    begin
        clk <= '1';
        wait for clock_period/2;
        clk <= '0';
        wait for clock_period/2;
    end process;
	
	STIMULUS : process
	begin
	
		
	-- Initiating	
	reset <= '1';
	wait for clock_period*2;
	reset <= '0';
	wait for clock_period*2;
	-- Making sure that di_ready is set at falling_edge
	wait for 5 ns; 
	-- Test and implementation assumes that the inputs for di_ready and mp_data
	-- to liasion are set on their own, assumed to be falling_edge of clock here	
		
	-- BEGIN TEST
	
	-- Controller should do nothing while di_ready does nothing and stay 0
	wait for clock_period*5;
	
	-- Doing two run-throughs with both counters with a big intervall
	-- between, in order to ensure that do_ready and do_counter is depending
	-- on di_ready (and it's counter)
	
	di_ready <= '1'; 
	wait for clock_period;
	di_ready <= '0'; 
	wait for clock_period * 40;
	
	di_ready <= '1';
	wait for clock_period;
	di_ready <= '0';
	wait for clock_period * 40;
	
	-- Doing a third run-through.
	-- Multiple di_ready should not disturb the current ongoing process
	-- (though it should not happen)
	
	di_ready <= '1';
	wait for clock_period;
	di_ready <= '0';
	wait for clock_period * 8; 
	-- do_ready should have had a recent pulse at this time, 
	-- activating do_count and output-control.
	-- activating di_ready will should not have effect, due to already processing inputs
	-- but do_ready will pulse while the current output process is not done
	-- A such pulse should not have concequences (but should not happen).
	di_ready <= '1';
	wait for clock_period;
	di_ready <= '0';
	
	-- Waiting long in order to ensure that controller is idle for next test
	wait for clock_period * 40; 
	
	-- Now testing the control for as often outputs as possible.
	-- With current configuration, there are 8 voted data bits, 3 system status bits
    -- and 8 ECC/parity bits to be sent out. A total 19 bits, and thus
	
	-- Using time interval output_period (= clock_period * 19)
	
	-- A total of 5 tests. Afterwards, reset will be tested.
	
	-- 1
	di_ready <= '1';
	wait for clock_period;
	di_ready <='0';
	wait for output_period;
	-- 2
	di_ready <= '1';
	wait for clock_period;
	di_ready <='0';
	wait for output_period;
	-- 3
	di_ready <= '1';
	wait for clock_period;
	di_ready <='0';
	wait for output_period;
	-- 4
	di_ready <= '1';
	wait for clock_period;
	di_ready <='0';
	wait for output_period;
	-- 5
	di_ready <= '1';
	wait for clock_period;
	di_ready <='0';
	wait for output_period;
	
	-- Now testing reset
	
	-- Resetting while input is being dealt with
	di_ready <= '1';
	wait for clock_period;
	di_ready <='0';
	wait for clock_period*5;
	reset <= '1';
	wait for clock_period;
	reset <= '0';
	wait for clock_period*10;
	
	-- Resetting while output is being dealt with
	di_ready <= '1';
	wait for clock_period;
	di_ready <='0';
	wait for clock_period*18; -- Should be in middle of output
	reset <= '1';
	wait for clock_period;
	reset <= '0';
	wait for clock_period*10;
	
	-- TEST ENDS HEREbn 
		
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_controller of controller_tb is
	for TB_ARCHITECTURE
		for UUT : controller
			use entity work.controller(controller);
		end for;
	end for;
end TESTBENCH_FOR_controller;

