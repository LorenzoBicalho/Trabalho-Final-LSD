library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_ram is 
end entity;

architecture behavior of tb_ram is

signal DATA_IN : std_logic_vector(7 downto 0) := "00000000";
signal ADDRESS : std_logic_vector(7 downto 0) := "00000000";
signal W_R : std_logic := '0';
signal DATA_OUT : std_logic_vector(7 downto 0);

component ram is
    port(DATA_IN : in std_logic_vector(7 downto 0);
         ADDRESS : in std_logic_vector(7 downto 0);
         W_R : in std_logic;
         DATA_OUT : out std_logic_vector(7 downto 0)
         );
end component;

begin
  UUT : ram port map(DATA_IN, ADDRESS, W_R, DATA_OUT);

  process
  begin
    -- Write data into ram
    wait for 100 ns;
    ADDRESS <= "10000000";
    DATA_IN <= "01111111";
    wait for 100 ns;
    ADDRESS <= "01000000";
    DATA_IN <= "10111111";
    wait for 100 ns;
    ADDRESS <= "00100000";
    DATA_IN <= "11011111";
    wait for 100 ns;
    ADDRESS <= "00010000";
    DATA_IN <= "11101111";
    wait for 110 ns;

    -- Read data from ram
    W_R  <= '1';
    ADDRESS <= "00000000";
    wait for 100 ns;
    ADDRESS <= "10000000";
    wait for 100 ns;
    ADDRESS <= "01000000";
    wait for 100 ns;
    ADDRESS <= "00100000";
    wait for 100 ns;
    ADDRESS <= "00010000";
    wait for 100 ns;

    wait;
  end process;

end behavior;
