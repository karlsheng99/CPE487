library ieee;
use ieee.std_logic_1164.all;

entity ex6 is
    port (
        D3, D2, D1, D0: in std_logic;
        SEL: in std_logic_vector(1 downto 0);
        MX_OUT: out std_logic
    );
end ex6;

architecture behave of ex6 is
begin
    with SEL select
    MX_OUT <= 
        D3 when "11",
        D2 when "10",
        D1 when "01",
        D0 when "00",
        '0' when others;
end behave;