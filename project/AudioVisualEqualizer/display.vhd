
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity display is
    PORT (
		v_sync    : IN STD_LOGIC;
		pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		motion    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		red       : OUT STD_LOGIC;
		green     : OUT STD_LOGIC;
		blue      : OUT STD_LOGIC
	);
end display;

architecture Behavioral of display is
    CONSTANT size  : INTEGER := 10;
	SIGNAL ball_on : STD_LOGIC; -- indicates whether ball is over current pixel position
	-- current ball position - intitialized to center of screen
	SIGNAL ball_x  : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(250, 11);
	SIGNAL ball_y  : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(300, 11);
	-- current ball motion - initialized to +4 pixels/frame
	SIGNAL ball_y_motion : STD_LOGIC_VECTOR(10 DOWNTO 0) := "00000000100";
	SIGNAL ball_x_motion : STD_LOGIC_VECTOR(10 DOWNTO 0) := "00000000100";
BEGIN
	red <= NOT ball_on; -- color setup for red ball on white background
	green <= NOT ball_on;
	blue  <= '1';
	-- process to draw ball current pixel address is covered by ball position
	bdraw : PROCESS (ball_x, ball_y, pixel_row, pixel_col) IS
	VARIABLE x : INTEGER;
	VARIABLE y : INTEGER;
	BEGIN
	    x := CONV_INTEGER(pixel_col) - CONV_INTEGER(ball_x);
	    y := CONV_INTEGER(pixel_row) - CONV_INTEGER(ball_y);
	    
		IF ((x * x + y * y) <= (size * size)) THEN
				ball_on <= '1';
		ELSE
			ball_on <= '0';
		END IF;
	END PROCESS;
		-- process to move ball once every frame (i.e. once every vsync pulse)
    mball : PROCESS
    BEGIN
        WAIT UNTIL rising_edge(v_sync);
        -- allow for bounce off top or bottom of screen
        if motion = 0 then ball_y <=   CONV_STD_LOGIC_VECTOR(125, 11) ;
        elsif motion = 1 then ball_y <=   CONV_STD_LOGIC_VECTOR(150, 11);
        elsif motion = 2 then ball_y <=   CONV_STD_LOGIC_VECTOR(175, 11);
        elsif motion = 3 then ball_y <=   CONV_STD_LOGIC_VECTOR(200, 11);
        elsif motion = 4 then ball_y <=   CONV_STD_LOGIC_VECTOR(225, 11);
        elsif motion = 5 then ball_y <=   CONV_STD_LOGIC_VECTOR(250, 11);
        elsif motion = 6 then ball_y <=   CONV_STD_LOGIC_VECTOR(275, 11);
        elsif motion = 7 then ball_y <=   CONV_STD_LOGIC_VECTOR(300, 11);
        elsif motion = 8 then ball_y <=   CONV_STD_LOGIC_VECTOR(325, 11);
        elsif motion = 9 then ball_y <=   CONV_STD_LOGIC_VECTOR(350, 11);
        elsif motion = 10 then ball_y <=   CONV_STD_LOGIC_VECTOR(375, 11);
        elsif motion = 11 then ball_y <=   CONV_STD_LOGIC_VECTOR(400, 11);
        elsif motion = 12 then ball_y <=   CONV_STD_LOGIC_VECTOR(425, 11);
        elsif motion = 13 then ball_y <=   CONV_STD_LOGIC_VECTOR(450, 11);
        elsif motion = 14 then ball_y <=   CONV_STD_LOGIC_VECTOR(475, 11);
        elsif motion = 15 then ball_y <=   CONV_STD_LOGIC_VECTOR(500, 11);
        else ball_y <=   CONV_STD_LOGIC_VECTOR(100, 11);
        end if;
        
        
        --ball_y <= ball_y + ball_y_motion; -- compute next ball position
    END PROCESS;
  
end Behavioral;

