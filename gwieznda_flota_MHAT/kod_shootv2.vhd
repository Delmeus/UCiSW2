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

entity kod_shoot is
    Port ( zegar : in  STD_LOGIC;
           lewo : in STD_LOGIC;
           prawo : in STD_LOGIC;
           shot : in STD_LOGIC;
           znak : out  STD_LOGIC_VECTOR (7 downto 0);
           znak_gotowy : out  STD_LOGIC;
           go_to_beginning : out STD_LOGIC)
    ;
end kod_shoot;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package Table_Package is
    type Table_Type is array (0 to 19, 0 to 47) of std_logic_vector(7 downto 0);
end Table_Package;

-- package Table_Package_Binary is
--     type Table_Binary is array (0 to 19, 0 to 47) of boolean;
-- end Table_Package_Binary;


package Table_Package_Binary is
    type Table_Type is array (0 to 19, 0 to 47) of std_logic_vector(1 downto 0);
end Table_Package_Binary;

package Int_Table_Package is
    type Int_Table_Type is array (0 to 9) of integer;
end Int_Table_Package;

use work.Table_Package.all;
use work.Table_Package_Binary.all;

architecture Behavioral of kod_shoot is
    signal game_over : boolean := false;
    signal zegar_dzielnik : std_logic_vector(31 downto 0) := X"00000000";
    signal temp : STD_LOGIC := '0';
    signal go_home_temp : STD_LOGIC := '0';
    signal myTable : Table_Type := (others => (others => "00000000"));
    signal obstacles : Table_Binary := (others => (others => "00"));
    --signal shots : Table_Binary := (others => (others => false));
    signal i : integer range 0 to 19 := 0; -- 19
    signal j : integer range 0 to 47 := 0; --47 TO NIE WINA J
    signal ship_x : integer range 0 to 47 := 24;
    signal ship_y : integer range 0 to 19 := 17;
    signal tablica_gotowa : STD_LOGIC := '0';
    --signal score : integer := 0;
    signal score : Int_Table_Type := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    signal new_char_code : integer;
    signal lfsr : std_logic_vector(5 downto 0) := ("101001");--(others => '0');
    signal random_counter : integer range 0 to 10 := 7;


