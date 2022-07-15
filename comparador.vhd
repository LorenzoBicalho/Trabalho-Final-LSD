LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY comparador16bits IS
	PORT (
		FirstNumber : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		SecondNumber : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		First_lt_Second : OUT STD_LOGIC
	);
END comparador16bits;

ARCHITECTURE compara OF comparador16bits IS
BEGIN
	WITH FirstNumber < SecondNumber SELECT
	First_lt_Second <= '1' WHEN true,
		'0' WHEN OTHERS;
END compara;