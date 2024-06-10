library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity kod_kbd is
    Port (
        my_clk : in  STD_LOGIC;
        symbol : out  STD_LOGIC_VECTOR (7 downto 0);
        symbol_ready : out  STD_LOGIC;
        go_to_beginning : out STD_LOGIC;
        keyboard : in STD_LOGIC_VECTOR (7 downto 0);
        keyboard_status : in STD_LOGIC
    )
    ;
end kod_kbd;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package Table_Package is
    type Table_Type is array (0 to 19, 0 to 47) of std_logic_vector(7 downto 0);
end Table_Package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package Table_Package_Binary is
    type Table_Binary is array (0 to 19, 0 to 47) of boolean;
end Table_Package_Binary;

package Int_Table_Package is
    type Int_Table_Type is array (0 to 9) of integer;
end Int_Table_Package;

use work.Table_Package.all;
use work.Table_Package_Binary.all;
use work.Int_Table_Package.all;



architecture Behavioral of kod_kbd is
    signal game_over : boolean := false;
    signal myTable : Table_Type := (others => (others => "00000000"));
    signal obstacles : Table_Binary := (others => (others => false));
    signal i : integer range 0 to 19 := 0;
    signal j : integer range 0 to 47 := 0;
    signal ship_x : integer range 0 to 47 := 24;
    signal ship_y : integer range 0 to 19 := 17;
    signal tablica_gotowa : STD_LOGIC := '0';

    signal score : Int_Table_Type := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    signal lfsr : std_logic_vector(5 downto 0) := ("101001");
    signal random_counter : integer range 0 to 10 := 7;

    signal new_game : STD_LOGIC := '0';


