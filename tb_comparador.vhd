library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_incrementador is
	generic (
    	DATA_WIDTH : natural := 16
    );
end entity;

architecture teste of tb_incrementador is
	component incrementador is
		port(
          a 		: in std_logic_vector((DATA_WIDTH - 1) downto 0);
          result 	: out std_logic_vector((DATA_WIDTH - 1) downto 0)
        );
	
	end component;

	signal A : std_logic_vector((DATA_WIDTH - 1) downto 0);
	signal RESULT : std_logic_vector((DATA_WIDTH - 1) downto 0);

begin
	instancia_incrementador : incrementador port map(a=>A, result=>RESULT);
	A <= x"0001", x"0002" after 20 ns, x"0003" after 40 ns, x"0004" after 60 ns, x"0005" after 80 ns, x"0006" after 100 ns, x"0007" after 120 ns;
end teste;
