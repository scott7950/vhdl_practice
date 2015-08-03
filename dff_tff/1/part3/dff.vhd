-- include library
library ieee;
use ieee.std_logic_1164.all;

-- define entity dff
entity dff is
-- define ports
port (
    rst_n : in std_logic  ;
    clk   : in std_logic  ;
    d     : in std_logic  ;
    q     : out std_logic  
);
end dff;

-- architecture of dff
architecture behavioral of dff is
begin

-- dff process
process(clk, rst_n) begin
    if(rst_n = '0') then
        q <= '0';
    elsif(clk'event and clk = '1') then
        q <= d;
    end if;
end process;

end behavioral;

