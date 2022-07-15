library ieee;
use ieee.std_logic_1164.all;

entity registrador is
	generic (n : NATURAL := 10);
	port (
		entrada : in std_logic_vector(n - 1 downto 0);
		clk : in std_logic;
		rst : in std_logic;
		load : in std_logic;
		saida : out std_logic_vector(n - 1 downto 0)
	);
end entity registrador;

architecture behavior of registrador is
begin
	process (clk, rst) is
	begin
		if (rst = '1') then
			saida <= (others => '0');
		elsif (rising_edge(clk) and (load = '1')) then
			saida <= entrada
			end if;
		end process;
	end architecture behavior;