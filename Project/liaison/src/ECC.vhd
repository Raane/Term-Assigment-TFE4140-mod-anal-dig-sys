-------------------------------------------------------------------------------
--
-- Title       : ECC
-- Design      : liaison
-- Author      : Ole Brumm
-- Company     : Hundremeterskogen Dataservice
--
-------------------------------------------------------------------------------
--
-- File        : ECC.vhd
-- Generated   : Mon Feb 24 15:00:59 2014
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
--{entity {ECC} architecture {ECC}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ECC is
	 port(
		 voted_data_bus_out : in STD_LOGIC_VECTOR(7 downto 0);
		 status_bus_out : in STD_LOGIC_VECTOR(2 downto 0);
		 ECC : out STD_LOGIC_VECTOR(7 downto 0)
	     );
end ECC;

--}} End of automatically maintained section

architecture ECC of ECC is
begin

	 -- enter your statements here --

end ECC;
