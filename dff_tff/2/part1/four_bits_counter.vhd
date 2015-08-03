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
d(0) <= q_tmp(0) when pause = '1' else
        '0' when q_tmp = "1010" else
        not q_tmp(0);

-- register for d(0)
dff0: dff port map (
    reset  => reset    ,
    clk    => clk      ,
    enable => enable   ,
    d      => d(0)     ,
    q      => q_tmp(0)       
);

-- next-state logic for d(1)
d(1) <= q_tmp(1) when pause = '1' else 
        '0' when q_tmp = "1010" else
        not q_tmp(1) when q_tmp(0) = '1' else
        q_tmp(1);

-- register for d(1)
dff1: dff port map (
    reset  => reset    ,
    clk    => clk      ,
    enable => enable   ,
    d      => d(1)     ,
    q      => q_tmp(1)       
);

-- next-state logic for d(2)
d(2) <= q_tmp(2) when pause = '1' else
        '0' when q_tmp = "1010" else
        not q_tmp(2) when q_tmp(1 downto 0) = "11" else
        q_tmp(2);

-- register for d(2)
dff2: dff port map (
    reset  => reset    ,
    clk    => clk      ,
    enable => enable   ,
    d      => d(2)     ,
    q      => q_tmp(2)       
);

-- next-state logic for d(3)
d(3) <= q_tmp(3) when pause = '1' else
        '0' when q_tmp = "1010" else
        not q_tmp(3) when q_tmp(2 downto 0) = "111" else
        q_tmp(3);

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

