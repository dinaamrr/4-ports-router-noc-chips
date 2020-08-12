
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity FIFO is
generic(
    dataw : integer := 7);
port( reset: in std_logic :='1';
      rclk,wclk: in std_logic;
		rreq,wreq: in std_logic;
		datain: in std_logic_vector(dataw downto 0);
		dataout: out std_logic_vector(dataw downto 0);
		empty,full: out std_logic);

end FIFO;

architecture struct of FIFO is
COMPONENT dualport IS 
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
	
	END COMPONENT dualport;
	FOR Mem: dualport USE ENTITY work.dualport(behave);

COMPONENT FIFOcontroller is
    generic(
    addrw : integer := 2);
    port( reset: in std_logic :='1';
          rdclk,wrclk: in std_logic;
			 rreq,wreq: in std_logic;
		    write_valid,read_valid: out std_logic;
		    wr_ptr,rd_ptr: out std_logic_vector( addrw downto 0);
		    empty,full: out std_logic);
     end component FIFOcontroller;
	FOR controller : FIFOcontroller USE ENTITY work.FIFOcontroller(Behavioral);

signal wr_addr,r_addr: std_logic_vector( 2 downto 0);
signal write_valid, read_valid, f,e : std_logic;
signal data_out: std_logic_vector(dataw downto 0);
BEGIN
	Mem: dualport
	PORT MAP(datain,wr_addr,r_addr,write_valid,read_valid,wclk,rclk,data_out);
dataout<=data_out;
	controller : FIFOcontroller
	PORT MAP(reset,rclk,wclk,rreq,wreq,write_valid,read_valid,wr_addr,r_addr,e,f);

empty <= e;
full <= f;



end struct;

