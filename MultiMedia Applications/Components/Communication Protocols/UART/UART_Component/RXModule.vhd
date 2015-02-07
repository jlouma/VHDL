----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:27:18 01/27/2015 
-- Design Name: 
-- Module Name:    RXModule - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RXModule is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           BaudSel : in  STD_LOGIC_VECTOR (2 downto 0);
           RX : in  STD_LOGIC;
           RX_Buff : out  STD_LOGIC_VECTOR (7 downto 0);
           RX_Busy : out  STD_LOGIC);
end RXModule;

architecture Behavioral of RXModule is
signal CLKGenRST, BaudCLK, last_RX, lastBaudCLK,tmp_Busy : STD_LOGIC;
signal bitNum : integer range 0 to 9;
signal Din : unsigned (7 downto 0);
begin
	BaudCLK1 : entity work.BaudCLKGen port map(
		BaudSel => BaudSel,
		RST => CLKGenRST,
		CLK => CLK,
		BaudCLK => BaudCLK);

	process(CLK,RST, RX, tmp_Busy, BaudCLK)
	begin
	if RST = '0' then
		CLKGenRST <= '0';
		RX_Buff <= (others => '0');
		RX_Busy <= '0';
		last_RX <= '1';
		tmp_Busy <= '0';
		lastBaudCLK <= '0';
		bitNum <= 0;
		Din <= (others => '0');
	else
		if rising_edge(CLK) then
			if tmp_Busy = '0' then	--no RX has been received
				if last_RX = '1' and RX = '0' then --stop bit received, start clocking
					tmp_Busy <= '1';
					CLKGenRST <= '1'; --start baud clk
				end if;
			else							--getting message
				if lastBaudCLK = '0' and BaudCLK = '1' then
					if bitNum < 9 then	--message and start bit (start bit gets thrown away)
						Din <= Din srl 1;
						Din(7) <= RX;
						bitNum <= bitNum + 1;
					elsif bitNum = 9 then						--stop bit
						CLKGenRST <= '0';
						RX_Buff <= std_logic_Vector(Din);
						tmp_Busy <= '0';
						bitNum <= 0;
					end if;
				end if;
			end if;
			last_RX <= RX;
			lastBaudCLK <= BaudCLK;
		end if;
	end if;
	RX_Busy <= tmp_Busy;
	end process;		
end Behavioral;