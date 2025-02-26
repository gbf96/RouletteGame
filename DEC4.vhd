library ieee;
use ieee.std_logic_1164.all;

entity DEC4 is 
    port(
        S: in std_logic_vector(1 downto 0);  
        Y: out std_logic_vector(3 downto 0);                     
    );
end DEC4;

architecture behavioral of DEC4 is
begin
    Y(3) <= not(S(1) and S(0));
	 Y(2) <= not(S(1) and not S(0));
	 Y(1) <= not(not S(1) and S(0));
	 Y(0) <= not(not S(1) and not S(0));
end behavioral;
