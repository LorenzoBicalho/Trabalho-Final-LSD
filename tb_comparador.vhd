library ieee;
use ieee.std_logic_1164.all;

entity tb_comparador is
	generic (
    	DATA_WIDTH : natural := 16
    );
end tb_comparador;

architecture teste of tb_comparador is
	component comparador is
		port(
          a : in std_logic_vector((DATA_WIDTH - 1) downto 0);
          a_eq_0 : out std_logic
        );

	end component;

	signal A : std_logic_vector((DATA_WIDTH - 1) downto 0);
	signal A_EQ_0 : std_logic;

	begin
      instancia_comparador : comparador port map(a=>A, a_eq_0=>A_EQ_0);
      A <= x"0000", x"0002" after 5 ns, x"0000" after 10 ns, x"0003" after 15 ns, x"0000" after 20 ns;
end teste;