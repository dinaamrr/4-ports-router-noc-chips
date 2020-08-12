----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:58:30 05/20/2020 
-- Design Name: 
-- Module Name:    router - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity router is
generic( n : integer :=7);
port( datai1,datai2,datai3,datai4: in std_logic_vector(n downto 0);
      reset,wclk,rclk,wr1,wr2,wr3,wr4: in std_logic;
		datao1,datao2,datao3,datao4: out std_logic_vector(n downto 0));
end router;

architecture Behavioral of router is
component reg8 is
    Port ( Data_in : in  STD_LOGIC_vector(7 downto 0);
           Clock : in  STD_LOGIC;
           Clock_En : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Data_out : out STD_LOGIC_vector(7 downto 0));
end component reg8;
FOR reg1: reg8 USE ENTITY work.reg8(Behavioral);
FOR reg2: reg8 USE ENTITY work.reg8(Behavioral);
FOR reg3: reg8 USE ENTITY work.reg8(Behavioral);
FOR reg4: reg8 USE ENTITY work.reg8(Behavioral);
component DeMUX1_4 is
    port
    (      
        Sel: in std_logic_vector(1 downto 0);
        En: in std_logic;
        d_in: in std_logic_vector(7 downto 0);
        d_out1, d_out2, d_out3, d_out4: out std_logic_vector(7 downto 0)
     );
end component DeMUX1_4;
FOR mux1: DeMUX1_4 USE ENTITY work.DeMUX1_4(DeMUX1to4);
FOR mux2: DeMUX1_4 USE ENTITY work.DeMUX1_4(DeMUX1to4);
FOR mux3: DeMUX1_4 USE ENTITY work.DeMUX1_4(DeMUX1to4);
FOR mux4: DeMUX1_4 USE ENTITY work.DeMUX1_4(DeMUX1to4);
component FIFO is
generic(
    dataw : integer := 7);
port( reset: in std_logic :='1';
      rclk,wclk: in std_logic;
		rreq,wreq: in std_logic;
		datain: in std_logic_vector(dataw downto 0);
		dataout: out std_logic_vector(dataw downto 0);
		empty,full: out std_logic);

end component FIFO;
FOR 	FIFO1: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO2: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO3: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO4: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO5: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO6: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO7: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO8: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO9: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO10: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO11: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO12: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO13: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO14: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO15: FIFO USE ENTITY work.FIFO(struct);
FOR 	FIFO_16: FIFO USE ENTITY work.FIFO(struct);
component RR_Schedular IS 
 Port(Clock: IN std_logic;
      din1, din2, din3, din4: IN std_logic_vector(7 downto 0); 
      dout: OUT std_logic_vector(7 downto 0)); 
End component RR_Schedular; 
FOR 	RR1: RR_Schedular USE ENTITY work.RR_Schedular(RR_Fsm);
FOR 	RR2: RR_Schedular USE ENTITY work.RR_Schedular(RR_Fsm);
FOR 	RR3: RR_Schedular USE ENTITY work.RR_Schedular(RR_Fsm);
FOR 	RR4: RR_Schedular USE ENTITY work.RR_Schedular(RR_Fsm);

