LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux2X1 IS
	GENERIC (n : NATURAL := 16);
	PORT (
		CurrentChange : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		CurrentMoney : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		ChaveRetorno : IN STD_LOGIC;
		ReturnValue : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE rtl OF mux2X1 IS
BEGIN
	WITH ChaveRetorno SELECT
		ReturnValue <= CurrentChange WHEN '1',
		CurrentMoney WHEN OTHERS;
END rtl;