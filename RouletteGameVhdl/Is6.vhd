LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Is6 IS
    PORT (
        input : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
        S : OUT STD_LOGIC                 
    );
END Is6;

ARCHITECTURE behavior OF Is6 IS
BEGIN
    S <= (input(2) AND input(1) AND NOT input(0));  
END behavior;