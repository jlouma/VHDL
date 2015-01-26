----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:44:38 01/23/2015 
-- Design Name: 
-- Module Name:    Timer - Behavioral 
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
use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Timer is
    Port ( RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Sel : in  STD_LOGIC_VECTOR (1 downto 0);
			  TimeCount : out STD_LOGIC_VECTOR (15 downto 0));
end Timer;
architecture Behavioral of Timer is
signal tmpTimeCount: unsigned (15 downto 0):= (others => '0');
signal CLKCount,countThreshold: unsigned (31 downto 0) := (others => '0');
begin
	process(CLK, RST)
	begin
		if RST = '0' then --reset the timer
			tmpTimeCount <= (others => '0'); 
			CLKCount <= (others => '0'); 
			TimeCount <= (others => '0');
			if Sel = "00" then		--seconds
				countThreshold <= to_unsigned(100000000,32);
			elsif Sel = "01" then	--ms
				countThreshold <= to_unsigned(100000,32);
			elsif Sel = "10" then	--us
				countThreshold <= to_unsigned(100,32);
			else 							--10s of ns
				countThreshold <= to_unsigned(1,32);
			end if;
		else
			if rising_edge(CLK) then
					CLKCount <= CLKCount + 1;
					if CLKCount >= countThreshold-1 then 
						CLKCount <= (others => '0');
						tmpTimeCount <= tmpTimeCount + 1;
					end if;
				end if;
			end if;
		TimeCount <= std_logic_vector(tmpTimeCount);
	end process;

end Behavioral;

