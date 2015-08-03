-- include library
library ieee;
use ieee.std_logic_1164.all;

-- define entity dff
entity dff is
-- define ports
port (
    reset  : in std_logic  ;
    clk    : in std_logic  ;
    enable : in std_logic  ;
    d      : in std_logic  ;
    q      : out std_logic  
);
end dff;

-- architecture of dff
architecture behavioral of dff is
begin

-- dff process
process(clk, reset) begin
    if(reset = '1') then
        q <= '0';
    elsif(clk'event and clk = '1') then
        if(enable = '1') then
            q <= d;
        end if;
    end if;
end process;

end behavioral;

