-------------------------------------------------------------------------------
--
-- Title       : liaison
-- Design      : liaison
-- Author      : Ole Brumm
-- Company     : Hundremeterskogen Dataservice
--
-------------------------------------------------------------------------------
--
-- File        : liaison.vhd
-- Generated   : Mon Feb 24 11:08:09 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {liaison} architecture {liaison}}

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

--}} End of automatically maintained section

architecture liaison of liaison is
begin

	 -- enter your statements here --

end liaison;
