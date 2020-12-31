library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;


entity display is
    PORT (
        clk       : IN STD_LOGIC;
		v_sync    : IN STD_LOGIC;
		pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		mic_data  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		sw        : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		red       : OUT STD_LOGIC;
		green     : OUT STD_LOGIC;
		blue      : OUT STD_LOGIC
	);
end display;

architecture Behavioral of display is
    CONSTANT size_x  : INTEGER := 10;
    SIGNAL size_y : INTEGER := 10;
	SIGNAL ball_on : STD_LOGIC; 
	SIGNAL ball_x  : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(400, 11);
	SIGNAL ball_y  : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(600, 11);
	signal position : integer;
	signal count : std_logic_vector(22 downto 0);
	
BEGIN
    color : process(sw) is
    begin
        if sw(2) = '1' then
           red <= '1';
        else
           red <= NOT ball_on;
        end if;
        if sw(1) = '1' then
           green <= '1';
        else
           green <= NOT ball_on;
        end if;
        if sw(0) = '1' then
           blue <= '1';
        else
           blue <= NOT ball_on;
        end if;
    end process;
    
	draw : PROCESS (ball_x, ball_y, pixel_row, pixel_col) IS
	BEGIN
    IF (pixel_col >= ball_x - size_x) AND
       (pixel_col <= ball_x + size_x) AND
       (pixel_row >= ball_y - size_y) AND
       (pixel_row <= ball_y + size_y) THEN
       ball_on <= '1';
    ELSE
       ball_on <= '0';
    END IF;
	END PROCESS;
	
    motion : PROCESS
    BEGIN
        if rising_edge(clk) then
            count <= count + 1;
            if count = 0 then
                position <= conv_integer(mic_data);
                size_y <= position;
                if position < 2500 then size_y <= 40;
                elsif position > 2500 and position <= 3750 then size_y <= 60;
                elsif position > 3750 and position <= 5000 then size_y <= 80;
                elsif position > 5000 and position <= 6250 then size_y <= 100;
                elsif position > 6250 and position <= 7500 then size_y <= 120;
                elsif position > 7500 and position <= 8750 then size_y <= 140;
                elsif position > 8750 and position <= 10000 then size_y <= 160;
                elsif position > 10000 and position <= 11250 then size_y <= 180;
                elsif position > 11250 and position <= 12500 then size_y <= 200;
                elsif position > 12500 and position <= 13750 then size_y <= 220;
                elsif position > 13750 and position <= 15000 then size_y <= 240;
                elsif position > 15000 and position <= 16250 then size_y <= 260;
                elsif position > 16250 and position <= 17500 then size_y <= 280;
                elsif position > 17500 and position <= 18750 then size_y <= 300;
                elsif position > 18750 and position <= 20000 then size_y <= 320;
                elsif position > 20000 and position <= 21250 then size_y <= 340;
                elsif position > 21250 and position <= 22500 then size_y <= 360;
                elsif position > 22500 and position <= 23750 then size_y <= 380;
                elsif position > 23750 and position <= 25000 then size_y <= 400;
                elsif position > 25000 and position <= 26250 then size_y <= 420;
                elsif position > 26250 and position <= 27500 then size_y <= 440;
                elsif position > 27500 and position <= 28750 then size_y <= 460;
                elsif position > 28750 and position <= 30000 then size_y <= 480;
                elsif position > 30000 and position <= 31250 then size_y <= 500;
                elsif position > 31250 then size_y <= 520;
                else size_y <= 40;
                end if;
            end if;
        end if;
        
    END PROCESS;
  
end Behavioral;