signal Data_out1,Data_out2,Data_out3,Data_out4: STD_LOGIC_vector(7 downto 0);--reg outputs & demux inputs
signal Demux_out1,Demux_out2,Demux_out3,Demux_out4,Demux_out11,Demux_out12,Demux_out13,Demux_out14,Demux_out21,Demux_out22,Demux_out23,Demux_out24,Demux_out31,Demux_out32,Demux_out33,Demux_out34: STD_LOGIC_vector(7 downto 0);--demux outputs
signal EM,FULL,EM1,FULL1,EM2,FULL2,EM3,FULL3,EM4,FULL4,EM5,FULL5,EM6,FULL6,EM7,FULL7,EM8,FULL8,EM9,FULL9,EM10,FULL10,EM11,FULL11,EM12,FULL12,EM13,FULL13,EM14,FULL14,EM15,FULL15,EM16,FULL16: std_logic;
signal FIFOout1,FIFOout2,FIFOout3,FIFOout4,FIFOout5,FIFOout6,FIFOout7,FIFOout8,FIFOout9,FIFOout10,FIFOout11,FIFOout12,FIFOout13,FIFOout14,FIFOout15,FIFOout16:STD_LOGIC_vector(7 downto 0);--FIFO outputs
signal sel1,sel2,sel3,sel4:  std_logic_vector(1 downto 0);
signal allowread: std_logic_vector(3 downto 0);
signal nextt: std_logic_vector(3 downto 0);
signal write1,write2,write3,write4,write5,write6,write7,write8,write9,write10,write11,write12,write13,write14,write15,write16:std_logic;
signal w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16:std_logic;
signal r:std_logic;
signal sync,nsync: std_logic_vector(1 downto 0);
begin
reg1: reg8
PORT MAP(datai1,wclk,wr1,reset,Data_out1);
reg2: reg8
PORT MAP(datai2,wclk,wr2,reset,Data_out2);
reg3: reg8
PORT MAP(datai3,wclk,wr3,reset,Data_out3);
reg4: reg8
PORT MAP(datai4,wclk,wr4,reset,Data_out4);
--demux
sel1<=Data_out1(1 downto 0);
sel2<=Data_out2(1 downto 0);
sel3<=Data_out3(1 downto 0);
sel4<=Data_out4(1 downto 0);
w1<= not(FULL) and (not(sel1(1) or sel1(0)))  and wr1;
w2<= not(FULL1)  and not(sel2(1) or sel2(0))  and wr2;
w3<= not(FULL2) and not(sel3(1) or sel3(0))  and wr3;
w4<= not(FULL3)  and not(sel4(1) or sel4(0))  and wr4;
w5<=not(FULL4)  and (not(sel1(1)) and sel1(0)) and wr1 ;
w6<=not(FULL5)  and (not(sel2(1)) and sel2(0)) and wr2 ;
w7<=not(FULL6)  and (not(sel3(1)) and sel3(0)) and wr3 ;
w8<=not(FULL7)  and (not(sel4(1)) and sel4(0)) and wr4 ;
w9<=not(FULL8)  and (not(sel1(0)) and sel1(1)) and wr1 ;
w10<=not(FULL9) and (not(sel2(0)) and sel2(1)) and wr2;
w11<=not(FULL10)  and (not(sel3(0)) and sel3(1)) and wr3;
w12<=not(FULL11) and (not(sel4(0)) and sel4(1)) and wr4;
w13<=not(FULL12)  and (sel1(1) and sel1(0)) and wr1 ;
w14<=not(FULL13) and (sel2(1) and sel2(0)) and wr2;
w15<=not(FULL14) and (sel3(1) and sel3(0)) and wr3;
w16<=not(FULL15) and (sel4(1) and sel4(0)) and wr4 ;
mux1: DeMUX1_4
PORT MAP(sel1,wr1,Data_out1,Demux_out1,Demux_out2,Demux_out3,Demux_out4);
mux2: DeMUX1_4
PORT MAP(sel2,wr2,Data_out2,Demux_out11,Demux_out12,Demux_out13,Demux_out14);
mux3: DeMUX1_4
PORT MAP(sel3,wr3,Data_out3,Demux_out21,Demux_out22,Demux_out23,Demux_out24);
mux4: DeMUX1_4
PORT MAP(sel4,wr4,Data_out4,Demux_out31,Demux_out32,Demux_out33,Demux_out34);
--FIFO
FIFO1: FIFO
PORT MAP(reset,rclk,wclk,not(EM) and allowread(0) ,w1 ,Demux_out1,FIFOout1,EM,FULL);
FIFO2: FIFO
PORT MAP(reset,rclk,wclk,not(EM1) and allowread(1),w2,Demux_out11,FIFOout2,EM1,FULL1);
FIFO3: FIFO
PORT MAP(reset,rclk,wclk,not(EM2) and allowread(2),w3,Demux_out21,FIFOout3,EM2,FULL2);
FIFO4: FIFO
PORT MAP(reset,rclk,wclk,not(EM3) and allowread(3),w4,Demux_out31,FIFOout4,EM3,FULL3);
FIFO5: FIFO
PORT MAP(reset,rclk,wclk,not(EM4) and allowread(0),w5,Demux_out2,FIFOout5,EM4,FULL4);
FIFO6: FIFO
PORT MAP(reset,rclk,wclk,not(EM5)and allowread(1),w6,Demux_out12,FIFOout6,EM5,FULL5);
FIFO7: FIFO
PORT MAP(reset,rclk,wclk,not(EM6)and allowread(2),w7,Demux_out22,FIFOout7,EM6,FULL6);
FIFO8: FIFO
PORT MAP(reset,rclk,wclk,not(EM7)and allowread(3),w8,Demux_out32,FIFOout8,EM7,FULL7);
FIFO9: FIFO
PORT MAP(reset,rclk,wclk,not(EM8)and allowread(0),w9,Demux_out3,FIFOout9,EM8,FULL8);
FIFO10: FIFO
PORT MAP(reset,rclk,wclk,not(EM9)and allowread(1),w10,Demux_out13,FIFOout10,EM9,FULL9);
FIFO11: FIFO
PORT MAP(reset,rclk,wclk,not(EM10)and allowread(2),w11,Demux_out23,FIFOout11,EM10,FULL10);
FIFO12: FIFO
PORT MAP(reset,rclk,wclk,not(EM11)and allowread(3),w12,Demux_out33,FIFOout12,EM11,FULL11);
FIFO13: FIFO
PORT MAP(reset,rclk,wclk,not(EM12)and allowread(0),w13 ,Demux_out4,FIFOout13,EM12,FULL12);
FIFO14: FIFO
PORT MAP(reset,rclk,wclk,not(EM13)and allowread(1),w14,Demux_out14,FIFOout14,EM13,FULL13);
FIFO15: FIFO
PORT MAP(reset,rclk,wclk,not(EM14)and allowread(2),w15,Demux_out24,FIFOout15,EM14,FULL14);
FIFO_16: FIFO
PORT MAP(reset,rclk,wclk,not(EM15)and allowread(3),w16,Demux_out34,FIFOout16,EM15,FULL15);
--RR
RR1: RR_Schedular
port map(rclk,FIFOout1,FIFOout2,FIFOout3,FIFOout4,datao1);
RR2: RR_Schedular
port map(rclk,FIFOout5,FIFOout6,FIFOout7,FIFOout8,datao2);
RR3: RR_Schedular
port map(rclk,FIFOout9,FIFOout10,FIFOout11,FIFOout12,datao3);
RR4: RR_Schedular
port map(rclk,FIFOout13,FIFOout14,FIFOout15,FIFOout16,datao4);

 p1:PROCESS (reset,rclk)
  BEGIN
  if(reset='1') then
  allowread<="0100";
  else IF (rising_edge(rclk)) THEN
   allowread <= nextt;
	end if;
	end if;
	end process;
	
 p2:PROCESS (allowread )
 begin
    CASE allowread IS
    WHEN "0001" =>
       nextt<="0010";
    WHEN "0010"=>
      nextt<= "0100";
    WHEN "0100" =>
      nextt<= "1000";
    WHEN "1000" =>
      nextt<= "0001";
	 when others => 
	 nextt<= "0001";
  END CASE;
  END PROCESS;
end Behavioral;

