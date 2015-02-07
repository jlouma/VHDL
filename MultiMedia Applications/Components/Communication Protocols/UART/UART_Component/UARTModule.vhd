----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:10:50 01/27/2015 
-- Design Name: 
-- Module Name:    UARTModule - Behavioral 
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

entity UARTModule is
    Port ( TX_BUFF : in  STD_LOGIC_VECTOR (7 downto 0);
           RX : in  STD_LOGIC;
           BaudSel : in  STD_LOGIC_VECTOR (2 downto 0);
           TX_Send : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           TX : out  STD_LOGIC;
           RX_BUFF : out  STD_LOGIC_VECTOR (7 downto 0);
           TX_Busy : out  STD_LOGIC;
           RX_Busy : out  STD_LOGIC);
end UARTModule;

architecture Behavioral of UARTModule is
signal TX_CLK : STD_LOGIC;
begin
	TXCLKGEN : entity work.BaudCLKGen port map(
		BaudSel => BaudSel,
		RST => RST,
		CLK => CLK,
		BaudCLK => TX_CLK);
	TX_Mod : entity work.TXModule port map(
		TX_Buff => TX_BUFF,
		TX_Send => TX_Send,
		CLK => TX_CLK,
		RST => RST,
		TX => TX,
		TX_BUSY => TX_Busy);
	RX_Mod : entity work.RXModule port map(
		CLK => CLK,
		RST => RST,
		BaudSel => BaudSel,
		RX => RX,
		RX_Buff => RX_BUFF,
		RX_Busy => RX_Busy);
end Behavioral;

