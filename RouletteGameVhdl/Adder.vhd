library ieee;
use ieee.std_logic_1164.all;

entity Adder is 
	port(
	A, B: in std_logic_vector(3 downto 0);
	C0: in std_logic;
	C4: out std_logic;
	S: out std_logic_vector(3 downto 0)
	);
end Adder;

architecture structural of Adder is 

component Full_adder
	port(
	A: in std_logic;
	B: in std_logic;
	Cin: in std_logic;
	S: out std_logic;
	Cout: out std_logic
	);
end component;

signal C: std_logic_vector(4 downto 0);
    
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

    FA3: Full_adder
        port map(
            A => A(3),
            B => B(3),
            Cin => C(3),
            S => S(3),
            Cout => C(4)
        );

    C4 <= C(4);

end structural;