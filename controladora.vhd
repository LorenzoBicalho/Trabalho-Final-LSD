library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controladora is
    port ( 
		--Entradas--

		dadosLeitorQr : in std_logic;
		addrLeitorQr : in std_logic;
		placaCapturada : in std_logic;
		dadosPlaca : in std_logic;
		botaoEntrada : in std_logic;
		sensorEntrada : in std_logic;
		sensorSaida : in std_logic;
        ticketOk : in std_logic;
		
		
		clock : in std_logic;
		clear : in std_logic;
		
		--Saídas--
		
		mensagem : out std_logic;
		selecionaMensagem : out std_logic;
		imprimeTicket : out std_logic;
		dadosImpressao : out std_logic;
		
		entradaAberto : out std_logic;
		saidaAberto : out std_logic;
		salvaDados : out std_logic;
		addrTicket : out std_logic;
        ticketRegClr : out std_logic
    );

end Controladora;

architecture RTLControladora of Controladora is

type estado is (
	inicio,
	espera,
	capturaDaPlaca,
	impressaoTicket,
	portaoEntradaAberto,
	portaoEntradaFechado,
	leTicket,
	portaoSaidaAberto,
	portaoSaidaFechado,
);

signal estadoAtual : estado := inicio;
signal proximoEstado : estado := inicio;

-------------------------------------------------
--          Auxiliares para os botoes
-- identificar se o botao foi pressionado e solto
-------------------------------------------------
signal auxBotaoEntrada : std_logic := '0';
signal aux_finaliza_compra : std_logic := '0';
signal aux_cancelar : std_logic := '0';
signal aux_pagar_compra : std_logic := '0';

begin

	-- REGISTRADOR DE ESTADOS --
	
	process(clear, clock) is	
	begin
		if(clear = '1') then
			estado_atual <= iniciar;
		elsif(rising_edge(clock)) then
			estado_atual <= proximo_estado;
			auxBotaoEntrada <= botaoEntrada;
		end if;
	end process;
	
	process (
		dadosLeitorQr,
		addrLeitorQr,
		placaCapturada,
		dadosPlaca,
		botaoEntrada,
		sensorEntrada,
		sensorSaida,
        ticketOk,
		estadoAtual
	)

	begin
	
	mensagem <= '0';
	selecionaMensagem <= '0';
	imprimeTicket <= '0';
	dadosImpressao <= '0';
	
	entradaAberto <= '0';
	saidaAberto <= '0';
	salvaDados <= '0';
	addrTicket <= '0';
    ticketRegClr <= '0';
					
	case estado_atual is 
		when inicio =>
                mensagem <= '0';
                selecionaMensagem <= '0';
                imprimeTicket <= '0';
                dadosImpressao <= '0';
                entradaAberto <= '0';
                saidaAberto <= '0';
                salvaDados <= '0';
                addrTicket <= '0';
                ticketRegClr <= '1';
                
				proximoEstado <= espera;


		when espera =>
        
			selecionaMensagem <= '0';
			salvaDados <= '0';
			if (sensorSaida = '1') then
				proximoEstado <= leTicket;
			elsif (sensorEnrada = '1') and (sensorSaida = 0) then
				proximoEstado <= capturaPlaca;
			else
				proximoEstado <= espera;
			end if;
		
		when capturaPlaca =>
        	salvaDados <= '1';
			if (placaCapturada = '1') then
				proximo_estado <= impressaoTicket;
			else
				proximo_estado <= capturaPlaca;
			end if;
		
		when impressaoTicket =>
			imprimeTicket <= '1';
			proximo_estado <= portaoEntradaAberto;

		when portaoEntradaAberto =>
			imprimeTicket <= '0';
            entradaAberto <= '1';
            if (sensorEnrada = '1') then
				proximo_estado <= portaoEntradaFechado;
			else
				proximo_estado <= portaoEntradaAberto;
			end if;
            
		when portaoEntradaFechado =>
			entradaAberto <= '0';
			proximo_estado <= espera;
		
		when leTicket =>
        	selecionaMensagem <= '0'
			if (sensorSaida = '0') then
				proximo_estado <= espera;
			elsif (ticketOk = '0') then
				proximo_estado <= leTicket;
			else
				proximo_estado <= portaSaidaAberto;
			end if;
		
		when portaSaidaAberto =>
			selecionaMensagem <= '1';
            saidaAberto <= '1';
			if (sensorSaida = '0') then
				proximo_estado <= portaSaidaFechado;
			else
				proximo_estado <= portaSaidaAberto;
			end if;

		when portaSaidaFechado =>
			saidaAberto <= '0';
			proximo_estado <= espera;
		
			
		end case;
	end process;
 
end RTLControladora;