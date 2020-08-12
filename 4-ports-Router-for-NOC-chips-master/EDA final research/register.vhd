library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg8 is
    Port ( Data_in : in  STD_LOGIC_vector(7 downto 0);
           Clock : in  STD_LOGIC;
           Clock_En : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Data_out : out STD_LOGIC_vector(7 downto 0));
end reg8;

architecture Behavioral of reg8 is
--Signal temp: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
begin
process(Clock,Reset)
begin
if Reset = '1' then
Data_out <= (others => '0');
  elsif (Clock'event and Clock='1') then
    if(Clock_En='1') then
	 Data_out <= Data_in;
	 end if;
end if;
end process;

end Behavioral;