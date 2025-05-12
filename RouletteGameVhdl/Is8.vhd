LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Is8 IS
    PORT (
        input : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
        S : OUT STD_LOGIC                 
    );
END Is8;

ARCHITECTURE behavior OF Is8 IS
BEGIN
    S <= (not input(3) and input(2) and input(1) and input(0));  
END behavior;