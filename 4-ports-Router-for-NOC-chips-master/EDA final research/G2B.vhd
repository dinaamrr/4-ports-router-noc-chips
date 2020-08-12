library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity GrayToBin is 
port
(
	G: in std_logic_vector (3 downto 0); -- G is the gray_in
	B: out std_logic_vector (3 downto 0) -- B is the bin_out
);
end GrayToBin;

architecture behav of GrayToBin is

begin 

B(3) <= G(3);
B(2) <= G(3) xor G(2);
B(1) <= G(3) xor G(2) xor G(1);
B(0) <= G(3) xor G(2) xor G(1) xor G(0);

end behav;



