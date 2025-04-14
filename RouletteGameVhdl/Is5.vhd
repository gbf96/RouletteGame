LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Is5 IS
    PORT (
        input : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
        S : OUT STD_LOGIC                 
    );
END Is5;

ARCHITECTURE behavior OF Is5 IS
BEGIN
    S <= (input(2) AND NOT input(1) AND input(0));  
END behavior;