library ieee;
use ieee.std_logic_1164.all;

entity ex19 is
    port (
        SET, CLK, X: in std_logic;
        Z2: out std_logic;
        Y: out std_logic_vector(1 downto 0)
    );
end ex19;

architecture behave of ex19 is
    type state_type is (ST0, ST1, ST2);
    signal PS, NS: state_type;
begin
    sync_proc: process(CLK, NS, SET)
    begin
        if (SET = '1') then
            PS <= ST2;
        elsif (rising_edge(CLK)) then
            PS <= NS;
        end if;
    end process sync_proc;

    comb_process: process(PS, X)
    begin
        Z2 <= '0';
        case PS is 
            when ST0 =>
                Z2 <= '0';
                if (X = '1') then NS <= ST1;
                else NS <= ST0;
                end if;
            when ST1 =>
                Z2 <= '0';
                if (X = '1') then NS <= ST2;
                else NS <= ST0;
                end if;
            when ST2 =>
                if (X = '1') then NS <= ST2; Z2 <= '1';
                else NS <= ST0; Z2 <= '0';
                end if;
            when others =>
                Z2 <= '1';
                NS <= ST0;
        end case;
    end process comb_process;

    with PS select
        Y <= 
            "00" when ST0,
            "10" when ST1,
            "11" when ST2,
            "00" when others;
end behave; 
