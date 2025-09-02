-- ==============================================================
-- Seven-Segment Controller
-- Scans 4 digits at 500 Hz (2 ms per digit).
-- Multiplexes digit data onto the display.
-- ==============================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sevenSegmentController is
    Port (
        DIGIT0   : in  STD_LOGIC_VECTOR (7 downto 0);
        DIGIT1   : in  STD_LOGIC_VECTOR (7 downto 0);
        DIGIT2   : in  STD_LOGIC_VECTOR (7 downto 0);
        DIGIT3   : in  STD_LOGIC_VECTOR (7 downto 0);
        AN       : out STD_LOGIC_VECTOR (3 downto 0); -- Digit enable
        CATHODES : out STD_LOGIC_VECTOR (7 downto 0); -- Segment signals
        CLK2MS   : in  STD_LOGIC
    );
end sevenSegmentController;

architecture Behavioral of sevenSegmentController is
    signal digit_counter : integer range 0 to 3 := 0;
    signal ans   : STD_LOGIC_VECTOR (3 downto 0) := "1111";
    signal caths : STD_LOGIC_VECTOR (7 downto 0) := "11111111";
begin
    -- Digit scanning process
    process(CLK2MS)
    begin
        if rising_edge(CLK2MS) then
            if digit_counter = 3 then
                digit_counter <= 0;
            else
                digit_counter <= digit_counter + 1;
            end if;
        end if;
    end process;

    -- Assign digits
    process(digit_counter, DIGIT0, DIGIT1, DIGIT2, DIGIT3)
    begin
        case digit_counter is
            when 0 =>
                ans   <= "1110"; -- Enable rightmost digit
                caths <= DIGIT0;
            when 1 =>
                ans   <= "1101";
                caths <= DIGIT1;
            when 2 =>
                ans   <= "1011";
                caths <= DIGIT2;
            when 3 =>
                ans   <= "0111"; -- Enable leftmost digit
                caths <= DIGIT3;
            when others =>
                ans   <= "1111";
                caths <= "11111111"; -- Blank
        end case;
    end process;

    AN       <= ans;
    CATHODES <= caths;
end Behavioral;
