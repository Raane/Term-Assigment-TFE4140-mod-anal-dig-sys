library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity ecc_tb is
end ecc_tb;

architecture TB_ARCHITECTURE of ecc_tb is
	-- Component declaration of the tested unit
	component ecc
	port(
		voted_data_out : in STD_LOGIC_VECTOR(7 downto 0);
		status_out : in STD_LOGIC_VECTOR(2 downto 0);
		ECC_signal : out STD_LOGIC_VECTOR(3 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal voted_data_out : STD_LOGIC_VECTOR(7 downto 0);
	signal status_out : STD_LOGIC_VECTOR(2 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ECC_signal : STD_LOGIC_VECTOR(3 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : ecc
		port map (
			voted_data_out => voted_data_out,
			status_out => status_out,
			ECC_signal => ECC_signal
		);

	
-- Add aliases for easiers treatment of data
--alias a is voted_data_out(0);
--alias b is voted_data_out(1);
--alias c is voted_data_out(2);
--alias d is voted_data_out(3);
--alias e is voted_data_out(4);	
--alias f is voted_data_out(5);
--alias g is voted_data_out(6);
--alias h is voted_data_out(7);
--alias i is status_out(0);
--alias j is status_out(1);
--alias k is status_out(2);
--
--begin					
--	                     0     1     1     0     0     0     0	  0
--		ECC_signal(0) <= a xor b xor d xor e xor g xor i xor k; --parity1
--						 0	   0	 1	   1	 0	   1	 0	  1
--		ECC_signal(1) <= a xor c xor d xor f xor g xor j xor k; --parity2
--    	                 1     0     1     1     0     1     0	  0
--		ECC_signal(2) <= b xor c xor d xor h xor i xor j xor k; --parity3
-- 						 0     1     0     1     0     1     0	  1
--		ECC_signal(3) <= e xor f xor g xor h xor i xor j xor k; --parity4

process is 
begin											 
	
	-- Expected values:
	-- ECC_signal(0) = 0 xor 0 xor 0 xor 0 xor 0 xor 0 xor 0 = 0
	-- ECC_signal(1) = 0 xor 0 xor 0 xor 0 xor 0 xor 0 xor 0 = 0
	-- ECC_signal(2) = 0 xor 0 xor 0 xor 0 xor 0 xor 0 xor 0 = 0
	-- ECC_signal(3) = 0 xor 0 xor 0 xor 0 xor 0 xor 0 xor 0 = 0
	voted_data_out <= "00000000";
	status_out <= "000";
	
	wait for 10 ns;
	
	-- Expected values:
	-- ECC_signal(0) = 1 xor 1 xor 1 xor 1 xor 1 xor 1 xor 1 = 1
	-- ECC_signal(1) = 1 xor 1 xor 1 xor 1 xor 1 xor 1 xor 1 = 1
	-- ECC_signal(2) = 1 xor 1 xor 1 xor 1 xor 1 xor 1 xor 1 = 1
	-- ECC_signal(3) = 1 xor 1 xor 1 xor 1 xor 1 xor 1 xor 1 = 1
	voted_data_out <= "11111111";
	status_out <= "111";
	
	wait for 10 ns;
	
	-- Expected values:
	-- ECC_signal(0) = 0 xor 1 xor 1 xor 0 xor 0 xor 0 xor 0 = 0
	-- ECC_signal(0) = 0 xor 0 xor 1 xor 1 xor 0 xor 1 xor 0 = 1
	-- ECC_signal(0) = 1 xor 0 xor 1 xor 1 xor 0 xor 1 xor 0 = 0
	-- ECC_signal(0) = 0 xor 1 xor 0 xor 1 xor 0 xor 1 xor 0 = 1
	voted_data_out <= "10101010";
	status_out <= "010";
	
	wait for 10 ns;
	
	wait;
	
end process;	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_ecc of ecc_tb is
	for TB_ARCHITECTURE
		for UUT : ecc
			use entity work.ecc(ecc);
		end for;
	end for;
end TESTBENCH_FOR_ecc;

