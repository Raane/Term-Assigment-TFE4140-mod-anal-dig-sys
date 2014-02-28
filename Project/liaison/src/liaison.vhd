library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity liaison is
	 port(
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 di_ready : in STD_LOGIC;
		 mp_data : in STD_LOGIC_VECTOR(3 downto 0);
		 do_ready : out STD_LOGIC;
		 voted_data : out STD_LOGIC
	     );
end liaison;

architecture liaison of liaison is

signal voted_data_bit: STD_LOGIC;
signal status: STD_LOGIC_VECTOR (2 downto 0);
signal control_signals: STD_LOGIC_VECTOR (9 downto 0);
signal ECC_signal: STD_LOGIC_VECTOR(7 downto 0);
signal voted_data_out: STD_LOGIC_VECTOR (7 downto 0);
signal status_out: STD_LOGIC_VECTOR (2 downto 0);
signal ECC_out: STD_LOGIC_VECTOR (7 downto 0);
signal voted_data_selector: STD_LOGIC_VECTOR (4 downto 0);

-- Declare aliases for the input votes
alias a is mp_data(0);
alias b is mp_data(1);
alias c is mp_data(2);
alias d is mp_data(3);

begin
	-- Add all entities to the top level
	onebitvoter: entity work.onebitvoter
		port map(
		clk => clk,
		reset => reset,
		a => a,
		b => b,
		c => c,
		d => d,
		y => voted_data_bit,
		status => status
	);
	
	controller: entity work.controller
		port map(
		clk => clk,
		reset => reset,
		di_ready => di_ready,
		do_ready => do_ready,
		control_signals => control_signals,
		voted_data_selector => voted_data_selector
		);
		
	registers: entity work.registers
		port map(
		clk => clk,
		reset => reset,
		voted_data_bit => voted_data_bit,
		status => status,
		control_signals => control_signals,
		ECC_signal => ECC_signal,
		voted_data_out => voted_data_out,
		status_out => status_out,
		ECC_out => ECC_out
		);
		
	ECC: entity	work.ECC
		port map(
		voted_data_out => voted_data_out,
		status_out => status_out,
		ECC_signal => ECC_signal
		);
		
    -- End of entity declarations

    -- Add a process for the mux that will control the serial output from liaison
	process(voted_data_selector, voted_data_out, status_out, ECC_out)
	begin
		case voted_data_selector is
			when "00000" =>	-- 00
				voted_data <= voted_data_out(0);
			when "00001" =>	-- 01
				voted_data <= voted_data_out(1);
			when "00010" => -- 02
				voted_data <= voted_data_out(2);
			when "00011" =>	-- 03
				voted_data <= voted_data_out(3);
			when "00100" =>	-- 04
				voted_data <= voted_data_out(4);
			when "00101" =>	-- 05
				voted_data <= voted_data_out(5);
			when "00110" =>	-- 06
				voted_data <= voted_data_out(6);
			when "00111" =>	-- 07
				voted_data <= voted_data_out(7);
			when "01000" =>	-- 08
				voted_data <= status_out(0);								  
			when "01001" =>	-- 09
				voted_data <= status_out(1);
			when "01010" =>	-- 10
				voted_data <= status_out(2);
			when "01011" =>	-- 11
				voted_data <= ECC_out(0);
			when "01100" =>	-- 12
				voted_data <= ECC_out(1);
			when "01101" =>	-- 13
				voted_data <= ECC_out(2);
			when "01110" =>	-- 14
				voted_data <= ECC_out(3);
			when "01111" =>	-- 15
				voted_data <= ECC_out(4);
			when "10000" =>	-- 16
				voted_data <= ECC_out(5);
			when "10001" =>	-- 17
				voted_data <= ECC_out(6);
			when "10010" =>	-- 18
				voted_data <= ECC_out(7);
			when others =>
				voted_data <= '-'; -- should not be reached, but useful to detect glitches
		end case;				   -- when implementing and perfecting output throughput
	end process;

end liaison;
