----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2015 12:21:16 PM
-- Design Name: 
-- Module Name: mux - Behavioral
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

-- defination of entity mux
entity mux is
-- defination of port of mux
Port ( 
    sel   : in  std_logic ;
    a     : in  std_logic ;
    b     : in  std_logic ;
    mux_o : out std_logic 
);
end mux;

architecture Behavioral of mux is

begin

-- behavior of mux
mux_o <= a when (sel = '0') else b after 5 ns;

end Behavioral;
