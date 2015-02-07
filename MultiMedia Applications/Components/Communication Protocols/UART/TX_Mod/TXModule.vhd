----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:55:56 01/26/2015 
-- Design Name: 
-- Module Name:    TXModule - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TXModule is
    Port ( TX_Buff : in  STD_LOGIC_VECTOR (7 downto 0);
           TX_Send : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           TX : out  STD_LOGIC;
           TX_BUSY : out  STD_LOGIC);
end TXModule;

architecture Behavioral of TXModule is
signal lastTX_Send, busy :STD_LOGIC;
signal Din : unsigned (7 downto 0);
signal bitNum : integer range 0 to 10;
begin
	process(CLK, RST, TX_Send)
	begin
		if RST = '0' then
			TX <= '1';
			TX_BUSY <= '0';
			busy <= '0';
			bitNum <= 0;
			Din <= (others => '0');
		else
			if rising_edge(CLK) then
				if TX_Send = '1' and lastTX_Send = '0' then --begin transmit
					Din <= unsigned(TX_Buff);				--get buffer data
					TX_BUSY <= '1';
					busy <= '1';
					lastTX_Send <= '0';
				end if;
				if busy = '1' then
					if bitNum = 0 then --transmit begin
						TX <= '0';
						bitNum <= bitNum + 1;
					elsif bitNum = 9 then --send stop bit reset
						TX <= '1';
						bitNum <= 0;
						busy <= '0';
						TX_BUSY <= '0';
					else 					--transmit bits
						TX <= Din(0);
						bitNum <= bitNum + 1;
						Din <= Din srl 1;
					end if;
				end if;
			end if;
		end if;
		lastTX_Send <= TX_Send;
	end process;
end Behavioral;

