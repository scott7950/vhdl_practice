-- include library
library ieee;
use ieee.std_logic_1164.all;

-- define entity four_bits_counter
entity four_bits_counter is
-- define ports
port (
    clear_n : in  std_logic                     ;
    clk     : in  std_logic                     ;
    enable  : in  std_logic                     ;
    q       : out std_logic_vector(3 downto 0)   
);
end entity;

-- architecture of four_bits_counter
architecture dataflow of four_bits_counter is
-- compoment tff
component tff is 
port(  
    clk     : in  std_logic ;
    clear_n : in  std_logic ;
    t       : in  std_logic ;
    q       : out std_logic 
);
end component;

-- declare internal signals
signal t_sig : std_logic_vector(3 downto 0) ;
signal q_sig : std_logic_vector(3 downto 0) ;

begin

-- generate t_sig(0)
t_sig(0) <= enable;
-- instantiate tff to generate q_sig(0)
q0: tff port map (  
    clk     => clk      ,
    clear_n => clear_n    ,
    t       => t_sig(0) ,
    q       => q_sig(0)  
);

-- generate t_sig(1)
t_sig(1) <= q_sig(0) and t_sig(0);
-- instantiate tff to generate q_sig(1)
q1: tff port map (  
    clk     => clk      ,
    clear_n => clear_n    ,
    t       => t_sig(1) ,
    q       => q_sig(1)  
);

-- generate t_sig(2)
t_sig(2) <= q_sig(1) and t_sig(1);
-- instantiate tff to generate q_sig(2)
q2: tff port map (  
    clk     => clk      ,
    clear_n => clear_n    ,
    t       => t_sig(2) ,
    q       => q_sig(2)  
);

-- generate t_sig(3)
t_sig(3) <= q_sig(2) and t_sig(2);
-- instantiate tff to generate q_sig(3)
q3: tff port map (  
    clk     => clk      ,
    clear_n => clear_n    ,
    t       => t_sig(3) ,
    q       => q_sig(3)  
);

-- output logic   
q <= q_sig;

end dataflow;

