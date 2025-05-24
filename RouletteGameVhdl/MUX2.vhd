library ieee;
use ieee.std_logic_1164.all;

entity MUX2 is 
    port(
        A : in  std_logic_vector(3 downto 0); 	
        B : in  std_logic_vector(3 downto 0);
        S : in  std_logic;  
        Y : out std_logic_vector(3 downto 0)                      
    );
end MUX2;

architecture behavioral of MUX2 is
begin
    Y(0) <= (A(0) and S) or (B(0) and not S);
    Y(1) <= (A(1) and S) or (B(1) and not S);
    Y(2) <= (A(2) and S) or (B(2) and not S);
    Y(3) <= (A(3) and S) or (B(3) and not S);
end behavioral;