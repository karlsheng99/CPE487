library ieee;
use ieee.std_logic_1164.all;

entity ex8 is
    port (
        L, M, N: in std_logic;
        F3: out std_logic
    );
end ex8;

architecture behave of ex8 is
    signal temp: std_logic_vector(2 downto 0);
begin
    temp <= (L & M & N);
    with (temp) select
        F3 <= 
            '1' when "001" | "110" | "111",
            '0' when others;
end behave;