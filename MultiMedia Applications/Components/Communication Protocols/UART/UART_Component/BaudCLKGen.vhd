----------------------------------------------------------------------------------
-- Engineer: 		 John Louma
-- 
-- Create Date:    14:47:08 01/25/2015 
-- Design Name: 		
-- Module Name:    BaudCLKGen - Behavioral 
-- Project Name: 
-- Target Devices: Virtex 5
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
use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BaudCLKGen is
    Port ( BaudSel : in  STD_LOGIC_VECTOR (2 downto 0);
			  RST : in STD_LOGIC;
           CLK : in  STD_LOGIC;
           BaudCLK : out  STD_LOGIC);
end BaudCLKGen;

architecture Behavioral of BaudCLKGen is

signal prevBaud : STD_LOGIC_VECTOR (2 downto 0);
signal goal, accumulator : unsigned (20 downto 0);
begin
	--master clock at 100 MHz
	process(CLK, RST)
		--variable goal, accumulator : integer range 0 to 1000000;
	begin
		if RST = '0' then
			accumulator <= to_unsigned(0,21);
			BaudCLK <= '0';
		else
			if rising_edge(CLK) then
				accumulator <= accumulator + 1;
				case BaudSel is
					when "000" => goal <= to_unsigned(5208,21);	--9600 baud
					when "001" => goal <= to_unsigned(2604,21);	--19200 baud
					when "010" => goal <= to_unsigned(1302,21);	--38400 baud
					when "011" => goal <= to_unsigned(868,21);	--57600 baud
					when "100" => goal <= to_unsigned(434,21);	--115200 baud
					when "101" => goal <= to_unsigned(217,21);	--230400 baud
					when "110" => goal <= to_unsigned(108,21);	--460800 baud
					when others => goal <= to_unsigned(54,21);	--921600 baud
				end case;
				
				if accumulator < goal then
					BaudCLK <= '0';
				elsif accumulator >= goal and accumulator <= (2 * goal) then		
					BaudCLK <= '1';
				else 
					accumulator <= to_unsigned(0,21);
				end if;
			end if;
		end if;
	end process;
end Behavioral;