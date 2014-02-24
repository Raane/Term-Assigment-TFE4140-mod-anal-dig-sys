library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity controller is
	 port(
		 di_ready : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 control_signals : out STD_LOGIC_VECTOR (8 downto 0)
	     );
end controller;

architecture controller of controller is
	-- Counter is used to control when to activate do_ready
	signal counter: integer range 0 to 50; 
begin
	
	-- Reset sets all to 0

end controller;
