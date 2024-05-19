library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Draw_Line is
    
    Port(HP: in STD_LOGIC_VECTOR(9 downto 0);
         VP: in STD_LOGIC_VECTOR(9 downto 0);
         centerH : in STD_LOGIC_VECTOR (9 downto 0);
         centerV : in STD_LOGIC_VECTOR (9 downto 0);
         draw: out STD_LOGIC);
end Draw_Line;

architecture Behavioral of Draw_Line is

    constant LINE_LENGTH: integer := 200;               -- Length of the line
    constant LINE_WIDTH: integer := 5;                 -- Width of the line
    constant HALF_LENGTH: integer := LINE_LENGTH / 2;   -- Half of the length
    constant HALF_WIDTH: integer := LINE_WIDTH / 2;   -- Half of the width

begin
    draw <= '1' when
            -- Check if the horizontal position is within the boundaries of the line
            (HP >= centerH - HALF_LENGTH and HP <= centerH + HALF_LENGTH) 
            and
            -- Check if the vertical position is within the boundaries of the line
            (VP >= centerV - LINE_WIDTH and VP <= centerV + LINE_WIDTH)
            else '0';
end Behavioral;
