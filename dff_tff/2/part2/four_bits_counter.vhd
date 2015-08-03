-- include library
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

-- define entity four_bits_counter
entity four_bits_counter is
-- define ports
port (
    reset   : in  std_logic                    ;
    clk     : in  std_logic                    ;
    enable  : in  std_logic                    ;
    pause   : in  std_logic                    ;
    inc_dec : in  std_logic                    ;
    q       : out std_logic_vector(3 downto 0)  
);
end;

-- architecture of four_bits_counter
architecture two_seg_arch of four_bits_counter is
-- declare internal signals
signal d    : std_logic_vector(3 downto 0);     
signal q_tmp: std_logic_vector(3 downto 0);     

component dff is
-- define ports
port (
    reset  : in std_logic  ;
    clk    : in std_logic  ;
    enable : in std_logic  ;
    d      : in std_logic  ;
    q      : out std_logic  
);
end component;

begin

-- next-state logic for d(0)
process(q_tmp, pause, inc_dec) begin
    if(pause = '1') then
        d(0) <= q_tmp(0);
    elsif(inc_dec = '1') then
        if(q_tmp = "1010") then
            d(0) <= '0';
        else
            d(0) <= not q_tmp(0);
        end if;
    else
        if(q_tmp = x"0") then
            d(0) <= '0';
        else
            d(0) <= not q_tmp(0);
        end if;
    end if;
end process;

-- register for d(0)
dff0: dff port map (
    reset  => reset    ,
    clk    => clk      ,
    enable => enable   ,
    d      => d(0)     ,
    q      => q_tmp(0)       
);

-- next-state logic for d(1)
process(q_tmp, pause, inc_dec) begin
    if(pause = '1') then
        d(1) <= q_tmp(1);
    elsif(inc_dec = '1') then
        if(q_tmp = "1010") then
            d(1) <= '0';
        elsif(q_tmp(0) = '1') then
            d(1) <= not q_tmp(1);
        else
            d(1) <= q_tmp(1);
        end if;
    else
        if(q_tmp = x"0") then
            d(1) <= '1';
        elsif(q_tmp(0) = '0') then
            d(1) <= not q_tmp(1);
        else
            d(1) <= q_tmp(1);
        end if;
    end if;
end process;

-- register for d(1)
dff1: dff port map (
    reset  => reset    ,
    clk    => clk      ,
    enable => enable   ,
    d      => d(1)     ,
    q      => q_tmp(1)       
);

-- next-state logic for d(2)
process(q_tmp, pause, inc_dec) begin
    if(pause = '1') then
        d(2) <= q_tmp(2);
    elsif(inc_dec = '1') then
        if(q_tmp = "1010") then
            d(2) <= '0';
        elsif(q_tmp(1 downto 0) = "11") then
            d(2) <= not q_tmp(2);
        else
            d(2) <= q_tmp(2);
        end if;
    else
        if(q_tmp = x"0") then
            d(2) <= '0';
        elsif(q_tmp(1 downto 0) = "00") then
            d(2) <= not q_tmp(2);
        else
            d(2) <= q_tmp(2);
        end if;
    end if;
end process;


-- register for d(2)
dff2: dff port map (
    reset  => reset    ,
    clk    => clk      ,
    enable => enable   ,
    d      => d(2)     ,
    q      => q_tmp(2)       
);

-- next-state logic for d(3)
process(q_tmp, pause, inc_dec) begin
    if(pause = '1') then
        d(3) <= q_tmp(3);
    elsif(inc_dec = '1') then
        if(q_tmp = "1010") then
            d(3) <= '0';
        elsif(q_tmp(2 downto 0) = "111") then
            d(3) <= not q_tmp(3);
        else
            d(3) <= q_tmp(3);
        end if;
    else
        if(q_tmp = x"0") then
            d(3) <= '1';
        elsif(q_tmp(2 downto 0) = "000") then
            d(3) <= not q_tmp(3);
        else
            d(3) <= q_tmp(3);
        end if;
    end if;
end process;

-- register for d(3)
dff3: dff port map (
    reset  => reset    ,
    clk    => clk      ,
    enable => enable   ,
    d      => d(3)     ,
    q      => q_tmp(3)       
);

-- output logic   
q <= q_tmp;

end;

