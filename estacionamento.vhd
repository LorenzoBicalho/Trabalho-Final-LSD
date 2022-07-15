LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity estacionamento is
	port (
		-- Entradas
		
		placaCapturada : in std_logic;
		botaoEntrada : in std_logic;
		sensorEntrada : in std_logic;
		sensorSaida : in std_logic;
        ticketOk : in std_logic;
		
		
		clock : in std_logic;
		clear : in std_logic;
		
		
		-- Saidas 

		selecionaMensagem : out std_logic;
		imprimeTicket : out std_logic;
		dadosImpressao : out std_logic;
		entradaAberto : out std_logic;
		saidaAberto : out std_logic;
		salvaDados : out std_logic;
        ticketRegClr : out std_logic

    );
end estacionamento;

architecture RTLestacionamento of estacionamento is

component DataPath is
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
		dadosImpressao : out std_logic_vector(15 downto 0);
		
		addrTicket : out std_logic;
		ticketOk : out std_logic
    );
end component DataPath;

component Controladora is
    port ( 
		--Entradas--

		placaCapturada : in std_logic;
		botaoEntrada : in std_logic;
		sensorEntrada : in std_logic;
		sensorSaida : in std_logic;
        ticketOk : in std_logic;
		
		
		clock : in std_logic;
		clear : in std_logic;
		
		--Saídas--
		
		selecionaMensagem : out std_logic;
		imprimeTicket : out std_logic;
		dadosImpressao : out std_logic;
		entradaAberto : out std_logic;
		saidaAberto : out std_logic;
		salvaDados : out std_logic;
        ticketRegClr : out std_logic
    );

end component Controladora;

-- Signals entre Controladora e Datapath -- 

signal auxTicketOk : std_logic;
signal auxSelecionaMensagem : std_logic;
signal auxEntradaAberto : std_logic;
signal auxSalvaDados : std_logic;
signal auxTicketRegClr : std_logic;

begin
										  
	A_Controladora : Controladora
		port map (
			placaCapturada => placaCapturada,
			botaoEntrada => botaoEntrada,
			sensorEntrada => sensorEntrada,
			sensorSaida => sensorSaida,
			ticketOk => auxTicketOk,
			clock => clock,
			clear => clear,
			selecionaMensagem => auxSelecionaMensagem,
			imprimeTicket => imprimeTicket,
			entradaAberto => auxEntradaAberto,
			saidaAberto => saidaAberto,
			salvaDados => auxSalvaDados,
			ticketRegClr => auxTicketRegClr
		);
		
	B_DataPath : DataPath  
			port map (
			dadosLeitorQr => dadosLeitorQr,
			dadosPlaca => dadosPlaca,
			addrLeitorQr => addrLeitorQr,
			selecionaMensagem => auxSelecionaMensagem,
			entradaAberto => auxEntradaAberto,
			salvaDados => auxSalvaDados,
			ticketRegClr => auxTicketRegClr,
			clock => clock,
			mensagem => mensagem,
			dadosImpressao => dadosImpressao,
			addrTicket => addrTicket,
			ticketOk => auxTicketOk
		);

end RTLestacionamento ;