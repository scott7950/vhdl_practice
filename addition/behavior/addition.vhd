-- include the used library
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

-- declare entity addition
ENTITY addition IS
PORT (
    Num1       : in  std_logic_vector(3 downto 0);
    Num2       : in  std_logic_vector(3 downto 0);
    sum        : out std_logic_vector(3 downto 0);
    over_flow  : out std_logic;
    under_flow : out std_logic
);
END addition;

ARCHITECTURE arch_addition OF addition IS
signal res_tmp : INTEGER;
BEGIN

-- behavior of addition
add: PROCESS(Num1, Num2)
VARIABLE res : INTEGER;
BEGIN
    res := CONV_INTEGER(Num1) + CONV_INTEGER(Num2);
    res_tmp <= res;

    IF (res > 7) THEN
        over_flow <= '1';
    ELSE
        over_flow <= '0';
    END IF;

    IF (res < -8) THEN
        under_flow <= '1';
    ELSE
        under_flow <= '0';
    END IF;

    sum <= Conv_Std_Logic_Vector(res,4);
END PROCESS add;

END arch_addition;

