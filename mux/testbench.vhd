----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2015 12:26:25 PM
-- Design Name: 
-- Module Name: testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- defination of testbench
entity testbench is
end testbench;

architecture Behavioral of testbench is
-- declaration of mux as an component
component mux
Port ( 
    sel   : in  std_logic ;
    a     : in  std_logic ;
    b     : in  std_logic ;
    mux_o : out std_logic 
);
end component;

signal test_in  : std_logic_vector(2 downto 0) ;
signal test_out : std_logic                    ;

begin

-- instantiate mux
uut : mux Port map ( 
    sel   => test_in(0) ,
    a     => test_in(1) ,
    b     => test_in(2) ,
    mux_o => test_out  
);

-- test vector generator
process
begin

test_in <= "000";
wait for 200 ns;

test_in <= "001";
wait for 200 ns;

test_in <= "010";
wait for 200 ns;

test_in <= "011";
wait for 200 ns;

test_in <= "100";
wait for 200 ns;

test_in <= "101";
wait for 200 ns;

test_in <= "110";
wait for 200 ns;

test_in <= "111";
wait for 200 ns;

end process;

--verifier
process
variable error_status: boolean;
begin
    wait on test_in;
    wait for 100 ns;
    if ((test_in="000" and test_out = '0') or
    (test_in="001" and test_out = '0') or
    (test_in="010" and test_out = '1') or
    (test_in="011" and test_out = '0') or
    (test_in="100" and test_out = '0') or
    (test_in="101" and test_out = '1') or
    (test_in="110" and test_out = '1') or
    (test_in="111" and test_out = '1'))
    then
        error_status := false;
    else
        error_status := true;
    end if;
    -- error reporting
    assert not error_status
    report "test failed."
    severity note; -- note, warning, error, failure. Failure aborts the simulation
end process;

end Behavioral;
