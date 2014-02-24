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
signal voted_data_selector: STD_LOGIC_VECTOR (2 downto 0);

alias a is mp_data(0);
alias b is mp_data(1);
alias c is mp_data(2);
alias d is mp_data(3);

begin
	
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
			control_signals => control_signals
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
		status_out => status_out
		);
		
	ECC: entity	work.ECC
		port map(
		voted_data_out => voted_data_out,
		status_out => status_out,
		ECC_signal => ECC_signal
		);
		
	process(voted_data_selector)
	begin
		case voted_data_selector is
			when "000" =>
			voted_data <= voted_data_out(0);
			when "001" =>
			voted_data <= voted_data_out(1);
			when "010" =>
			voted_data <= voted_data_out(2);
			when "011" =>
			voted_data <= voted_data_out(3);
			when "100" =>
			voted_data <= voted_data_out(4);
			when "101" =>
			voted_data <= voted_data_out(5);
			when "110" =>
			voted_data <= voted_data_out(6);
			when "111" =>
			voted_data <= voted_data_out(7);
			when others =>
		end case;
	end process;

end liaison;
