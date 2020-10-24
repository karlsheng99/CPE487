library ieee;
use ieee.std_logic_1164.all;

--entity
entity ex1_tb is
end ex1_tb;

--architecture
architecture test of ex1_tb is
    component ex1
        port (
            A, B, C: in std_logic;
            F: out std_logic
        );
    end component;

    signal A, B, C, F: std_logic;
begin
    exercise: ex1 port map (A => A, B => B, C => C, F => F);

    process begin
        A <= 'X';
        B <= 'X';
        C <= 'X';
        wait for 1 ns;

        A <= '0';
        B <= '0';
        C <= '0';
        wait for 1 ns;

        A <= '1';
        B <= '0';
        C <= '0';
        wait for 1 ns;

        A <= '0';
        B <= '1';
        C <= '0';
        wait for 1 ns;

        A <= '0';
        B <= '0';
        C <= '1';
        wait for 1 ns;

        A <= '1';
        B <= '1';
        C <= '0';
        wait for 1 ns;

        A <= '1';
        B <= '0';
        C <= '1';
        wait for 1 ns;

        A <= '0';
        B <= '1';
        C <= '1';
        wait for 1 ns;

        A <= '1';
        B <= '1';
        C <= '1';
        wait for 1 ns;

        assert false report "Reached end of test";
        wait;

    end process;
end test;

