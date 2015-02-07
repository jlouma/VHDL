--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:38:19 01/27/2015
-- Design Name:   
-- Module Name:   C:/Users/jpl0102/Desktop/Independent Study-new/Communication Protocols/UART/UARTModule/UARTModule_TB.vhd
-- Project Name:  UARTModule
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UARTModule
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
 
ENTITY UARTModule_TB IS
END UARTModule_TB;
 
ARCHITECTURE behavior OF UARTModule_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UARTModule
    PORT(
         TX_BUFF : IN  std_logic_vector(7 downto 0);
         RX : IN  std_logic;
         BaudSel : IN  std_logic_vector(2 downto 0);
         TX_Send : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic;
         TX : OUT  std_logic;
         RX_BUFF : OUT  std_logic_vector(7 downto 0);
         TX_Busy : OUT  std_logic;
         RX_Busy : OUT  std_logic;
			TST_CLK : out STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal TX_BUFF : std_logic_vector(7 downto 0) := (others => '0');
   signal RX : std_logic := '0';
   signal BaudSel : std_logic_vector(2 downto 0) := (others => '0');
   signal TX_Send : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal TX : std_logic;
   signal RX_BUFF : std_logic_vector(7 downto 0);
   signal TX_Busy : std_logic;
   signal RX_Busy : std_logic;
	signal TST_CLK :std_logic;
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UARTModule PORT MAP (
          TX_BUFF => TX_BUFF,
          RX => RX,
          BaudSel => BaudSel,
          TX_Send => TX_Send,
          CLK => CLK,
          RST => RST,
          TX => TX,
          RX_BUFF => RX_BUFF,
          TX_Busy => TX_Busy,
          RX_Busy => RX_Busy,
			 TST_CLK => TST_CLK
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
   stimTX_proc: process
   begin		
		TX_Send <= '0';
      TX_BUFF <= "00100100";
      wait for 1.4 ms;	
		TX_Send <= '1';
		wait for 300 us;
		if TX_BUSY = '1' then
			TX_Send <= '0';
		end if;
      wait;
   end process;
	
	   -- Stimulus process
   stimRX_proc: process
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
