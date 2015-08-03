-- include library
library ieee;
use ieee.std_logic_1164.all;

-- define entity tff
entity tff is 
-- define ports
port(  
    clk     : in  std_logic ;
    clear_n : in  std_logic ;
    t       : in  std_logic ;
    q       : out std_logic 
);
end tff;

-- architecture of tff
architecture dataflow of tff is 
-- component dff
component dff is
port (
    rst_n : in std_logic  ;
    clk   : in std_logic  ;
    d     : in std_logic  ;
    q     : out std_logic  
);
end component;

-- declare internal signals
signal q_reg  : std_logic ;
signal q_next : std_logic ;

begin    

-- instance dff 
u_dff: dff port map (
    rst_n => clear_n ,
    clk   => clk     ,
    d     => q_next  ,
    q     => q_reg    
);

-- next-state logic   
q_next <= q_reg when t = '0' else not q_reg;

-- output logic   
q <= q_reg;

end dataflow;

