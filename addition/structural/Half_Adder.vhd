-- include the used library
library ieee;
use ieee.std_logic_1164.all;

-- declare the entity half_adder
entity half_adder is
port (
    a    : in  std_logic ;
    b    : in  std_logic ;
    sum  : out std_logic ;
    cout : out std_logic  
);
end half_adder;

architecture arch_half_adder of half_adder is
begin

-- behavior of half_adder
sum <= a xor b;
cout <= a and b;

end arch_half_adder;

