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
begin

end liaison;
