library ieee;
use ieee.std_logic_1164.all;

entity ex25 is
    port (
        D1_IN, D2_IN: in std_logic_vector(7 downto 0);
        CLK, SEL, LDA, LDB: in std_logic;
        REG_A, REG_B: out std_logic_vector(7 downto 0)
    );
end ex25;

architecture behave of ex25 is
    component mux2t1 is
        port (
            A,B: in std_logic_vector(7 downto 0);
            SEL: in std_logic;
            M_OUT: out std_logic_vector(7 downto 0)
        );
    end component;
    
    component reg8 is
        port (
            REG_IN: in std_logic_vector(7 downto 0);
            LD, CLK: in std_logic;
            REG_OUT: out std_logic_vector(7 downto 0)
        );
    end component;

    signal s_mux_result: std_logic_vector(7 downto 0);

begin
    ra: reg8 port map(s_mux_result, LDA, CLK, REG_A);

    rb: reg8 port map(s_mux_result, LDB, CLK, REG_B);

    mux: mux2t1 port map(D1_IN, D2_IN, SEL, s_mux_result);
end behave;
