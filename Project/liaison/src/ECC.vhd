library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ECC is
	 port(
		 voted_data_out : in STD_LOGIC_VECTOR(7 downto 0);
		 status_out : in STD_LOGIC_VECTOR(2 downto 0);
		 ECC : out STD_LOGIC_VECTOR(7 downto 0)
	     );
end ECC;

architecture ECC of ECC is
begin

end ECC;
