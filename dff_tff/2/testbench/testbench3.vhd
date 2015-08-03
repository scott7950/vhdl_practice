-- include library
library ieee;
use ieee.std_logic_1164.all;

-- define entity testbench3
entity testbench3 is
end testbench3;

-- architecture of testbench3
architecture arch_testbench3 of testbench3 is

-- component four_bits_counter
component four_bits_counter is
port (
    clear_n : in  std_logic                     ;
    clk     : in  std_logic                     ;
    enable  : in  std_logic                     ;
    q       : out std_logic_vector(3 downto 0)   
);
end component;

type counter_value_type is ARRAY(integer range 0 to 15) of std_logic_vector(3 downto 0);

-- declare internal signals
signal clear_n_sig : std_logic                    ;
signal clk_sig     : std_logic                    ;
signal enable_sig  : std_logic                    ;
signal q_sig       : std_logic_vector(3 downto 0) ;

signal exp_counter_value : counter_value_type ;

begin

-- instantiate four_bits_counter
uut: four_bits_counter port map (
    clear_n =>  clear_n_sig  ,
    clk     =>  clk_sig    ,
    enable  =>  enable_sig ,
    q       =>  q_sig       
);

-- generate clock
process 
variable i : integer;
begin
    clk_sig <= '0';
    wait for 10 ns;
    clk_sig <= '1';
    wait for 10 ns;
end process;

-- generate stimulus
process 
variable i : integer;
begin
    -- initialize input signal of uut
    enable_sig <= '1';

    -- clear_n the uut
    clear_n_sig <= '1';
    wait for 30 ns;
    clear_n_sig <= '0';
    wait for 30 ns;
    clear_n_sig <= '1';
    wait for 30 ns;

    -- normal counter for a whole loop and wrap
    for i in 0 to 20 loop
        wait until rising_edge(clk_sig);
    end loop;

    -- toggle enable
    for i in 0 to 100 loop
        wait until falling_edge(clk_sig);

        if(i = 10) then
            enable_sig <= '0';
        elsif(i = 20) then
            enable_sig <= '1';
        end if;
    end loop;

end process;

-- initialize expected counter value
exp_counter_value(0)  <= "0000" ;
exp_counter_value(1)  <= "0001" ;
exp_counter_value(2)  <= "0010" ;
exp_counter_value(3)  <= "0011" ;
exp_counter_value(4)  <= "0100" ;
exp_counter_value(5)  <= "0101" ;
exp_counter_value(6)  <= "0110" ;
exp_counter_value(7)  <= "0111" ;
exp_counter_value(8)  <= "1000" ;
exp_counter_value(9)  <= "1001" ;
exp_counter_value(10) <= "1010" ;
exp_counter_value(11) <= "1011" ;
exp_counter_value(12) <= "1100" ;
exp_counter_value(13) <= "1101" ;
exp_counter_value(14) <= "1110" ;
exp_counter_value(15) <= "1111" ;

--verifier
process
variable error_status: boolean;
variable i : integer;
begin
    i := 0;

    -- check counter for clear_n value
    wait until rising_edge(clear_n_sig);
    if q_sig /= exp_counter_value(i) then
        error_status := true;
    else
        error_status := false;
    end if;

    -- error reporting
    assert not error_status
    report "test failed."
    severity note; -- note, warning, error, failure. Failure aborts the simulation

    -- check counter
    while(true) loop
        -- check counter value
        wait until rising_edge(clk_sig);
        if q_sig /= exp_counter_value(i) then
            error_status := true;
        else
            error_status := false;
        end if;

        -- error reporting
        assert not error_status
        report "test failed."
        severity note; -- note, warning, error, failure. Failure aborts the simulation

        if(enable_sig = '1') then
            if(i = 15) then
                i := 0;
            else
                i := i + 1;
            end if;
        end if;
    end loop;
    wait;
end process;

end arch_testbench3;

