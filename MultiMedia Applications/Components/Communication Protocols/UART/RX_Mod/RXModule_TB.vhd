--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:57:19 01/27/2015
-- Design Name:   
-- Module Name:   C:/Users/jpl0102/Desktop/Independent Study-new/Communication Protocols/UART/RXModule/RXModule_TB.vhd
-- Project Name:  RXModule
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RXModule
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
 
ENTITY RXModule_TB IS
END RXModule_TB;
 
ARCHITECTURE behavior OF RXModule_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RXModule
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         BaudSel : IN  std_logic_vector(2 downto 0);
         RX : IN  std_logic;
         RX_Buff : OUT  std_logic_vector(7 downto 0);
         RX_Busy : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal BaudSel : std_logic_vector(2 downto 0) := (others => '0');
   signal RX : std_logic := '0';

 	--Outputs
   signal RX_Buff : std_logic_vector(7 downto 0);
   signal RX_Busy : std_logic;
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RXModule PORT MAP (
          CLK => CLK,
          RST => RST,
          BaudSel => BaudSel,
          RX => RX,
          RX_Buff => RX_Buff,
          RX_Busy => RX_Busy
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
   stim_proc1: process
   begin		
		BaudSel <= "000";
		RX <= '1';
		wait for 1 ms;
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
