
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity FIFOcontroller is
generic(
    addrw : integer := 2);
port( reset: in std_logic :='1';
      rdclk,wrclk: in std_logic;
		rreq,wreq: in std_logic;
		write_valid,read_valid: out std_logic;
		wr_ptr,rd_ptr: out std_logic_vector( addrw downto 0);
		empty,full: out std_logic);
end FIFOcontroller;

architecture Behavioral of FIFOcontroller is
component Gray_Counter IS 
 Port(Clock,Reset,En: IN std_logic; 
      Count_out:OUT std_logic_vector(3 downto 0)); 
End component Gray_Counter;
FOR writecount: Gray_Counter USE ENTITY work.Gray_Counter(Counter_Beh); 
FOR readcount: Gray_Counter USE ENTITY work.Gray_Counter(Counter_Beh); 
component GrayToBin is 
port
(
	G: in std_logic_vector (3 downto 0); -- G is the gray_in
	B: out std_logic_vector (3 downto 0) -- B is the bin_out
);
end component GrayToBin;
FOR writeG2B: GrayToBin USE ENTITY work.GrayToBin(behav); 
FOR readG2B : GrayToBin USE ENTITY work.GrayToBin(behav); 
signal WEN,REN: std_logic;
signal current_wr_ptr,current_rd_ptr: std_logic_vector(3 downto 0);
signal current_full,current_empty: std_logic;
signal wr,rd: std_logic_vector(3 downto 0);
begin
writecount: Gray_Counter
PORT MAP(wrclk,reset,wreq and not(current_full),current_wr_ptr);
readcount: Gray_Counter
PORT MAP(rdclk,reset,rreq and not(current_empty),current_rd_ptr);
writeG2B: GrayToBin
PORT MAP(current_wr_ptr,wr);
readG2B: GrayToBin
PORT MAP(current_rd_ptr,rd);
wr_ptr<=wr(addrw downto 0);
rd_ptr<=rd(addrw downto 0);
current_empty <= not((current_wr_ptr(3) xor current_rd_ptr(3))or(current_wr_ptr(2) xor current_rd_ptr(2))or(current_wr_ptr(1) xor current_rd_ptr(1))or(current_wr_ptr(0) xor current_rd_ptr(0))) ;
current_full <= (current_wr_ptr(3)xor current_rd_ptr(3)) and (current_wr_ptr(2)xor current_rd_ptr(2)) and not((current_wr_ptr(1) xor current_rd_ptr(1))or(current_wr_ptr(0) xor current_rd_ptr(0))) ;
full <=current_full;
empty <= current_empty;
write_valid<= wreq and not(current_full);
read_valid <= rreq and not(current_empty);
end Behavioral;

