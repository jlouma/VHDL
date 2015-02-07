--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:09:55 01/23/2015
-- Design Name:   
-- Module Name:   C:/Users/jpl0102/Desktop/Independent Study/LCD Driver/LCD_Driver/Timer_TB.vhd
-- Project Name:  LCD_Driver
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Timer
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
 
ENTITY Timer_TB IS
END Timer_TB;
 
ARCHITECTURE behavior OF Timer_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Timer
    PORT(
         RST : IN  std_logic;
         CLK : IN  std_logic;
         Sel : IN  std_logic_vector(1 downto 0);
         TimeCount : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';
   signal Sel : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal TimeCount : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Timer PORT MAP (
          RST => RST,
          CLK => CLK,
          Sel => Sel,
          TimeCount => TimeCount
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
      wait for 30 ns;	
		Sel <= "00";
		wait for 30 ns; 
		RST <= '1';
      wait;
   end process;

END;
