library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controladora is
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
	portaoSaidaFechado
);

signal estadoAtual : estado := inicio;
signal proximoEstado : estado := inicio;

-------------------------------------------------
--          Auxiliares para os botoes
-- identificar se o botao foi pressionado e solto
-------------------------------------------------
signal auxBotaoEntrada : std_logic := '0';

begin

	-- REGISTRADOR DE ESTADOS --
	
	process(clear, clock) is	
	begin
		if(clear = '1') then
			estadoatual <= inicio;
		elsif(rising_edge(clock)) then
			estadoatual <= proximoestado;
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
					
	case estadoatual is 
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
			elsif (sensorEntrada = '1') and (sensorSaida = '0') then
				proximoEstado <= capturadaPlaca;
			else
				proximoEstado <= espera;
			end if;
		
		when capturadaPlaca =>
        	salvaDados <= '1';
			if (placaCapturada = '1') then
				proximoestado <= impressaoTicket;
			else
				proximoestado <= capturadaPlaca;
			end if;
		
		when impressaoTicket =>
			imprimeTicket <= '1';
			proximoestado <= portaoEntradaAberto;

		when portaoEntradaAberto =>
			imprimeTicket <= '0';
            entradaAberto <= '1';
            if (sensorEntrada = '1') then
				proximoestado <= portaoEntradaFechado;
			else
				proximoestado <= portaoEntradaAberto;
			end if;
            
		when portaoEntradaFechado =>
			entradaAberto <= '0';
			proximoestado <= espera;
		
		when leTicket =>
        	selecionaMensagem <= '0';
			if (sensorSaida = '0') then
				proximoestado <= espera;
			elsif (ticketOk = '0') then
				proximoestado <= leTicket;
			else
				proximoestado <= portaoSaidaAberto;
			end if;
		
		when portaoSaidaAberto =>
			selecionaMensagem <= '1';
            saidaAberto <= '1';
			if (sensorSaida = '0') then
				proximoestado <= portaoSaidaFechado;
			else
				proximoestado <= portaoSaidaAberto;
			end if;

		when portaoSaidaFechado =>
			saidaAberto <= '0';
			proximoestado <= espera;
		
			
		end case;
	end process;
 
end RTLControladora;