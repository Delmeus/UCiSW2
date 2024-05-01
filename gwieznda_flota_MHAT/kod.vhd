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

entity kod is
    Port ( zegar : in  STD_LOGIC;
			  lewo : in STD_LOGIC;
			  prawo : in STD_LOGIC;
           znak : out  STD_LOGIC_VECTOR (7 downto 0);
           znak_gotowy : out  STD_LOGIC;
			  go_to_beginning : out STD_LOGIC)
			  ;
end kod;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package Table_Package is
    type Table_Type is array (0 to 19, 0 to 47) of std_logic_vector(7 downto 0); -- Assuming each element is an 8-bit vector
end Table_Package;

use work.Table_Package.all;

architecture Behavioral of kod is

signal zegar_dzielnik : std_logic_vector(31 downto 0) := X"00000000";
signal temp : STD_LOGIC := '0';
signal go_home_temp : STD_LOGIC := '0';
signal myTable : Table_Type := (others => (others => "00000000"));
signal i : integer range 0 to 19 := 0;
signal j : integer range 0 to 47 := 0;
signal tablica_gotowa : STD_LOGIC := '0';


begin
process1: process(zegar)
	begin
		if rising_edge(zegar) then	
			-- czyszczenie ca³ej tablicy
			--go_home_temp <= '0';
			tablica_gotowa <= '0';
			for x in 0 to 19 loop
				for y in 0 to 47 loop
					myTable(x,y) <= X"00";
				end loop;
			end loop;
			
			myTable(0,15) <= X"1C";
			myTable(10,15) <= X"01";
			--znak <= myTable(i, j);
			--temp <= '1';
			j <= j + 1;
         		if j = 47 then
				j <= 0;
			   	i <= i + 1;
			    	if i = 19 then
					i <= 0;
					--go_home_temp <= '1';
			    	end if;
			end if;
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
            		else
				-- Symbol not ready, output default data (e.g., blank)
				znak <= (others => '0');
				znak_gotowy <= '0';
            		end if;
        	end if;
end process process2;

process_sterowanie: process(zegar)
	begin
		if rising_edge(zegar) then
			temp <= '1';
		end if;
end process process_sterowanie;

--znak_gotowy <= temp;
--go_to_beginning <= go_home_temp;
end Behavioral;
