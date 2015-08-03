-- include the used library
library ieee;
use ieee.std_logic_1164.all;

-- declare the entity full_adder 
entity full_adder is
port (
    a    : in  std_logic ;
    b    : in  std_logic ;
    cin  : in  std_logic ;
    sum  : out std_logic ;
    cout : out std_logic  
);
end full_adder;

architecture arch_full_adder of full_adder is
-- declare the component half_adder
component half_adder
port (
    a    : in  std_logic ;
    b    : in  std_logic ;
    sum  : out std_logic ;
    cout : out std_logic  
);
end component;

signal sum_tmp : std_logic;
signal cout1   : std_logic;
signal cout2   : std_logic;

begin

-- generate the cout
cout <= cout1 or cout2;

-- use half adder to add a and b
u_half_adder0 : half_adder port map (
    a    => a       ,
    b    => b       ,
    sum  => sum_tmp ,
    cout => cout1     
);

-- use half adder to add the sum of a and b, and cin
u_half_adder1 : half_adder port map (
    a    => sum_tmp ,
    b    => cin     ,
    sum  => sum     ,
    cout => cout2     
);

end arch_full_adder;

