library ieee;
use ieee.std_logic_1164.all;

entity ex2 is
    port (
        L, M, N: in std_logic;
        F3: out std_logic
    );
end ex2;

architecture behave of ex2 is
begin
    F3 <= ((not L) and (not M) and N) or (L and M);
end behave;