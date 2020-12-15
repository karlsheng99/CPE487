library ieee;
use ieee.std_logic_1164.all;

entity ex14 is
    port (
        D, CLK: in std_logic;
        Q: out std_logic
    );
end ex14;

architecture behave of ex14 is
begin
    dff: process(CLK)
    begin
        if (rising_edge(CLK)) then
            Q <= D;
        end if;
    end process dff;
end behave;