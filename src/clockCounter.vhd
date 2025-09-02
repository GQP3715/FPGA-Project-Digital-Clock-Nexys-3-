-- ==============================================================
-- Clock Counter
-- Keeps track of hours (0–23) and minutes (0–59).
-- For test purposes: increments minutes every 100 ms.
-- Outputs 4 digits for seven-seg display.
-- ==============================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clockCounter is
    Port (
        DIGIT0 : out STD_LOGIC_VECTOR (7 downto 0); -- Minutes units
        DIGIT1 : out STD_LOGIC_VECTOR (7 downto 0); -- Minutes tens
        DIGIT2 : out STD_LOGIC_VECTOR (7 downto 0); -- Hours units
        DIGIT3 : out STD_LOGIC_VECTOR (7 downto 0); -- Hours tens
        CLK2MS : in  STD_LOGIC
    );
end clockCounter;

architecture Behavioral of clockCounter is
    type t_digitArray is array (0 to 3) of integer;
    signal digitArray : t_digitArray := (0,0,0,0);

    type t_CASevenSegment is array (0 to 9) of STD_LOGIC_VECTOR(7 downto 0);
    constant CASevenSegment : t_CASevenSegment := (
        "11000000", -- 0
        "11111001", -- 1
        "10100100", -- 2
        "10110000", -- 3
        "10011001", -- 4
        "10010010", -- 5
        "10000010", -- 6
        "11111000", -- 7
        "10000000", -- 8
        "10010000"  -- 9
    );

    signal tick_count : integer range 0 to 49 := 0;
    signal minutes    : integer range 0 to 59 := 0;
    signal hours      : integer range 0 to 23 := 0;
begin
    -- Timekeeping process
    process(CLK2MS)
    begin
        if rising_edge(CLK2MS) then
            -- Count 50 cycles for 100 ms
            if tick_count = 49 then
                tick_count <= 0;

                -- Update minutes
                if minutes = 59 then
                    minutes <= 0;

                    -- Update hours
                    if hours = 23 then
                        hours <= 0;
                    else
                        hours <= hours + 1;
                    end if;
                else
                    minutes <= minutes + 1;
                end if;
            else
                tick_count <= tick_count + 1;
            end if;
        end if;
    end process;

    -- Convert current time into BCD digits
    digitArray(0) <= minutes mod 10; -- Minutes units
    digitArray(1) <= minutes / 10;   -- Minutes tens
    digitArray(2) <= hours mod 10;   -- Hours units
    digitArray(3) <= hours / 10;     -- Hours tens

    -- Output 7-seg patterns
    DIGIT0 <= CASevenSegment(digitArray(0));
    DIGIT1 <= CASevenSegment(digitArray(1));
    DIGIT2 <= CASevenSegment(digitArray(2));
    DIGIT3 <= CASevenSegment(digitArray(3));
end Behavioral;
