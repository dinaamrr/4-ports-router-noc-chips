library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity DeMUX1_4 is
    port
    (      
        Sel: in std_logic_vector(1 downto 0);
        En: in std_logic;
        d_in: in std_logic_vector(7 downto 0);
        d_out1, d_out2, d_out3, d_out4: out std_logic_vector(7 downto 0)
     );
end DeMUX1_4;

architecture DeMUX1to4 of DeMUX1_4 is

begin
process(En,Sel)
begin
  if (En = '1') then
   case Sel is
     when"00" => 
	  d_out1 <= d_in;
	  d_out2 <="00000000";
	  d_out3 <="00000000";
	  d_out4 <="00000000";
     when"01" => 
	  d_out2 <=  d_in;
	  d_out1 <="00000000";
	  d_out3 <="00000000";
	  d_out4 <="00000000";
     when"10" => 
	  d_out3 <=  d_in;
	  d_out1 <="00000000";
	  d_out2 <="00000000";
	  d_out4 <="00000000";
     when"11" => 
	  d_out4 <= d_in;
	  d_out1 <="00000000";
	  d_out2 <="00000000";
	  d_out3 <="00000000";
     when others =>
	  d_out1 <="00000000";
	  d_out2 <="00000000";
	  d_out3 <="00000000";
     d_out4 <="00000000";	  
	  end case;
  end if;
end process;
end DeMUX1to4;