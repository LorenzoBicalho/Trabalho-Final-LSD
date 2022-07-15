library ieee;
use ieee.std_logic_1164.all;

entity DataPath is
   port (
		-- ENTRADAS --
		dadosLeitorQr : in std_logic_vector(15 downto 0);
		dadosPlaca : in std_logic_vector(15 downto 0);
		
		addrLeitorQr : in std_logic;
		selecionaMensagem : in std_logic;
		entradaAberto : in std_logic;
		salvaDados : in std_logic;
        ticketRegClr : in std_logic;
		
		
		clock : in std_logic;
		
		-- SAIDAS --
		
		mensagem : out std_logic_vector(15 downto 0);
		
		addrTicket : out std_logic;
		ticketOk : out std_logic
    );
end DataPath;


architecture RTLDataPath OF DataPath is

component mux is
	port(
		addrLeitorQr 		: in std_logic_vector(15 downto 0);
		addrTicket	 		: in std_logic_vector(15 downto 0);
		salvaDados		 	: in std_logic;
		saida_mux 			: out std_logic_vector(15 downto 0)
	);
end component;

component incrementador is
	port (
      	a 		: in std_logic_vector(15 downto 0);
      	result	: out std_logic_vector(15 downto 0)
    );
end component;

component comparador is
	port (
      	dadosLeitorQr		: in std_logic_vector(15 downto 0);
      	saida_ram			: in std_logic_vector(15 downto 0);
		saida_comparador	: out std_logic
    );
end component;

component rom is
		generic (
			ADDR_LENGHT : natural := 5;
			R_LENGHT : natural := 16;
			NUM_OF_REGS : natural := 32
		);
		port (
			clk : in std_logic;
			wr : in std_logic;
			addr : in std_logic_vector (ADDR_LENGHT - 1 downto 0);
			data_in : in std_logic_vector (R_LENGHT - 1 downto 0);
			data_out : out std_logic_vector (R_LENGHT - 1 downto 0)
		);
end component;

component ram IS
        port(
             addr : in std_logic_vector(7 downto 0);
             write : in std_logic_vector(7 downto 0);
             data_in : in std_logic;
             data_out : out std_logic_vector(7 downto 0)
             );
end component;

component registrador is
		generic (n : natural := 10);
		port (
			entrada : in std_logic_vector(n - 1 downto 0);
			clk : in std_logic;
			rst : in std_logic;
			load : in std_logic;
			saida : out std_logic_vector(n - 1 downto 0)
		);
end component;


signal aux_E_C : std_logic_vector(15 downto 0);
signal aux_B_F, aux_A_E : std_logic_vector(9 downto 0);

begin

-- Componentes --

A_Mux_2x1 : mux
	port map(addrLeitorQr => addrLeitorQr, addrTicket => addrTicket, salvaDados => salvaDados, saida_mux => aux_A_E);
    
B_Incrementador : incrementador
	port map(a=>addrTicket, result=>aux_B_F);
	
C_Comparador : comparador
	port map(dadosLeitorQr=>dadosLeitorQr, saida_ram=>aux_E_C, saida_comparador=>ticketOk);

D_ROM : ram 
	port map(clk => CLOCK, wr => MEM_wr, addr => selecionaMensagem, data_in => MEM_data_input, data_out => mensagem);

E_RAM : rom 
	port map(dadosPlaca => data_in, aux_A_E => addr, salvaDados => write, aux_E_C => data_out);
    
F_Registrador : registrador 
	port map(clk => CLOCK, aux_B_F => entrada, saida => aux_BF, clr => ticketRegClr, ld => entradaAberto);


end RTLDataPath ;