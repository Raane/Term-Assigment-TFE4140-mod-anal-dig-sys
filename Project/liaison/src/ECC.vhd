library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ECC is
	 port(
		 voted_data_out : in STD_LOGIC_VECTOR(7 downto 0);
		 status_out : in STD_LOGIC_VECTOR(2 downto 0);
		 ECC_signal : out STD_LOGIC_VECTOR(3 downto 0) := "0000"
	     );
end ECC;

architecture ECC of ECC is

-- Add aliases for easiers treatment of data
alias a is voted_data_out(0);
alias b is voted_data_out(1);
alias c is voted_data_out(2);
alias d is voted_data_out(3);
alias e is status_out(0);
alias f is status_out(1);
alias g is status_out(2);

begin

end ECC;