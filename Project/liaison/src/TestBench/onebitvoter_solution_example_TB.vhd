library ieee;
use ieee.std_logic_1164.all;

entity onebitvoter_solution_example_tb is
end onebitvoter_solution_example_tb;

architecture TB_ARCHITECTURE of onebitvoter_solution_example_tb is
	signal clk : std_logic := '0';
	signal reset : std_logic;
	signal data_in : std_logic_vector(3 downto 0);
	signal y : std_logic;
	signal status : std_logic_vector (2 downto 0);
	
	type testvec_t is array(0 to 1, 0 to 8) of std_logic_vector(7 downto 0);
	
	constant testvec : testvec_t := ((
		--   input  & y   & status
		0 => "1111" & "1" & "000",
		1 => "1111" & "1" & "000",
		2 => "0000" & "0" & "000",
		3 => "0100" & "0" & "001",	-- First fail.
		4 => "1000" & "0" & "010",	-- Second fail.
		5 => "0011" & "1" & "010",
		6 => "1100" & "0" & "010",
		7 => "1110" & "0" & "111",	-- Third fail.
		8 => "1111" & "0" & "111"
	),(
		--   input  & y   & status
		0 => "0000" & "0" & "000",
		1 => "0000" & "0" & "000",
		2 => "1111" & "1" & "000",
		3 => "1110" & "1" & "001",	-- First fail.
		4 => "1101" & "1" & "010",	-- Second fail.
		5 => "0011" & "0" & "010",
		6 => "1100" & "1" & "010",
		7 => "1000" & "0" & "111",	-- Third fail.
		8 => "1111" & "0" & "111"
	));
	
begin
	-- Change this to your entity and architecture name.
	dut: entity onebitvoter
		port map (
			clk => clk, reset => reset,
			a => data_in(3), b => data_in(2), c => data_in(1), d => data_in(0),
			y => y, status => status
		);
		
	clk <= not clk after 5ns;
	
	process is begin
		for i in testvec'range(1) loop
			-- Reset:
			reset <= '1';
			wait until falling_edge(clk);
			reset <= '0';
			
			for j in testvec'range(2) loop
				-- Update inputs.
				data_in <= testvec(i, j)(7 downto 4);
				-- Wait one clock cycle, then check ouputs.
				wait until falling_edge(clk);
				assert y = testvec(i, j)(3) report "Output 'y' wrong at vector " & integer'image(i) & ", " & integer'image(j) severity error;
				assert status = testvec(i, j)(2 downto 0) report "Output 'status' wrong at vector " & integer'image(i) & ", " & integer'image(j) severity error;
			end loop;
		end loop;
		
		wait; -- Testbench completed.
	end process;
end architecture;