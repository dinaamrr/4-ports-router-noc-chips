
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity dualport is
  generic(
    addrw : integer := 2;
    dataw : integer := 7);
	port 
	(
		D_in	: in std_logic_vector(dataw downto 0);
		ADDRA	: in std_logic_vector(addrw downto 0);
		ADDRB	: in std_logic_vector(addrw downto 0);
		WEA		: in std_logic := '1';
		REA		: in std_logic := '1';
		CLKA	: in std_logic;
		CLKB	: in std_logic;
		D_out		: out std_logic_vector(dataw downto 0)
	);
	
end dualport; 
architecture behave of dualport is

	-- 2-D array
	type dblock is array(addrw downto 0) of std_logic_vector(dataw downto 0);
	
	-- Declare the RAM signal.
	signal temp : dblock;

begin

	process(CLKA)
	begin
		if(rising_edge(CLKA)) then 
			if(WEA = '1') then
				temp(conv_integer(ADDRA)) <= D_in;
			end if;
		end if;
	end process;
	
	process(CLKB)
	begin
		if(rising_edge(CLKB)) then
		  if(REA = '1') then
			D_out <= temp(conv_integer(ADDRB));
			else
			D_out <= (others=>'Z');
	   	end if;
		end if;
	end process;

end behave;
