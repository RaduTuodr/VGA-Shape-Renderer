library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Draw_Circle is
    
    Port(HP: in STD_LOGIC_VECTOR(9 downto 0);
         VP: in STD_LOGIC_VECTOR(9 downto 0);
         centerH : in STD_LOGIC_VECTOR(9 downto 0);
         centerV : in STD_LOGIC_VECTOR(9 downto 0);
         draw: out STD_LOGIC);
end Draw_Circle;

architecture Behavioral of Draw_Circle is
    signal distance_squared : integer range 0 to 2_097_151; -- Maximum value 2^20 - 1
    constant radius_squared : integer := 10_000; -- Radius squared (100 * 100)
    
begin

    process    
    
        variable HP_int: integer;
        variable centerH_int: integer;
        variable VP_int: integer;
        variable centerV_int: integer;
    
        begin
        
            HP_int := to_integer(unsigned(HP));
            centerH_int := to_integer(unsigned(centerH));
            VP_int := to_integer(unsigned(VP));
            centerV_int := to_integer(unsigned(centerV));
        
            -- Calculate the squared distance from the center
            distance_squared <= (HP_int - centerH_int) * (HP_int - centerH_int) + (VP_int - centerV_int) * (VP_int - centerV_int);

            if distance_squared <= radius_squared then
                draw <= '1';
            else
                draw <= '0';
            end if;
        
        end process;

end Behavioral;