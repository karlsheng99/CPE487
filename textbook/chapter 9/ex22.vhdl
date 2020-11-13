library ieee;
use ieee.std_logic_1164.all;

entity ex22 is
    port (
        A_IN: in std_logic_vector(2 downto 0);
        B_IN: in std_logic_vector(2 downto 0);
        EQ_OUT: out std_logic
    );
end ex22;

architecture behave of ex22 is
    component big_xnor is
        port (
            A, B: in std_logic;
            F: out std_logic
        );
    end component;

    component big_and3 is
        port (
            A, B, C: in std_logic;
            F: out std_logic
        );
    end component;

    signal p1_out, p2_out, p3_out: std_logic;

begin
    x1: big_xnor port map (
        A => A_IN(2),
        B => B_IN(2),
        F => p1_out
    );

    x2: big_xnor port map (
        A => A_IN(1),
        B => B_IN(1),
        F => p2_out
    );

    x3: big_xnor port map (
        A => A_IN(0),
        B => B_IN(0),
        F => p3_out
    );

    a1: big_and3 port map (
        A => p1_out,
        B => p2_out,
        C => p3_out,
        F => EQ_OUT
    );
end behave;

