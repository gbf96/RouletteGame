library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Equals is
    port (
        A     : in  std_logic_vector(3 downto 0);
        B     : in  std_logic_vector(3 downto 0);
        Equal : out std_logic
    );
end Equals;

architecture behavioral of Equals is

    signal diff : std_logic_vector(3 downto 0);

begin
    
    diff <= A xor B;
	
    Equal <= not (diff(0) or diff(1) or diff(2) or diff(3));
end behavioral;
