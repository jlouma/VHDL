----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:01:59 01/23/2015 
-- Design Name: 
-- Module Name:    LCDController - Behavioral 
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
use IEEE.STD_LOGIC_MISC.ALL;
use IEEE.NUMERIC_STD.ALL;


entity LCDController is
    Port ( Din : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  TX : in STD_LOGIC;
           E : out  STD_LOGIC;
			  RS : out STD_LOGIC;
           RW : out  STD_LOGIC;
           D : out  STD_LOGIC_VECTOR (7 downto 0));
end LCDController;

architecture Behavioral of LCDController is
	signal state: unsigned (3 downto 0);
	signal screenAddress : unsigned (6 downto 0);
	signal currentStateTime : unsigned (15 downto 0);
	signal stateTimeVector : STD_LOGIC_VECTOR (15 downto 0);
	signal timeSel : STD_LOGIC_VECTOR (1 downto 0) := "01";
	signal timerRst : STD_LOGIC := '0';
	signal lastTX: STD_LOGIC;
begin
	TimeCounter1 : entity work.Timer port map(
		RST => timerRst,
		CLK => CLK,
		Sel => timeSel,
		TimeCount => stateTimeVector);
		
	process(CLK, RST)
	begin
		currentStateTime <= unsigned(stateTimeVector);
		if rising_edge(CLK) then
			if RST = '0' then
				E <= '0';
				RS <= '0';
				RW <= '0';
				D <= (others => '0');
				screenAddress <= (others => '0');
				state <= (others => '0');
				timeSel <= "01";
				timerRst <= '0';
				lastTX <= TX;
			else -- LCD operation
			timerRst <= '1'; 
				if state = 0 then --wait 40 ms
					if currentStateTime = to_unsigned(40, 16) then
						E <= '0';
						state <= state + 1;
						timerRst <= '0';
						timeSel <= "10";
					end if;
				elsif state = 1 then --function set instruction
					RS <= '0';
					RW <= '0';
					E <= '1';
					D <= "00111100";
					timerRst <= '0';
					state <= state+1; --next wait 40 us
				elsif state = 3 then -- display control instruction
					RS <= '0';
					RW <= '0';
					E <= '1';
					D <= "00001110";
					timerRst <= '0';
					state <= state+1; --next wait 40 us
				elsif state = 5 then --clear instruction
					RS <= '0';
					RW <= '0';
					E <= '1';
					D <= "00000001";
					timerRst <= '0';
					state <= state+1;
				elsif state = 6 then --wait 1.52 ms (1520 us)
					if currentStateTime = to_unsigned(1520, 16) then
						E <= '0';
						state <= state + 1;
						timerRst <= '0';
						timeSel <= "10";
					end if;
				elsif state = 7 then --entry mode instruction
					RS <= '0';
					RW <= '0';
					E <= '1';
					D <= "00000110";
					timerRst <= '0';
					state <= state+1; --wait 40 us
				elsif state = 9 then --display shift mode
					RS <= '0';
					RW <= '0';
					E <= '1';
					D <= "00010000";
					timerRst <= '0';
					state <= state+1;
				elsif state = 11 then --change a value for the screen
					RS <= '0';
					RW <= '0';
					E <= '1';
					D <= '1' & std_logic_vector(screenAddress);
					timerRst <= '0';
					state <= state+1;
					if screenAddress = "0001111" then --if at the end of the first row
						screenAddress <= "0101000"; --change to second row
					elsif screenAddress = "0110111" then --if at the end of the second row
						screenAddress <= (others => '0'); --reset back to beginning
					else 
						screenAddress <= screenAddress + 1;
					end if;
				elsif state = 13 then --normal operation wait for a write
					if (TX = '1' and lastTX = '0') then
						RS <= '1';
						RW <= '0';
						--D <= "00100100"; --test $
						D <= Din; --final
						E <= '1';
						timerRst <= '0';
						state <= state+1;
					end if;
					lastTX <= Tx;
				else --wait 40 us 
					if currentStateTime = to_unsigned(50, 16) then
						E <= '0';
						if state = 14 then
							state <= "1011"; -- state 11
						else 
							state <= state + 1;
						end if;
						timerRst <= '0';
						timeSel <= "10";
					end if;
				end if;
			end if;
		end if;
	end process;
end Behavioral;