-- include library
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

-- define entity four_bits_counter
entity four_bits_counter is
-- define ports
port (
    reset  : in  std_logic                    ;
    clk    : in  std_logic                    ;
    enable : in  std_logic                    ;
    pause  : in  std_logic                    ;
    q      : out std_logic_vector(3 downto 0)  
);
end;

-- architecture of four_bits_counter
architecture two_seg_arch of four_bits_counter is
-- declare internal signals
signal r_reg: unsigned(3 downto 0);     
signal r_next: unsigned(3 downto 0);

begin

-- register 
process(clk, reset) begin
    if (reset='1') then
        r_reg <= (others => '0');  
    elsif (clk'event and clk = '1') then  
        r_reg <= r_next; 
    end if;
end process;

-- next-state logic   
process(r_reg, enable, pause) begin
    if(enable = '1' and pause = '0') then
        if(r_reg = "1010") then
            r_next <= (others => '0');
        else
            r_next <= r_reg + 1;
        end if;
    else
        r_next <= r_reg; 
    end if;
end process;

-- output logic   
q <= std_logic_vector(r_reg);   

end;

