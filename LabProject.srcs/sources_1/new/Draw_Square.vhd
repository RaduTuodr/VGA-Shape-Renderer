library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Draw_Square is
    
    Port(HP: in STD_LOGIC_VECTOR(9 downto 0);
         VP: in STD_LOGIC_VECTOR(9 downto 0);
         centerH : in STD_LOGIC_VECTOR (9 downto 0);
         centerV : in STD_LOGIC_VECTOR (9 downto 0);
         draw: out STD_LOGIC);
end Draw_Square;

architecture Behavioral of Draw_Square is

    constant SIDE_LENGTH: integer := 200;  -- Length of each side of the square
    constant HALF_SIDE: integer := SIDE_LENGTH / 2;  -- Half of the side length

begin
    draw <= '1' when
            -- Check if the horizontal position is within the boundaries of the square
            (HP >= centerH - HALF_SIDE and HP <= centerH + HALF_SIDE) 
            and
            -- Check if the vertical position is within the boundaries of the square
            (VP >= centerV - HALF_SIDE and VP <= centerV + HALF_SIDE)
            else '0';
end Behavioral;
