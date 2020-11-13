--full encoding
library ieee;
use ieee.std_logic_1164.all;

entity ex20 is
    port (
        RESET, CLK, X: in std_logic;
        Z1, Z2: out std_logic;
        Y: out std_logic_vector(1 downto 0)
    );
end ex20;

architecture behave of ex20 is
    type state_type is(ST0, ST1, ST2, ST3);
    signal PS, NS: state_type;
begin
    sync_proc: process(CLK, NS, RESET)
    begin
        if (RESET = '1') then
            PS <= ST0;
        elsif (rising_edge(CLK)) then
            PS <= NS;
        end if;
    end process sync_proc;

    comb_proc: process(PS, X)
    begin
        Z1 <= '0';
        Z2 <= '0';
        case PS is
            when ST0 =>
                Z1 <= '1';
                if (X = '1') then NS <= ST0; Z2 <= '1';
                else NS <= ST1; Z2 <= '0';
                end if;
            when ST1 =>
                Z1 <= '1';
                if (X = '1') then NS <= ST1; Z2 <= '1';
                else NS <= ST2; Z2 <= '0';
                end if;
            when ST2 =>
                Z1 <= '0';
                if (X = '1') then NS <= ST2; Z2 <= '1';
                else NS <= ST3; Z2 <= '0';
                end if;
            when ST3 =>
                Z1 <= '1';
                if (X = '1') then NS <= ST3; Z2 <= '1';
                else NS <= ST0; Z2 <= '0';
                end if;
            when others =>
                Z1 <= '1';
                Z2 <= '0';
                NS <= ST0;
        end case;
    end process comb_proc;

    with PS select
            Y <=
                "00" when ST0,
                "01" when ST1,
                "10" when ST2,
                "11" when ST3,
                "00" when others;
end behave;