begin
    process1: process(zegar)
    begin
        if rising_edge(zegar) then
            -- czyszczenie całej tablicy
            --go_home_temp <= '0';
            if game_over = false then
                tablica_gotowa <= '0';
                for y in 0 to 19 loop -- 19
                    for x in 0 to 47 loop -- 47
                        if x = ship_x and y = ship_y then
                            myTable(y,x) <= X"0A";
                        elsif obstacles(y,x) = "01" then
                            myTable(y,x) <= X"10";
                        elsif obstacles(y,x) = "10" then
                            myTable(y,x) <= X"09";
                        elsif obstacles(y,x) = "11" then
                            myTable(y,x) <= X"06";
                        -- elsif x = 0 and y = 0 and score mod 2 = 0 then
                        --     myTable(y,x) <= X"52";
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
            --myTable(0,35) <= X"1C";
            --myTable(10,15) <= X"01";
            --znak <= myTable(i, j);
            --temp <= '1';
            --j <= j + 1;
            --if j = 47 then --47
            --j <= 0;
            --i <= i + 1;
            --if i = 19 then--19
            --i <= 0;
            --go_home_temp <= '1';
            --end if;
            --end if;
            tablica_gotowa <= '1';
        end if;
    end process process1;



    process2: process(zegar)
    begin
        if rising_edge(zegar) then
            if tablica_gotowa = '1' then
                -- Output the symbol data
                znak <= myTable(i, j);
                -- Signal that the symbol is ready to be printed
                znak_gotowy <= '1';
                j <= j + 1;
                if j = 47 then --47
                    j <= 0;
                    i <= i + 1;
                    if i = 19 then--19
                        i <= 0;
                        --go_home_temp <= '1';
                    end if;
                end if;
            else
                -- Symbol not ready
                znak <= (others => '0');
                znak_gotowy <= '0';
            end if;
        end if;
    end process process2;



    process_control: process(zegar)
        variable delay_counter : integer range 0 to 24999994 := 0;
    begin
        --if rising_edge(zegar) then
        -- dac counter jak w obstacles
        -- zegar_dzielnik <= std_logic_vector(unsigned(zegar_dzielnik)+1);
        -- if zegar_dzielnik = X"000FFFFF" then
        -- 	zegar_dzielnik <= X"00000000";
        --if delay_counter < 24999994 then --
        --delay_counter := delay_counter + 1;
        --else
        --if lewo = '1' then
        --ship_x <= ship_x-1;
        --elsif prawo = '1' then
        --ship_x <= ship_x+1;
        --end if;
        --end if;
        --end if;
        if rising_edge(zegar) then
            if game_over = false then
                zegar_dzielnik <= std_logic_vector(unsigned(zegar_dzielnik)+1);
                if zegar_dzielnik = X"000FFFFF" then
                    zegar_dzielnik <= X"00000000";
                    if lewo = '1' then
                        ship_x <= ship_x-1;
                    elsif prawo = '1' then
                        ship_x <= ship_x+1;
                    end if;
                end if;
            end if;
        end if;
    end process process_control;



    process_obstacles: process(zegar)
        variable delay_counter : integer range 0 to 12499999 := 0; -- 250 ms delay
        variable shot_delay : integer range 0 to 6249999 := 0;
        --variable random_counter : integer range 0 to 10 := 7;
    begin
        if rising_edge(zegar) then
            if game_over = false then
                if obstacles(ship_y, ship_x) = "01" or obstacles(ship_y, ship_x) = "10" then
                    game_over <= true;
                end if;
                if shot_delay < 6249999 then
                    shot_delay := shot_delay + 1;
                else
                    shot_delay := 0;
                    if shot = '1' then
                        obstacles(ship_y - 1, ship_x) <= "11";
                    end if;
                end if;
                if delay_counter < 12499999 then--24999999
                    delay_counter := delay_counter + 1;
                else
                    delay_counter := 0;
                    -- Causing obstacles to fall - wygląda legitnie
                    for y in 18 downto 0 loop
                        for x in 47 downto 0 loop
                            -- Opadanie meteoru
                            if obstacles(y,x) = "01" then
                                if y < 19 then
                                    obstacles(y+1,x) <= obstacles(y,x);
                                end if;
                                obstacles(y,x) <= "00";
                            -- opadanie statkow
                            elsif obstacles(y,x) = "10" then
                                if y < 19 then
                                    obstacles(y,x) <= "00";
                                    if obstacles(y+1,x) = "11" then
                                        obstacles(y+1,x) <= "00";
                                    else
                                        obstacles(y+1,x) <= "10";
                                    end if;
                                end if;
                            -- strzaly
                            elsif obstacles(y,x) = "11" then
                                if y > 0 then
                                    obstacles(y-1,x) <= "11";
                                end if;
                                obstacles(y,x) <= "00";
                            end if;
                        end loop;
                    end loop;
                    -- Generate new obstacles
                    random_counter <= random_counter + 1;
                    if random_counter = 2 then
                        random_counter <= 0;
                        lfsr(5 downto 1) <= lfsr(4 downto 0);
                        lfsr(0) <= lfsr(5) xor lfsr(3) xor lfsr(2);
                        if unsigned(lfsr) < 48 then
                            obstacles(0, to_integer(unsigned(lfsr))) <= "01";
                        else
                            obstacles(0, to_integer(unsigned(lfsr) - 40)) <= "01";
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process process_obstacles;



    process_score: process(zegar)
        variable delay_counter : integer range 0 to 24999999 := 0;
        variable score_pointer : integer := 0;
    begin
        if rising_edge(zegar) then
            if game_over = false then
                if delay_counter < 24999999 then
                    delay_counter := delay_counter + 1;
                else
                    delay_counter := 0;
                    score(0) <= score(0) + 1;
                    for i in 0 to 9 loop
                        if score(i) = 10 and i /= 9 then
                            score(i) <= 0;
                            score(i+1) <= score(i+1) + 1;
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process process_score;


    --go_to_beginning <= go_home_temp;
end Behavioral;