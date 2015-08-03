-- include the used library
library ieee;
use ieee.std_logic_1164.all;

-- declare the entity Two_Complement_Addition 
entity Two_Complement_Addition is
port (
    Num1       : in  std_logic_vector(3 downto 0);
    Num2       : in  std_logic_vector(3 downto 0);
    sum        : out std_logic_vector(3 downto 0);
    over_flow  : out std_logic;
    under_flow : out std_logic
);
end Two_Complement_Addition;

architecture arch_Two_Complement_Addition of Two_Complement_Addition is
-- declare the component half_adder
component half_adder
port (
    a    : in  std_logic ;
    b    : in  std_logic ;
    sum  : out std_logic ;
    cout : out std_logic  
);
end component;

-- declare the component full_adder
component full_adder
port (
    a    : in  std_logic ;
    b    : in  std_logic ;
    cin  : in  std_logic ;
    sum  : out std_logic ;
    cout : out std_logic  
);
end component;

signal c : std_logic_vector(3 downto 0);

begin

-- generate overflow and underflow
over_flow <= not(Num1(3) or Num2(3) or (not c(2)));
under_flow <= not((not Num1(3)) or (not Num2(3)) or c(2));

-- adder for bit 0 of sum
add0 : half_adder port map (
    a    => Num1(0) ,
    b    => Num2(0) ,
    sum  => sum(0)  ,
    cout => c(0) 
);

-- adder for bit 1 of sum
add1 : full_adder port map (
    a    => Num1(1) ,
    b    => Num2(1) ,
    cin  => c(0)    ,
    sum  => sum(1)  ,
    cout => c(1) 
);

-- adder for bit 2 of sum
add2 : full_adder port map (
    a    => Num1(2) ,
    b    => Num2(2) ,
    cin  => c(1)    ,
    sum  => sum(2)  ,
    cout => c(2) 
);

-- adder for bit 3 of sum
add3 : full_adder port map (
    a    => Num1(3) ,
    b    => Num2(3) ,
    cin  => c(2)    ,
    sum  => sum(3)  ,
    cout => c(3) 
);

end arch_Two_Complement_Addition;

