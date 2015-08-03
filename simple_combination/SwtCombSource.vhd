library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SwtComb is port (

A: in std_logic;
B: in std_logic;
C: in std_logic;
D: in std_logic;
Y: out std_logic

); 
end SwtComb ;

Architecture behavioral of SwtComb is 
begin
process (A,B,C,D) begin 

Y <= (A AND NOT(B)) OR (NOT(C) AND D);

end process;
end behavioral;

