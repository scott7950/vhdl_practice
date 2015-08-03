LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_arch OF testbench IS

COMPONENT SwtComb 
PORT (
A 	: in std_logic;
B 	: in std_logic;
C 	: in std_logic;
D 	: in std_logic;
Y 	: out std_logic
);
END COMPONENT;

--Signals to stimulate
SIGNAL a : std_logic := '0';
SIGNAL b : std_logic := '0';
SIGNAL c : std_logic := '0';
SIGNAL d : std_logic := '0';
SIGNAL y : std_logic := '0';

--UUT: unit under test
BEGIN
UUT : SwtComb 

PORT MAP (
A => a,
B => b,
C => c,
D => d,
Y => y
);
  
Proc_1: process
begin
a <= NOT a;
wait for 1 ns;
end process;

Proc_2: process
begin
b <= NOT b;
wait for 2 ns;
end process;

Proc_3: process
begin
c <= NOT c;
wait for 4 ns;
end process;

Proc_4: process
begin
d <= NOT d;
wait for 8 ns;
end process;

END testbench_arch;

