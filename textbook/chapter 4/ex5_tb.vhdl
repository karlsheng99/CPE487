library ieee;
use ieee.std_logic_1164.all;

--entity
entity ex5_tb is
end ex5_tb;

--architecture
architecture test of ex5_tb is
    component ex5
        port (
            L, M, N: in std_logic;
            F3: out std_logic
        );
    end component;

    signal L, M, N, F3: std_logic;
begin
    exercise: ex5 port map (L => L, M => M, N => N, F3 => F3);

    process begin
        L <= 'X';
        M <= 'X';
        N <= 'X';
        wait for 1 ns;

        L <= '0';
        M <= '0';
        N <= '0';
        wait for 1 ns;

        L <= '1';
        M <= '0';
        N <= '0';
        wait for 1 ns;

        L <= '0';
        M <= '1';
        N <= '0';
        wait for 1 ns;

        L <= '0';
        M <= '0';
        N <= '1';
        wait for 1 ns;

        L <= '1';
        M <= '1';
        N <= '0';
        wait for 1 ns;

        L <= '1';
        M <= '0';
        N <= '1';
        wait for 1 ns;

        L <= '0';
        M <= '1';
        N <= '1';
        wait for 1 ns;

        L <= '1';
        M <= '1';
        N <= '1';
        wait for 1 ns;

        assert false report "Reached end of test";
        wait;

    end process;
end test;

