library ieee;
use ieee.std_logic_1164.all;

entity MUX4 is 
    port(
        A: in std_logic_vector(3 downto 0);  
        S: in std_logic_vector(1 downto 0);  
        Y: out std_logic                     
    );
end MUX4;

architecture behavioral of MUX4 is
begin
    Y <= not ((A(0) and not S(1) and not S(0)) or 
             (A(1) and not S(1) and S(0)) or 
             (A(2) and S(1) and not S(0)) or 
             (A(3) and S(1) and S(0)));
end behavioral;
