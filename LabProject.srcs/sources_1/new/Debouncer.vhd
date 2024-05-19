library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Debouncer for the buttons
entity Debouncer is
    Port ( CLK100 : in STD_LOGIC;
           RST : in STD_LOGIC;
           BTN : in STD_LOGIC;
           BTN_DEB : out STD_LOGIC);
end Debouncer;

architecture Behavioral of Debouncer is
signal count : std_logic_vector (22 downto 0) := (others => '0');
signal enable : std_logic;
signal q1, q2, q3 : std_logic;
begin
    counter: process(CLK100)
    begin
        if rising_edge(CLK100) then
            if RST = '1' then
                count <= (others => '0');
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    
    enable <= '1' when count = x"3FFFFF" else '0';
    
    DFF1 : process(CLK100)
    begin
        if rising_edge(CLK100) then
            if enable = '1' then
                q1 <= BTN;
            end if;
        end if;
    end process;
    
    DFF2 : process(CLK100)
    begin
        if rising_edge(CLK100) then
            q2 <= q1;
        end if;
    end process;
    
    DFF3 : process(CLK100)
    begin
        if rising_edge(CLK100) then
            q3 <= q2;
        end if;
    end process;

    BTN_DEB <= q1 and q2 and q3;

end Behavioral;