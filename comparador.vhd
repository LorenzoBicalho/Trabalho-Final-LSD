library ieee;
use ieee.std_logic_1164.all;

entity comparador is
	generic (
		DATA_WIDTH : natural := 16
    );

	port (
      a : in std_logic_vector((DATA_WIDTH - 1) downto 0);
      a_eq_0 : out std_logic
    );
	
end comparador;

architecture behavior of comparador is
begin
  process(a)
  begin
    if(a = x"0000") then
      a_eq_0 <= '1';
    else
      a_eq_0 <= '0';
  	end if;
	end process;
end behavior;