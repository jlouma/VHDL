--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:25:42 01/28/2015
-- Design Name:   
-- Module Name:   C:/Users/jpl0102/Desktop/Independent Study-new/Applications/Terminal_To_LCD/TerminalToLCD_TB.vhd
-- Project Name:  Terminal_To_LCD
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TerminalToLCD
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TerminalToLCD_TB IS
END TerminalToLCD_TB;
 
ARCHITECTURE behavior OF TerminalToLCD_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TerminalToLCD
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         RX : IN  std_logic;
         TX : OUT  std_logic;
         E : OUT  std_logic;
         RS : OUT  std_logic;
         RW : OUT  std_logic;
         D : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal RX : std_logic := '0';

 	--Outputs
   signal TX : std_logic;
   signal E : std_logic;
   signal RS : std_logic;
   signal RW : std_logic;
   signal D : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TerminalToLCD PORT MAP (
          CLK => CLK,
          RST => RST,
          RX => RX,
          TX => TX,
          E => E,
          RS => RS,
          RW => RW,
          D => D
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
   -- Stimulus process
   stim_procRX: process
   begin		
		RX <= '1';
		wait for 45 ms;
		RX <= '0'; -- start bit
		wait for 104 us;
		RX <= '0';
		wait for 104 us;
		RX <= '0';
		wait for 104 us;
		RX <= '1';
		wait for 104 us;
		RX <= '0';
		wait for 104 us;
		RX <= '0';
		wait for 104 us;
		RX <= '1';
		wait for 104 us;
		RX <= '0';
		wait for 104 us;
		RX <= '0';
		wait for 104 us;
		RX <= '1';
		wait for 104 us;
		wait;
   end process;


   -- Stimulus process
   stim_proc: process
   begin		
      RST <= '0';
      wait for 100 ns;	
		RST <= '1';
      wait;
   end process;

END;
