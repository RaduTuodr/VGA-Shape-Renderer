library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Draw_Triangle is
        Port(HP: in STD_LOGIC_VECTOR(9 downto 0);
             VP: in STD_LOGIC_VECTOR(9 downto 0);
             centerH : in STD_LOGIC_VECTOR (9 downto 0);
             centerV : in STD_LOGIC_VECTOR (9 downto 0);
             draw: out STD_LOGIC);
end Draw_Triangle;

architecture Behavioral of Draw_Triangle is
    
    constant max_distance : integer := 100; -- Distance from center in Taxicab metric
    constant offset_y : integer := 20;
    
begin

    process
    
        variable HP_int: integer;
        variable centerH_int: integer;
        variable VP_int: integer;
        variable centerV_int: integer;
        variable distance : integer;
    
        begin
        
            HP_int := to_integer(signed(HP));
            centerH_int := to_integer(signed(centerH));
            VP_int := to_integer(signed(VP));
            centerV_int := to_integer(signed(centerV)) + offset_y;
        
            distance := abs(HP_int - centerH_int) + abs(VP_int - centerV_int);
            -- distance := abs(HP_int - centerH_int) + abs(VP_int - centerV_int) * CEVA_SUBUNITAR;

            if distance <= max_distance and VP_int >= centerV_int then
                draw <= '1';
            else
                draw <= '0';
            end if;
        
        end process;

end Behavioral;
