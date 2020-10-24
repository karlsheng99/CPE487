library ieee;
use ieee.std_logic_1164.all;

--entity
entity ex1 is
    port (
        A, B, C: in std_logic;
        F: out std_logic
    );
end ex1;

--architecture
architecture behave of ex1 is
begin
    F <= not (A and B and C);
end behave;