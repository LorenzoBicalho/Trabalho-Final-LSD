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
          b : in std_logic_vector((DATA_WIDTH - 1) downto 0);
          a_eq_b : out std_logic
        );

	end component;

	signal A : std_logic_vector((DATA_WIDTH - 1) downto 0);
    signal B : std_logic_vector((DATA_WIDTH - 1) downto 0);
	signal A_EQ_B : std_logic;

	begin
      instancia_comparador : comparador port map(a=>A, b=>B, a_eq_b=>A_EQ_B);
      A <= x"0000", x"0002" after 5 ns, x"0005" after 10 ns, x"0003" after 15 ns, x"0002" after 20 ns;
      B <= x"0000", x"0004" after 5 ns, x"0005" after 10 ns, x"0008" after 15 ns, x"0002" after 20 ns;
end teste;