library ieee;
use ieee.std_logic_1164.all;

entity Adder3 is 
	port(
	A, B: in std_logic_vector(2 downto 0);
	C0: in std_logic;
	C3: out std_logic;
	S: out std_logic_vector(2 downto 0)
	);
end Adder3;

architecture structural of Adder3 is 

component Full_adder
	port(
	A: in std_logic;
	B: in std_logic;
	Cin: in std_logic;
	S: out std_logic;
	Cout: out std_logic
	);
end component;

signal C: std_logic_vector(3 downto 0);
    
begin

    C(0) <= C0;

    FA0: Full_adder
        port map(
            A => A(0),
            B => B(0),
            Cin => C(0),
            S => S(0),
            Cout => C(1)
        );

    FA1: Full_adder
        port map(
            A => A(1),
            B => B(1),
            Cin => C(1),
            S => S(1),
            Cout => C(2)
        );

    FA2: Full_adder
        port map(
            A => A(2),
            B => B(2),
            Cin => C(2),
            S => S(2),
            Cout => C(3)
        );

    C3 <= C(3);

end structural;