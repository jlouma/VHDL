--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:27:17 01/23/2015
-- Design Name:   
-- Module Name:   C:/Users/jpl0102/Desktop/Independent Study/LCD Driver/LCD_Driver/LCDController_TB.vhd
-- Project Name:  LCD_Driver
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LCDController
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
 
ENTITY LCDController_TB IS
END LCDController_TB;
 
ARCHITECTURE behavior OF LCDController_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LCDController
    PORT(
         Din : IN  std_logic_vector(7 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         LCD_BUSY : OUT  std_logic;
			currentState : OUT std_logic_vector(3 downto 0);
         E : OUT  std_logic;
         RS : OUT  std_logic;
         RW : OUT  std_logic;
         D : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Din : std_logic_vector(7 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal LCD_BUSY : std_logic;
   signal E : std_logic;
   signal RS : std_logic;
   signal RW : std_logic;
   signal D : std_logic_vector(7 downto 0);
	signal currentState : std_logic_vector (3 downto 0);
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LCDController PORT MAP (
          Din => Din,
          RST => RST,
          CLK => CLK,
          LCD_BUSY => LCD_BUSY,
			 currentState => currentState,
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
   stim_proc: process
   begin		
      RST <= '0';
      wait for 400 ns;	
		RST <= '1';
      wait;
   end process;

END;
