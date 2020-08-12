LIBRARY ieee; 
USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;
 
Entity Gray_Counter IS 
 Port(Clock,Reset,En: IN std_logic; 
      Count_out:OUT std_logic_vector(3 downto 0)); 
End Entity Gray_Counter; 
 
Architecture Counter_Beh of Gray_Counter is 
  SIGNAL CS, NS, tmp, tmp_next: std_logic_vector (3 DOWNTO 0);
  Begin 
  process(Reset,Clock) is 
    Begin
    If(Reset ='1') then       --Asynchorouns Reset
        CS <= "0000";
    Elsif(rising_edge(Clock)) then 
        If(En = '1') then     
        CS <= NS;
      End if;
    End If;   
  End process; 

  tmp <= CS XOR ('0' & tmp(3 DOWNTO 1));
  tmp_next <= std_logic_vector(unsigned(tmp) + 1);
  NS <= tmp_next XOR ('0' & tmp_next(3 DOWNTO 1)); 
  Count_out <= CS;
End Counter_Beh;