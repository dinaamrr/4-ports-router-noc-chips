LIBRARY ieee; 
USE ieee.std_logic_1164.ALL; 
 
Entity RR_Schedular IS 
 Port(Clock: IN std_logic;
      din1, din2, din3, din4: IN std_logic_vector(7 downto 0); 
      dout: OUT std_logic_vector(7 downto 0)); 
End Entity RR_Schedular; 

ARCHITECTURE RR_Fsm OF RR_Schedular IS
  TYPE state IS (s1, s2, s3, s4);
  SIGNAL current_state: state:= s4;
  SIGNAL next_state: state:= s1;
BEGIN
  cs: PROCESS (Clock)
  BEGIN
    IF (rising_edge(Clock)) THEN
      current_state <= next_state;
    END IF;
  END PROCESS cs;
  
  ns: PROCESS (current_state)
  BEGIN
  CASE current_state IS
    WHEN s1 =>
      next_state <= s2;
      dout <= din1;
    WHEN s2 =>
      next_state <= s3;
      dout <= din2;
    WHEN s3 =>
      next_state <= s4;
      dout <= din3;
    WHEN s4 =>
      next_state <= s1;
      dout <= din4;  
  END CASE;
  END PROCESS ns;
END ARCHITECTURE RR_Fsm;