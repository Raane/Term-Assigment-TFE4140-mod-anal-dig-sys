library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ECC is
	 port(
		 voted_data_out : in STD_LOGIC_VECTOR(7 downto 0);
		 status_out : in STD_LOGIC_VECTOR(2 downto 0);
		 ECC_signal : out STD_LOGIC_VECTOR(7 downto 0) := "00000000"
	     );
end ECC;

architecture ECC of ECC is

alias a is voted_data_out(0);
alias b is voted_data_out(1);
alias c is voted_data_out(2);
alias d is voted_data_out(3);
alias e is voted_data_out(4);
alias f is voted_data_out(5);
alias g is voted_data_out(6);
alias h is voted_data_out(7);
alias i is status_out(0);
alias j is status_out(1);
alias k is status_out(2);

begin

	--process (a,b,c,d,e,f,g,h,i,j,k)
	--begin
	--end process;
	
end ECC;
