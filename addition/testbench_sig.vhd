library ieee;
use ieee.std_logic_1164.all;

use std.env.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture arch_testbench of testbench is

component ovrflo_undrflo 
--component ovrflo_undrflo_struct
PORT (
    Num1       : in  std_logic_vector(3 downto 0);
    Num2       : in  std_logic_vector(3 downto 0);
    sum        : out std_logic_vector(3 downto 0);
    over_flow  : out std_logic;
    under_flow : out std_logic
);
END component;

signal Num1_sig       : std_logic_vector(3 downto 0);
signal Num2_sig       : std_logic_vector(3 downto 0);
signal sum_sig        : std_logic_vector(3 downto 0);
signal over_flow_sig  : std_logic;
signal under_flow_sig : std_logic;

signal Num1_sig_ext   : signed(4 downto 0);
signal Num2_sig_ext   : signed(4 downto 0);
signal sum_ext        : signed(4 downto 0);
signal exp_sum        : std_logic_vector(3 downto 0);
signal exp_over_flow  : std_logic;
signal exp_under_flow : std_logic;

begin

uut : ovrflo_undrflo PORT map (
--uut : ovrflo_undrflo_struct PORT map (
    Num1       => Num1_sig       ,
    Num2       => Num2_sig       ,
    sum        => sum_sig        ,
    over_flow  => over_flow_sig  ,
    under_flow => under_flow_sig
);

process 
variable i, j: integer;
begin
    Num1_sig <= x"0";
    Num2_sig <= x"0";

    for i in 0 to 15 loop
        for j in 0 to 15 loop
            -- Num1_sig <= conv_std_logic_vector(i, Num1_sig'length);
            -- Num2_sig <= conv_std_logic_vector(j, Num2_sig'length);
            Num1_sig <= std_logic_vector(to_unsigned(i, Num1_sig'length));
            Num2_sig <= std_logic_vector(to_unsigned(j, Num2_sig'length));
            wait for 200 ns;
        end loop;
    end loop;

    finish(0);
end process;

--verifier
process
variable error_status: boolean;
begin
    wait on Num1_sig, Num2_sig;
    wait for 100 ns;

    Num1_sig_ext <= signed(Num1_sig(3) & Num1_sig);
    Num2_sig_ext <= signed(Num2_sig(3) & Num2_sig);

    wait for 0 ns;
    sum_ext <= Num1_sig_ext + Num2_sig_ext;

    wait for 0 ns;
    --exp_sum <= sum_ext(4) & sum_ext(2 downto 0);
    exp_sum <= std_logic_vector(sum_ext(3 downto 0));
    exp_over_flow <= (not sum_ext(4)) and sum_ext(3);
    exp_under_flow <= sum_ext(4) and (not sum_ext(3));

    wait for 0 ns;
    if (sum_sig /= exp_sum) or (over_flow_sig /= exp_over_flow) or (under_flow_sig /= exp_under_flow)
    then
        error_status := true;
    else
        error_status := false;
    end if;

    -- error reporting
    assert not error_status
    report "test failed."
    severity note; -- note, warning, error, failure. Failure aborts the simulation
end process;

end arch_testbench;

