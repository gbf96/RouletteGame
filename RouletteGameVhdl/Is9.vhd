LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Is9 IS
    PORT (
        input : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
        S : OUT STD_LOGIC                 
    );
END Is9;

ARCHITECTURE behavior OF Is9 IS
BEGIN
    S <= (input(3) and not input(2) and not input(1) and not input(0));  
END behavior;