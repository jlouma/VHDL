--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:19:47 01/26/2015
-- Design Name:   
-- Module Name:   C:/Users/jpl0102/Desktop/Independent Study/Communication Protocols/UART/TXModule/TXModule_TB.vhd
-- Project Name:  TXModule
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TXModule
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
 
ENTITY TXModule_TB IS
END TXModule_TB;
 
ARCHITECTURE behavior OF TXModule_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TXModule
    PORT(
         TX_Buff : IN  std_logic_vector(7 downto 0);
         TX_Send : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic;
         TX : OUT  std_logic;
         TX_BUSY : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal TX_Buff : std_logic_vector(7 downto 0) := (others => '0');
   signal TX_Send : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal TX : std_logic;
   signal TX_BUSY : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 104.18 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TXModule PORT MAP (
          TX_Buff => TX_Buff,
          TX_Send => TX_Send,
          CLK => CLK,
          RST => RST,
          TX => TX,
          TX_BUSY => TX_BUSY
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
   TX_Proc: process
   begin		
		TX_Buff <= "00100100";
      wait for 200 ns;
		TX_Send <= '1';
		wait for 20 ns;
		if TX_BUSY = '1' then
			TX_Send <= '0';
		end if;
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
