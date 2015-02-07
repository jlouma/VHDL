----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:04:18 01/27/2015 
-- Design Name: 
-- Module Name:    TerminalToLCD - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TerminalToLCD is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  --uart IO
           RX : in  STD_LOGIC;
           TX : out  STD_LOGIC;
			  --LCD IO
			  E : out STD_LOGIC;
			  RS : out STD_LOGIC;
			  RW : out STD_LOGIC;
			  D : out STD_LOGIC_VECTOR (7 downto 0)
			  );
end TerminalToLCD;

architecture Behavioral of TerminalToLCD is
signal RX_Buffer, LCD_Buffer: STD_LOGIC_VECTOR (7 downto 0);
signal TX_Buffer : unsigned (7 downto 0);
signal BaudSel : STD_LOGIC_VECTOR (2 downto 0);
signal UART_Send, LCD_Send,TX_Busy, RX_Busy, Last_RX_Busy, Last_TX_Busy, msg_received : STD_LOGIC;
begin
	UART_Mod : entity work.UARTModule port map (
		TX_BUFF => STD_LOGIC_VECTOR(TX_Buffer),
		RX => RX,
		BaudSel => BaudSel,
		TX_Send => UART_Send,
		CLK => CLK,
		RST => RST,
		TX => TX,
		RX_BUFF => RX_Buffer,
		TX_Busy => TX_Busy,
		RX_Busy => RX_Busy);
	LCD_Mod : entity work.LCDController port map (
		Din => LCD_Buffer,
		RST => RST,
		CLK => CLK,
		TX => LCD_Send,
		E => E,
		RS => RS,
		RW => RW,
		D=>D);
		process(CLK, RST)
		begin
			if RST = '0' then
				TX_Buffer <= (others => '0');
				LCD_Buffer <= (others => '0');
				BaudSel <= "000"; --9600 baud
				Last_RX_Busy <= '0';
				UART_Send <= '0'; 
				msg_received <= '0';
				Last_TX_Busy <= '0';
				LCD_Send <= '0';
			else
				if rising_edge(CLK) then
					if RX_Busy = '0' and Last_RX_Busy = '1' then -- message received
							msg_received <= '1';
							LCD_Buffer <= RX_Buffer;
							TX_Buffer <= unsigned(RX_Buffer) + 1;
							--TX_Buffer <= TX_Buffer + 1;
							UART_Send <= '1';
							LCD_Send <= '1';
					elsif msg_received = '1' then
						if TX_Busy = '0' and Last_TX_Busy = '1' then
							LCD_Send <= '0';
							UART_Send <= '0';
							msg_received <= '0';
						end if;
					end if;
					Last_RX_Busy <= RX_Busy;
					Last_TX_Busy <= TX_Busy;
				end if;
			end if;
		end process;
end Behavioral;