begin
    process1: process(my_clk)
    variable new_char_code : integer;
    begin
        if rising_edge(my_clk) then
            if game_over = false then
                tablica_gotowa <= '0';
                for y in 0 to 19 loop -- 19
                    for x in 0 to 47 loop -- 47
                        if x = ship_x and y = ship_y then
                            myTable(y,x) <= X"4F";
                        elsif (x  = ship_x - 1 or x = ship_x + 1) and y = ship_y then
                            --if  then
                            myTable(y,x) <= X"2D";
                            --end if;
                        elsif obstacles(y,x) = true then
                            myTable(y,x) <= X"10";
                        else
                            myTable(y,x) <= X"00";
                        end if;
                    end loop;
                end loop;
                myTable(19,0) <= X"53"; -- S
                myTable(19,1) <= X"43"; -- C
                myTable(19,2) <= X"4F"; -- O
                myTable(19,3) <= X"52"; -- R
                myTable(19,4) <= X"45"; -- E
                for i in 9 downto 0 loop
                    new_char_code := score(i) + 48;
                    myTable(19,16 - i) <= std_logic_vector(to_unsigned(new_char_code, 8));
                end loop;
            else
                for y in 0 to 19 loop -- 19
                    for x in 0 to 47 loop -- 47
                        myTable(y,x) <= X"00";
                    end loop;
                end loop;
                myTable(10,10) <= X"4F"; -- O
                myTable(10,11) <= X"56"; -- V
                myTable(10,12) <= X"45"; -- E
                myTable(10,13) <= X"52"; -- R

                myTable(11,10) <= X"53"; -- S
                myTable(11,11) <= X"43"; -- C
                myTable(11,12) <= X"4F"; -- O
                myTable(11,13) <= X"52"; -- R
                myTable(11,14) <= X"45"; -- E
                for i in 9 downto 0 loop
                    new_char_code := score(i) + 48;
                    myTable(11,26 - i) <= std_logic_vector(to_unsigned(new_char_code, 8));
                end loop;
            end if;
            tablica_gotowa <= '1';
        end if;
    end process process1;



    process2: process(my_clk)
    begin
        if rising_edge(my_clk) then
            if tablica_gotowa = '1' then
                -- Output the symbol data
                symbol <= myTable(i, j);
                -- Signal that the symbol is ready to be printed
                symbol_ready <= '1';
                j <= j + 1;
                if j = 47 then --47
                    j <= 0;
                    i <= i + 1;
                    if i = 19 then--19
                        i <= 0;
                    end if;
                end if;
            else
                -- Symbol not ready
                symbol <= (others => '0');
                symbol_ready <= '0';
            end if;
        end if;
    end process process2;



    process_control: process(my_clk)
    variable delay_counter : integer range 0 to 3125000 := 0; -- 125/2 ms delay
    begin
        if rising_edge(my_clk) then
            delay_counter := delay_counter + 1;
            if game_over = false then
                new_game <= '0';
                if delay_counter = 3125000 then
                    delay_counter := 0;
                    if keyboard_status = '1' then
                        if keyboard = X"4B" and ship_x > 1 then -- left
                            ship_x <= ship_x - 1;
                        elsif keyboard = X"4D" and ship_x < 46 then -- right
                            ship_x <= ship_x + 1;
                        elsif keyboard = X"48" and ship_y > 1 then -- up
                            ship_y <= ship_y - 1;
                        elsif keyboard = X"50" and ship_y < 19 then -- down
                            ship_y <= ship_y + 1;
                        end if;
                    end if;
                end if;
            end if;
            if game_over = true then
                if delay_counter = 3125000 and keyboard_status = '1' and keyboard = X"39" then --niby spacja, nw
                    game_over := false;
                    ship_x <= 24;
                    ship_y <= 17;
                    new_game <= '1';
                end if;
            end if;
        end if;
    end process process_control;



    process_obstacles: process(my_clk)
    variable delay_counter : integer range 0 to 12499999 := 0; -- 250 ms delay
    variable change_lfsr : integer := 0;
    variable prev_lfsr : STD_LOGIC_VECTOR(5 downto 0) := "000000";
    begin
        if rising_edge(my_clk) then
            if new_game = '1' then
                for y in 19 downto 0 loop
                    for x in 47 downto 0 loop
                        obstacles(y,x) <= false;
                    end loop;
                end loop;
            end if;

            if game_over = false then
                if obstacles(ship_y, ship_x) = true or obstacles(ship_y, ship_x - 1) = true or obstacles(ship_y, ship_x + 1) = true then
                    game_over <= true;
                end if;
                if delay_counter < 12499999 then--24999999
                    delay_counter := delay_counter + 1;
                else
                    delay_counter := 0;
                    -- Causing obstacles to fall - wygląda legitnie
                    for y in 19 downto 0 loop -- bylo 18 26.05
                        for x in 47 downto 0 loop
                            -- causing meteorites to fall
                            if obstacles(y,x) = true then
                                obstacles(y,x) <= false;
                                if y < 19 then -- ewentualnie 18
                                    obstacles(y+1,x) <= true;
                                else
                                    obstacles(y,x) <= false;
                                end if;
                            end if;
                        end loop;
                    end loop;

                    -- Generate new obstacles
                    random_counter <= random_counter + 1;
                    if random_counter = 1 then
                        change_lfsr := change_lfsr + 1;
                        random_counter <= 0;
                        prev_lfsr <= lfsr; -- uwaga
                        lfsr(5 downto 1) <= lfsr(4 downto 0);
                        lfsr(0) <= lfsr(5) xor lfsr(3) xor lfsr(2);
                        if unsigned(lfsr) < 48 then
                            obstacles(0, to_integer(unsigned(lfsr))) <= true;
                        else
                            obstacles(0, to_integer(unsigned(lfsr) - 40)) <= true;
                        end if;
                    end if;

                    if change_lfsr = 20 then
                        change_lfsr := 0;
                        lfsr <= std_logic_vector(unsigned(lfsr)+2);
                    end if;
                    if lfsr = "000000" or prev_lfsr = lfsr then -- uwaga
                        lfsr <= "011110";
                    end if;
                end if;
            end if;
        end if;
    end process process_obstacles;



    process_score: process(my_clk)
    variable delay_counter : integer range 0 to 24999999 := 0;
    begin
        if rising_edge(my_clk) then
            if new_game = '1' then
                for i in 0 to 9 loop
                    score(i) <= 0;
                end loop;
            end if;
            if game_over = false then
                if delay_counter < 24999999 then
                    delay_counter := delay_counter + 1;
                else
                    delay_counter := 0;
                    score(0) <= score(0) + 1;
                    for i in 0 to 9 loop
                        if score(i) >= 9 and i < 9 then -- handling overflow
                            score(i) <= 0;
                            score(i+1) <= score(i+1) + 1;
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process process_score;


end Behavioral;